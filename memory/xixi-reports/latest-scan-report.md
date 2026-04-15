# xixi-report.md — OpenClaw Issues Scan
**扫描时间（北京时间）:** 2026-04-15 10:53  
**扫描时间（UTC）:** 2026-04-15 02:53  
**数据范围:** open issues 最近更新（约 2026-04-14 20:30 ~ 2026-04-15 02:53 UTC）

---

## 新 issue 总数
约 **50+ 个**（过去 ~6 小时内有更新的 open issues）

---

## 按优先级分类

### 🔴 S 级（Regression / P0-P1 / 数据/功能性破坏 / bug:crash）

| # | 标题 | 类型 | 时间(UTC) | 备注 |
|---|------|------|-----------|------|
| **66942** | TypeError: Cannot read properties of undefined (reading 'trim') | **bug:crash** | 02:52 | 已知 duplicate，fix PR #66882 已提（nikilster） |
| **66941** | QClaw客服号(wechat-access)无法连接，Gateway进程不启动 | **bug:crash** | 02:46 | 新鲜出炉（7 min ago），gateway 进程 crash，无 PR |
| **66916** | Malformed tool calls on longer requests for approval button on Slack | **Bug+Regression** | 01:44 | Slack approval button 在长命令时崩溃，sessions_send 找不到 session |
| **66892** | [MiniMax Model] Tool call ID format error (code 2013) causes LCM compaction failure | **bug:crash** | 00:53 | MiniMax LCM compaction 崩溃，无 PR |
| **66885** | Telegram polling stall + subagent announce timeout on Windows | **Bug+Regression** | 00:50 | ✅ PR #66889 已合并（neeravmakwana） |
| **66887** | Single plugin failure causes complete gateway outage | **Bug** | 00:36 | Magicray1217 称将提 PR（存疑，疑似 spam） |
| **66797** | Group natural-language messages silently dropped in 2026.4.11 | **Bug** | 20:50 | 影响 group 会话，kpiy88 确认 2026.4.14 仍然 broken |
| **66786** | System Prompt doesn't respect OPENCLAW_WORKSPACE_DIR | **Regression** | 20:31 | 严重功能 regression，无 PR |
| **66785** | Umbrel openclaw version 2026.4.12 setup wizard - impossible | **Bug+Regression** | 20:30 | setup wizard regression |
| **66768** | Empty completed turns in ghcr.io/openclaw/openclaw:2026.4.14 | **Bug+Regression** | 20:27 | openrouter 用户确认，仍 broken in 2026.4.14 |
| **66752** | ERR_MODULE_NOT_FOUND audit-Cb4RZuLD.js on ARM64 npm global inst | **Bug+Regression** | 19:16 | ARM64 regression，无 PR |

### 🟡 M 级（中等优先级）

| # | 标题 | 标签 | 时间(UTC) |
|---|------|------|-----------|
| **66940** | MCP streamable-http: missing Accept header causes connection failure | - | 02:30 |
| **66937** | lmstudio provider does not allow to skip api key | bug | 02:21 |
| **66936** | CLI `openclaw agents list` fails with unresolved SecretRef | bug | 02:21 |
| **66934** | Webchat: sender label shows 'openclaw-control-ui' instead of 'you' | - | 02:13 |
| **66926** | google-generative-ai reasoning mode breaks tool calling — Gemma 4 26B | - | 02:45 |
| **66925** | registerMemoryCapability is overwrite-only | bug | 01:44 |
| **66920** | WhatsApp group inbound messages silently drop after repeated 408 reconnects | - | 01:42 |
| **66917** | WhatsApp Stability: Persistent 408/499 Disconnects & Group Inbound Fail | - | 01:38 |
| **66895** | modelOverrideSource="auto" persists indefinitely after failover | bug:behavior | 01:07 |
| **66886** | Memory leak: gateway process persistent memory growth | - | 01:41 |
| **66879** | Mac App image send reaches agent as text only | bug | 00:04 |
| **66875** | Webchat race: chat final / session.message / sessions.changed triggers | - | 01:17 |
| **66867** | Race condition in `ensureTrustedFallbackDir`: concurrent subprocess | - | 00:36 |
| **66866** | excessive RESUMEs from Discord Gateway integration (carbon) | bug+regression | 23:18 |
| **66799** | agents.files.get allows operator.read callers to read arbitrary files | bug:behavior | 20:42 |
| **66773** | device.token.rotate returns plaintext device tokens | bug:behavior | 20:05 |
| **66769** | skills.update echoes raw apiKey and env secrets in gateway response | bug:behavior | 00:34 |

### 🟢 L 级（feature / size: S-XS）

约 30+ 个，多为 size: S/XS 的 fix/feat。

---

## Top 3 详细分析

### 1️⃣ #66941 — QClaw客服号(wechat-access)无法连接，Gateway进程不启动（最高优先级）
**严重程度:** 🔴 S（bug:crash，P0）  
**发现时间:** 2026-04-15 02:46 UTC（约 7 分钟前）  
**标签:** bug:crash  
**评论数:** 0

**问题描述:**
Gateway 进程完全不启动，WeChat 接入层（wechat-access）无法连接。这是一个 crash 级别的 bug，新鲜报告，暂无任何人接手。

**影响范围:** 所有使用 WeChat 接入的用户

**是否值得提 PR:** ✅ **建议接单**。crash 级别，需要尽快确认根因并修复。

---

### 2️⃣ #66916 — Malformed tool calls on longer requests for approval button on Slack（regression）
**严重程度:** 🔴 S（Regression + bug:behavior，P1）  
**发现时间:** 2026-04-15 01:44 UTC（约 1 小时前）  
**标签:** bug, regression  
**评论数:** 0（无人接手）

**问题描述:**
升级到 2026.4.14 后，Slack 的 allow-once approval button 在处理较长命令时崩溃：
- 按钮完全失效（长命令必定失败，短命令如 "pwd" 正常）
- `sessions_send` 无法找到 Slack session key
- 根因指向 tool call 在较长请求时被 malformed

**根因分析:**
sessions_send 找不到 session key，可能是 tool call ID 生成或 session 路由在新版本中有 regression。

**影响范围:** 所有 Slack 接入用户（approval 按钮完全失效）

**是否值得提 PR:** ✅ **建议接单**。regression，根因在 sessions 路由 + tool call 生成，size 可能不大。

---

### 3️⃣ #66786 — System Prompt doesn't respect OPENCLAW_WORKSPACE_DIR（regression）
**严重程度:** 🔴 S（Regression，P1）  
**发现时间:** 2026-04-14 20:31 UTC（约 6 小时前）  
**标签:** bug, regression  
**评论数:** 0

**问题描述:**
系统 prompt 的 workspace 路径不尊重 `OPENCLAW_WORKSPACE_DIR` 环境变量配置。这是一个严重的功能 regression，影响所有通过环境变量配置 workspace 的用户。

**根因:**
可能是 2026.4.14 workspace 路径解析逻辑变更导致。

**影响范围:** Headless Linux (EC2/ECS) 等通过环境变量配置 workspace 的用户

**是否值得提 PR:** ✅ **建议接单**。regression，根因清晰（OPENCLAW_WORKSPACE_DIR 处理），修复路径明确。

---

## inProgressFixes（当前已有进展）

| 状态 | Issue # | PR # | 动作 |
|------|---------|------|------|
| ✅ Merged | #66885 | #66889 | Telegram polling stall 修复（neeravmakwana） |
| ⏳ Open | #66942 | #66882 | TypeError fix（nikilster，guard clack text prompt）|
| ⏳ Open | #66887 | - | Single plugin failure 导致 gateway outage（Magicray1217 声称要修，存疑） |

**注意:** heartbeat-state.json 中记录 `fix-66561 @ PR #66599`，但当前 PR 列表中未见 #66599，需 main agent 确认状态。

---

## 建议汇总

| 优先级 | Issue # | 建议动作 |
|--------|---------|----------|
| 🔴 S | #66941 | ✅ **立即派单**：crash，7分钟前新鲜报告，无人接手 |
| 🔴 S | #66916 | ✅ **建议接单**：Slack approval button regression，sessions_send 路由问题 |
| 🔴 S | #66786 | ✅ **建议接单**：OPENCLAW_WORKSPACE_DIR regression |
| 🟡 M | #66768 | ⚠️ **观察**：openrouter empty turns regression，仍 broken in 2026.4.14 |
| 🟡 M | #66752 | ⚠️ **观察**：ARM64 ERR_MODULE_NOT_FOUND |
| ✅ | #66885 | 已 merge，无需处理 |
| ⏳ | #66942 | PR #66882 open 中，关注 merge 状态 |

---

*xixi-report.md generated at 2026-04-15 02:53 UTC*
