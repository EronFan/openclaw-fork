# OpenClaw Agent Guidelines

## 空转防止机制（最高优先级）

**xixi 扫描完成 = 立即触发修复，不等确认。**

1. 扫描到 Top Candidate（S/M级、根因明确、无PR覆盖）→ 立即派出 subagent 修复
2. 不满足条件的 issue → 记录到 `memory/OPENCLAW-PROJECT.md` 待处理队列
3. 禁止：只汇报"建议接单"而不触发实际修复

**汇报必须包含 inProgressFixes 字段**，每次汇报都要报告当前进展。

**heartbeat-state.json 必须维护 lastPrCreatedAt**：超过 2 小时无新 PR 且无活跃 fix，视为空转，主动告警范总。

## Repo Info
- Repo: https://github.com/openclaw/openclaw
- Source: `src/` | Tests: `*.test.ts` | Docs: `docs/`
- Plugin SDK: `openclaw/plugin-sdk/*` | Gateway protocol: `src/gateway/protocol/*`
- File refs in replies: repo-root relative only (e.g., `src/telegram/index.ts:80`)

## 核心规则

### 修复标准化流程
1. 收到 issue → 本地代码复现
2. 定位根因 → 最小改动点
3. 写修复 + 补测试用例
4. 跑 `pnpm test` 确保通过
5. 提 PR，标题格式：`fix: <简短描述>`
6. 描述清楚：问题是什么、为什么这么修、测试覆盖了什么

### 工程文化
- **必须先复现再修**。看不到问题就不写 fix，这是底线。
- 质量大于数量。一条烂 PR 被关闭等于浪费时间。
- 遇到阻塞超过 30 分钟 → 立即回主会话说明卡点。

### 决策风格
- 快速决断：不等不拖，带方案而不是带问题
- 默认执行：除非涉及资金/删除/高危，否则直接干
- 交付闭环：任务从派单到 PR 创建才算完成

### 禁止行为
- ❌ 只汇报"建议接单"而不触发实际修复
- ❌ 等待范总指令才开始修代码
- ❌ 晨报里列一堆 issue 但没有 inProgressFixes

## Subagent 派单

```json
{"task": "<任务描述>", "label": "<label>", "runtime": "subagent", "mode": "run"}
```

Task 格式：
1. 简短描述问题
2. 根因线索（如有）
3. 步骤（搜索代码 → 定位根因 → 写 fix → 测试 → PR）
4. PR 描述格式模板

## Git / PR

- Commit: `scripts/committer "<msg>" <file...>`
- 标题格式：`fix: <简短描述>` | `feat: <简短描述>` | `chore: <简短描述>`
- PR 描述：问题是什么、根因是什么、fix 是什么、测试覆盖了什么
- **禁止**在 main 上创建 merge commit；必须 rebase
- 使用 `$openclaw-pr-maintainer` skill 进行 maintainer PR triage

## Test
- `pnpm test` (vitest) — 跑通再提 PR
- 窄范围测试优先：`pnpm test <path-or-filter>`
- 清理：timers、env、globals、mocks、temp dirs
- 不改 baseline/snapshot/expected-failure 文件来 silencing 失败

## Build / Dev
- `pnpm check` (lint + format + type)
- `pnpm build`（影响 build 输出时必须跑）
- `pnpm test`（影响逻辑时必须跑）
- `pnpm tsgo`（TypeScript 检查）
- Node 22+ required

## Coding Style
- TypeScript (ESM)，strict typing，避免 `any`
- 不加 `@ts-nocheck`（除非有明确理由 + 注释解释）
- 优先 `zod` 在外部边界（config、webhook、CLI 输出）
- 文件 <~700 LOC；逻辑复杂就拆分
- human-readable strings 用于 logs/CLI/UI
- 不使用 `?? 0` / 空字符串 / 魔法字符串作为分支依据

## Tool Schema Guardrails
- 避免 `Type.Union`；用 `stringEnum` / `optionalStringEnum`
- 不使用 `anyOf`/`oneOf`/`allOf`
- 顶层 schema 用 `type: "object"` + `properties`
- 避免 `format` 属性名（部分 validator 把它当保留字）

## Architecture Boundaries（参考）
- `src/plugin-sdk/*` = public plugin contract
- `src/channels/*` = channel impl details
- `src/plugins/*` = plugin discovery/loader/registry
- `src/gateway/protocol/*` = gateway control-plane wire protocol
- 核心规则：extension 只通过 `openclaw/plugin-sdk/*` + manifest metadata 跨入 core

## Security
- 不提交真实手机号、视频、live 配置值
- 不修改 `node_modules`（会被覆盖）
- 不 change version numbers without explicit approval
- 不 publish/release without explicit approval

## Multi-Agent Safety
- 不创建/应用/drop `git stash`（除非明确要求）
- 不切换分支（除非明确要求）
- 不创建/删除 `git worktree`
- "push" 时可以 `git pull --rebase` 整合最新代码
- "commit" 时只 commit 自己的改动
- "commit all" 时 commit 所有相关改动

## 常用命令
```bash
# 重启 gateway
pkill -9 -f openclaw-gateway || true
nohup openclaw gateway run --bind loopback --port 34459 --force > /tmp/openclaw-gateway.log 2>&1 &

# 检查 gateway 状态
openclaw gateway status

# 日志
tail -100 /tmp/openclaw/openclaw-$(date +%Y-%m-%d).log
```

## 文件位置
- Gateway config: `~/.openclaw/openclaw.json`
- Sessions: `~/.openclaw/agents/<agentId>/sessions/*.jsonl`
- Memory: `memory/OPENCLAW-PROJECT.md`, `memory/heartbeat-state.json`
- Agent workspace: `/root/.openclaw/workspace`
