# 全量扫描报告 2026-04-16T05:31 CST (21:31 UTC)

## GitHub Issues（方向1）

**新发现 X≈30+ 个 Open Issues（过去2小时内更新）**，其中最高优先级候选：

### 🔴 Regression / Crash 类（建议立即接单）
| # | 标题 | 标签 | 优先级 |
|---|------|------|--------|
| **67394** | WhatsApp group auto-reply silently fails — reply generates but never delivers | bug+regression | **S** |
| **67393** | Massive VM bloat (22GB+) immediately on Gateway startup — 同 #6413（之前被标记 won't-fix 但问题仍存在） | bug+crash | **S** |

### 🟠 功能/行为类新 Issue
| # | 标题 | 备注 |
|---|------|------|
| **67402** | Internal control/update messages leak into normal chat sessions after gateway restarts | 内部消息混入用户会话，导致 assistant 误回复内部事件 |
| **67400** | The agent is unable to create persistent sub-agent sessions — circular dependency mode="session" vs thread=true | bug label，regression |
| **67399** | Circuit breaker for repeated tool failures — agent 无限重试同一失败工具，烧tokens | 纯设计缺失，无 circuit breaker |
| **67397** | Dreaming cron skipped by heartbeat activeHours（夜间 03:00 dreaming 被 activeHours 窗口阻断） | docs 默认示例就是 03:00，矛盾 |
| **67396** | Telegram silently drops messages > 4096 chars — 无 error 无截断无 partial | 静默失败，用户体验差 |
| **67379** | qmd scope denies subagent sessions — channel/chatType resolve to undefined | subagent 降级到 builtin MEMORY.md，无声退化 |
| **67377** | Cron classifier sets status=error when run summary narrates success（与 #67172 相反，inverse bug） | #67186（fix for #67172）尚未 merge |
| **67363** | memory-core dreaming deep phase promotes raw verbatim daily-log snippets to MEMORY.md without distillation | 污染 MEMORY.md |
| **67362** | memory-core dreaming cron reconciliation depends on stale one-time startup cron reference | 运行时 reconcile 永远失败 |
| **67361** | Hook-delivered messages lost on bootstrap-context:full — agent 无法记住自己发过的通知 | bootstrap-context:full 覆盖了 hook turn 的上下文 |

**已有追踪勿重复**: #54952 #54964 #55008 #55013 #55153 #55137 #55466 #55458 #55479 #67237 #67314 #67323 等

---

## 插件仓库（方向2）

**Tencent/openclaw-weixin**: 45 个 open issues（repo 公开但 issues 不可通过 API 访问，可能为 private 或中文）

→ 无需新增追踪项，已在 P60220 追踪微信插件问题

**openclaw 相关插件**: 未发现新的高优先级 open issues

---

## 贡献者文件区域（方向3）

扫描了排名最末的 10 个贡献者（chilu18, sliverp, clawdinator[bot], lml2468, Whoaa512, darkamenosa, BruceMacD, davidrudduck, pandego, joaohlisboa）：

- **8/10 无最近 commits**，无文件可扫描
- 2 个有 commits 的用户（sliverp, lml2468 等）— API 查询文件变更返回空

→ **无新发现**，无需追加追踪项

---

## 追踪 PR 反馈（方向4）

### 重大新反馈

| PR | 新评论 | 严重度 | 建议 |
|----|--------|--------|------|
| **#67376** (MCP loopback bearer token bind) | `chatgpt-codex-connector[bot]` P1: `clearActiveMcpLoopbackRuntime()` 无条件清除全局 runtime，race with `closeMcpLoopbackServer()`，`ensureMcpLoopbackServer()` 可在 close 期间启动新 server 然后被旧 close 回调清掉 | **P1** | 需 maintainer 或作者确认 fix |
| **#67376** (same PR) | P2: `runPreparedCliAgent` 中 token revocation 在 `cleanup?.()` 之后，cleanup 异常时 unregister 不执行 → bearer token 泄漏 | P2 | 同上 |
| **#67253** (models authStatus) | `omarshahine` (maintainer) 已响应 Greptile/bot P2 评论并 fix (04fbbf06c2) | 已修复 | 无需跟进 |
| **#67186** (cron classifier fix for denial tokens) | **仍 Open，未 merge** — #67377（inverse bug: status=error on success）待同作者处理 | 阻塞 | 需跟进 |

### maintainer PRs 状态
- **#67401** (stability: session skills snapshot, tool-loop guard, LM Studio preload backoff) — size:L, gateway+agents labels，无新评论
- **#67372** (docs gateway protocol) — maintainer + docs label，已有 maintainer review
- **#67395** (Windows pnpm.exe + Lobster fallback) — 有评论，需 review

---

## 结论

**最高优先级**：
1. 🔴 **#67394** WhatsApp group auto-reply silently fails（regression，2026.4.14）
2. 🔴 **#67393** VM bloat 22GB+（之前被标记 won't-fix 但持续存在）
3. 🟠 **#67400** persistent sub-agent sessions circular dependency（bug，block ACP 功能）
4. 🟠 **#67376 P1** MCP loopback runtime race condition（需 confirm fix 未 in-flight）
5. 🟠 **#67396** Telegram 4096 silent drop（usability gap）
6. 🟠 **#67399** circuit breaker design gap（token burn 风险）

**建议**：
- **aoao 接单** #67394 + #67396（Telegram/WhatsApp 渠道问题，size:S 可快速修）
- **跟进 #67376 P1** — 确认 maintainer 是否已处理 MCP loopback race
- **跟进 #67186** — cron classifier fix 未 merge，#67377 inverse bug 又来，需合并处理
- **#67393** 重新评估 — 之前 won't-fix，但用户仍在报，根因可能与 #66886 内存泄漏相关

---

## inProgressFixes（本次扫描确认）

| ID | 状态 | 备注 |
|----|------|------|
| fix-67173 | 待确认 | queued messages dropped after timeout |
| fix-67270 v3 | LLM timeout retry | exec preflight scanner |
| fix-67261/67257/67250 | 待确认 | various Telegram/onboarding regressions |

**heartbeat-state.json**: lastPrCreatedAt 约 2026-04-15T21:11 UTC（约 4 小时前无新 PR）— 需确认是否有 PR 在跑
