# xixi Scan Report

**Scanner:** xixi (autonomous issue scanner)
**Scan Range:** #69150–#69336 (open issues + open PRs as of scan)
**Scanned:** 2026-04-20T21:00:00 GMT+8
**Previous Scan:** 2026-04-15T13:15:00 GMT+8 (report covered #66951–#67200)
**Delta:** ~5 days of new activity

---

## 🔴 CRITICAL — Active S-Tier (no PR yet)

### 1. #69300 — Agent harness compaction short-circuits memory flush + session bookkeeping
- **Severity:** S
- **Labels:** bug (no other label — but severity is systemic)
- **Updated:** 2026-04-20 10:34 UTC
- **Root Cause:** When OpenClaw is used as agent harness (e.g. Codex, Claude CLI), compaction short-circuits the memory flush and session bookkeeping, leaving session state unbounded. This is a data-leak / resource-exhaustion bug.
- **Impact:** Every compaction run silently leaks session state; over time gateway memory grows unbounded.
- **Has PR:** No open PR found.
- **Spawn candidate:** YES → `fix-69300`

### 2. #69296 — ACP client hangs on slash commands and normal prompts in 2026.4.15
- **Severity:** S
- **Labels:** `bug`, `regression`
- **Updated:** 2026-04-20 10:19 UTC
- **Root Cause:** Regression introduced in 2026.4.15 (recent release). ACP client completely hangs on slash commands and normal prompts.
- **Impact:** Users on 2026.4.15 cannot use ACP functionality at all.
- **Has PR:** No open PR found.
- **Spawn candidate:** YES → `fix-69296`

### 3. #69294 — ACP plugin crashes gateway on Windows 11
- **Severity:** S
- **Labels:** `bug`, `bug:crash`
- **Updated:** 2026-04-20 10:15 UTC
- **Root Cause:** ACP plugin probe fails on Windows 11, causing full gateway crash.
- **Impact:** Complete service outage on Windows 11.
- **Has PR:** No open PR found.
- **Spawn candidate:** YES → `fix-69294`

### 4. #69286 — session totalTokens not reset after compaction causes infinite safeguard loop
- **Severity:** S
- **Labels:** (unlabeled but clearly S — infinite loop + data loss)
- **Updated:** 2026-04-20 (with ongoing activity note)
- **Root Cause:** After compaction, `totalTokens` is not reset; the session believes it has massive token usage and triggers the compaction safeguard loop repeatedly — consuming infinite resources with no useful output.
- **Related:** #69287 (token count not reset), #69269 (compaction breaks session invariants)
- **Has PR:** No open PR found.
- **Spawn candidate:** YES → `fix-69286`

### 5. #69289 — Browser aria snapshot refs resolve in snapshots but fail in follow-up actions
- **Severity:** S
- **Labels:** `bug`, `regression`
- **Updated:** 2026-04-20 09:59 UTC
- **Root Cause:** Regression — aria snapshot refs work in initial snapshot but break when used in subsequent actions within the same session. Browser automation is completely broken for multi-step flows.
- **Impact:** All browser automation workflows fail after first step.
- **Has PR:** No open PR found.
- **Spawn candidate:** YES → `fix-69289`

---

## 🟠 HIGH — M-Tier Bugs with Clear Root Cause, No PR

### 6. #69329 — exec runtime surfaces "completed" from lifecycle with no seam for artifact-gated closure
- **Severity:** M (behavior)
- **Labels:** `bug`, `bug:behavior`
- **Updated:** 2026-04-20 12:35 UTC
- **Root Cause:** exec runtime prematurely surfaces "completed" state based purely on lifecycle events, without waiting for artifact-gated closure. Tool results / artifacts may still be pending when the run is marked complete.
- **Impact:** Race conditions in exec-dependent workflows, potential data loss.
- **Has PR:** No open PR found.
- **Spawn candidate:** YES → `fix-69329`

### 7. #69327 — Subagent sandbox does not propagate sandbox.docker.env, reuses stale workspace state
- **Severity:** M (behavior)
- **Labels:** `bug`, `bug:behavior`
- **Updated:** 2026-04-20 12:28 UTC
- **Root Cause:** `sandbox.docker.env` settings are not propagated to subagent sandbox processes. Additionally, after sandbox recreation, stale workspace/bootstrap state can be reused.
- **Impact:** Subagent isolation is broken; docker env vars leak or are missing.
- **Has PR:** No open PR found.
- **Spawn candidate:** YES → `fix-69327`

### 8. #69287 — Session token count not reset after compaction
- **Severity:** M
- **Updated:** 2026-04-20 09:55 UTC
- **Root Cause:** Token accounting not reset after compaction. Related to #69286 and #69269.
- **Has PR:** No open PR found.
- **Consider:** Merge with #69286 fix.

### 9. #69303 — Inbound dedupe released on error path can replay same message_id after provider failure
- **Severity:** M
- **Updated:** 2026-04-20 11:03 UTC
- **Root Cause:** Deduplication mechanism releases the dedupe key on error paths, allowing the same message_id to be replayed after a provider failure.
- **Impact:** Message duplication; potential duplicate processing consequences.
- **Has PR:** No open PR found.
- **Spawn candidate:** YES → `fix-69303`

### 10. #69330 — MCP server leak: duplicate processes accumulate on gateway reconnect
- **Severity:** M (resource leak)
- **Updated:** 2026-04-20 12:41 UTC (very fresh — within hours of scan)
- **Root Cause:** On WhatsApp 499, MCP server processes duplicate on gateway reconnect and are never cleaned up. Each reconnect adds more orphaned processes.
- **Impact:** Process leak → eventual resource exhaustion.
- **Has PR:** No open PR found.
- **Spawn candidate:** YES → `fix-69330`

### 11. #69284 — Gateway recurring pairing required error — subagent sessions fail
- **Severity:** M
- **Updated:** 2026-04-20 09:43 UTC
- **Root Cause:** Gateway keeps requesting pairing re-authentication for recurring sessions; subagent sessions fail with pairing required error.
- **Impact:** Cron / recurring subagent tasks fail repeatedly.
- **Has PR:** No open PR found. Related to PRs #69226/#69221/#69227 (merged 2026-04-20) which addressed similar pairing issues.
- **Spawn candidate:** YES → `fix-69284`

### 12. #69326 — WeChat replies not routed back when message originates from webchat UI
- **Severity:** M
- **Updated:** 2026-04-20 12:22 UTC (fresh)
- **Root Cause:** When a message comes through webchat UI and should route back to WeChat, the reply routing fails.
- **Impact:** WeChat users receive no reply when message originates from webchat.
- **Has PR:** No open PR found.
- **Spawn candidate:** YES → `fix-69326`

### 13. #69255 — Feishu WebSocket fails to reconnect after token timeout during gateway restart
- **Severity:** M
- **Updated:** 2026-04-20 (active)
- **Root Cause:** Feishu WebSocket connection fails to reconnect when token expires during gateway restart/bootstrap.
- **Impact:** Feishu integration permanently breaks after gateway restart.
- **Has PR:** No open PR found.
- **Spawn candidate:** YES → `fix-69255`

### 14. #69254 — IM channels (Telegram/QQ) do not get recovery-aware gateway restart behavior
- **Severity:** M
- **Updated:** 2026-04-20 07:32 UTC
- **Root Cause:** Unlike other channels, Telegram/QQ do not implement the recovery-aware restart behavior, so in-flight messages are lost on restart.
- **Related:** #69304 (Telegram 409 on restart), #69249 (Discord abort on restart)
- **Has PR:** No open PR found.
- **Spawn candidate:** YES → `fix-69254`

### 15. #69269 — Compaction/reset paths break session invariants (messageProvider + token accounting)
- **Severity:** M (umbrella for compaction invariants)
- **Updated:** 2026-04-20 12:16 UTC (recent activity)
- **Root Cause:** Both compaction and reset paths leave sessions in an inconsistent state regarding messageProvider and token accounting.
- **Has PR:** PR #69270 (fix: restore session invariants across compaction and reset) — open, not yet merged.
- **Status:** PR EXISTS — monitor for merge.

### 16. #69251 — exec host=node SYSTEM_RUN_DENIED for all file-referencing commands
- **Severity:** M
- **Updated:** 2026-04-20 (active)
- **Root Cause:** `exec host=node` denies all file-referencing commands because of `/bin/sh -lc` wrapping. All find/grep/disk commands blocked.
- **Has PR:** No open PR found.
- **Spawn candidate:** YES → `fix-69251`

### 17. #69242 — exec tool on Linux intermittently SIGKILLs broad find/grep commands without OOM evidence
- **Severity:** M
- **Updated:** 2026-04-20 07:05 UTC
- **Root Cause:** Linux exec tool occasionally kills broad find/grep discovery commands with SIGKILL, even when no OOM evidence exists.
- **Has PR:** No open PR found.
- **Spawn candidate:** YES → `fix-69242`

### 18. #69332 — AWS EC2 Linux instance fails to install on one-line install
- **Severity:** M (crash)
- **Labels:** `bug`, `bug:crash`
- **Updated:** 2026-04-20 12:42 UTC (very fresh)
- **Root Cause:** One-line install fails on AWS EC2 Linux.
- **Has PR:** No open PR found.
- **Spawn candidate:** YES → `fix-69332`

### 19. #69280 — compaction.truncateAfterCompaction rejected by strict zod schema
- **Severity:** M
- **Updated:** 2026-04-20 09:18 UTC
- **Root Cause:** `truncateAfterCompaction` config field is rejected by the Zod schema even though it's a documented config option.
- **Has PR:** PR #69282 (fix: add truncateAfterCompaction to schema) — open, not merged.
- **Status:** PR EXISTS — monitor.

### 20. #69220 — Gemini text-tag reasoning conflicts with native thinking — produces unclosed <think>, empty post-tool turn, payloads=0
- **Severity:** M
- **Updated:** 2026-04-20
- **Root Cause:** Gemini uses text-tag reasoning mode which conflicts with OpenClaw's native thinking format, producing malformed output.
- **Has PR:** No open PR found.
- **Spawn candidate:** YES → `fix-69220`

---

## ✅ Already Has Open PR

| Issue | Title | PR | Status |
|-------|-------|-----|--------|
| 69269 | compaction breaks session invariants | **#69270** | Open (fix: restore session invariants) |
| 69280 | truncateAfterCompaction rejected by schema | **#69282** | Open |
| 69214 | Gateway client stuck in scope-upgrade repair loop (Telegram) | (analyzing — see memory) | In progress |
| 67251 | Windows CLI SIGKILL | (subagent running) | In progress |
| 69300 | Agent harness compaction short-circuits | (new, no PR) | — |
| 69286 | totalTokens not reset after compaction | (new, no PR) | — |

### Newly Merged PRs (since 2026-04-15 scan)
- **#69226** — Surface pending scope upgrades in gateway auth errors
- **#69221** — Explain pairing scope upgrades during reconnects
- **#69227** — Fix pairing-required recovery details
- **#69215** — Split gateway probe capability from reachability
- **#69210** — Surface device pairing auth drift in doctor
- **#69207** — Default GitHub Copilot onboarding to Claude Opus 4.6
- **#69191** — fix(telegram): require numeric allowFrom ids in setup
- **#69224** (external fork PR #15) — docker: include patches/ in published image
- **#69229** (external fork PR #14) — tasks: clamp startedAt >= createdAt

---

## 🟡 Cluster: Compaction Invariants (related — consider cross-fix)

Multiple issues all pointing to compaction breaking core session state:
- **#69300** — memory flush + bookkeeping short-circuits
- **#69286** — totalTokens not reset → infinite safeguard loop
- **#69287** — session token count not reset after compaction
- **#69269** — messageProvider + token accounting broken after compaction/reset
- **#69202** — Compaction failure leaves session in permanent failed state

→ **PR #69270** addresses #69269. #69300 may need to be bundled with #69270 or a follow-up. #69286/#69287 are subsets.

---

## 🟡 Cluster: ACP Issues (all introduced/changed in 2026.4.15)

- **#69296** — ACP client hangs on slash commands (regression in 2026.4.15)
- **#69294** — ACP plugin crashes gateway on Windows 11 (crash)
- **#69290** — /new and /reset reply "ACP session reset in place" for non-ACP sessions (misleading)
- **#69301** — Telegram direct session survives /new and /reset (persistence bug)
- **#69304** — Telegram inbound 409 self-conflict after gateway restart

→ These may share a common root in the 2026.4.15 ACP changes. Worth investigating together.

---

## 🟡 Cluster: MCP / Subprocess Leaks

- **#69330** — MCP server duplicate processes on WhatsApp gateway reconnect (fresh today)
- **#69145** — Bundle MCP runtime never released for isolated cron sessions

---

## 🟡 Unclear / Needs Investigation

| Issue | Title | Notes |
|-------|-------|-------|
| 69333 | Hubitat installed-app config discovery | Low-priority Todo |
| 69331 | Venice.ai as image_generate provider | Enhancement |
| 69320 | Dreaming cron hard-coded 10-minute timeout | Config hardening |
| 69315 | Non-blocking TTS delivery | Enhancement |
| 69314 | OPENCLAW_DOCKER_PLATFORM support | Enhancement |
| 69311 | MEDIA: false-positive extraction from code blocks | Fix PR #69312 exists |
| 69309 | MEDIA directive silently drops media | Fix PR #69310 exists |
| 69307 | before_tts modifying hook | Enhancement |
| 69306 | Control UI date separators | Enhancement |
| 69302 | Image tool "Unknown model" for custom providers | Provider issue |
| 69298 | Codex harness double-counts cached input | Token accounting |
| 69293 | zsh completion for wiki ingest | CLI completion |
| 69291 | Agent Behavior Principles proposal | Enhancement |
| 69279 | Kokoro TTS as native provider | Enhancement |
| 69274 | Qwen qwen3.6-plus blocked on Coding Plan Pro | Model config |
| 69271 | Per-session delete/archive button in Control UI | Enhancement |
| 69260 | Harden Gemini ACP integration | Security hardening |
| 69250 | Gateway calls plugin register() ~30x per boot | Performance |
| 69249 | Gateway restart silently aborts Discord turn | Discord integration |
| 69246 | OpenClaw website loads indefinitely on MCP errors | Website/UI |
| 69241 | GitHub Copilot: add Claude Opus 4.7 | PR #69318 exists |
| 69239 | Image tool silently drops custom models when any provider lacks apiKey | Bug |
| 69238 | Architecture: remove duplicate BlueBubbles schema | Maintainer |
| 69235 | Opus/Sonnet reasoning leakage on Slack | Channel bug |
| 69234 | Configurable compaction summarization base instructions | Enhancement |
| 69233 | WhatsApp Group Admin Privacy Feature | PR #69297 exists |
| 69229 | tasks audit false positive inconsistent_timestamps | PR merged (#14) |
| 69224 | patches/ dir missing in published image | PR merged (#15) |
| 69220 | Gemini text-tag reasoning conflicts with native thinking | M (see above) |
| 69216 | openclaw doctor/upgrade should backup .env and openclaw.json | Enhancement |
| 69208 | Umbrella: duplicate transcript, replay, context assembly | Architectural |
| 69206 | Telegram /dock_discord falls through to normal chat | Regression |
| 69205 | Heartbeat configuration: no documented schema | Docs |
| 69204 | Cron isolated session agent-turn ends prematurely after 4.15 upgrade | Cron regression |
| 69202 | Compaction failure leaves session in permanent failed state | Compaction cluster |
| 69200 | Feishu message truncated with backticks/angle brackets | Streaming bug |
| 69190 | Frequent timeouts & agent ignoring tool restrictions | Broad / needs repro |
| 69188 | Cron Alert: Gemini CLI bridge OAuth pool | Cron-specific |
| 69187 | memory-core dreaming deleteSession() fails 100% → sessions.json leak → OOM | Memory leak |
| 69186 | Completion/success notification sound | Enhancement |
| 69185 | Control UI file uploads (documents, zips) | Enhancement |
| 69184 | feishu_drive tool: add download action | Enhancement |
| 69183 | Local outbound media allowlist/staging regression | Media regression |
| 69182 | active-memory plugin blocks chat replies up to ~5s | Performance regression |
| 69181 | plugins install treats npm packages as hook packs | Bug |
| 69180 | Unknown memory embedding provider: github-copilot | Regression |
| 69171 | media-understanding ignores agents.defaults.imageModel | Bug |
| 69167 | Automated bug-fix pipeline with Claude Code | Enhancement |
| 69166 | sessions_spawn schema lacks runtime=acp hint | Schema issue |
| 69165 | Outbound Telegram send queue with rate limiting | Enhancement |
| 69162 | openclaw cron run (dry-run) semantics mismatch | Cron |
| 69161 | Cron-context exec denials thrash verbose | Cron |
| 69160 | Status false-positive plugin allowlist warnings in 2026.4.15 | Regression |
| 69158 | spawn ENAMETOOLONG on Windows with claude-cli | Windows |
| 69157 | Slack Socket Mode stale-socket health check | Slack |
| 69156 | Session reset keeps old transcript file | Session management |
| 69155 | Session token count reports 0% context | Bug |
| 69147 | Telegram long-poll stalls cause delayed/missing replies | Telegram |
| 69142 | DEP0190 DeprecationWarning passing args to child process | Deprecation |
| 69141 | Adler ACP: model outputs raw tool_call JSON + empty post-tool turn | ACP bug |
| 69137 | Paperclip adapter sends root-level field schema rejects | Integration bug |
| 69135 | gateway probe false positive "multiple reachable gateways" | Probe bug |

---

## 📋 Summary

| Category | Count |
|----------|-------|
| Total open issues scanned | ~80 |
| **New S-tier (no PR)** | 5 |
| **New M-tier bug candidates (no PR)** | ~15 |
| **Has open PR (track for merge)** | 2 (compaction invariants + schema) |
| **Recently merged (since last scan)** | 9 |
| **Enhancement / feature request** | ~20 |
| **Needs investigation** | ~30 |

**Top subagent spawn list:**
1. `fix-69300` — compaction short-circuits memory flush (S)
2. `fix-69296` — ACP client hangs regression 2026.4.15 (S)
3. `fix-69294` — ACP plugin crashes gateway Windows 11 (S)
4. `fix-69286` — totalTokens not reset → infinite loop (S)
5. `fix-69289` — Browser aria refs fail in follow-up actions (S)
6. `fix-69329` — exec runtime premature "completed" surfacing (M)
7. `fix-69327` — Subagent sandbox stale workspace state (M)
8. `fix-69303` — Dedup replay on error path (M)
9. `fix-69330` — MCP server process leak on reconnect (M)
10. `fix-69284` — Recurring pairing required error (M)
11. `fix-69326` — WeChat routing failure from webchat origin (M)
12. `fix-69255` — Feishu WebSocket reconnection failure (M)
13. `fix-69254` — IM channels no recovery-aware restart (M)
14. `fix-69251` — exec host=node SYSTEM_RUN_DENIED (M)
15. `fix-69242` — exec SIGKILL without OOM evidence (M)
16. `fix-69332` — AWS EC2 install crash (M)

**Monitor for merge:** PR #69270 (compaction invariants), PR #69282 (truncateAfterCompaction schema), PR #69328 (ACP false zero-diff failures), PR #69312 (MEDIA false-positive), PR #69310 (MEDIA silent drop), PR #69318 (GitHub Copilot model list)

---

*Report generated by xixi at 2026-04-20T21:00:00 GMT+8*
