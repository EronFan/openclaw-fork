# 全量扫描报告 2026-04-13 02:26 CST (第105轮)

## GitHub Issues（方向1）

**发现了 28+ 个近 2 小时更新的 open issues**，其中新候选最重要的：

### 🔴 最高优先级新候选

1. **#65501** `forceFlushTranscriptBytes is a no-op on fresh sessions` (无标签, High severity)
   - 根因：`forceFlushTranscriptBytes` 在 legacy compaction 未触发前完全不工作
   - 影响：文档承诺的 TPM overflow 保护在新鲜会话上完全失效，直到 compaction 路径已触发一次
   - 可修性：M，代码路径清晰
   - **建议 aoao 接单**

2. **#65500** `[Bug][regression]` Custom models not shown by /models in Telegram or Web Console UI
   - 2026.3.24 → 2026.4.11 升级后 Ollama/oMLX/LM-Studio 自定义模型在 Telegram 和 Web Console 均不可见
   - **已覆盖：#65211** (provider catalog 未合并用户模型)，可能同根因，关联追踪

3. **#65470** `[Bug][bug:behavior]` CommandLane.Nested maxConcurrent defaults to 1 — sessions_send 全串行化
   - 高优先级：生产 90+ agents 完全串行，阻塞多 agent 编排
   - 代码证据清晰：`applyGatewayLanes()` 无处覆盖该默认值
   - **建议 aoao 接单（S-M）**

4. **#65498** `[Bug][bug:crash]` Main-session user task loses final reply after heartbeat/exec-completion interrupt
   - 心跳或 exec 完成中断时，原始任务的最终用户回复丢失
   - bug:crash 标签，serious
   - **建议 aoao 接单**

### 🟡 中高优先级新候选

5. **#65499** `[Bug][regression]` --force-reset-cross-signing sends malformed UIA response
   - 2026.4.2 → 2026.4.11 均受影响，HTTP 401 "Unknown message"
   - 安全adjacent（key reset 功能损坏）

6. **#65495** Browser tool SSRF policy blocks CDP connection to localhost on WSL2
   - 清晰 fix：`dangerouslyAllowPrivateNetwork` 选项缺失；**与 #65208/#65204 同簇**

7. **#65494** iMessage channel fails: `ReferenceError: accountInfo is not defined`
   - iMessage 回复失败，regression（版本未标，但描述清晰）

8. **#65493** delivery-mirror duplicates messages sent via `message(action=send)` tool
   - 清晰 bug：delivery-mirror 对每条 message(action=send) 发出二次 plain-text 副本
   - 范围清晰（Telegram message tool 用户），可修性 S

9. **#65486** Gateway restart does not invalidate approval-pending session tool results — infinite loop
   - 重启后 stale approval IDs 导致 `INVALID_REQUEST` 循环
   - 严重，影响所有使用 approval 的用户

10. **#65485** Gateway SIGTERM-restarts kill in-flight agent runs on non-critical config changes
    - 任何 `openclaw.json` 变化触发 SIGTERM，包括不需要重启的配置项
    - 在飞 agent runs 被杀，产生静默失败

### 其他（feature/low-priority）

- #65490: Running an OpenClaw agent in production: the execution discipline gap (文档类)
- #65488: [Bug] Issue with context with Heartbeat turns (lightContext:true 高 token usage)
- #65487/#65477: Show model/token usage in usage footer (feature)
- #65483: Telegram Topics 会话隔离功能请求
- #65480: QMD regression — 已追踪 P59880
- #65479/#65466/#65464: 已追踪项
- #65475: Google Lyria music generation 404 (baseUrl double-includes /v1beta)
- #65474: Skills Index Mode feature request
- #65472: session-corpus not generated when session spans multiple days
- #65468: MEDIA directive delivers audio attachment twice on Telegram
- #65465: Ollama compaction reserve config ignored (regression)
- #65463: TTS parser doesn't match plain [[tts]] tags
- #65455: control ui 梦境界面显示问题 (regression)
- #65454: youtube-transcript MCP returns status ok without transcript
- #65451: WhatsApp outbound media (images) not attaching
- #65450: Image Tool Fails with 'Unknown model' v2026.4.11

---

## 插件仓库（方向2）

**Tencent/openclaw-weixin** 发现 1 个新 issue：

- **#57** `unable to uninstall` — 无评论，2026-04-12 09:18 UTC 新发
  - 🔒 代码不可见；无法评估根因
  - 建议：外部追踪

已有追踪项无更新：
- #56 ACP thread binding adapter PR — maintainer 在推进
- #55 ACP thread binding feature — 同上
- #54 图片查看功能不可用（sharp 缺失）— 已追踪 P59883
- #53 AI 定时提醒未创建 cron 任务 — 已追踪 P59884
- #40 openclaw-weixin startup hang — 已追踪 P331

---

## 贡献者文件区域（方向3）

扫描了排名最末的 10 位 contributors（9 commits ~ 11 commits 区间）：
`pandego, BruceMacD, lml2468, Whoea512, clawdinator[bot], aether-ai-agent, MoerAI, chilu18, emonty, jadilson12`

**发现**：merge commits 占比高，无法提取有效文件变更路径。最近有意义 commit：
- **lml2468**: 最近 commit 在 2026-04-10，merge commit，无法提取文件区
- **BruceMacD**: 最近 commit 在 2026-04-07，merge commit
- **MoerAI**: 最近 commit 在 2026-04-10

merge commit 限制了文件区扫描有效性。本轮文件区扫描**无新的可关联 open bug 发现**。

---

## 追踪 PR 反馈（方向4）

**17 个新 PR 全部在过去 2 小时内提交**（本轮新 PR 洪泛）：

### 重点 PR 反馈

1. **PR #65452** `[security fix] Fix SQL injection in memory schema management` by apocalypse9949
   - ⚠️ **Greptile P2 评论**：definition 参数仍然未被转义，SQL 注入漏洞 Latent
   - **需要 maintainer 确认**：greptile-apps[bot] 指出同一问题两次
   - 建议：向 maintainer 确认该 P2 是否已解决，#65452 是否需要 re-open

2. **PR #65453** `fix(models): add image input to MiniMax-M2.7 catalog` by mjamiv
   - ✅ **直接对应 aoao 已接单**的 #65442（MiniMax-M2.7 图片附件被静默丢弃）
   - PR 修 catalog，`input: ["text", "image"]`；建议确认 #65442 是否可以直接 close

3. **PR #65496** `fix(browser): skip SSRF policy for managed loopback CDP readiness` by keithce
   - Greptile Summary: 修复 managed local openclaw profile 的 CDP readiness false-negative
   - 与 #65495（WSL2 CDP SSRF）**同期同簇**，建议确认是否覆盖 #65495

4. **PR #65461** `fix: sendPolicy deny should suppress delivery, not inbound processing (#53328)` by omarshahine
   - E2E test confirmed fix applied
   - 建议确认 #53328 是否可以 close

### 其余新 PR（快速审查）

| PR # | Title | Author | 建议 |
|-------|-------|--------|------|
| 65497 | reuse gateway provider registry in worker sessions | yubingjiaocn | 关联 #62051 |
| 65492 | make slug generator timeout configurable | fabioquinzi | 新功能 |
| 65491 | CLI detect env-backed audio providers | scoootscooob | 关联音频 provider 检测 |
| 65489 | avoid duplicate voice member lookup (Discord) | VACInc | 常规修复 |
| 65482 | retry watch.subscribe startup failures (iMessage) | vincentkoc | iMessage regression |
| 65481 | prefer --mask for collection patterns (memory-qmd) | ccage-simp | QMD regression |
| 65476 | persist capability in plugin registry cache (memory-wiki) | lanyasheng | memory-wiki 相关 |
| 65473 | docs(gateway): Docker-out-of-Docker Paradox | jlapenna | 文档 |
| 65460 | lazy-load browser help subcommands | pandego | 性能改进 |
| 65459 | centralize manifest owner trust policy | vincentkoc | 插件安全 |
| 65457 | stop dropping repeated markdown tokens in chat stream | mohuaxiao | gateway 流式处理 |
| 65447 | lazy-refresh Private API status on send (bluebubbles) | omarshahine | 关联 #43764 |

---

## 结论

**最高优先级是：**

1. 🔴 **#65501** `forceFlushTranscriptBytes is a no-op` — 高严重性，TPM 保护失效，S-M 可修性，建议 **aoao 立即接单**

2. 🔴 **PR #65452** SQL injection fix 的 Greptile P2 — 需要 maintainer 确认 definition 参数是否已完全转义，**存在 latent SQL 注入风险**

3. 🟡 **#65500** Custom models not shown in Telegram/Web Console — regression，影响所有自定义模型用户，与 #65211 可能同根

4. 🟡 **#65470** CommandLane.Nested maxConcurrent=1 导致 sessions_send 全串行 — 阻塞 90+ agents 生产部署，**建议 aoao 接单**

5. 🟡 **PR #65453** MiniMax-M2.7 image catalog — 直接解决 aoao 已接单的 #65442，建议确认后 close issue

**建议：**
- 向 maintainer 询问 PR #65452 的 Greptile P2 问题
- aoao 优先接 #65501（forceFlushTranscriptBytes）和 #65470（CommandLane serialization）
- 继续盯 #65452 Greptile 反馈演变
