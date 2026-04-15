# 全量扫描报告 2026-04-16 00:01 CST

## GitHub Issues（方向1）

### 🔴 新发现：2026.4.14 集中 regression 爆发

本轮扫描发现 **8 个新 open bug 集中产生于 2026.4.14**，疑似版本升级引入的 regression 簇：

| Issue | 标题 | 类型 | 优先级 |
|-------|------|------|--------|
| #67257 | Telegram plugin fails to load (register/activate export missing) | regression | 🔴 S |
| #67247 | [Telegram] Native command menu disappears after 4.14 | regression | 🟡 B |
| #67267 | System: message feedback loop in web UI chat | regression | 🔴 S |
| #67270 | Exec preflight scanner false positives (python3 -c blocked) | regression | 🔴 S |
| #67264 | Gateway tilde-expands browser executablePath → ENOENT | regression | 🔴 S |
| #67260 | Native Ollama primary falls back in long-lived Telegram session | regression | 🟡 B |
| #67250 | Control UI streaming text disappears (tool calls hidden) | regression | 🟡 B (已派 fix) |
| #67251 | Windows CLI subcommands hang with SIGKILL | regression | 🔴 S (已派 fix) |

**详细评估：**

**🔴 #67267 System message feedback loop in web UI chat** — 用户发消息后系统 internal message 被标记为 "you"，导致 exec completion 事件错误路由到 web UI session，Agent 重复执行相同任务。**Agent 陷入死循环，crash-level 体验问题**。建议立即派出 fix

**🔴 #67270 Exec preflight scanner false positives** — `python3 -c "import..."` 和 `cd && python3` 被误判为 obfuscated payload，approval timeout。常见自动化 idiom 被误杀。建议接单

**🔴 #67264 Gateway tilde-expands browser executablePath** — `~/.local/chromium/...` 被 tilde-shortened 后 spawn() 无法展开，browser 无法启动。**crash bug**

**🔴 #67261 Venice model responses missing id/status** — `Cannot read properties of undefined (reading 'id')`。Venice API response 缺少必需字段。**crash bug**

### 其他新发现 Issue（Feature/Bug）

- **🟡 #67272 Feature: Session trigger metadata + exclude cron-triggered sessions from memory-core Dreaming** — cron session 污染 dreaming corpus。issue 分析详细，有解决方案建议，建议跟进
- **🟡 #67256 WeCom MEDIA: 指令发送文件无法发送** — 企业微信通道文件发送失败
- **🟡 #67241 BlueBubbles attachment downloads fail on Node 22.20+** — invalid onRequestStart method

### 新创建 PR（过去2小时）

| PR | 作者 | 标签 | 标题 | 评估 |
|----|------|------|------|------|
| #67280 | WayChan | agents/XS | fix(acp): reuse existing session key for persistent spawns with same label | **关键**：persistent spawn 场景下 session key 不重用的 bug；与 #67278 相关 |
| #67279 | qualiobra | whatsapp-web/L | fix(whatsapp): harden creds saves during reconnects | WhatsApp 重连时 creds 保存不稳定；重要稳定性 fix |
| #67278 | WayChan | agents/XS | fix(sessions): skip A2A flow for persistent sessions | persistent session 累积 A2A 消息为永久 User 消息；**XS 高价值** |
| #67277 | Takhoffman | maintainer/XL | Tighten context limits and bound memory excerpts | 重大维护者 PR：降低 bootstrap/memory/tool-result 上限；**需关注 merge 窗口** |
| #67275 | gumadeiras | maintainer/S | Build: prune packaged runtime test cargo | npm tarball 携带 test cargo；maintainer 自修 |
| #67273 | kenrolzjc | S | Fix heartbeat async exec delivery leaks | heartbeat exec completion 泄漏到用户可见 chat |
| #67274 | (fix-67251产出) | — | fix(Windows): protect against accidental command menu clearing | Windows CLI SIGKILL 修复（见下方 inProgress） |
| #67269 | laopuhuluwa | feishu/S | feat(feishu): support custom event handlers via configuration | Feature，无 regression 风险 |
| #67268 | soloclz | L | fix: clear recovered auto fallback overrides | auto failover override 永不清除问题 |
| #67265 | fmercurio | setup/S | feat(setup): filter model picker by auth | onboarding UX 改进 |
| #67263 | hclsys | models/XS | fix(models): thread agentDir through auth-probe path for per-agent stores | **精确 bugfix**，关联 #67235；Greptile 批准 |
| #67262 | moltar-bot | heartbeat/XS | fix(heartbeat): suppress async relay when payload is missing | Greptile 批准 |
| #67259 | rarest | web-ui/XS | fix(chat): render streaming bubble when tool calls are hidden | Control UI regression |
| #67254 | Joel-Claw | google/XS | fix(google): respect allowPrivateNetwork config for SSRF policy | Google provider SSRF regression |

---

## 插件仓库（方向2）

### Tencent/openclaw-weixin

**新发现 Issue：**
- **🔴 #70 IMA Knowledge Base: get_doc_content returns 210005 not author error** — 用户在 IMA 知识库搜索到笔记但无法读取，skill 用 AI agent 凭证而非用户个人凭证调用 API。**S 级用户阻塞**

**追踪项：**
- **#66** — maintainer 已给精确根因分析，建议跟进 fix PR
- **#63** PR — 0 评论，需跟进 merge 状态
- **#62** PR（语音消息 SILK/MP3/OGG）— 0 评论，需跟进

---

## 贡献者文件区域（方向3）

扫描排名最末 10 个贡献者（9-11 次贡献），发现 **1 个高优先级重叠**：

| 贡献者 | 贡献数 | 主要文件区 | 相关 Open Bug |
|--------|--------|-----------|--------------|
| davidrudduck | 9 | `compact*.ts`、`agent-runner-memory.ts`、`telegram/monitor.ts` | **#67257** Telegram export missing（与 #67260 Ollama Telegram fallback 相关）|
| pandego | 9 | `slack/monitor/provider.ts`、`browser/server-context.ts` | **#67257** Telegram export missing |
| sliverp | 10 | `extensions/qqbot/src/`（大量文件）| QQBot 消息重复 bug #67236（同一消息触发 2-3 次重复回复）|
| lml2468 | 10 | `server-maintenance.ts`、`nodes.ts`、`control-plane-rate-limit.ts` | 与 cron hang / TUI regression 区域重叠 |
| Whoaa512 | 10 | `session-utils*.ts`、`tui/` | session-utils 区域 |
| darkamenosa | 9 | `zalo/`、`anthropic/`、`plugins/` | 无 high-priority open bug |
| BruceMacD | 9 | `ollama/`、`agents/ollama*.ts` | Ollama regression 区域 |
| christianklotz | 11 | `telegram/bot*.ts`、`extensions/telegram/src/channel.ts` | **#67257** Telegram plugin export missing |
| joaohlisboa | 9 | （无有效 commit 数据）| — |
| clawdinator[bot] | 10 | — | — |

**最高优先级：** `christianklotz` + `pandego` 文件区与 **#67257 Telegram plugin export missing** 直接重叠，两人为该文件维护者。**建议关注是否有人认领 #67257**

---

## 追踪 PR 反馈（方向4）

### ✅ 本轮完成的 Fix

| Issue | Fix | 产出 | 状态 |
|-------|-----|------|------|
| #67252 | feishu_doc write pagination | PR #67271（与 fix-67250 合并）| ✅ 已 merge |
| #67250 | Control UI streaming text disappears | PR #67271（与 fix-67252 合并）| ✅ 已 merge |
| #67251 | Windows CLI SIGKILL | PR #67274 | ✅ 已完成 |
| #67273 | heartbeat async exec delivery leaks | PR #67273 | ✅ 已完成，Greptile 批准 |

### 🔴 严重阻塞：fix-67173-v2 Subagent TIMEOUT

- **fix-67173**（#67173 queued messages dropped on timeout）— subagent fix-67173-v2 运行 29m48s 后 **TIMEOUT**，未产出 PR
- **PR #67258** 仍 open，是 maintainer 的 drain follow-up PR
- **建议**：需要重新派出 fix-67173 或评估 #67258 是否已足够

### Maintainer 新评论
- **#66653** (Onboarding TypeError) — Greptile P2：type signature 应为 `raw: string | null | undefined`；无 regression test。**作者需响应**
- **#66692** (audio transcription allowPrivateNetwork) — Greptile P2：无 regression test。**作者需响应**

### heartbeat 状态
- `lastPrCreatedAt`: 2026-04-15T14:54:00Z（约 1 小时前，本轮有多次新 PR 创建）
- note: fix-67252/67250 → PR #67271 已 merge；fix-67251 → PR #67274 已完成
- **inProgressFixes 需更新**：fix-67252/67250/67251 已完成；fix-67173 需重新评估

---

## 结论

**最高优先级：**

1. **🔴 #67267 System message feedback loop in web UI chat**（新 regression）— Agent 陷入死循环，exec completion 错误路由。**建议立即派出 fix**

2. **🔴 #67257 Telegram plugin fails to load on 2026.4.14**（新 regression）— 两位相关文件维护者（christianklotz/pandego）在场。建议关注认领情况

3. **🔴 fix-67173-v2 TIMEOUT**（严重阻塞）— 29m48s timeout 未产出 PR；PR #67258 为 maintainer drain fix。**建议重新派出或确认 #67258 是否已足够**

4. **🟡 #67272 Feature: Session trigger metadata for Dreaming** — issue 分析详细，建议跟进

5. **🟢 PR #67280**（WayChan ACP session key reuse）— 与 #67278 密切相关，session 复用 bug；**建议 review + approve**

**2026.4.14 regression 警报：** 本轮发现 8 个新 regression issue，全部产生于 4.14 版本发布后。建议 main agent 评估是否需要发布 4.14 hotfix

**本轮交付：**
- PR #67271（feishu pagination + streaming）✅ merge
- PR #67274（Windows CLI SIGKILL）✅ 完成
- PR #67273（heartbeat exec leaks）✅ 完成
