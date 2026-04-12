# 全量扫描报告 2026-04-12 20:55 CST (第101轮)

## GitHub Issues（方向1）
发现了 **15+** 个新 open 项，其中最重要的是：

### 最高优先级候选

**#65341 — memory-core dreaming narrative 每次运行都静默失败（bug:behavior, 1 comment）**
- 根因已定位：`server.impl-*.js` 的 `createGatewaySubagentRuntime().run()` 用条件 spread `...params.idempotencyKey && {...}` 省略了必填字段 `idempotencyKey`，而 `AgentParamsSchema` 要求该字段非空
- 影响：所有启用了 memory-core dreaming 的用户（v2026.4.11）；次生问题是 cron job 仍报告 `lastRunStatus: "ok"` 和 `consecutiveErrors: 0`，静默失败
- 修复方案已给出：`crypto.randomUUID()` 作为 fallback；**建议 aoao 接单（S 级，1-2 小时可 PR）**

**#65347 — OpenAI Codex OAuth `invalid_scope` 认证失败（bug+regression, 0 comments）**
- v2026.4.10 起 openai-codex provider 的 OAuth 请求包含 `model.request` scope，被 OpenAI 拒绝
- 用户无法重新认证，即使手动 `openclaw models auth login` 也失败
- 已有 refresh_token 但 OAuth flow 彻底中断
- **建议 aoao 接单（调查 scope 变更是否 OpenAI API 端变化）**

**#65328 — 同步 readFileSync 在 .map() 里导致 99% CPU（bug, 0 comments）**
- 6 个 agent 时 gateway 持续 99% CPU 30+ 分钟
- 根因：plugin 初始化时对每个 agent 并行读 MEMORY.md/AGENTS.md/SOUL.md，同步读文件阻塞事件循环
- `lsof` 显示同一 MEMORY.md 被多次同时打开（不同 fd）
- **建议 aoao 接单（M 级）**

**#65346 — Skill catalog prompt injection 忽略 blockedByAllowlist 过滤（0 comments）**
- `skills.allowBundled` 配置和 `blockedByAllowlist` 计算结果被忽略
- 已从 allowlist 移除的 skills 仍注入到 system prompt，消耗 token
- **建议 aoao 接单（S 级）**

**#65343 — Ollama provider 每次请求 120 秒超时（0 comments）**
- v2026.4.11；直接 curl 0.5-6 秒，OpenClaw 120 秒超时
- 可能与 P443 (#61487, HTTP timeout 硬编码 ~60s) 同根
- **建议 aoao 确认 #61487 是否覆盖**

**#65335 — Dreams Diary 调用未知 RPC `wiki.importInsights`（0 comments）**
- Control UI → Dreams → Diary 触发 `GatewayRequestError: unknown method: wiki.importInsights`
- memory-core dreaming 启用时暴露，影响 v2026.4.11

**#65334 — CLI 报告错误版本 2026.4.1 而实际是 2026.4.11（0 comments）**
- `openclaw agents list` 报告 `host is 2026.4.1; skipping load`，但实际版本 2026.4.11
- 插件加载被误判跳过

**#65322 — chat.history 在 gateway 启动期间不可用（bug+regression, 0 comments）**
- 极简 bug 描述：`atewayRequestError: chat.history unavailable during gateway startup`
- v2026.4.11, macOS；需更多信息才能评估

**#65321 — 内置 TTS provider 在 2026.4.5 后持续损坏（bug+regression, 0 comments）**
- 使用 elevenlabs 时完全不工作；信息不足，需跟进

**#65329 — msteams DM inline images/files 被静默丢弃（1 comment）**
- `msteams://media/...` 占位符无法解析；RSC only 配置
- 已有 1 条评论，详情待读

**#65326 — Google Chat JWT/event format 不兼容（0 comments）**
- Google 2026 年起所有 Chat API apps 改走 Add-ons framework，JWT 格式和 webhook body 格式均变化
- 需 `audienceType: "app-url"` 而非 `audienceType: "project-number"`
- 影响所有 Google Chat 用户；**建议修文档**

**#65339 — Feature: Same-model retry with backoff before fallback（0 comments）**
- 重开 #17465；429/503 超时后应重试同模型（5-10s 后恢复）而非立即切换
- 已有完整日志证据

## 插件仓库（方向2）
发现了 **1 个** 新候选：

**Tencent/openclaw-weixin #57 — 无法卸载（0 comments）**
- `openclaw plugins uninstall weixin` 失败
- 🔒 代码不可见
- 建议外部追踪

**Tencent/openclaw-weixin #56 — ACP thread binding adapter for WeChat（PR, 0 comments）**
- 修复 #55（ACP thread binding）；与 thread-bound persistent session 相关

**继续追踪：**
- #54（图片查看 sharp 模块缺失）
- #53（定时提醒未创建 cron 任务）
- #55（ACP thread binding feature request）

## 贡献者文件区域（方向3）
扫描了 **10 个**排名最末的 contributors 的文件区域，发现 **0 个**新的高相关 open bug：

**lml2468** (10 contributions) 最近活跃文件：
- `src/auto-reply/reply/agent-runner-memory*`、`src/auto-reply/reply/memory-flush.ts`
- `src/gateway/control-plane-rate-limit*`、`src/gateway/server-maintenance.ts`、`src/gateway/server-methods/nodes.ts`
- `src/infra/agent-events*`
- `extensions/discord/src/monitor/message-handler.preflight.test.ts`、`extensions/msteams/src/sdk.ts`
- `src/cli/daemon-cli/install.ts`、`src/cli/daemon-cli/lifecycle-core.ts`

→ 相关已追踪 bug：P59897（control-plane-rate-limit ↔ #64911 WS ready 问题）、P59898（server-maintenance ↔ #64984 reconnect OOM）；本轮未发现新 bug

**BruceMacD** (9) 最近活跃：Ollama provider/stream/auth 相关；与 #65343(Ollama timeout) / #65328(CPU) 高相关，未发现新 bug

**christianklotz** (11) 最近活跃：Telegram/msteams/compaction；与 #65329(msteams DM images) 相关

**其他**：无新发现

## 追踪 PR 反馈（方向4）
- **PR #65206**（cron persist state, P59904）：Greptile P2 新评论：`lastErrorReason` 未校验 `FailoverReason` enum；建议加白名单校验；**非阻塞性，可作为 follow-up 处理**
- **PR #65242**（CompletionDeliveryGate ACP）：Greptile P2 新评论：`getCompletionClaim` 在 gate mode "off" 时静默返回 undefined；**建议 review 后要求 author 修复**
- **PR #65219 / #65224**（GPT-5.4 parity rollups）：Greptile 确认 line 18 已加 `.trim()`；streaming SSE 支持需更新 block comment；**接近 merge ready，继续推动**
- 追踪 PR 整体状态：无新的 maintainer 人工反馈；两条 greptile 自动 review 为本轮新信息

## 结论
**最高优先级是 #65341（memory-core dreaming idempotencyKey bug）和 #65347（OpenAI Codex OAuth invalid_scope regression）。**

建议：
1. **aoao 接单 #65341** — 根因明确，fix 简单，workaround 可直接验证
2. **aoao 调查 #65347** — 确认 OpenAI 是否变更了 Codex OAuth scope
3. **aoao 调研 #65328** — 同步 readFileSync 在 .map() 的性能问题，影响所有多 agent 用户
4. **#65242 greptile P2 反馈** — review 后决定是否要求 author 修复再 merge
5. **继续推动 #65219/#65224 merge** — greptile review 通过，只剩文档更新

**本轮无 blocker。**
