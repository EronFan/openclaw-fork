# 全量扫描报告 2026-04-14 21:50 CST (13:50 UTC)

## GitHub Issues（方向1）
- 发现了 **14个新候选**（近2小时内更新 + 新开 issue 中未追踪项）
- **最重要的 5 个新发现：**

### 🔥 P60101 #66573 [Bug] chat.history limit=2000 exceeds server maximum of 1000, no retry
- **级别：** S (bug)
- **根因明确：** 客户端写死 `limit=2000`，服务器上限 1000，收到 INVALID_REQUEST 后静默跳过不重试
- **影响：** 历史上下文丢失，多轮对话质量下降；静默失败用户无感知
- **环境：** Windows 2026.4.10, Feishu websocket, ollama/qwen3.5:9b
- **已有建议修复方案：** 客户端不指定 limit 或收到 INVALID_REQUEST 后自动调整 limit 重试
- **0评论，未认领**
- **建议：接单，S级可修性好**

### 🔥 P60102 #66564 [Bug] Control UI feels significantly laggier in 2026.4.12 during normal chat use
- **级别：** S (regression)
- **现象：** 2026.4.12 后 Control UI 初始加载卡顿，回车后消息需要几秒才能稳定显示
- **证据充分：** 提供了 Bundle audit 结果，`node.list` 每 5s 轮询、`logs` 每 2s 轮询、`debug` 每 3s 轮询；eager connect-time 加载了 `health`、`node.list`、`device.pair.list`、`commands.list`
- **相关 PR：** #66575 (filter heartbeat content from session selector labels) - 正在修复但未完全解决
- **0评论，未认领**
- **建议：接单，与 #66575 可能相关但独立**

### P60103 #66561 [Bug] openai-codex SSE stream begins, but embedded run aborts locally and is surfaced as timeout (408)
- **级别：** S (bug+behavior)
- **亮点：** 作者用 mitmproxy 抓包，证明了 upstream 已经开始响应（first response byte 已到达），但 client 端仍然 abort，然后被误分类为 timeout
- **runId=fb87df63** 时间线清晰：first response byte 12:03:01.557，client close 12:03:02.215，gateway timeout log 12:03:02.205（几乎同时）
- **误判影响：** failover 逻辑触发，但实际不是 provider 问题；debug 困难
- **0评论，未认领**
- **建议：接单，与 SSE stream 处理/window 超时判断相关**

### P60104 #66558 [Bug] sessions_spawn / sessions_send not available in main agent despite tools.profile: "coding"
- **级别：** S (bug)
- **现象：** `tools.profile: "coding"` 应该包含 `group:sessions`（sessions_spawn, sessions_send 等），但 main agent 实际工具列表里没有
- **相关 issue：** #42726、#56208（同类根因但 sessions_spawn 是 native tool 不一样）
- **日志证据：** `tools.allow allowlist contains unknown entries (edit, exec, process, browser...)` 警告反复出现
- **0评论，未认领**
- **建议：接单，工具配置解析问题**

### P60105 #66553 [Bug] Race condition — voice message delivery fires before STT transcription is available
- **级别：** M (架构 bug)
- **清晰描述：** WhatsApp voice note → `StoreMessage()` 立即提交 `transcription=NULL` → agent turn 触发 → agent 读到空 transcription → STT 2-5秒后完成但 agent turn 已结束 → transcript 被 orphaned
- **影响：** 100% 可复现；WhatsApp 语音消息完全失效；用户必须发 follow-up text 才能触发重读
- **提供了多种解决方案：** `wait_for_transcript` flag / `STT_DONE` event trigger / `inbound_processing_delay` 配置
- **0评论，未认领**
- **建议：接单但 M 级，先确认根因路径再开始修复**

### 其他新发现（已记录待追踪）
- #66522 (M) - Session index rebuilds on restart, session history 完全丢失（session 文件存在但 sessions.json 重建后变 invisible）
- #66500 (S) - Feishu Chinese filenames garbled（UTF-8 → Latin-1 mojibake）- **已在 PR 覆盖区，待确认**
- #66540 (S) - replyToCurrent default false blocks implicit replyToId - **已在 PR #66562 覆盖**
- #66535 (S) - /compact command cannot be canceled while in progress - **值得接单**
- #66534 (S) - lifecycle:end event missing aborted/stopReason - **已在 PR #66574 覆盖**
- #66549 (S) - dry-run still delivers message - **已在 PR #66559 覆盖**
- #66514 (S) - Browser control reports healthy but CDP path dead - **已在 aoao 追踪**

---

## 插件仓库（方向2）
- 发现了 **1个新候选**：

### Tencent/openclaw-weixin #65 [Bug] 微信消息接收乱序，有的消息网页端可以收到微信收不到
- **更新时间：** 2026-04-14 09:33:06 UTC（近24小时内）
- **问题：** WeChat 消息接收乱序，部分消息只在网页端收到，微信端丢失
- **0评论，未认领**
- **建议：** 跟进确认是否与 openclaw core 的 message ordering 相关

### 其他 WeChat issues（已追踪/已覆盖）
- #50 (P60095) - 定时推送无法触发 - 已追踪
- #65 - 新发现
- PR #49 (preserve quote context for voice) - 已 merge
- PR #56 (ACP thread binding) - 已 open

---

## 贡献者文件区域（方向3）
- 扫描了排名最末的 **10位 contributors**（贡献量 87→45）
- 名单：scoootscooob(87), github-actions[bot](81), BunsDev(81), Sid-Qin(80), joshp123(71), huntharo(70), bmendonca3(69), mcaxtr(69), onutc(67), jalehman(66)
- **无新发现**（本轮扫描的 issue 均与这些 contributor 的最近文件区无直接重叠）

---

## 追踪 PR 反馈（方向4）
- **PR #66575** (fix webchat: filter heartbeat from session selector) - **maintainer 新评论（P1×2）：**
  - **P1-1:** dry-run 分支没有调用 `runMessageAction`，导致 `result` 缺少必需字段（action/kind/handledBy/payload），破坏了下游 `buildMessageCliJson` 和 `formatMessageCliText` 的格式契约
  - **P1-2:** `aborted` 逻辑把除了 `end_turn`/`stop_sequence` 之外的所有 stop reason 都标记为 `aborted: true`，导致正常完成（如 `stop`）被误判为 aborted，进而传播到 `lifecycle` consumers 把成功运行报告为 timeout
- **PR #66574** (fix lifecycle: add missing aborted/stopReason) - **maintainer P2 反馈：**
  - Keep media type indexes aligned after path filtering - `MediaPaths` 和 `MediaTypes` 独立过滤可能导致 index 不对齐，破坏 attachment 类型判断

### 其他追踪 PR 状态
- **PR #66578** (chore: package.json metadata) - 新开，0评论
- **PR #66568** (fix streaming: prevent markdown table split) - 新开，0评论
- **PR #66572** (fix: honor cfg-compatible capability provider resolution) - 新开，0评论

---

## 结论
**最高优先级是 #66573（chat.history limit 无重试机制，导致上下文静默丢失），其次是 #66564（Control UI laggier regression，2026.4.12 引入）。**

**建议：**
1. **立即派 aoao 接单 #66573** - 根因清晰，S级，5行代码可修（加 limit 上限校验或加 retry）
2. **派 aoao 接单 #66564** - regression，与 #66575 相关但独立
3. **跟进 #66561** - mitmproxy 证据充分，S级，值得派 aoao
4. **跟进 #66558** - S级，工具配置问题，可能与 #42726/#56208 同根
5. **跟进 #66535** - /compact 无法取消，S级，用户体验影响大
6. **review #66575 maintainer P1 反馈** - 确认 dry-run 修复是否完整

**inProgressFixes:**
- aoao 已派出处理 #65584（cron hang）
- aoao 已派出处理 #66135（background exec / cron --at / Claude CLI）
- aoao 已派出处理 #66393（Image viewing）
- aoao 已派出处理 #66391（TUI Ollama）
- aoao 已派出处理 #66421（AutoClaw workspace overwrite）
- aoao 已派出处理 #66443（Overflow recovery duplicates）
- aoao 已派出处理 #66436（ThrottleInterval 1s）
- aoao 已派出处理 #66433（node-llama-cpp removed on upgrade）
- aoao 已派出处理 #66424（github-copilot 401）
- aoao 已派出处理 #66423（tool_call tags as text）
