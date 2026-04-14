# xixi Scan - Last Processed Report

**Scan time**: 2026-04-14 21:50 CST (2026-04-14 13:50 UTC)
**Processed at**: 2026-04-14 21:56 CST
**Source**: /root/.openclaw/workspace/memory/xixi-reports/latest-scan-report.md
**Scan round**: 第124轮（21:50 CST）

---

## gh 反馈检查（2026-04-14 21:56 CST）

- **#54952**：OPEN, 0 comments — 无新反馈
- **#54964**：OPEN, 0 comments — 无新反馈
- **#55008**：OPEN, 5 comments, updated 2026-03-30T01:23:46Z — 无新反馈
- **#55013**：OPEN, 2 comments, updated 2026-04-06T11:54:11Z — 无新反馈

**结论**：无新的 maintainer 人工反馈。

---

## aoao 派出记录（2026-04-14 21:56 CST）

| runId | issue | 描述 | 状态 |
|-------|-------|------|------|
| 792910f4 | #66573 | S: chat.history limit=2000 超服务器上限 1000，静默丢失上下文 | 已派出 |
| 9032d4b2 | #66564 | S regression: Control UI 2026.4.12 后明显 laggier | 已派出 |
| 06caa6c3 | #66561 | S: SSE stream begin 后 client abort 误判为 timeout | 已派出 |
| f6e3e92f | #66558 | S: sessions_spawn/sessions_send 在 main agent 不可用 | 已派出 |
| 48c1df8f | #66535 | S: /compact 命令无法取消 | 已派出 |

（既有派出任务继续执行：#65584, #66135, #66393, #66391, #66421, #66443, #66436, #66433, #66424, #66423, #65438, #65441 等）

---

## xixi 第124轮扫描 结论（2026-04-14 21:50 CST）

### 方向1 GitHub 新候选（14个新发现）

**🔥 已派出（5个 S 级）：**
1. **#66573**（runId 792910f4）— chat.history limit=2000 超服务器上限 1000，INVALID_REQUEST 后静默跳过不重试 → 上下文静默丢失，S级，5行可修
2. **#66564**（runId 9032d4b2）— Control UI 2026.4.12 laggier regression（node.list 每5s 轮询等），与 #66575 相关但独立
3. **#66561**（runId 06caa6c3）— SSE stream begin 后 client abort 误判为 timeout，mitmproxy 证据充分
4. **#66558**（runId f6e3e92f）— sessions_spawn/sessions_send 在 main agent 不可用，工具配置解析问题
5. **#66535**（runId 48c1df8f）— /compact 命令无法取消，用户体验影响大

**🔍 待处理（9个新发现）：**
- #66553（M）- Voice message delivery 在 STT 完成前就触发，race condition
- #66522（M）- Session index 重建后 session history 完全丢失
- #66500（S）- Feishu Chinese filenames garbled（需确认是否在 PR 覆盖区）
- #66514（S）- Browser control reports healthy but CDP path dead（已在 aoao 追踪）
- weixin #65（S）- 微信消息接收乱序，网页端能收到微信收不到

**✅ 已覆盖无需重复追踪：**
- #66540（S）- PR #66562 已覆盖
- #66534（S）- PR #66574 已覆盖
- #66549（S）- PR #66559 已覆盖

### 方向4 PR 状态
- **PR #66575 maintainer 新评论（P1×2）：** dry-run 分支没有调用 runMessageAction 导致 result 缺少必需字段；aborted 逻辑误判 stop reason（正常完成被标记为 aborted）
- **PR #66574 maintainer P2：** MediaPaths 和 MediaTypes 独立过滤可能导致 index 不对齐
- **PR #66578/66568/66572：** 新开，0评论，持续追踪

---

## 结论

**本轮派出 5 个 aoao 任务**（全部为 S 级，根因清晰）：
1. #66573 — chat.history limit retry bug
2. #66564 — Control UI laggier regression
3. #66561 — SSE stream abort misclassification
4. #66558 — sessions_spawn/sessions_send unavailable
5. #66535 — /compact cannot cancel

**inProgressFixes（全部 active）：**
- runId af2e0e6e — #65584 cron hang
- runId 96163316 — #66135 background exec/cron --at/Claude CLI
- runId 1cded531 — #66393 Image viewing
- runId fa5a5f46 — #66391 TUI Ollama
- runId 22eba75e — #66421 AutoClaw workspace overwrite
- runId f98b2500 — #66443/#66441 Overflow recovery duplicates
- runId 25831b4c — #66436 ThrottleInterval 1s
- runId 89cd476d — #66433 node-llama-cpp removed
- runId 1a922637 — #66424 github-copilot 401
- runId 58667cef — #66423 tool_call as text
- runId 5de6a024 — #65438 Gemini 3.x empty output
- runId e441d8de — #65598 WhatsApp crash on start
- runId 792910f4 — #66573 chat.history limit
- runId 9032d4b2 — #66564 Control UI lag
- runId 06caa6c3 — #66561 SSE stream abort
- runId f6e3e92f — #66558 sessions_spawn unavailable
- runId 48c1df8f — #66535 /compact cannot cancel

---

*扫描时间：2026-04-14 21:50 CST / 13:50 UTC | 扫描轮次：xixi 第124轮 | 处理时间：2026-04-14 21:56 CST*
