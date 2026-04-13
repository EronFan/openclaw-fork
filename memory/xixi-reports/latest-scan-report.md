# 全量扫描报告 2026-04-13 07:39 CST (2026-04-12 23:39 UTC)

**第106轮 | 扫描时间: 2026-04-13 07:39 CST**

---

## GitHub Issues（方向1）

**发现了 20+ 个新候选，最值得注意的：**

| 优先级 | issue | 描述 | 备注 |
|--------|-------|------|------|
| 🔥 | [#65594](https://github.com/openclaw/openclaw/issues/65594) | **M** packaging: runtime dist build does not emit control-ui/ when only pnpm build is run | 最新更新(23:39 UTC)，0评论；build流程bug |
| 🔥 | [#65584](https://github.com/openclaw/openclaw/issues/65584) | **S** cron CLI commands can succeed but hang instead of exiting cleanly | 0评论；CLI teardown bug，清晰可本地复现 |
| 🔥 | [#65578](https://github.com/openclaw/openclaw/issues/65578) | **regression** Kilo Gateway model auto-discovery only returning Kilo/kilo-auto | bug+regression；2026.4.11；只有1个模型可选而非500+；1评论 |
| | [#65581](https://github.com/openclaw/openclaw/issues/65581) | **bug:behavior** Agent emits duplicate Discord messages on every response | bug+bug:behavior；streaming关闭仍双发；0评论 |
| | [#65582](https://github.com/openclaw/openclaw/issues/65582) | **bug** ENOENT: no such file or directory, mkdir '/home/node' on macOS | bug；native无Docker环境；0评论 |
| | [#65576](https://github.com/openclaw/openclaw/issues/65576) | **M** Cron runs silently disable LLM idle watchdog by default (v2026.4.11) | 无explicit idleTimeout时 watchdog 被禁用；cron timeout 不足导致 providers 耗尽；0评论 |
| | [#65571](https://github.com/openclaw/openclaw/issues/65571) | **regression** Browser CDP fails on Linux (Chrome CDP port binding) | bug+regression；2026.4.8~4.11全部中招；0评论 |
| | [#65590](https://github.com/openclaw/openclaw/issues/65590) | **bug** MCP streamable-http transport not forwarding custom headers to remote servers | MCP bug；0评论 |
| | [#65572](https://github.com/openclaw/openclaw/issues/65572) | **M** TUI chat.history fails without retry on gateway restart race condition | bug；与 #65576 同簇（cron/ws restart时序）；0评论 |
| | [#65568](https://github.com/openclaw/openclaw/issues/65568) | **bug** Discord-bound persistent Codex ACP session cannot be resumed | ACP session恢复bug；0评论 |
| | [#65566](https://github.com/openclaw/openclaw/issues/65566) | **bug** Streaming partialParse errors crash agent runs | JSON解析错误导致crash；0评论 |
| | [#65563](https://github.com/openclaw/openclaw/issues/65563) | **bug** plugins/webhooks create_flow fails with NOT NULL constraint | DB schema问题；0评论 |
| | [#65538](https://github.com/openclaw/openclaw/issues/65538) | **bug:behavior** Screen readers announce every token during streaming (aria-live) | Accessibility bug；0评论 |
| | [#65580](https://github.com/openclaw/openclaw/issues/65580) | **bug** macOS Gmail/Chrome send runs ambiguous outcomes | macOS特定；0评论 |

**建议 aoao 优先接单**：
- #65584（cron hang，S级，根因清晰）
- #65578（Kilo regression，regression标签，影响模型选择）
- #65581（Discord duplicate messages，高频复现）
- #65576（cron LLM watchdog disabled，级联影响大）

---

## 插件仓库（方向2）

**发现了 0 个近2小时更新的候选**

Tencent/openclaw-weixin 仓库近2小时无新issue更新。最近的是 #57 "unable to uninstall"（09:18 UTC），超出2小时窗口。

已追踪的 weixin issues 状态：
- [#57](https://github.com/Tencent/openclaw-weixin/issues/57) unable to uninstall — 新发现，updated 09:18 UTC
- [#55](https://github.com/Tencent/openclaw-weixin/issues/55) ACP thread binding — Feature request
- [#54](https://github.com/Tencent/openclaw-weixin/issues/54) 图片查看功能（sharp缺失）— bug
- [#53](https://github.com/Tencent/openclaw-weixin/issues/53) 定时提醒未创建cron任务 — bug

---

## 贡献者文件区域（方向3）

**扫描了排名最末的10个贡献者的文件区域，发现高相关 open bug：**

### lml2468（10 contributions）— 最活跃末段贡献者

最近5个commit涉及文件：
- `src/gateway/control-plane-rate-limit.ts/test.ts` — rate limit
- `src/gateway/server-maintenance.ts` — server maintenance
- `src/gateway/server-methods/nodes.ts/invoke-wake*` — node invoke
- `src/gateway/session-transcript-key.ts/test.ts` — session key
- `src/infra/agent-events.ts/test.ts` — agent events
- `src/auto-reply/reply/agent-runner-memory*.ts` — memory dedup
- `src/auto-reply/reply/memory-flush.ts` — memory flush
- `src/auto-reply/reply/agent-runner.ts/runreplyagent.e2e.test.ts` — agent runner
- `src/cli/daemon-cli/install.ts` — daemon install
- `extensions/msteams/src/sdk.ts/test.ts` — MS Teams SDK

**相关 open bugs：**
- [#64911](https://github.com/openclaw/openclaw/issues/64911) gateway 提前 ready 但 WS control plane 尚不可用 — lml2468 活跃区 `control-plane-rate-limit*`，已追踪
- [#64984](https://github.com/openclaw/openclaw/issues/64984) reconnect 后 MCP 子进程不清理导致 OOM — lml2468 活跃区 `server-maintenance*`，已追踪
- [#55679](https://github.com/openclaw/openclaw/issues/55679) memoryFlush 永不触发 — lml2468 活跃区 `memory-flush*`，已追踪

### 其他末段 contributors（joelnishanth/xinhuagu/MoerAI/aether-ai-agent 等）

近20个commit的files信息无法通过 gh api 直接获取（可能需要更高权限）。从 commit SHA 来看，这几位 contributor 的提交频率较低（3-12个commits），且活跃时间分散，无明显的近期文件区热点。

**结论**：方向3核心发现仍是 lml2468 的文件区，该贡献者已持续活跃于 gateway/server-maintenance/memory-flush 等核心路径。相关 open bugs 均已在前序轮次加入追踪，暂无新的高优先级遗漏。

---

## 追踪 PR 反馈（方向4）

### 重大发现：PR #65589 maintainer review 指出关键缺陷

| PR | 状态 | maintainer 评论 |
|----|------|----------------|
| [#65589](https://github.com/openclaw/openclaw/pull/65589) `feat(memory-core): dreaming circuit breaker` | OPEN | **chefallan (maintainer) 发出 P1 review**：DreamingBudgetEnforcer 从未被接入 dreaming pipeline (`dreaming.ts` 和 `dreaming-p*` 未调用 Enforcer)；⚠️ PR 修的是 budget enforcer 本身，但未连接实际调用路径 |
| [#65583](https://github.com/openclaw/openclaw/pull/65583) `feat(agents): per-agent model optimization` | OPEN | chefallan 多处评论（12条），size:L，CLI+Dashboard；持续 review 中 |
| [#65591](https://github.com/openclaw/openclaw/pull/65591) `agents: hybrid personality mode` | OPEN | chefallan 已 review（10条评论）；这是 issue #65587 的配套 PR |
| [#65577](https://github.com/openclaw/openclaw/pull/65577) `Outbound: centralize payload normalization` | OPEN | greptile 5/5 safe to merge；aisle security bot 报告高危安全问题（MEDIA directive 本地文件泄露）；**建议：merge 前需确认安全问题修复** |
| [#65574](https://github.com/openclaw/openclaw/pull/65574) `fix(mcp-stdio): propagate proxy env vars` | OPEN | 9条评论，maintainer P1×2 已修复，新 P1（lowercase proxy precedence）需确认覆盖 |
| [#65539](https://github.com/openclaw/openclaw/pull/65539) `feat(session-message-events) socket.drain` | OPEN | 14条评论，gateway+agents，size:M |
| [#65233](https://github.com/openclaw/openclaw/pull/65233) `Run context-engine turn maintenance as idle-aware background work` | OPEN | 24条评论，agents+docs，size:XL |
| [#65224](https://github.com/openclaw/openclaw/pull/65224) `agents: GPT-5.4 parity proof rollup` | OPEN | 30条评论，GPT-5.4 parity rollup 收尾阶段 |

### 已追踪 PRs 状态（无 maintainer 新评论）：
- #65593 (fix mattermost media) — 0 maintainer comments
- #65592 (feat searxng onboarding) — 0 maintainer comments
- #65575 (fix UI aria-live) — 1 review pending draft resolution
- #65569 (fix memory-wiki token-overlap) — 6 comments, size:M
- #65567 (fix telegram hashText) — 0 comments, size:XS
- #65541 (fix deliver text blocks progressively) — 3 comments
- #65449 (fix amazon-bedrock au prefix) — 1 comment
- #65364 (feat plugins registerProviderRuntimeAuthOverride) — 3 comments, size:L
- #64787 (fix streamTo for subagent spawns) — 9 comments
- #64653 (honor provider-prefixed model ids) — 3 comments
- #64597 (skip futile overflow truncation retries) — 2 comments
- #64512 (feat amazon-bedrock service_tier) — 6 comments
- #61982 (fix openai codex reasoning/thinking) — 14 comments
- #61483 (feat android http.request invoke) — 11 comments
- #61121 (Gateway pass agentId in ingressOpts) — 3 comments
- #59898 (fix agents handle explicit empty tool lists) — 30 comments, size:XL

---

## 结论

**最高优先级：**

1. **[#65589](https://github.com/openclaw/openclaw/pull/65589) maintainer P1 review — DreamingBudgetEnforcer 未接入 pipeline**（方向4）
   - chefallan 明确指出：budget enforcer 修好了但从未被调用
   - 风险：dreaming 功能修了个寂寞，仍会 runaway cost
   - 建议：aoao 确认 #65589 是否修复了这个连接问题，如未修复需补充

2. **[#65577](https://github.com/openclaw/openclaw/pull/65577) MEDIA directive 本地文件泄露安全漏洞**（方向4）
   - aisle security bot 报告高危：MEDIA:/etc/passwd 可被读取发送
   - PR 测试覆盖好但安全缺陷未修复，merge 前需处理

3. **[#65584](https://github.com/openclaw/openclaw/issues/65584) cron CLI hang after success**（方向1 新候选）
   - S级，0评论，根因在 CLI/gateway transport teardown
   - 建议 aoao 接单

4. **[#65578](https://github.com/openclaw/openclaw/issues/65578) Kilo model auto-discovery regression**（方向1 新候选）
   - regression，只有1个模型可选而非500+
   - 建议 aoao 接单

**建议操作：**
- aoao 优先检查 #65589 是否覆盖 DreamingBudgetEnforcer 接入问题
- aoao 接单 #65584/#65578（两小时内可本地复现）
- 确认 #65577 merge 前是否处理 MEDIA directive 安全问题
