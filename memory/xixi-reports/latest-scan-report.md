# 全量扫描报告 2026-04-15 01:11 CST (2026-04-14 17:11 UTC)

---

## GitHub Issues（方向1）

**发现了 22 个新/更新候选**，全部集中在 **2026.4.14 发布日 regression 爆发**——这是迄今为止最高密度的 S 级集中窗口。

### 🔴 最高优先级（直接 fix 候选）

| # | 标题 | 优先级 | 根因 | 备注 |
|---|------|--------|------|------|
| **#66693** | Onboarding `TypeError: Cannot read properties of undefined (reading 'trim')` (2026.4.14) | **S regression** | `.trim()` on undefined after channel selection | 两个独立 reporter 确认；**PR #66653 已修同根因** |
| **#66677** | 同 #66693 — Select channel trim crash (duplicate) | **S regression** | 同上 | 合并追踪 |
| **#66681** | Health-monitor causes gateway crash: `TypeError: Cannot read properties of undefined (reading 'info')` | **S** | `log.info?.()` 保护了 `info` 但没保护 `log`；应改为 `log?.info?.()` | **1行 fix，root cause 极清晰** |
| **#66679** | Telegram 和 Slack chat-triggered tools/actions 完全不执行 (2026.4.14 a88c6f0) | **S regression** | agent→channel action dispatch 路径静默失败 | channel probe 正常但工具不触发；跨 Telegram+Slack 两个主流渠道 |
| **#66691** | `models.providers.*.request.allowPrivateNetwork` 不再对 audio transcription 生效 (v2026.4.14) | **S regression** | 两处根因：① `resolveProviderExecutionContext` 未合并 provider-level request config ② `resolveProviderRequestPolicyConfig` 忽略 `params.request?.allowPrivateNetwork` | **PR #66692 已开**（jhsmith409）；Greptile P2：**无 regression test** |
| **#66690** | Sandboxed agent cannot reach browser CDP — `127.0.0.1` hardcoded in `ensureSandboxBrowser` | **S** | Docker sandbox agent 无法访问 host loopback CDP；需用容器内部 DNS 名 | 文档推荐的 sandbox+browser 组合完全不可用 |
| **#66674** | openai-codex/gpt-5.4 CLI 返回 HTML rawError 但 surface 为"DNS lookup failed" (2026.4.14) | **S** | HTML provider 错误被误分类为 DNS 异常；`rawErrorPreview` 含 HTML | 所有 Codex 用户完全无法用 |

### 🟡 次高优先级（建议 aoao 接单）

| # | 标题 | 优先级 | 备注 |
|---|------|--------|------|
| **#66688** | `memory index` fails with `Unknown memory embedding provider: ollama` | **S regression** | ollama 作为 memory embedding provider 不被识别 |
| **#66686** | Memory search over-generalization: 系统状态验证被强制走 memory_search | **S** | `Before answering anything about prior work...` 规则过宽；系统状态验证应直接调 API |
| **#66683** | Subagent completions resolve before parent reply delivery succeeds | **S** | 生命周期 ownership 问题；可能导致 duplicate completion 或 silent drop |
| **#66682** | Telegram `commands.native` 不注册 setMyCommands (2026.4.14) | **S regression** | 无任何日志/调用；setup 代码存在但从未执行 |
| **#66675** | `openclaw gateway restart` 返回 false failure after healthy systemd restart | **S** | 疑似 stale exec approval followup 污染 restart 报告路径 |
| **#66684** | Security scan findings: remote script execution and credential-pattern hits | **S** | ClawHavoc/ClawSafe 静态扫描工具报告；需人工 triage |
| **#66670** | sessions_spawn should populate agent_id in task_runs SQLite | **S** | Feature/bug；agent_id 丢失导致 task runs 无法关联 |
| **#66668** | `plugins uninstall` does not remove extension files for --link or manually installed plugins | **S** | 卸载不完全；--link 安装的插件文件残留 |

### 🟠 Feature Requests（勿误报为 bug）

- **#66695** — pre-commit hook assumes bare pnpm instead of Corepack-managed pnpm（enhancement）
- **#66694** — Feature: Building a Smarter OpenClaw（AI autonomous handling roadmap）
- **#66672** — Feature: Safe AI Workflow Modes: Ask, Plan, Modify（roadmap）
- **#66667/#66666** — Feature Request: before_delivery / ` hook for reply interception（功能请求）

---

## 插件仓库（方向2）

**无新发现**。

- `openclaw/openclaw-weixin` — 仓库不存在（私有）
- `Tencent/openclaw-weixin` — 近2小时内无新 issues 或 PRs
- 其他 openclaw 插件 — 无公开新 activity

---

## 贡献者文件区域（方向3）

扫描了排名最末的 **10 位贡献者**（45~81 次贡献），最近 3 条 commit 变更文件：

| Contributor | 贡献数 | 最近文件区 | 相关 Open Bug |
|------------|--------|-----------|-------------|
| **huntharo** | 81 | `src/plugins/plugin-sdk/`, `extensions/telegram/`, `src/agents/` | ⚠️ #66693（onboarding trim crash）在 Telegram setup 路径；PR #66653 已修；huntharo 的 plugin-sdk bundle error context 改动可能影响其他 setup 路径 |
| **bmendonca3** | 69 | `extensions/feishu/`, `src/plugins/` | 无直接新 bug 匹配 |
| **mcaxtr** | 69 | `extensions/whatsapp/`, `extensions/tts/` | 无直接新 bug 匹配 |
| **onutc** | 67 | `scripts/ci/`, `docs/`, `src/config/` | 无直接新 bug 匹配 |
| **jalehman** | 66 | `src/agents/`, `extensions/telegram/`, `src/channels/` | 与 #66682（Telegram setMyCommands）文件区重叠；与 #66683（subagent completions）agents 文件区重叠 |
| **eleqtrizit** | 62 | `src/memory/`, `src/gateway/`, `src/media/` | 与 #66686（memory search over-generalization）直接重叠；刚提了 #66636 `fix(agents): tighten workspace file opens` |
| **osolmaz** | 62 | `src/gateway/`, `src/agents/` | 无直接新 bug 匹配 |
| **Glucksberg** | 59 | `src/hooks/`, `src/media-understanding/` | 与 #66691（allowPrivateNetwork audio）文件区部分重叠 |
| **altaywtf** | 54 | `scripts/qa/`, `.github/workflows/` | 无直接新 bug 匹配 |
| **quotentiroler** | 45 | `scripts/credits/` | 无直接新 bug 匹配 |

**关键发现**：eleqtrizit（memory/gateway）和 jalehman（telegram/agents）是本批中对当前 S 级 bug 覆盖最密集的贡献者。eleqtrizit 刚提了 #66636（workspace file opens），其 memory 文件区与 #66686 直接重叠；jalehman 的 telegram 文件区与 #66682/#66683 重叠。

---

## 追踪 PR 反馈（方向4）

### ⚠️ Security Alert — PR #66689

**PR #66689**（`fix: allow workspace-rooted absolute media paths in auto-reply`，joelnishanth，size S）：
- **aisle-research-bot 报告 🔴 High Security Issue**：Symlink escape allows arbitrary host file read
- Greptile P1：新增 `isPathInside` 检查允许任何 workspace/sandbox 内的路径，但 `realpath` 前信任 path → 符号链接逃脱
- **建议**：阻塞此 PR，等 security fix 再合并

### Greptile 反馈摘要

| PR | 分数 | 问题 |
|----|------|------|
| **#66689** | P1 | Symlink escape arbitrary host file read（security 🔴）|
| **#66687** | P1 | Unguarded `RegExp` construction throws on invalid `cfg.stages` |
| **#66653** | P2 | Type signature doesn't reflect the null guard |
| **#66692** | P2 | No regression test for this fix |

### Maintainer 反馈

| PR | 人 | 反馈 |
|----|---|------|
| **#66685** | pfrederiksen | PR 被 `main` 不稳定性阻塞，非本 PR 代码问题 |

### PR 状态

| PR | 作者 | 内容 | 状态 |
|----|------|------|------|
| **#66697** | EronFan | fix(config): correct sourceConfig/runtimeConfig assignment | ❌ **Closed（未合并）** |
| **#66673** | samzong | feat: add doctor.memory.remHarness probe | ✅ Open |
| **#66692** | jhsmith409 | fix(audio): restore allowPrivateNetwork for self-hosted STT | ✅ Open，Greptile P2 |
| **#66689** | joelnishanth | fix: workspace-rooted absolute media paths | ✅ Open，**Security 🔴 issue** |
| **#66687** | wzhgba | feat(cache-trace): capture stream-context tools | ✅ Open，Greptile P1 |
| **#66685** | pfrederiksen | suppress expired exec approval followup warnings | ✅ Open，被 main 阻塞 |
| **#66678** | GodsBoy | accept third-party context engines info.id mismatch | ✅ Open |
| **#66653** | mm1ord | fix(telegram): add null safety to .trim() calls | ✅ Open，Greptile P2 |
| **#66636** | eleqtrizit | fix(agents): tighten workspace file opens | ✅ Open |

### 新 PR 发现

- **#66697**（EronFan）：fix(config): correct sourceConfig/runtimeConfig — **已关闭，未合并**，需跟进
- **#66696**（pfrederiksen）：Support Corepack-managed pnpm in pre-commit tooling

---

## 结论

### 最高优先级

**#66693/#66677（onboarding trim crash）最紧急**：
- 影响所有 2026.4.14 新安装用户
- 两个独立 reporter 确认同根因
- **PR #66653 已开**（mm1ord），直接修了同根因
- **建议**：立即 review #66653 + 支持

**#66681（health-monitor crash）次紧急**：
- 1行 fix（`log?.info?.()`），root cause 清晰
- **建议 aoao 直接接单，5分钟可 PR**

**⚠️ #66689（workspace media paths）security issue 阻塞**：
- aisle-research-bot 报告 symlink escape → arbitrary host file read
- **必须修复后再合并**

**#66691/#66692（allowPrivateNetwork audio）已有 PR**：
- PR #66692 已开（jhsmith409，size XS），Greptile P2 提示无 regression test
- 建议 review 时要求补充测试

### 建议 aoao 接单顺序

1. **#66681** — health-monitor crash，1行 fix，5分钟可 PR
2. **#66679** — chat-triggered tools Telegram/Slack regression，S级，需调研 agent→channel dispatch 路径
3. **#66690** — sandboxed CDP unreachable，设计问题，稍复杂
4. **#66686** — memory search over-generalization，system prompt 改1-2行
5. **#66668** — plugins uninstall 不删除 extension files

### inProgressFixes

（当前扫描期间无新 subagent 派出，无 in-progress fixes）

---

*报告时间：2026-04-14 17:11 UTC / 2026-04-15 01:11 CST*
*扫描工具：xixi 全量扫描 cron*
*数据来源：GitHub API v3, gh cli*
