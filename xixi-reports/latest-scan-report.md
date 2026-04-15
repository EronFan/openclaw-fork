# xixi Scan Report
**Scan range:** issues #66800–#66950 | PRs #66800–#66950
**Timestamp:** 2026-04-15T03:40 GMT+8
**Scanner:** xixi-subagent (manual GitHub API)

---

## Summary

- Issues scanned: ~130 (open, latest-updated in range)
- PRs scanned: ~80 (open/merged/closed in range)
- Top Candidates identified: **13 issues**
- Security bugs (no PR): **1 unassigned**
- Already covered by PRs: **3 issues**

---

## ✅ Already Covered by Open/Merged PRs

| Issue | Title | PR | Status |
|-------|-------|----|--------|
| #66947 | Dreaming system pollutes daily memory files | [#66948](https://github.com/openclaw/openclaw/pull/66948) | OPEN — fix(memory-core): default dreaming storage to "separate" |
| #66916 | Malformed tool calls on longer requests for approval button on Slack | [#66918](https://github.com/openclaw/openclaw/pull/66918) | OPEN — Discord: ignore stale exec approval clicks |
| #66832 | `logs.tail` likely fails to redact several credential formats | [#66896](https://github.com/openclaw/openclaw/pull/66896) | OPEN — fix: add redaction patterns for JWT, Basic auth, and custom header tokens |

> ⚠️ **Coverage concern on #66916:** PR #66918 is for Discord stale clicks, but issue #66916 is about Slack malformed tool calls on longer commands. These are different channels/symptoms. Needs confirmation that the fix actually covers the Slack case.

---

## 🔴 Top Candidates — Fix Immediately

### 1. [#66946](https://github.com/openclaw/openclaw/issues/66946) — Control UI路径重复导致404错误，聊天功能无法使用

| Field | Value |
|-------|-------|
| **Severity** | 🔴 P1 / Behavior |
| **Labels** | `bug:behavior` |
| **Author** | yndwx01 |
| **Updated** | 2026-04-15T02:59:36Z |
| **PR Coverage** | ❌ None |

**Assessment:** OpenClaw Control UI前端路径拼接错误，`__openclaw__`路径重复导致`/__openclaw__/__openclaw/control-ui-config.json`返回404，聊天功能完全不可用。影响所有2026.4.14通过SSH隧道访问Control UI的用户。根因：前端路由拼接逻辑错误，概率100% repro。

---

### 2. [#66945](https://github.com/openclaw/openclaw/issues/66945) — TypeError: Cannot read properties of undefined (reading 'trim') [onboard crash]

| Field | Value |
|-------|-------|
| **Severity** | 🔴 P1 / Crash |
| **Labels** | `bug`, `bug:crash` |
| **Author** | tobemorelucky |
| **Updated** | 2026-04-15T02:58:55Z |
| **PR Coverage** | ❌ None |

**Assessment:** 安装2026.4.14后运行`openclaw onboard --install-daemon`，选择channel时崩溃，TypeError: Cannot read properties of undefined (reading 'trim')。同根因还出现在#66942、#66848。全新安装完全阻塞，影响所有新用户。Reporter提供截图。

---

### 3. [#66941](https://github.com/openclaw/openclaw/issues/66941) — QClaw客服号(wechat-access)无法连接，Gateway进程不启动

| Field | Value |
|-------|-------|
| **Severity** | 🔴 P1 / Crash |
| **Labels** | `bug`, `bug:crash` |
| **Author** | join9461-coder |
| **Updated** | 2026-04-15T02:46:25Z |
| **PR Coverage** | ❌ None |

**Assessment:** wechat-access渠道无法连接，Gateway进程直接退出。关键渠道崩溃，所有通过微信接入的用户完全无法使用。根因待查，可能与2026.4.14引入的变更相关。

---

### 4. [#66887](https://github.com/openclaw/openclaw/issues/66887) — Single plugin failure causes complete gateway outage

| Field | Value |
|-------|-------|
| **Severity** | 🔴 P1 / Behavior |
| **Labels** | `bug` |
| **Author** | KarbonXX |
| **Updated** | 2026-04-15T00:36:04Z |
| **Comments** | 1 |

**Assessment:** 第三方插件（如lossless-claw）初始化失败或版本不匹配时，整个Gateway崩溃，所有渠道（Telegram、Discord、webchat）全部离线。故障隔离完全失效。错误信息`info.id must match registered id "lossless-claw"`明确指出了插件注册验证失败。需要为每个插件包装try/catch，失败时禁用插件而非整个Gateway。

---

### 5. [#66940](https://github.com/openclaw/openclaw/issues/66940) — MCP streamable-http: missing Accept header causes connection failure

| Field | Value |
|-------|-------|
| **Severity** | 🔴 P1 / Behavior |
| **Labels** | *(none)* |
| **Author** | sl-wen |
| **Updated** | 2026-04-15T02:58:29Z |
| **Comments** | 1 |
| **PR Coverage** | ❌ None |

**Assessment:** MCP streamable-http客户端未发送`Accept: application/json, text/event-stream`头，导致Zhipu BigModel等MCP服务器拒绝连接。根因明确（curl测试已证明），fix简单——在所有streamable-http请求上添加Accept头。完全阻塞相关MCP工具。

---

### 6. [#66885](https://github.com/openclaw/openclaw/issues/66885) — Telegram polling stall + subagent announce timeout on Windows (undici HTTP/2 root cause)

| Field | Value |
|-------|-------|
| **Severity** | 🔴 P1 / Regression |
| **Labels** | `bug`, `regression` |
| **Author** | swissfone |
| **Updated** | 2026-04-15T00:50:09Z |
| **Comments** | 2 |
| **PR Coverage** | ❌ None (partial: #66889 Telegram disable HTTP/2 polling transport) |

**Assessment:** 2026.4.12开始，Windows上Telegram轮询每10-12分钟冻结90-200秒，根因是undici尝试HTTP/2+IPv6但Windows上IPv6不可达。子agent announce超时，cron任务结果丢失。**#66889已开PR禁用HTTP/2轮询传输**，需确认是否能完整覆盖此问题。回归链清晰：4.1正常→4.12 regressed。

---

### 7. [#66916](https://github.com/openclaw/openclaw/issues/66916) — Malformed tool calls on longer requests for approval button on Slack + bad session routing

| Field | Value |
|-------|-------|
| **Severity** | 🟠 P2 / Regression |
| **Labels** | `bug`, `regression` |
| **Author** | awknode |
| **Updated** | 2026-04-15T01:44:05Z |
| **PR Coverage** | ⚠️ Partial (#66918 — Discord stale clicks, NOT Slack) |

**Assessment:** 2026.4.14升级后，Slack上allow-once按钮遇到较长命令（如`echo Hello World!`）时产生畸形tool call，`sessions_send`无法找到session `U05TZU51VC1`。短命令`pwd`正常。回归点明确。**PR #66918针对Discord，与Slack问题不同，需单独fix或确认底层共享代码**。

---

## 🟠 High Priority

### 8. [#66942](https://github.com/openclaw/openclaw/issues/66942) — TypeError: Cannot read properties of undefined (reading 'trim')

| Field | Value |
|-------|-------|
| **Severity** | 🟠 P2 / Crash |
| **Labels** | `bug`, `bug:crash` |
| **Author** | zillionare |
| **Updated** | 2026-04-15T02:53:42Z |
| **PR Coverage** | ❌ None (same root cause as #66945) |

**Assessment:** 与#66945同根因（TypeError: Cannot read properties of undefined (reading 'trim')），发生在安装或onboard流程中。合并分析。

### 9. [#66880](https://github.com/openclaw/openclaw/issues/66880) — Telegram Plugin Restart-Loop in 4.14 — deleteMyCommands failed

| Field | Value |
|-------|-------|
| **Severity** | 🟠 P2 / Regression |
| **Labels** | `bug` |
| **Author** | BigWiLLi111 |
| **Updated** | 2026-04-15T00:36:05Z |
| **PR Coverage** | ❌ None (PR #66843 was closed, reopened?) |

**Assessment:** 2026.4.14 Telegram插件重启循环，`deleteMyCommands`失败。#66843曾fix此问题（restore Telegram native commands），但状态为CLOSED。需确认是否在当前版本已merge或需要新PR。

### 10. [#66947](https://github.com/openclaw/openclaw/issues/66947) — Dreaming system pollutes daily memory files (covered by #66948)

| Field | Value |
|-------|-------|
| **Severity** | 🟠 P2 / Behavior |
| **Labels** | *(none)* |
| **Author** | jensenwang560-blip |
| **Updated** | 2026-04-15T03:02:12Z |
| **PR Coverage** | ✅ #66948 OPEN |

### 11. [#66892](https://github.com/openclaw/openclaw/issues/66892) — [MiniMax Model] Tool call ID format error (code 2013) causes LCM compaction failure and session crash

| Field | Value |
|-------|-------|
| **Severity** | 🟠 P2 / Crash |
| **Labels** | `bug`, `bug:crash` |
| **Author** | microsx |
| **Updated** | 2026-04-15T00:53:49Z |
| **PR Coverage** | ❌ None |

**Assessment:** MiniMax-M2.7使用LCM compaction时生成畸形tool call ID，被API以error code 2013拒绝，导致~7分钟auth profile cooldown和session crash。所有MiniMax用户+LCM用户受影响，频率100%。

### 12. [#66848](https://github.com/openclaw/openclaw/issues/66848) — TypeError: Cannot read properties of undefined (reading 'trim')

| Field | Value |
|-------|-------|
| **Severity** | 🟠 P2 / Crash |
| **Labels** | `bug`, `bug:crash` |
| **Author** | phpweb |
| **Updated** | 2026-04-15T00:19:26Z |
| **PR Coverage** | ❌ None (same root cause as #66945) |

### 13. [#66866](https://github.com/openclaw/openclaw/issues/66866) — Excessive RESUMEs from Discord Gateway integration (carbon)

| Field | Value |
|-------|-------|
| **Severity** | 🟡 P2 / Regression |
| **Labels** | `bug`, `regression` |
| **Author** | daisyzhou |
| **Updated** | 2026-04-14T23:18:27Z |
| **PR Coverage** | ❌ None |

**Assessment:** Discord Gateway产生过多RESUME事件，导致carbon token快速消耗。与2026.4.14变更相关，影响Discord用户成本和可用性。

---

## 🟡 Medium Priority (Notable but less urgent)

| Issue | Title | Notes |
|-------|-------|-------|
| #66950 | Telegram native command menu disappears after upgrade to 2026.4.14 | Same as #66880 family |
| #66936 | `openclaw agents list` fails with unresolved SecretRef; CLI hangs | Blocking CLI |
| #66893 | Critical: Progression Difficulty Spike | Likely game-related, not OpenClaw |
| #66900 | Task can end without final failure summary when tool execution fails | Missing error surfacing |
| #66907 | Control UI: input text reappears briefly when streaming response begins | UI flicker |
| #66864 | /new session reset doesn't purge system-events queue | Covered by PR #66868 (drain system events) |
| #66908 | npm link gets broken after openclaw update via Control UI | Update mechanism issue |

---

## 📋 Fix Queue (Recommended Order)

| Priority | Issue | Why |
|----------|-------|-----|
| 1 | #66946 | P1 — Control UI completely broken for tunnel users |
| 2 | #66945/#66942/#66848 | P1 — Onboarding完全崩溃，新用户阻塞 |
| 3 | #66941 | P1 — Gateway进程退出，微信渠道完全不可用 |
| 4 | #66887 | P1 — 单插件故障导致全Gateway宕机 |
| 5 | #66940 | P1 — MCP streamable-http完全不可用 |
| 6 | #66885 | P1 regression — Telegram每12分钟冻结3分钟 |
| 7 | #66916 | P2 regression — Slack approval buttons长命令全坏 |
| 8 | #66880/#66950 | P2 — Telegram菜单/命令丢失 |
| 9 | #66892 | P2 — MiniMax+LCM用户session crash |
| 10 | #66866 | P2 — Discord carbon过度消耗 |
| 11 | #66832 | P2 — 日志redaction缺失 credential泄露风险 |

---

## 🚨 Immediate Action Items

1. **#66946 (#66946) — Control UI路径重复** — 立即派单，前端路由拼接错误，fix简单但影响严重
2. **TypeError trim三连 (#66945/#66942/#66848)** — 立即分析onboard流程中所有`.trim()`调用，env/config解析相关
3. **#66941 — QClaw Gateway崩溃** — 检查wechat-access插件注册代码
4. **#66887 — 插件故障隔离** — 这是一个架构级问题，需要在plugin loader中增加isolate wrapper
5. **#66940 — MCP Accept头** — fix极小，但影响大

---

## inProgressFixes (from this scan)

- **#66940** (MCP Accept header): No PR yet — needs owner
- **#66885** (Telegram HTTP/2): PR #66889 exists — needs review/merge

---

*Report generated by xixi-subagent — 2026-04-15T03:40 GMT+8*
