# xixi Scan Report

**Scanner:** xixi (autonomous issue scanner)
**Scan Range:** #66951–#67200
**Scanned:** 2026-04-15T13:15:00 GMT+8
**Total Issues Found:** 116

---

## ✅ Already Has PR

| Issue | Title | PR |
|-------|-------|-----|
| 66958 | Telegram native command menu cleared on startup | #67169 |
| 66963 | openclaw agent crashes on startup (ReferenceError in buildPollSchema) | #67022 |
| 67020 | Slack dmHistoryLimit defined but never wired | #67054 |
| 67021 | Main workspace excluded from dreaming schedule | #67073 |
| 67026 | Plugin loading crashes management commands | #67027 |
| 67030 | Heartbeat isolated session relays in English without SOUL.md | #67059 |
| 67057 | dreaming-narrative导致Telegram通讯严重阻塞 (critical!) | #67073 (partial) |
| 67058 | Session list filter feature for dreaming sessions | #67155 |
| 67061 | Dreaming dayBucket uses file date instead of ingestion date | #67091 |
| 67068 | Feishu pass thread_id as MessageThreadId | #67069 |
| 67088 | Dashboard falsely reports "No GUI detected" on macOS with SSH env | #67115, #67110 |
| 67076 | Cannot read properties of undefined (reading 'trim') | #67086 |
| 67061 | Dreaming dayBucket (dup) | #67066 |
| 67130 | openclaw onboard crashes after channel selection (missing bundled metadata) | #67145 |
| 67131 | openai-codex stale /backend-api/v1 baseUrl | #67159 |
| 67172 | Cron classifier sets status=ok when summary contains denial tokens | #67186 |

---

## 🔴 Top Candidates (S/M with clear root cause, NO existing PR)

### CRITICAL / S — Immediate Action

#### 1. #67057 — dreaming-narrative会话累积导致Telegram通讯严重阻塞
- **Severity:** S (system blockage, communication blackout)
- **Root Cause:** 77个dreaming-narrative会话持续占用资源，消息队列阻塞，用户消息与梦境消息竞争处理
- **Fix:** 需要限制dreaming并发数，或在Telegram channel禁用/限流dreaming会话
- **Spawn:** YES → `fix-67057`

#### 2. #67029 — memory-core dreaming cleanup fails with missing scope operator.admin
- **Severity:** S (RBAC error blocks cleanup, sessions leak indefinitely)
- **Root Cause:** dreaming cleanup操作需要`operator.admin` scope但缺少此权限
- **Fix:** 在cleanup代码路径中添加正确的scope或使用有权限的session
- **Spawn:** YES → `fix-67029`

#### 3. #67173 — Queued messages silently dropped after agent run timeout
- **Severity:** S (data loss, no error notification)
- **Root Cause:** agent run超时被终止时，queued消息没有被followup drain处理，直接丢弃
- **Fix:** timeout时触发followup drain处理队列
- **Spawn:** YES → `fix-67173`

### MEDIUM / M — High Value

#### 4. #67035 — Windows chat UI regression: input text swallowed, streamed replies invisible
- **Severity:** M (regression, affects Windows users)
- **Root Cause:** 2026.4.14 Windows特定UI问题，streamed replies不显示，input text被吞
- **Spawn:** YES → `fix-67035`

#### 5. #67091 — sessions_spawn defaults to thread-bound persistent mode
- **Severity:** M (unexpected permanent bindings from one-shot tests)
- **Root Cause:** sessions_spawn默认mode="run"但实际变成thread-bound persistent，导致测试用例创建永久绑定
- **Spawn:** YES → `fix-67091`

#### 6. #67136 — Write tool falsely reports successful write of X bytes but no file created
- **Severity:** M (silent data loss)
- **Root Cause:** Write tool报告成功但文件未实际创建
- **Spawn:** YES → `fix-67136`

#### 7. #67151 — Discord inbound messages containing `https` stripped before reaching agent
- **Severity:** M (content modification, broken functionality)
- **Root Cause:** Discord消息中的URL在被agent处理前被剥离
- **Spawn:** YES → `fix-67151`

#### 8. #67087 — Browser tool downloads to temp instead of configured downloads path
- **Severity:** M (wrong behavior, not catastrophic)
- **Root Cause:** CDP模式下browser tool下载到temp目录而非用户配置的downloads路径
- **Spawn:** YES → `fix-67087`

#### 9. #67092 — Malformed reasoning output leaks into user-visible text
- **Severity:** M (data corruption visible to user)
- **Root Cause:** reasoning输出格式错误时，trailing `</think>`无有效opening tag，内容泄露到用户可见文本
- **Spawn:** YES → `fix-67092`

#### 10. #67093 — Discord Channel Leaking Raw Tool Call Syntax
- **Severity:** M (broken Discord integration)
- **Root Cause:** Discord channel暴露原始tool call语法给用户
- **Spawn:** YES → `fix-67093`

#### 11. #67081 — WebChat user message not displayed until assistant response
- **Severity:** M (UX regression, appears frozen)
- **Root Cause:** WebChat用户消息发送后不立即显示，要等assistant回复才出现
- **Spawn:** YES → `fix-67081`

---

## 🟡 Unclear / Needs More Info

| Issue | Title | Notes |
|-------|-------|-------|
| 66971 | exec call hardcodes security=allowlist | Need to check if this is intentional or a bug |
| 66977 | sqlite-vec extension cannot load on macOS | OMIT_LOAD_EXTENSION compile flag issue, may need build fix |
| 66982 | Exec completion relay creates orphan sessions | Need more diagnostic info |
| 67013 | Browser control heartbeat logs errors for expected unavailability | Expected behavior? Needs clarification |
| 67040 | Performance: Optimize CLI startup by persisting plugin discovery cache | Enhancement, not bug |
| 67044 | subagent-registry.runtime.js missing from dist output | Build issue, need repro |
| 67045 | Sticky model fallback after compaction-triggered tool_use formatting error | Need log trace |
| 67052 | TUI streaming indicator stays active long after response finishes | Can be visual-only, L candidate |
| 67053 | TUI streaming indicator (duplicate of 67052) | Dup |
| 67057 noted above |
| 67065 | Managed media workflows need session-scoped next-turn suppression | Enhancement |
| 67071 | ${VAR} substitution sentinels stripped by config set | Need clarification on scope |
| 67074 | TypeError: Cannot read properties of undefined (reading 'trim') | Likely dup of 67076/66945, already has PR |
| 67078 | /new initialized wrong model on fresh Telegram DM | Need more info |
| 67084 | Session Timeout Spam with Codex and Active Memory ON | Need context |
| 67085 | HOOK.md hooks silently no-op on before_tool_call / after_tool_call | Needs investigation |
| 67097 | models.json bundled plugins bypass onboard lifecycle | Enhancement/discrepancy |
| 67099 | Empty title | Blank |
| 67102 | Bug Tool Calls sans Suite avec OpenRouter | Need body |
| 67106 | Control UI / Webchat text disappears in Safari | Safari-specific regression |
| 67107 | Blank title bug | Empty |
| 67109 | Control UI / Webchat does not render inbound images | Enhancement |
| 67113 | QMD on ARM (Pi 5): qmd embed timeout loop | Platform-specific |
| 67114 | openclaw status / health hangs on Windows | Windows startup issue |
| 67118 | Cron isolated agentTurn may not advance to model fallback | Need log trace |
| 67121 | MiniMax Portal OAuth completes but credentials not saved | Auth issue, need logs |
| 67122 | pdf/image tools reject sub-agent workspace paths | Workspace path blacklist issue |
| 67133 | hooks未触发和定时任务执行历史缺失 | Need more info |
| 67135 | Webchat context meter shows false overflow after /new | Need context |
| 67139-67141 | TKT tickets | Internal tracking |
| 67152 | memory-core dreaming uses request-scoped subagent runtime outside gateway | Architecture issue |
| 67158 | openai-codex gpt-5.1/5.2/5.3 rejected | OAuth scope issue |
| 67160 | TUI: chat.history unavailable during gateway startup | Race condition |
| 67161 | ACP agent sessions terminated with ACP_TURN_FAILED during gateway restart | Need logs |
| 67162 | Blank title bug | Empty |
| 67164 | Allow 1-hour cache TTL for custom Anthropic-compatible providers | Enhancement |
| 67165 | SSRF blocking searxng/browsers | Enhancement/security |
| 67166 | Feature Request: Display user-sent images inline in WebChat | Enhancement |
| 67167 | Session Lifecycle Hooks (PreCompact + Stop hooks) | Enhancement |
| 67168 | logging.file config is read but not applied | Config not honored |
| 67170 | talk-voice plugin audio delivery failure to Telegram | Audio pipeline issue |
| 67171 | config set writes resolved values stripping ${VAR} sentinels | Config serialization issue |
| 67177 | MS Teams inbound file attachments fail silently | Graph API URL rewrite missing |
| 67178 | Context Engine Turn Maintenance Loop | Internal tracking |
| 67181 | Discord async completion leaks internal resume-fallback message | Discord integration bug |
| 67182 | Telegram file download fails: unresolved token in URL | URL construction issue |
| 67187 | ekcli: macOS identity + EventKit privacy keys | macOS-specific enhancement |
| 67188 | TTS bug | Blank title |
| 67189 | LCM 0.9.0: Empty assistant messages accumulate from tool-only turns | Message accumulation |
| 67190 | memory-wiki CLI returns 0 artifacts but gateway call works | CLI vs gateway discrepancy |
| 67191 | BOOT.md messages not delivered to user | deliver:false flag issue |

---

## 🟢 Small Issues (L)

| Issue | Title | Notes |
|-------|-------|-------|
| 66965 | WhatsApp: expose messageTimeoutMs as config option | Enhancement, small |
| 66979 | Feature: sandbox limit | Enhancement |
| 66983 | Feature: web canvas node support | Enhancement |
| 66992 | macOS: gateway plist should set ProcessType: Interactive | Small platform fix |
| 66994 | Exec approval prompts persist despite tools.exec.ask: off | M? Actually could be M |
| 67000 | Feature: Warm-up / session reuse for embedded agents | Enhancement |
| 67002 | Feature: Independent workspace for every channel | Enhancement |
| 67014 | QQ Bot streaming mode配置无效 | Enhancement |
| 67016 | Dreaming UI lacks status information | Enhancement |
| 67052 | TUI streaming indicator stays active (also in Unclear) | Low priority |
| 67060 | Feature: Provider requests ignore env proxy → silent timeout | Enhancement |
| 67062 | Feature: Add channels.qqbot.mediaAllowHosts for SSRF policy | Enhancement |
| 67067 | Feature: Time-Aware Active Memory with Schedule Management | Enhancement |
| 67116 | Feature: openclaw logs --follow use local time by default | Enhancement |
| 67117 | Feature: Support Parallel Dispatch for Multiple Bot Accounts | Enhancement |
| 67120 | Feature: Feishu voice messages not transcribed | Enhancement |
| 67128 | Feature: /usage command or session stats panel in Telegram | Enhancement |
| 67129 | Blank feature request | Empty |
| 67154 | Feature: Separate runtime tracking from allowlist | Enhancement |
| 67164 | Allow 1-hour cache TTL for custom providers | Enhancement |
| 67165 | SSRF blocking searxng / browser CDP | Enhancement |

---

## 📋 Summary

- **Total Issues Scanned:** 116
- **Already Has PR:** 16
- **Top Candidates (S/M, clear root cause, no PR):** 11
- **Unclear/Needs Info:** ~50
- **Feature Requests (L/enhancement):** ~25
- **Spam/Duplicate/Blank:** ~10

**Subagents Spawned:** 11 (for top candidates without PR)

---

*Report generated by xixi at 2026-04-15T13:15:00 GMT+8*
