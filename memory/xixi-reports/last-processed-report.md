# xixi Scan - Last Processed Report

**Scan time**: 2026-04-13 11:09 CST (2026-04-13 03:09 UTC)
**Processed at**: 2026-04-13 11:15 CST
**Source**: /root/.openclaw/workspace/memory/xixi-reports/latest-scan-report.md
**Scan round**: 第115轮（11:09 CST）

---

## gh 反馈检查（2026-04-13 11:15 CST）

- **#54952**：OPEN, 0 comments — 无新反馈
- **#54964**：OPEN, last comment 2026-03-30T01:23:46Z（旧，无新）— 无新反馈
- **#55008**：OPEN, last comment 2026-04-06T11:50:15Z（旧，无新）— 无新反馈
- **#55013**：OPEN, 0 comments — 无新反馈

**结论**：无新的 maintainer 人工反馈。

---

## xixi 第115轮扫描 结论（2026-04-13 11:09 CST）

### GitHub 新候选（方向1，第115轮 11:09 CST）

| 优先级 | issue | 描述 | 状态 |
|--------|-------|------|------|
| P60019 | #65676 | **Bug + Regression** Model fallback never actually executes — live session model switch overrides fallback in loop | 🔥 建议派 aoao（最高 regression）|
| P60020 | #65660 | **Bug (HIGH)** TTS audio base64 blobs inflate context → compaction death spiral | 🔥 建议派 aoao（两行 patch）|
| P60021 | #65659 | **Bug (HIGH)** sessions.json entries missing sessionId/sessionFile — thread context lost on restart | 🔥 建议派 aoao |
| P60022 | #65667 | **Bug (HIGH)** browser CDP websocket health check never TCP connects after /json/version 200 | 🔥 建议派 aoao |
| P60023 | #65668 | **Bug + Regression** SIGUSR1/config.patch restart orphans gateway → EADDRINUSE crash loop | 🔍 建议派 aoao |
| P60024 | #65663 | **Bug + Regression** Azure OpenAI reasoning+tool_call history causes 400 on gpt-5.3-chat | 🔍 建议派 aoao |
| P60025 | PR #65673 | **fix(line): allow rich messages to use reply token** (size:XS) | 🔍 建议快速 review + approve |

### 方向4 PR 动态

- **#65574** MCP stdio proxy：author 连续修复中（5个 fix commits），接近可 merge
- **老 PR #44815**（Feishu image placeholder）：`lsdcc01` 突然活跃更新（03:12 UTC），需跟进

### aoao 派出（2026-04-13 11:15 CST）

- **P60019 #65676**：sessions_spawn 派出（最高 regression，model fallback 死循环）
- **P60020 #65660**：sessions_spawn 派出（TTS compaction 死亡螺旋，两行 patch）
- **P60021 #65659**：sessions_spawn 派出（sessions.json 缺字段，thread 历史丢失）
- **P60022 #65667**：sessions_spawn 派出（CDP WebSocket health check 静默失败）

### 结论

**XS/S 高优先级新发现已派 aoao（P60019-P60022）。**

---

*扫描时间：2026-04-13 11:09 CST / 03:09 UTC | 扫描轮次：xixi 第115轮*
