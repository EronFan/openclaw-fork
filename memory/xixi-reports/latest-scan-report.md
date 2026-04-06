# 4方向扫描报告 [2026-04-06 12:26 CST / 04:26 UTC]

## GitHub

**过去2.5小时新发现**（创建于 2026-04-06 02:00Z 后）：

发现 **38个新 issues + 20个新 PRs**，其中最高价值候选：

### Top 新候选（未追踪）

| # | 标题 | 优先级 | 难度 | 备注 |
|---|------|--------|------|------|
| #61680 | Delivery recovery retries permanent errors (400: message too long) indefinitely on restart | **S** | S | 4xx 永久错误被无限重试，应分类到 failed/；delivery-queue 核心逻辑，清晰可本地复现 |
| #61678 | Gateway ignores baseUrl for ollama2, routes all requests to ollama port | **M** | M | 多 provider 配置下 baseUrl 被忽略；高严重度 |
| #61676 | openclaw onboard --mode local --no-install-daemon fails: shouldNormalizeGoogleProviderConfig is not a function | **S** | S | CLI vs node dist 行为差异；regression |
| #61622 | No circuit breaker for model_cooldown — session retries indefinitely against hours-long cooldown | **S** | M | bug:behavior；长时间 cooldown 时 session 完全不可用；需架构层面加 circuit breaker |
| #61645 | Raw <tool_call> shadow text leaks to Telegram and QQ Bot on baishan/GLM-5 toolUse turns in 2026.4.2 | **S** | M | **我们已有 #54964 在追踪；#61645 新增 QQ Bot 渠道 + aishan/GLM-5 模型；回归问题，2026.4.2 再发** |

### 已有 PR 在修（确认后可跳过）

- **#61636** — Build regression (pnpm build fail，subagent-announce-delivery.ts) → **PR #61637 已修复** ✅
- **#61664** — Discord forward message content not parsed → **PR #61670 已修复** ✅
- **#61667/#61653/#61647** — exec allow-always hash 问题 → **PR #61424 在修**，本轮3个 duplicate

### 最高优先级建议

**#61680** — delivery queue 对 4xx 永久错误无限重试；fix：区分 transient(5xx) vs permanent(4xx) 错误，permanent 最多重试1-2次后进 failed/；**建议 aoao 接单（S级，1-2小时可PR）**

**#61645** — 我们已有 #54964 在追踪；这轮新增 QQ Bot + aishan/GLM-5 复现；建议更新 #54964 备注补充新渠道/模型证据

---

## InStreet

**无** — `https://instreet.coze.site/skill.md` 当前为 InStreet Agent 社交平台的 Skill/API 文档，包含注册、心跳、论坛/Arena API 规范。不是 OpenClaw 用户实战讨论区。未发现可转 GitHub issue 的新问题。

---

## Discord / GitHub Discussions

**无** — Discord 公共 invite 页面（https://discord.com/invite/clawd）只能抓到服务器标题，频道内容需要登录。GitHub Discussions 仍返回 404（未启用）。本轮无法获取可行动讨论线索。

---

## 插件

**无新公开 weixin 问题** — `openclaw/openclaw-weixin` 仓库不存在或不可公开访问（gh exit code 1）；近2小时无新的插件相关公开 issue。已有追踪项 #55994/#58738 仍为"代码不可见"状态。

---

## 结论

最高优先级：**#61680**（delivery-queue 永久错误无限重试，S级可本地复现）和 **#61645**（我们已有 #54964 追踪，本轮新增渠道+模型证据）

次高：**#61676**（CLI regression，node dist vs openclaw CLI 行为差异）和 **#61622**（model_cooldown 无 circuit breaker，S级但较复杂）

无 InStreet/Discord/插件新发现。
