# 全量扫描报告 2026-04-15 16:18 CST (08:18 UTC)

## 扫描概况
- 扫描时间：2026-04-15 16:18 CST
- 扫描范围：openclaw/openclaw 主仓库（含 issues + PRs）
- 策略：no-build（不做 pnpm test/build/check，纯代码定位 + 派单）

---

## GitHub Issues（方向1）

### 🔴 S 级 — 立即派单修复

#### 1. #66885 — Telegram polling stall + undici HTTP/2 root cause
- **严重程度：S regression**
- **根因：** 完全清晰。`allowH2: false` 在 4.7 被加到 web_fetch，但 **Telegram polling dispatcher 未应用**，导致 undici 在 Windows 上尝试 HTTP/2 + IPv6，90-200s 超时，event loop 完全冻结。
- **关联：** 与 #67034（16-account Telegram avalanche）为同一根因的不同表现。
- **修复方案：** 在 Telegram polling dispatcher 加上 `allowH2: false`（同 web_fetch 一样的 fix）。
- **状态：** 无关联 PR，仍 open。
- **建议：** 立即派单，根因+fix均明确，1-2小时可完成。

#### 2. #67057 — 紧急：dreaming-narrative 导致 Telegram 通讯严重阻塞
- **严重程度：S regression（阻塞核心通讯）**
- **根因：** 完全清晰。77个 dreaming-narrative 会话（占82%活跃会话）持续消耗资源，Load Avg 达 45.67，消息处理被梦境会话阻塞，响应从秒级变为分钟级，最终完全阻塞。
- **关键数据：** 94个活跃会话中77个是 dreaming-narrative，主 agent sessions.json 膨胀到 4.5MB。
- **修复方案：** 需要：① 梦境会话自动清理机制；② 梦境并发数限制；③ 用户消息优先级高于梦境消息。
- **状态：** 无关联 PR。
- **建议：** 立即派单，这是功能性回归而非简单 bug。

#### 3. #66975 — Telegram bot commands disappear after upgrading to 2026.4.14
- **严重程度：S regression**
- **根因：** 描述清晰。4.14 changelog 提到"Telegram/native commands: restore plugin-registry-backed auto defaults" 和 "keep Telegram command-sync cache process-local"，但升级后命令完全不显示，Bot Menu 按钮丢失。
- **Workaround：** `/setmenubutton` + `/empty` 可恢复菜单按钮但无法恢复斜杠命令列表。
- **状态：** 无关联 PR。
- **建议：** 立即派单，changelog 相关性100%。

---

### 🟡 M 级 — 清晰根因，可派单

#### 4. #67035 — Windows chat UI regression (2026.4.14): input swallowed, streaming broken
- **严重程度：M regression**
- **根因：** 回归 2026.4.14，输入文字延迟/丢失，流式输出不实时渲染，需刷新页面才可见，typing indicator 闪一下就消失。
- **关键线索：** 同 4.14 的 WebChat message disappear (#67028) 可能同一 root cause。
- **状态：** 无关联 PR。
- **建议：** 派单，与 #67028 合并处理。

#### 5. #67034 — Telegram 16-account polling avalanche
- **严重程度：M regression**
- **根因：** 所有16个 Telegram 账号同时触发 `getUpdates` stall（110-136s timeout），然后级联重启，16个并发 WebSocket 重连 + 16个 transport 重建 + 16个 native-approvals 连接失败同时发生。根因同 #66885。
- **状态：** 无关联 PR（与 #66885 同根因）。
- **建议：** 与 #66885 合并派单。

#### 6. #67028 — WebChat 消息短暂显示后消失（4.14 回归）
- **严重程度：M regression**
- **根因：** 与 #66316 描述的 history reload race condition 完全一致。消息短暂显示 → 消失 → 数秒后重新出现。触发 tool use 的多轮对话消息可能丢失。
- **状态：** 无关联 PR。
- **建议：** 派单，可参考 #66316 的分析。

#### 7. #67021 — Main workspace excluded from dreaming schedule
- **严重程度：M regression**
- **根因：** `agents.list` 包含 main agent，但 dreaming 只处理 4个 agi-* workspace，跳过 main。main 有210条 short-term recall 但 DREAMS.md 过期（4月13日最后修改）。
- **状态：** ⚠️ **有 PR #67021** — fix(dreaming): use ingestion date for dayBucket... 由 Etoilelune 创建于 08:12 UTC，reviewDecision 空，尚无 maintainer review。
- **建议：** 等待/推动 #67021 merge。

#### 8. #67019 — GLM-4.7 garbled output
- **严重程度：M regression**
- **根因：** GLM-4 模型所有响应都是乱码字符（"matth"、"仓"、"insurgency"），/clear、reinstall、换模型均无法解决。可能是 provider 路由或 model encoding 问题。
- **状态：** 无关联 PR。
- **建议：** 派单调查。

#### 9. #67006 — main(9b1b56a) stuck at `[build-all] runtime-postbuild`
- **严重程度：M regression**
- **根因：** 不明确，但 build 停在 runtime-postbuild 阶段，package 变化（+5 -213）可能是诱因。
- **状态：** 无关联 PR。
- **建议：** 派单，需要本地复现。

---

### 未归级但值得关注

| # | Title | 备注 |
|---|-------|------|
| 67058 | [Feature] Add session list filter to hide dreaming/system sessions | enhancement，可做可不做 |
| 67051 | Config validation error when disabling second skill | bug:behavior，config schema 相关 |
| 67053/67052 | TUI streaming indicator stays active | UI bug，M 级潜在 |
| 66988 | Raw mode silently disabled | regression，有详细 fix 建议 |
| 66978 | sessions_spawn timeout while child completes | regression，orchestration layer 问题 |

---

## 插件仓库（方向2）

- **openclaw/openclaw-plugin**：无 open issues
- **openclaw/openclaw-plugin-weixin**：无 open issues
- **Tencent/openclaw-weixin**：无新 activity
- **结论：** 无需行动。

---

## PR 反馈（方向4）

### ⚡ 新 PR — 需立即关注

| # | Title | Author | 状态 |
|---|-------|--------|------|
| **#67069** | feat(feishu): pass thread_id as MessageThreadId in inbound context | Etoilelune | greptile-apps commented (08:21 UTC) |
| #67066 | fix(dreaming): use ingestion date for dayBucket... | leaderlemon | 无 review，刚更新 |
| #67063 | fix(plugins): include memory slot plugin... | sahilsatralkar | 2 bots + author commented |

### 🔍 PRs 大量 review activity — 可能需要 maintainer 介入

| # | Title | Activity | 说明 |
|---|-------|----------|------|
| **#67047** | fix(media): allow host-local CSV and Markdown uploads via Slack | chatgpt-codex-connector 密集评论 + Unayung 回复 8次 | 最新 08:14 UTC，可能需要 maintainer review |
| **#67037** | fix(ui): skip session.message reloads during active chat | chatgpt-codex-connector 4次评论 | web-ui 相关，可能与 #67028 同根因 |
| **#67036** | fix(ui): filter leaked control ui transcript rows | 2 bots commented | UI leak fix |
| **#67033** | fix(discord): unblock gateway CI checks | chatgpt-codex-connector 2次评论 | CI 相关 |

### ✅ 已 reviewed 可 merge 的 PR（size ≤ M）

| # | Title | Author | Size | 说明 |
|---|-------|--------|------|------|
| #67047 | fix(media): allow host-local CSV and Markdown via Slack | Unayung | S | 大量 review，需跟进 |
| #67037 | fix(ui): skip session.message reloads during active chat | hansolo949 | M | 可能同时修 #67028 |
| #67036 | fix(ui): filter leaked control ui transcript rows | hansolo949 | S | UI leak |
| #67033 | fix(discord): unblock gateway CI checks | luoyanglang | S | CI unblock |
| #67027 | fix(cli): explicitly skip plugin loading for cron | xl0shk | XS | cron subcommand |
| #67025 | fix(plugins): register HTTP routes for setup-runtime | ly85206559 | XS | plugin deferred load |

---

## Top Candidate 派单汇总

| 优先级 | # | Title | Root Cause | 建议 |
|--------|---|-------|------------|------|
| **🔴 S** | **#66885** | Telegram polling stall (undici HTTP/2) | `allowH2: false` 未应用到 Telegram dispatcher | **立即派单** |
| **🔴 S** | **#67057** | dreaming-narrative blocks Telegram | 无 session cleanup，77 sessions 耗尽资源 | **立即派单** |
| **🔴 S** | **#66975** | Telegram bot commands disappear 4.14 | changelog 相关命令同步逻辑 regression | **立即派单** |
| **🟡 M** | **#67035** | Windows chat UI regression | 与 #67028 同 root cause 群 | 派单，合并 #67028 |
| **🟡 M** | **#67034** | Telegram 16-account avalanche | 同 #66885 | 与 #66885 合并 |
| **🟡 M** | **#67028** | WebChat messages disappear (4.14) | history reload race condition (#66316) | 派单 |
| **🟡 M** | **#67021** | Main workspace excluded from dreaming | agents.list/dreaming workspace filter bug | ⚠️ **有 PR #67021 待 merge** |
| **🟡 M** | **#67019** | GLM-4.7 garbled output | provider routing 或 model encoding 问题 | 派单 |
| **🟡 M** | **#67006** | build stuck at runtime-postbuild | 不明确 | 派单复现 |

---

## 已追踪项状态

| # | 状态 | 备注 |
|---|------|------|
| #66885 | ⚠️ 仍 open，无 PR | 上轮已识别，仍未修复，需重新派单 |
| #66975 | ⚠️ 仍 open，无 PR | 上轮已识别，需立即派单 |

---

## PR Merge 窗口期建议

1. **#67021**（dreaming main workspace）- author Etoilelune，刚创建，快速 merge 减少阻塞
2. **#67069**（feishu thread_id）- feat 类型，feishu 紧急需求，跟进 review
3. **#67047**（media Slack CSV）- S 级，review 密集，可能快 merge 了

---

## 输出结论

**本轮发现 3个 S 级新候选（#66885、#67057、#66975），均无关联 PR，需立即派单修复。**

**最紧急：**
- #66885 和 #67034 是同一根因（telegram undici HTTP/2），合并派单
- #67057 是资源泄漏导致的通讯阻塞，需紧急处理
- #66975 是用户直接感知的 regression（命令消失）

**本轮新增发现：** #67057（dreaming 阻塞 Telegram）之前未被追踪，是新发现的高危问题。
