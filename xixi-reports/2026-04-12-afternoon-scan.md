# xixi 调研报告 · 2026-04-12 下午扫描

**扫描时间**: 2026-04-12 12:30 GMT+8  
**扫描范围**: 4 个方向全量扫描  
**最新版本**: v2026.4.11 (2026-04-12 00:18 发布)

---

## 📋 方向一：GitHub Issues（最近更新）

### ✅ 可接单的 Regression Bug（无 PR）

| 优先级 | Issue | 标题 | Size | 更新 | 备注 |
|--------|-------|------|------|------|------|
| 🥇 | **#65042** | Gmail watcher duplicates + port 8788 bind conflict | **S** | 04-11 | **当前第一推荐** |
| 🥈 | **#65078** | Telegram transcript invisible in Web UI (google-gemini-cli) | M | 04-12 | 新增1条评论，限定 google-gemini-cli provider |
| 🥉 | #64894 | OpenAI Codex OAuth `invalid_scope` on 2026.4.10 | S | 04-11 | |
| — | #63992 | session key write hardcodes DEFAULT_AGENT_ID (after PR #30) | M | 04-11 | |
| — | #63366 | dmPolicy 'allowlist' still sends to all DMs (issue 26982 is back) | S | 04-11 | regression |
| — | #63968 | Packaging regression: missing qa/scenarios/index.md in 2026.4.9 | S | 04-11 | 有 PR #65118 已关 |
| — | #64552 | Severe Performance Regression: 30-60s delay per API call | M | 04-11 | 模糊，无明确复现步骤 |

---

### 🔍 #65042 Gmail Watcher 深度分析

**结论：推荐接单，Size S，修复路径清晰**

**问题本质**: Gmail watcher 在 2026.4.10 中被启动了两次，第二次因 port 8788 已被占用而 bind 失败。

**代码定位**:
- 入口: `src/hooks/gmail-watcher-lifecycle.ts` → `startGmailWatcherWithLogs()`
- 实际启动: `src/hooks/gmail-watcher.ts` → `startGmailWatcher()`
- 生命周期管理: `src/hooks/gmail-watcher-lifecycle.ts`

**已知关键点**:
- 用户成功启动了第一个 watcher（gog 进程监听 127.0.0.1:8788）
- OpenClaw 稍后再次尝试启动第二个 watcher → `bind: address already in use`
- 即使重启 gateway、kill 所有 gog 进程也不行（说明不是残留进程问题）
- 在不同 port (8799) 上运行正常 → 问题在 OpenClaw 侧的 watcher lifecycle，不在 gog 本身

**可能的修复方向**:
1. 在 `startGmailWatcherWithLogs()` 中增加 guard：检查 port 是否已被占用（lsof 或尝试 connect）
2. 在 gateway lifecycle 中确保 watcher 只被 start 一次（用 flag 或状态追踪）
3. 看 `gmail-watcher-lifecycle.ts` 中是否缺少 `already started` 检测

**修复难度**: S  
**所需知识**: Gmail watcher lifecycle, gateway startup sequence  
**文件**: `src/hooks/gmail-watcher-lifecycle.ts`, `src/hooks/gmail-watcher.ts`

---

### 🔍 #65078 Telegram Transcript 分析

**问题**: 使用 `google-gemini-cli` provider 时，Telegram 会话 transcript 在 Web UI 不可见。但 OpenAI CLI provider 的 transcript 是可见的 → 说明是 google-gemini-cli provider 特有的问题。

**新增评论** (2026-04-12): 用户补充说明 ChatGPT (OpenAI CLI) 和 Google Gemini CLI 都通过 CLI providers 连接，只有 google-gemini-cli 的 transcript 看不见。

**Size 评估**: M（需要理解 CLI provider 的 session/history 写入路径与 google-gemini-cli 的交互）  
**不建议优先接单**: 规模偏大，需要理解 google-gemini-cli 的实现细节。

---

## 📋 方向二：已开 PR 的 Issue（勿重复接单）

以下 issues **已有 PR 在修**，不要重复接单：

| Issue | PR | 标题 | 作者 | 状态 |
|-------|-----|------|------|------|
| #65082 | #65124, #65118 | Completion cache missing qa/scenarios/index.md | mr-kelly, EdderTalmor | 双 PR |
| #65130 | #65147 | npm install -g --force flag | w-sss | |
| #65157 | #65167 | dispatch plugin hooks in cli-runner | w-sss | |
| #65132 | #65140 | Discord commentary leak | cass-clearly | |
| #65107 | #65128 | Browser SSRF blocks hostname URLs | mr-kelly | |
| #65102 | #65137 | tools.exec.security: full not enabling inline Python | mr-kelly | |
| #65103 | #65110 | MEDIA: lines redundant in generate tool | hclsys | |
| #65093 | #65101 | Browser CDP websocket ready wait | drvoss | |
| #65076 | #65096 | OpenAI audio transcription failures | l0cka | |
| #65009 | #65087 | Discord stale heartbeat timers | — | |
| #65075 | #65085 | Cron isolated agent workspace | — | |
| #65056 | #65071 | Prompt chat ids leak | — | |
| #65027 | #65057, #65034 | Dreaming timezone | — | |
| #65054 | #65059 | MiniMax baseUrl | — | |
| #65050 | #65061 | Codex image tool loops | — | |
| #65007 | #65058 | GoogleChat add-on space | — | |
| #65020 | #65036 | resolveModelsConfigInput | — | |
| #64982 | #65040 | plugins.allow exclusive warning | — | |

---

## 📋 方向三：已追踪 PR 的 Maintainer 评论

| PR | 作者 | 标题 | Maintainer 评论 |
|----|------|------|----------------|
| #65172 | ShionEria | fix(ui): stop misparsing cron-like at schedule strings | 无 review |
| #65171 | duqaXxX | fix(sessions-send): isolate announce deadlock | 1条 greptile-apps[bot] 评论 |
| #65170 | duqaXxX | fix(inter-session-completion-delivery) | 无 review |
| #65169 | coygeek | fix: node.invoke before node pairing | 无 review |
| #65138 | Takhoffman | Fix dreaming replay, repair polluted artifacts | maintainer PR，greptile 评论 |
| #65126 | shakkernerd | fix: preserve anthropic replay safety | maintainer PR，greptile + chatgpt-codex-connector bot 评论 |
| #65148 | pashpashpash | OpenAI: reduce repeated heartbeat alerts | maintainer PR，**无其他评论** |
| #65147 | w-sss | fix: npm install -g --force | 无 review |
| #65143 | uninhibite-scholar | feat: per-provider timeoutSeconds | 无 review |
| #65140 | cass-clearly | fix(agents): suppress commentary | 无 review |
| #65139 | kagura-agent | feat(skills): mixed-tier format | 无 review |
| #65137 | mr-kelly | fix: tools.exec.security full | 无 review |
| #65121 | CyberRaccoonTeam | fix: cron channel validation | 无 review |

**注意**: #65148 (OpenAI heartbeat alerts, maintainer PR, size XS) 没有任何 review，等待合并机会极低。已接近完成状态。

---

## 📋 方向四：v2026.4.11 发布后的 Regression 线索

v2026.4.11 发布于 2026-04-12 00:18，包含大量修复。新 regression 可能在未来几天涌现。

**v2026.4.11 修复覆盖的问题**（已修复，勿重复接）:
- #64713 OpenAI/Codex OAuth invalid_scope ← 对应 #64894
- #64766 Audio transcription OpenAI-compatible
- #62459 macOS Talk Mode after mic permission
- #63514 Control UI TTS audio persistence
- #53918 WhatsApp default account
- #64753 Ollama /api/show caching
- #64754 OpenAI-compatible endpoint classification
- #64441 QA/parity GPT-5.4 vs Opus 4.6
- #64648 QA packaging missing qa/scenarios/index.md ← 对应 #63968, #65082
- #64869 Telegram topic session
- #62907 Agents failover stale failure
- #64964 MiniMax OAuth
- #64918 WhatsApp image attachment

---

## 🎯 本次推荐优先级

```
🥇 #65042 Gmail watcher duplicate (SIZE S, 修复路径清晰, 无PR)
🥈 #63366 dmPolicy allowlist regression (SIZE S, 无PR)
🥉 #63992 session key hardcoded DEFAULT_AGENT_ID (SIZE M, 偏复杂)
```

**#65042 当前第一推荐**已确认无 PR，修复路径：
1. 在 `gmail-watcher-lifecycle.ts` 增加重复启动 guard
2. 检查 `gmail-watcher.ts` 的 `started` 状态管理
3. 在 gateway 启动序列中确保 watcher 只被调用一次

---

## ❌ 已排除

- 所有已有 open PR 的 issues（已在方向二列出）
- #64894 Codex OAuth：已被 #64713 在 v2026.4.11 中修复（release note 明确）
- #63968 Packaging：已被 #65118/#65124 双 PR 修复
- 大型/复杂 issue（#64552 performance regression 无明确复现步骤）
