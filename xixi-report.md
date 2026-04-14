# xixi-report.md — OpenClaw Issues Scan
**扫描时间（北京时间）:** 2026-04-14 22:29  
**扫描时间（UTC）:** 2026-04-14 14:29  
**数据范围:** 最近 2 小时更新的 open issues（约 2026-04-14 10:13 ~ 14:27 UTC）

---

## 新 issue 总数
约 **84 个**（最近 2 小时有更新的 open issues）

---

## 按优先级分类

### 🔴 S 级（Regression / P0-P1 / 数据/功能性破坏）

| # | 标题 | 类型 | 时间(UTC) | 备注 |
|---|------|------|-----------|------|
| **66522** | Session index rebuilds on Gateway restart, complete loss of session history | **Bug** | 11:54 | sessions.json 重启后清空，文件还在但索引丢失，用户无感知无警告 |
| **66591** | 2026.4.14 broke lossless-claw: Context engine factory returned invalid ContextEngine | **Regression** | 14:09 | 升级到 2026.4.14 后 lossless-claw 用户完全无法使用，必须禁用插件 |
| **66519** | Subagent completion triggers duplicate delivery: raw status + proper summary | **Regression** | 12:29 | 子 agent 完成后发两条消息，CPU 100%，属于 regression |
| **66516** | Beta Blocker: Active Memory Timeout | **Bug** | 11:34 | Active Memory 超时阻塞 |
| **66518** | memory status --deep fails with "Unknown memory embedding provider: ollama" in v2026.4.12 | **Bug** | 11:45 | v2026.4.12 memory deep scan 失败 |
| **66582** | Active Memory issue (bug:behavior) | **Bug** | 13:58 | Active Memory 行为异常 |
| **66596** | Async relay heartbeat can emit 'result shown above' without payload | **Bug** | 14:13 | cron/heartbeat 相关 |
| **66558** | sessions_spawn / sessions_send not available in main agent session | **Bug** | 13:19 | subagent 工具缺失 |

### 🟡 M 级（中等优先级）

| # | 标题 | 标签 | 时间(UTC) |
|---|------|------|-----------|
| **66568** | fix(streaming): prevent block chunker from splitting markdown tables | agents, size: M | 14:25 |
| **66542** | feat(mcp): add reconnect with retry, jitter, parallel startup, dead-server tracking | agents, size: M | 13:23 |
| **66578** | chore: enhance package.json metadata for better NPM discoverability | channel: telegram, app: web-ui, commands, agents, size: M | 13:57 |
| **66491** | [codex] fix(status): quiet read-only plugin registry loads | gateway, cli, commands, agents, size: M | 11:41 |
| **66517** | feat(config): add ratio-based sibling fields for compaction token budgets | agents, size: L（实际 M 级） | 13:11 |
| **66546** | feat(sessions): add transcriptRotateBytes and transcriptMaxLines to cap .jsonl growth | size: L | 12:56 |
| **66533** | WebChat session selector shows main session as "heartbeat" | bug, regression | 12:46 |

### 🟢 L 级（feature / size: S-XS）

约 70+ 个，多为 size: S/XS 的 fix/feat，以及无标签的功能请求和普通 bug。

---

## Top 3 详细分析

### 1️⃣ #66522 — Session index rebuilds on Gateway restart（最高优先级）
**严重程度:** 🔴 S（数据丢失，等效 P0）  
**发现时间:** 2026-04-14 11:54 UTC（约 10 小时前）  
**标签:** 无官方标签（但本质是数据破坏级 bug）

**问题描述:**
Gateway 重启后，`sessions.json` 被完全重建（而非合并），所有历史 session 从索引中消失。磁盘上的 `.jsonl` 文件实际还存在，但用户在任何客户端（WebUI/WeChat/Feishu）都无法看到历史会话。无备份、无警告、无恢复选项。

**根因分析（issue 自述）:**
重启时 session index 逻辑：
1. 加载或初始化新的 `sessions.json`
2. 只注册启动时活跃的 session
3. **不扫描磁盘上已有的 session 文件**
4. **不备份旧的 `sessions.json`**

异常状态（如 Context Overflow、compaction 失败）的 session 在重启时被静默标记为 ended。

**影响范围:**
- 所有 channel（WebUI、Discord、WeChat、Feishu 等）
- 涉及所有历史会话丢失
- 特别严重：长会话、重要上下文全部消失

**修复建议（优先级顺序）:**
1. 重启前备份 `sessions.json` → `sessions.json.bak-YYYYMMDDHHMMSS`
2. 启动时扫描磁盘 session 文件并合并
3. 异常 session 重启时通知用户
4. 提供 session 恢复工具

**是否值得提 PR:** ✅ **强烈建议**。这是数据损坏级别的问题，且根因清晰（session index rebuild 逻辑），修复路径明确。

---

### 2️⃣ #66591 — 2026.4.14 broke lossless-claw（regression）
**严重程度:** 🔴 S（Regression，等效 P1）  
**发现时间:** 2026-04-14 14:09 UTC（约 8 小时前）  
**标签:** bug, regression  
**评论数:** 0（无人接手）

**问题描述:**
升级到 2026.4.14 后，使用 lossless-claw 0.8.2 的用户完全无法使用 OpenClaw：
```
Error: Context engine "lossless-claw" factory returned an invalid ContextEngine: info.id must match registered id "lossless-claw".
```
用户必须禁用 lossless-claw 才能恢复使用。

**根因分析:**
这是一个 manifest/registry 级别的 regression —— `info.id` 与注册的 id 不匹配。很可能 2026.4.14 的某个改动（context engine 注册逻辑变更或 lossless-claw 发布新版本）导致了 id 注册名不一致。

**影响范围:**
所有使用 lossless-claw 插件的 2026.4.14 用户（无法使用）

**是否值得提 PR:** ✅ **建议接单**。根因相对明确（id 注册不匹配），但需要确认是 OpenClaw core 改动引起还是 lossless-claw 插件本身的问题。先确认 `lossless-claw` 是bundled 还是 third-party plugin。

---

### 3️⃣ #66519 — Subagent completion triggers duplicate delivery（regression）
**严重程度:** 🔴 S（Regression，UX 破坏）  
**发现时间:** 2026-04-14 12:29 UTC（约 10 小时前）  
**标签:** bug, regression  
**评论数:** 1（但无 PR）

**问题描述:**
子 agent 完成后，主 agent 向 Telegram 发送两条消息：
1. 原始状态回退消息（前缀 "Automatic session resume failed, so sending the status directly."）
2. 格式化的正确摘要

两次消息之间 Gateway CPU 达到 ~100%。

**根因分析（issue 自述）:**
子 agent 完成 → session resume 失败触发直接状态传递 + 主 agent 同时发送自己的格式化摘要。两个路径并行触发。

**相关 issues:** #50791, #51917, #62442（历史相关 issues，说明这是一个已知问题的新变种或未完全修复）

**是否值得提 PR:** ✅ **建议接单**。是 regression，且已有相关历史 issues 可参考修复思路。根因定位后改动应该不大。

---

## 建议汇总

| 优先级 | Issue # | 建议动作 |
|--------|---------|---------|
| 🔴 S | #66522 | ✅ **立即派单**：数据丢失，根因明确 |
| 🔴 S | #66591 | ✅ **建议接单**：regression，但需先确认 lossless-claw 是 bundled 还是 third-party |
| 🔴 S | #66519 | ✅ **建议接单**：regression，有历史 issues 可参考 |

**不纳入 Top3 但值得关注的 S 级:**
- #66518: memory status deep 失败（v2026.4.12）
- #66516: Active Memory Timeout
- #66558: sessions_spawn/sessions_send 不可用

---

## inProgressFixes（当前扫描后触发）
（本报告产出后由 main agent 触发派单，暂无 in-progress fix）

---
*xixi-report.md generated at 2026-04-14 22:29 Beijing*
