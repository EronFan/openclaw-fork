#!/usr/bin/env python3
import argparse
import json
import shutil
import sys
from pathlib import Path

CONFIG_PATH = Path('/root/.openclaw/openclaw.json')
MAIN_WORKSPACE = Path('/root/.openclaw/workspace')
WORKSPACES_ROOT = Path('/root/.openclaw/workspaces')
AGENTS_ROOT = Path('/root/.openclaw/agents')

MAIN_AGENTS_MD = MAIN_WORKSPACE / 'AGENTS.md'


def eprint(*args):
    print(*args, file=sys.stderr)


def load_json(path: Path):
    return json.loads(path.read_text(encoding='utf-8'))


def save_json(path: Path, data):
    path.write_text(json.dumps(data, ensure_ascii=False, indent=2) + '\n', encoding='utf-8')


def ensure_dir(path: Path, dry_run: bool):
    if dry_run:
        print(f'[dry-run] mkdir -p {path}')
    else:
        path.mkdir(parents=True, exist_ok=True)


def write_if_missing(path: Path, content: str, dry_run: bool):
    if path.exists():
        print(f'skip existing: {path}')
        return
    if dry_run:
        print(f'[dry-run] write {path}')
    else:
        path.write_text(content, encoding='utf-8')
        print(f'created: {path}')


def copy_main_agents_md(target: Path, dry_run: bool):
    if target.exists():
        print(f'skip existing: {target}')
        return
    if not MAIN_AGENTS_MD.exists():
        raise FileNotFoundError(f'Main AGENTS.md not found: {MAIN_AGENTS_MD}')
    if dry_run:
        print(f'[dry-run] copy {MAIN_AGENTS_MD} -> {target}')
    else:
        shutil.copyfile(MAIN_AGENTS_MD, target)
        print(f'created: {target}')


def default_soul_md(agent_id: str, bot_name: str, role: str) -> str:
    return f'''# SOUL.md - {bot_name}\n\n你是 **{bot_name}**。\n\n## 核心职责\n- 角色：{role}\n- Agent ID：`{agent_id}`\n- 工作原则：先理解任务边界，再输出结果；不知道就明确回报，不要编造。\n\n## 行为要求\n- 结论先行\n- 中文优先\n- 少废话，重执行\n- 发现阻塞、失败、无权限时，及时回报\n\n## 协作要求\n- 先读 `AGENTS.md`，明确团队成员和联系规则\n- 需要协作时按 `AGENTS.md` 指定对象联系\n- 不要递归派单，不要横向乱转\n- 关键结果直接回 main\n\n## 禁止事项\n- 不得编造事实、结果、日志或工具输出\n- 不得擅自泄露敏感信息\n- 不得在任务不清楚时自行脑补需求\n'''


def normalize_account_id(account_id: str | None, agent_id: str) -> str:
    return account_id or agent_id


def update_config(data: dict, agent_id: str, bot_name: str, account_id: str, workspace: Path, agent_dir: Path):
    agents = data.setdefault('agents', {})
    agent_list = agents.setdefault('list', [])
    bindings = data.setdefault('bindings', [])
    tools = data.setdefault('tools', {})
    agent_to_agent = tools.setdefault('agentToAgent', {})
    agent_to_agent['enabled'] = True
    allow = agent_to_agent.setdefault('allow', [])

    # agent entry
    existing_agent = next((a for a in agent_list if a.get('id') == agent_id), None)
    if existing_agent:
        existing_agent['name'] = existing_agent.get('name') or bot_name
        existing_agent['workspace'] = existing_agent.get('workspace') or str(workspace)
        existing_agent['agentDir'] = existing_agent.get('agentDir') or str(agent_dir)
    else:
        agent_list.append({
            'id': agent_id,
            'name': bot_name,
            'workspace': str(workspace),
            'agentDir': str(agent_dir),
        })

    # binding entry
    existing_binding = next((b for b in bindings if b.get('agentId') == agent_id and isinstance(b.get('match'), dict) and b['match'].get('channel') == 'feishu'), None)
    if existing_binding:
        existing_binding.setdefault('match', {})['channel'] = 'feishu'
        existing_binding['match']['accountId'] = account_id
    else:
        bindings.append({
            'agentId': agent_id,
            'match': {
                'channel': 'feishu',
                'accountId': account_id,
            }
        })

    # allow list
    if agent_id not in allow:
        allow.append(agent_id)

    # keep sessions visibility
    sessions = tools.setdefault('sessions', {})
    if sessions.get('visibility') != 'all':
        sessions['visibility'] = 'all'

    return data


def main():
    parser = argparse.ArgumentParser(description='Initialize a new OpenClaw agent workspace and patch openclaw.json')
    parser.add_argument('--agent-id', required=True, help='Agent ID, e.g. content')
    parser.add_argument('--bot-name', required=True, help='Display name, e.g. 内容机器人')
    parser.add_argument('--role', required=True, help='Role description, e.g. 内容创作 / 文案')
    parser.add_argument('--account-id', help='Feishu accountId; default = agent-id')
    parser.add_argument('--workspace', help='Override workspace path')
    parser.add_argument('--agent-dir', help='Override agentDir path')
    parser.add_argument('--force-agents-md', action='store_true', help='Overwrite AGENTS.md in target workspace with main template')
    parser.add_argument('--dry-run', action='store_true', help='Preview changes without writing')
    args = parser.parse_args()

    if not CONFIG_PATH.exists():
        raise FileNotFoundError(f'Config not found: {CONFIG_PATH}')

    agent_id = args.agent_id.strip()
    bot_name = args.bot_name.strip()
    role = args.role.strip()
    account_id = normalize_account_id(args.account_id.strip() if args.account_id else None, agent_id)
    workspace = Path(args.workspace) if args.workspace else (WORKSPACES_ROOT / f'workspace-{agent_id}')
    agent_dir = Path(args.agent_dir) if args.agent_dir else (AGENTS_ROOT / agent_id / 'agent')

    if agent_id == 'main':
        raise ValueError('This script is for non-main agents. main is already the primary controller.')

    print('== init-agent ==')
    print(f'agent_id   : {agent_id}')
    print(f'bot_name   : {bot_name}')
    print(f'role       : {role}')
    print(f'account_id : {account_id}')
    print(f'workspace  : {workspace}')
    print(f'agent_dir  : {agent_dir}')
    print(f'dry_run    : {args.dry_run}')
    print()

    ensure_dir(workspace, args.dry_run)
    ensure_dir(workspace / 'memory', args.dry_run)
    ensure_dir(agent_dir, args.dry_run)

    agents_md_target = workspace / 'AGENTS.md'
    soul_md_target = workspace / 'SOUL.md'

    if args.force_agents_md and agents_md_target.exists():
        if args.dry_run:
            print(f'[dry-run] overwrite {agents_md_target} from {MAIN_AGENTS_MD}')
        else:
            shutil.copyfile(MAIN_AGENTS_MD, agents_md_target)
            print(f'overwritten: {agents_md_target}')
    else:
        copy_main_agents_md(agents_md_target, args.dry_run)

    write_if_missing(soul_md_target, default_soul_md(agent_id, bot_name, role), args.dry_run)

    data = load_json(CONFIG_PATH)
    new_data = update_config(data, agent_id, bot_name, account_id, workspace, agent_dir)

    if args.dry_run:
        print(f'[dry-run] update {CONFIG_PATH}: agents.list + bindings + tools.agentToAgent.allow')
    else:
        backup_path = CONFIG_PATH.with_suffix('.json.bak.init-agent')
        shutil.copyfile(CONFIG_PATH, backup_path)
        save_json(CONFIG_PATH, new_data)
        print(f'updated: {CONFIG_PATH}')
        print(f'backup : {backup_path}')

    print('\nDone.')
    print('Next steps:')
    print(f'1) 在 openclaw.json 里补 channels.feishu.accounts.{account_id} 的真实账号配置（如果还没有）')
    print('2) 检查 bindings / agents.list 是否符合预期')
    print('3) 执行: openclaw gateway restart')
    print('4) 做一次 main -> 新 agent 的在线测试')


if __name__ == '__main__':
    main()
