# OpenClaw GitHub 扫描报告
**扫描时间：2026-04-11 23:02 CST (15:02 UTC)**
**覆盖范围：最近 24 小时新 open issues + PR 状态 + 追踪 issue 变化**

---

## 一、最近 24 小时新 Open Issues（重点标注）

> 按优先级排序，筛选条件：bug 标签 或 regression 标签 或 P0-P2 关键词

### 🚨 P1 - Regression（2026.4.10 刚回归）

**#64852** — google-vertex OAuth/service-account auth works on 2026.4.9, fails on 2026.4.10 with 401 CREDENTIALS_MISSING
- 标签：`bug` `regression`
- 时间：2026-04-11 14:59 UTC（6小时前）
- 摘要：2026.4.9 → 2026.4.10 升级后 Vertex OAuth / service-account auth 全部 401
- 难度：**S** | 可修性：**S**
- 根因：版本 diff 引入，需对照 2026.4.9 vs 2026.4.10 的 Vertex provider 代码
- 建议：aoao 可修，对比两个版本的 provider 代码

**#64814** — api.pluginConfig is null in extension plugin register() despite config being set
- 标签：`bug` `regression`
- 时间：2026-04-11 13:13 UTC
- 摘要：plugin register() 里拿到的 pluginConfig 是 null，config 明明已设
- 难度：**S** | 可修性：**S**

**#64839** — qwen3.6-plus via bailian cannot handle images after upgrade (regression)
- 标签：`bug` `regression`
- 时间：2026-04-11 14:44 UTC
- 摘要：图片 tool 说 Unknown model，QQ media URL 被 block

### 🔒 P1 - Security + Crash

**#64821** — tools.exec.security corrupted by plugin init logs — hot-reload concatenates plugin output into config value
- 标签：`bug` `security` `bug:crash`
- 时间：2026-04-11 13:30 UTC
- 摘要：hot-reload 后 `tools.exec.security` 从 "full" 变成 plugin init log 拼接字符串；安全关键配置被污染
- 根因：hot-reload 时 plugin 输出被错误地拼接到 config 值里
- 难度：**M** | 可修性：**M**（涉及 hot-reload 逻辑）
- **这个值得优先修，security bug**

### ⚠️ P2 - 有 work-around 或新发现

**#64841** — Disabled memory-lancedb entry still fails config validation after upgrading to 2026.4.9
- 标签：`bug` `bug:crash`
- 时间：2026-04-11 14:49 UTC（刚6分钟前）
- 评论：用户已找到 workaround（删掉 lancedb 配置块），workaround 有效
- 难度：**S** | 可修性：**S**（config validation 对 disabled plugin 跳过即可）

**#64831** — Cron jobs run inconsistently, chat-triggered exec unstable, and missing catch-up delivery on Telegram
- 标签：`bug` `regression`
- 时间：2026-04-11 14:17 UTC
- 摘要：cron 不稳定、Telegram 丢消息、多个症状叠加

**#64810** — Heartbeat / async system events can interrupt in-progress replies in Telegram topic sessions
- 标签：（无标签）
- 时间：2026-04-11 13:02 UTC
- 评论：**EronFan 已定位根因并开出 PR #64823**，+72 -0，size S
- 状态：**已有 PR，无需重复**

---

## 二、追踪 Issue 状态变化

| # | 标题 | 状态 | 变化 |
|---|------|------|------|
| 62569 | toolsAllow on cron agentTurn silently dropped | OPEN | hexsprite PR #62675 已开，正在扩展修4个字段（+disableMessageTool, +requireExplicitMessageTarget, +internalEvents）|
| 62550 | browser snapshot --format ai returns role refs instead of numeric AI refs | OPEN | 无变化 |
| 62750 | iMessage echo loop | **CLOSED** ✅ | 已由 #61619 修复 |
| 62755 | sessions_spawn returns modelApplied:true while running stale resumed model | OPEN | 无变化 |

**值得注意：**
- #62750 已关闭，aoao 不需再修
- #62569 的修复范围扩大了，从修1个字段变修4个字段，aoao 如要接需同步这个上下文

---

## 三、Open PR 审查建议（值得 Approve 的）

> 筛选标准：size XS/S、无 maintainer 标签、无 review decision、community PR

| PR | 标题 | Size | 可 Approve？ |
|----|------|------|-------------|
| #64846 | fix(tools): tolerate duplicate sessionKey/label in sessions_send | XS | ✅ 可 Approve |
| #64843 | fix(tui): recover footer state after stale run final | XS | ✅ 可 Approve |
| #64842 | fix(tui): clear stale streaming status for completed unbound runs | XS | ✅ 可 Approve |
| #64822 | chore: stop tracking a2ui bundle hash (again) | XS | ✅ 可 Approve |
| #64796 | fix(matrix): trust m.mentions.user_ids as authoritative mention source | XS | ✅ 可 Approve |
| #64790 | fix(security): redact secrets in exec approval prompts | XS | ✅ 可 Approve |
| #64787 | fix: ignore auto-filled streamTo for subagent spawns | XS | ✅ 可 Approve |
| #64823 | fix: avoid heartbeat preempting active reply runs | S | ⚠️ EronFan 的 PR，有 `r:too-many-prs` 标签，注意不要 Approve 并催 review |

**最值得 Approve 的 XS PR：**
1. **#64790** — security fix（exec approval prompts 泄露 secret），size XS，紧急
2. **#64796** — matrix channel mention 修复，清晰可验证
3. **#64846** — sessions_send 工具修复，逻辑简单

---

## 四、本轮新发现可修 Issue 推荐

### 优先队列（建议 aoao 选一个接）

1. **#64852**（Google Vertex regression）— 难度 S，有 2026.4.9 对比，清晰可复现
2. **#64821**（tools.exec.security corruption）— 难度 M，security 级别，hot-reload 逻辑问题
3. **#64841**（disabled memory-lancedb 仍触发 validation）— 难度 S，workaround 已确认，修复范围小
4. **#64814**（api.pluginConfig is null）— 难度 S，regression，直接可修

### 延续追踪（勿重复修）
- #62569 → hexsprite PR #62675 在修中（aoao 可 review 不修）
- #62750 → 已关闭，无需修

---

## 五、摘要

```
【24h 新issue】13个新open，5个regression/bug
【最高优先级】#64821 security/crash + #64852 Vertex regression
【已有PR保护】#64810 → EronFan PR #64823
【追踪变化】#62750 已关闭；#62569 修复范围扩大
【可合并PR】7个 XS PR 可 Approve（含 security fix #64790）
【aoao建议接】#64852 或 #64814（清晰regression，难度S）
```
