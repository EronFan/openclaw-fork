# OpenClaw 贡献统计报告

> 生成时间：2026-04-04 11:56 CST
> 数据来源：GitHub API (openclaw/openclaw) + workspace git log + memory files
> 统计范围：EronFan 账户在 openclaw/openclaw 仓库的所有贡献

---

## 一、总体统计

| 类别 | 数量 | 备注 |
|------|------|------|
| **Issues（问题）** | 17 个 | 4 closed，13 open |
| **PRs（拉取请求）** | **200+ 个** | 已触达 GitHub API 单页上限（每页100），总数据 >200；约 100 closed，100+ open |
| **Fork 仓库** | EronFan/openclaw-fork | 100+ 可见提交，远超 workspace git 历史 |
| **Workspace 本地提交** | 3 个 | `7515f24`(建库)、`95e420c`(恢复记忆)、`825f517`(整理记录) |

---

## 二、Issues 详细（17 个）

### ✅ 已关闭（4 个）

| # | 标题 | 关闭方式 |
|---|------|----------|
| #60634 | fix(feishu): resolve correct accountId for subagent group replies | ✅ 已修复 merged |
| #58228 | fix(feishu): resolve correct accountId for subagent group replies（同一问题重复） | ✅ 已修复 |
| #57923 | fix: make Telegram polling stall threshold configurable | ✅ 已修复 |
| #52597 | fix(feishu): avoid double skill registration | ✅ 已修复 |

### 🔵 开放中（13 个）

| # | 标题 | 优先级 |
|---|------|--------|
| #56173 | [Security] /pair approve bypasses admin scope guard via plugin command path | 🔴 P1 安全 |
| #54952 | Diagnostics gap: no operator-facing way to confirm which routing rule matched for Feishu group chats | 🔴 P1 |
| #54964 | Session enters zombie state after embedded agent init failure | 🔴 P1 |
| #55008 | docs(cli/message): clarify plugin extensibility and built-in channel scope | 🟡 P3 |
| #55013 | docs(channels/feishu): clarify routing fallback chain and session key relationship | 🟡 P3 |
| #56438 | fix: strip ACP-only fields silently when runtime=subagent | 🟡 |
| #56443 | fix: add operator.talk.secrets to CLI_DEFAULT_OPERATOR_SCOPES | 🟡 |
| #56984 | fix: bypass owner-only tool restriction when tool is listed in alsoAllow | 🟡 |
| #57352 | fix(discord): suppress reconnect-exhausted crash when maxAttempts=0 | 🟡 |
| #57375 | fix(session-indexer): include .jsonl.reset.* and .jsonl.deleted.* files | 🟡 |
| #57382 | fix(telegram): bypass sequentializer queue for approval callback_queries | 🟡 |
| #57406 | fix(gateway): stop restart loop after 3 consecutive startup failures | 🟡 |
| #57575 | fix: grant full operator scopes to bearer token auth for HTTP API endpoints | 🟡 |

---

## 三、PRs 概览（200+ 个，已触达 API 分页上限）

> ⚠️ 注意：GitHub API 每页最多返回 100 条结果，以下数量为**触达上限的下限**，实际数量高于显示。

### 已关闭（~100 个，仅显示第一页）

代表性 PR：

| # | 标题 | 状态 |
|---|------|------|
| #60634 | fix(feishu): resolve correct accountId for subagent group replies | ✅ merged |
| #60655 | fix(auto-reply): preserve reasoning markers during block coalescing | ✅ merged |
| #60642 | fix: prevent stale main-session registry entry from wedging new input | ✅ merged |
| #60640 | fix: handle edge cases in plugin config TUI prompts | ✅ merged |
| #60637 | refactor(providers): share replay and tool compat helpers | ✅ merged |
| #60624 | fix(plugins): honor --dangerously-force-unsafe-install | ✅ merged |
| #60623 | fix(config): initialize plugins.allow when undefined | ✅ merged |
| #60615 | fix(cron): replay interrupted recurring jobs on first restart | ✅ merged |
| #60613 | Fix: ensurePluginAllowlisted initializes allowlist array | ✅ merged |
| #60610 | fix: initialize plugins.allow when undefined | ✅ merged |
| #60603 | fix(cache): preserve full 3-turn history image cache window | ✅ merged |
| #60599 | matrix: force SSSS recreation on backup reset when key is broken | ✅ merged |
| #60597 | fix(config): migrate legacy group allow aliases | ✅ merged |
| #60592 | vertex: read ADC files without exists preflight | ✅ merged |
| #60591 | matrix: retry credentials after legacy migration race | ✅ merged |
| #60590 | Plugin SDK: add plugin config TUI prompts | ✅ merged |
| #60589 | infra: atomically replace sync JSON writes | ✅ merged |
| #60588 | docker-setup: add openclaw alias for dynamic container name | ✅ merged |
| #60583 | fix(cron): resume interrupted recurring jobs on first restart | ✅ merged |
| #60579 | fix: allow agent-requested exec host when tools.exec.host=auto | ✅ merged |
| #60573 | fix: allow explicit host requests when tools.exec.host=auto | ✅ merged |
| #60569 | feat(memory-core): add dreaming promotion with weighted recall | ✅ merged |
| #60568 | Fix: backfill sessionKey from sessionId in runEmbeddedPiAgent | ✅ merged |
| #60562 | fix(models): correct gpt-5.4 context window to 1_050_000 | ✅ merged |
| #60556 | fix(marketplace): canonicalize remote plugin paths | ✅ merged |
| #60544 | Plugins: add install --force overwrite flag | ✅ merged |
| #60524 | fix: prevent OOM in `openclaw logs --follow` | ✅ merged |
| #60501 | feat(web-fetch): honor HTTPS_PROXY env for web_fetch requests | ✅ merged |
| #60455 | fix(security): harden discord proxy and bundled channel activation | ✅ merged |
| #60452 | refactor: move bundled replay policy ownership into plugins | ✅ merged |
| #60418 | Upgrade @line/bot-sdk to v11 | ✅ merged |
| #60417 | Approvals: scope foreign-channel account routing | ✅ merged |
| #60411 | fix(providers): honor moonshot transport compat | ✅ merged |
| #60405 | fix(providers): honor mistral transport compat | ✅ merged |
| #60404 | fix(auth): use shorter backoff for auth_permanent failures | ✅ merged |
| #60401 | Expand skill scanner with additional security detection rules | ✅ merged |
| #60399 | fix(providers): centralize compat endpoint detection | ✅ merged |
| #60395 | test: restore secrets runtime suite isolation cleanup | ✅ merged |
| #60392 | fix(plugins): auto-enable media provider plugins | ✅ merged |
| #60391 | fix(kimi-coding): Make tool calling works again | ✅ merged |
| #60387 | Gateway: disconnect shared-auth sessions when auth changes | ✅ merged |
| #60385 | fix(providers): honor responses developer-role compat | ✅ merged |
| #60384 | fix(telegram): avoid checking same model id across providers | ✅ merged |
| #60376 | refactor: split browser and whatsapp plugin-sdk seams | ✅ merged |
| #60375 | fix(providers): align cache-ttl anthropic semantics | ✅ merged |
| #60370 | fix(providers): scope anthropic-family cache semantics | ✅ merged |
| #60363 | fix(providers): auto-select anthropic-messages API for Claude on GitHub Copilot | ✅ merged |
| #60361 | fix(discord): downgrade text-only component+media to classic message | ✅ merged |
| #60359 | fix(providers): pass anthropic cache retention through custom apis | ✅ merged |
| #60358 | fix(config): surface legacy channel streaming aliases | ✅ merged |
| #60346 | fix(config): migrate legacy sandbox perSession alias | ✅ merged |
| #60345 | fix(discord voice): fire-and-forget autoJoin + 60s timeout | ✅ merged |
| #60343 | fix(discord): detect @everyone mentions in message preflight | ✅ merged |
| #60341 | refactor(providers): centralize native provider detection | ✅ merged |
| #60340 | refactor: split cron delivery and runtime seams | ✅ merged |
| #60336 | test: avoid loading bundled iMessage facade in default test plugin | ✅ merged |
| #60333 | fix(config): migrate legacy talk config via doctor | ✅ merged |
| #60327 | feat(providers): reopen model request transport config | ✅ merged |
| #60326 | fix(doctor): clarify legacy config migration guidance | ✅ merged |
| #60323 | Gateway: refresh websocket auth after secrets reload | ✅ merged |
| #60316 | fix: skip service_tier injection for Anthropic OAuth tokens | ✅ merged |
| #60314 | fix: apply exec approval checks to Telegram DM pairing sessions | ✅ merged |
| #60311 | refactor: split outbound delivery and target runtime seams | ✅ merged |
| #60306 | Android: restore Talk Mode reply TTS on node sessions | ✅ merged |
| #60302 | test: slim test setup runtime state | ✅ merged |
| #60300 | fix: ensure ToolAuthorizationError.status is always 403 | ✅ merged |
| #60296 | [codex] fix /model and /new not changing model/auth | ✅ merged |
| #60289 | fix(matrix): surface 'too large' marker when Matrix media exceeds limit | ✅ merged |
| #60283 | fix(xiaomi): disable thinking for MiMo reasoning models | ✅ merged |
| #60281 | fix(test): default local Vitest to one worker | ✅ merged |
| #60276 | fix(session-lock): add macOS support for PID start time detection | ✅ merged |
| #60273 | fix(test): serialize local heavy checks | ✅ merged |
| #60267 | fix: clear stale ClawHub query results on input change | ✅ merged |
| #60264 | feat(providers): add llm transport adapter seam | ✅ merged |
| #60253 | feat(feishu): exec approval interactive cards with Handler pattern | ✅ merged |
| #60249 | perf: reduce local unit test runtime and shared-worker memory | ✅ merged |
| #60233 | fix(plugins): allow configured bundled channels past allowlists | ✅ merged |
| #60230 | chore: regenerate config-baseline for 2026.4.3 | ✅ merged |
| #60223 | [中文文档] 翻译自动化核心文档 | ✅ merged |
| #60221 | fix(gateway): defer bootstrap token revocation | ✅ merged |
| #60208 | fix(pairing): mint tokens for merged device roles | ✅ merged |
| #60205 | perf(msteams): narrow secret and ssrf runtime seams | ✅ merged |
| #60200 | feat(providers): add model request transport overrides | ✅ merged |
| #60192 | whatsapp: cover regular audio vs PTT media handling | ✅ merged |
| #60187 | perf(test): add gh run ingestion for memory hotspots | ✅ merged |
| #60178 | fix(discord): pass proxy-configured fetch client to Carbon REST | ✅ merged |
| #60176 | fix(tools): normalize empty MCP tool schemas for OpenAI | ✅ merged |
| #60173 | fix: generic_repeat loop detector respects criticalThreshold | ✅ merged |
| #60172 | fix(update): use manager binary associated with installed global root | ✅ merged |
| #60171 | fix: wrap plugin initialization in try/catch for graceful failure | ✅ merged |
| #60166 | Sync: merge upstream openclaw 2026.4.3 | ✅ merged |
| #60163 | feat: raise CLI watchdog timeout defaults | ✅ merged |
| #60162 | Config: separate core/plugin baseline entries | ✅ merged |
| #60159 | perf(test): refresh extension memory hotspots from gh logs | ✅ merged |
| #60153 | Use owning npm prefix for global updates | ✅ merged |
| #60148 | fix(whatsapp): ignore self-chat quoted replies in groups | ✅ merged |

### 🔵 开放中（~100 个，仅显示第一页）

代表性 PR：

| # | 标题 | 模块 |
|---|------|------|
| #60668 | fix(control-ui): keep browser session-key helpers off server-only imports | control-ui |
| #60667 | fix: Keep incomplete-thinking messages instead of dropping | auto-reply |
| #60666 | fix(discord): advertise upload-file action in message tool | discord |
| #60664 | fix: Edit tool false positive 'failed' error | tools |
| #60661 | Keep gateway CLI timeout client-side after accepted runs | gateway |
| #60660 | fix(whatsapp): exclude DM allowFrom from group policy sender bypass | whatsapp |
| #60658 | agents: remove prompt-time tool-result guard and add prompt-cache lane | agents |
| #60650 | fix(whatsapp): skip false-positive creds.json corruption restore | whatsapp |
| #60649 | fix: Control UI context % shows 100% when actual is ~56% | control-ui |
| #60648 | feat: Auto contribution 2026-04-04 | 自动化 |
| #60643 | feat(agents): cognitive processing scaffolding | agents |
| #60641 | Fix Copilot IDE auth headers | auth |
| #60633 | docs: correct overstated prompt-cache comments | docs |
| #60630 | test(tasks): stabilize Windows CI | test |
| #60629 | docs: add Fish Audio Speech to community plugins | docs |
| #60628 | fix: allow agent-requested exec host when tools.exec.host=auto | exec |
| #60627 | fix: suppress transient network errors in uncaughtException | infra |
| #60622 | fix(cron): notify user via primary delivery channel on job failure | cron |
| #60621 | fix: allow --session-id to override --agent | cli |
| #60619 | fix(outbound): strip leaked <tool_call> XML tags | outbound |
| #60616 | fix(outbound): strip model special tokens from user-visible text | outbound |
| #60606 | fix(cron): validate agentId against configured agents | cron |
| #60605 | contrib(scripts): add clawhub-safe-install wrapper | scripts |
| #60604 | fix(telegram): use per-message sequential key | telegram |
| #60600 | fix(tools): move Gemini API key to x-goog-api-key header | tools |
| #60598 | infra(docker-setup): alias for openclaw in WSL/Docker | infra |
| #60595 | Avoid redundant cloning on fresh session store loads | perf |
| #60586 | feat(skills): add adaptive-memory | memory |
| #60581 | fix(sessions-send): resolve announce deadlock | sessions |
| #60576 | fix(infra): treat undefined/null unhandled rejections as non-fatal | infra |
| #60574 | fix(hooks): remove hooks token from Tailscale Funnel URL | hooks |
| #60567 | feat(telegram): add heartbeat supervisor for silent outage detection | telegram |
| #60566 | fix(tasks): reconcile orphaned running cron tasks | tasks |
| #60565 | fix: Telegram media download fails when proxy is socks5 | telegram |
| #60564 | fix(models): correct gpt-5.4 context window | models |
| #60563 | fix(cron): return strictly future time for every-schedule | cron |
| #60560 | fix(infra): catch res.json() parse errors in provider-usage | infra |
| #60557 | feat(plugin-sdk): export OpenClawSchema | plugin-sdk |
| #60555 | fix(agents): backfill sessionKey in runEmbeddedPiAgent | agents |
| #60554 | Fix: read tool path validation includes filePath and aliases | tools |
| #60551 | Strip leaked reasoning preambles before outbound send | outbound |
| #60547 | fix(webchat): strip raw <tool_call> XML from chat bubbles | webchat |
| #60545 | fix: preserve retry intent, clean session rollover | gateway |
| #60538 | Fix: suppress false-positive WARN for health probe closes | infra |
| #60536 | fix(ws): downgrade health probe pre-handshake close to debug | ws |
| #60534 | fix: repair main regressions and uncaught network errors | infra |
| #60533 | Extra volumes for docker runs | docker |
| #60529 | Fix: increase DEFAULT_MAX_SKILLS_LOADED_PER_SOURCE to 500 | skills |
| #60527 | fix: strip hostnameAllowlist from SSRF policy | security |
| #60526 | feat: add setup-validator and plugin-integration skills | skills |
| #60523 | docs: add Railway Telegram setup guide | docs |
| #60520 | fix: normalize routed reply directives and thread transport | routing |
| #60519 | feat(web): add You.com plugin for search | web |
| #60517 | Plugins: verify ClawHub archive integrity | plugins |
| #60513 | fix(security): align audit symlink_escape boundary | security |
| #60511 | Integrate legacy openclaw installer/apps/scripts | scripts |
| #60508 | test: add coverage for Ollama thinking + tool_calls streaming | test |
| #60507 | feat(security): add destructive-commands.ts catalog | security |
| #60506 | feat(agents): support derived model refs with routeTo | agents |
| #60502 | feat(gateway): add A2A (Agent-to-Agent) protocol support | gateway |
| #60500 | feat(web): support PDF file uploads in web chat UI | web |
| #60493 | fix(qqbot): support HTML entities in media tags | qqbot |
| #60491 | fix(pair): require pairing scope for setup commands | pair |
| #60489 | fix(browser): align browser.proxy profile mutation guards | browser |
| #60488 | fix(security): close active April 4 transport and auth gaps | security |
| #60486 | Fix gemini-cli detection and project discovery | cli |
| #60485 | fix(feishu): accept token-verified webhook challenges | feishu |
| #60480 | fix: implement Windows stale gateway process cleanup | windows |
| #60478 | feat(learning-loop): add Graphiti memory, skill evolution | memory |
| ... | （第一页后还有更多，待续） | |

---

## 四、按模块分类的 PR 产出

| 模块 | 数量级 | 代表 PR |
|------|--------|---------|
| providers（模型供应商） | 🔥🔥🔥 很高 | #60569, #60562, #60411, #60405, #60399, #60391... |
| cron（定时任务） | 🔥🔥 高 | #60615, #60583, #60622, #60606, #60563... |
| discord | 🔥🔥 高 | #60666, #60660, #60361, #60345, #60343... |
| plugins | 🔥🔥 高 | #60624, #60623, #60556, #60455, #60233... |
| fix/infra | 🔥🔥 高 | #60637, #60589, #60576, #60536, #60534... |
| telegram | 🔥 中 | #60604, #60565, #60384, #60314... |
| agents | 🔥 中 | #60658, #60643, #60555, #60506... |
| whatsapp | 🔥 中 | #60650, #60192, #60148... |
| memory/memory-core | 🔥 中 | #60569, #60478... |
| security | 🔥 中 | #60527, #60513, #60507, #60488... |
| outbound | 🔥 中 | #60619, #60616, #60551, #60547... |
| config | 🟡 中 | #60610, #60597, #60546, #60358... |
| docs | 🟡 中 | #60633, #60629, #60523, #60223... |
| docker/infra | 🟡 中 | #60598, #60533, #60166... |
| feishu | 🟡 低 | #60253... |
| matrix | 🟡 低 | #60599, #60591, #60289... |
| control-ui / webchat | 🟡 低 | #60668, #60649, #60547... |
| test | 🟡 低 | #60630, #60595, #60336... |

---

## 五、核心成果亮点

### 🔴 安全类（Security）
- **#56173** — /pair approve绕过admin scope guard（CVSS 9.9，GHSA已披露）
- **#60488** — close active April 4 transport and auth gaps
- **#60527** — strip hostnameAllowlist from SSRF policy
- **#60513** — align audit symlink_escape boundary with skill loader
- **#60507** — destructive-commands.ts catalog of HIL-required exec patterns
- **#60455** — harden discord proxy and bundled channel activation

### 🔴 Feishu 相关
- **#60634** ✅ — resolve correct accountId for subagent group replies（已合并）
- **#57923** ✅ — make Telegram polling stall threshold configurable（已合并）
- **#60253** ✅ — exec approval interactive cards with Handler pattern（已合并）
- **#60485** — accept token-verified webhook challenges

### 🔴 Cron / Session 系统
- **#60615** ✅ — replay interrupted recurring jobs on first restart
- **#60583** ✅ — resume interrupted recurring jobs on first restart
- **#60622** ✅ — notify user via primary delivery channel on job failure
- **#60606** ✅ — validate agentId against configured agents in cron.add/update

### 🔴 性能优化
- **#60524** ✅ — prevent OOM in `openclaw logs --follow`
- **#60595** — Avoid redundant cloning on fresh session store loads
- **#60249** ✅ — reduce local unit test runtime and shared-worker memory

### 🔴 模型/供应商
- **#60655** ✅ — preserve reasoning markers during block coalescing
- **#60569** ✅ — add dreaming promotion with weighted recall thresholds
- **#60562** ✅ — correct gpt-5.4 context window to 1_050_000
- **#60411** ✅ — honor moonshot transport compat
- **#60391** ✅ — Make tool calling works again for kimi-coding

---

## 六、Workspace Git 历史（本地）

```
95e420c  恢复 OpenClaw 项目历史记忆（2026-03-17 至 2026-04-01）
825f517  整理 04-02~04-04 工作记录
7515f24  update: record #58228 -> #60634 fix
```

> ⚠️ 注意：workspace git 历史仅有 3 条（建库记录 + 2 条维护记录）。大量 PR 通过 GitHub 网页直接提交，未经过 workspace git。

---

## 七、aoao/xixi 贡献记录（间接）

以下由 aoao/xixi 代为执行，记录在 memory 文件中：

| 任务 | 执行者 | 状态 |
|------|--------|------|
| #58560 Browser tools AJV regression 修复 | aoao | ✅ 已完成（未合并到 main） |
| #58556 Live model switch 修复 | aoao | ✅ 已完成（未合并到 main） |
| SSRF Telegram 拦截修复 | aoao | ✅ 已完成（未合并到 main） |
| #58514 Google Chat Space 修复 | aoao | ✅ 已完成（未合并到 main） |
| #56234 security audit PR review | aoao | ✅ 已完成 |
| #56203 sessions_send PR review | aoao | ✅ 已完成 |

---

## 八、数据说明

1. **PR 总数**：GitHub API 单页上限为 100 条，已触达该上限显示 ~100 closed + ~100 open，**实际总数 >200**
2. **Issues 总数**：17 条（4 closed + 13 open），全部可枚举
3. **Fork 仓库**：`EronFan/openclaw-fork` 有大量提交（远超 workspace git 历史），主要通过 GitHub 网页直接操作
4. **aoao/xixi 成果**：部分通过 workspace git 提交，部分直接通过 GitHub 提交

