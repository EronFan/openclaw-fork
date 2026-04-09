# 4方向扫描报告 2026-04-09 10:39 CST (02:39 UTC)

## GitHub

**发现了约25个在过去2小时内更新的 open issues**（不含已追踪项），重点候选：

### 🔴 最高优先级

**#63496 — WhatsApp creds.json corruption every ~30 minutes (non-atomic write)** ⭐NEW
- 严重度高：49次损坏/24小时，每次触发 WhatsApp 重连 → 消息延迟/丢失
- 根因明确：`fs.writeFileSync(credsPath, ...)` 非原子写入 → 文件损坏
- 修复方案明确：write to tmp → rename()
- 可修性：**S** — 代码位置明确（auth-store/Baileys session persistence），修复模式标准
- 建议：aoao 接单

**#63489 — [Bug][regression] Cron isolated session first LLM call times out in 2026.4.2** ⭐NEW
- regression 标签；0 comments
- 影响：cron 触发的 isolated session 第一次 LLM 调用必然超时
- 可修性：**M** — 需确认是 isolated session 特有的 timeout 配置问题还是有其他根因

**#63493 — message tool silently drops local file paths and external URLs in media field** ⭐NEW
- PR #63497（fix agents: support media://inbound URIs）已开，但 reporter 描述的是**本地文件路径**场景：`/Users/rootzeye/.openclaw/media/...`
- 两者可能不完全重叠（URL/本地路径 vs media://inbound URI）
- 严重度：功能完全失效，WhatsApp 媒体完全不发
- 可修性：**S** — 需确认 PR #63497 是否覆盖本地路径，不覆盖则可接

### 🟡 中等优先级

**#63214 — memory-core: dreaming narrative generation fails with 'must have required property idempotencyKey' in 2026.4.8** ⭐NEW
- 0 labels；v2026.4.8 regression
- 根因清晰：dreaming light/REM 阶段 narrative generation 调用 agent params 缺少 `idempotencyKey`
- 症状明确：`invalid agent params: must have required property 'idempotencyKey'`
- 可修性：**XS/S** — 添加缺失字段即可；memory-core 代码应可读

**#63463 — MLX routing fails: model_not_found + fallback despite direct MLX API success** ⭐NEW
- 0 labels, 0 comments
- 根因线索：`provider/model normalization mismatch in MLX adapter path (mlx/ prefix)`
- 直接 curl MLX API 成功，排除 provider 端问题
- 可修性：**M** — 需定位 MLX lane-specific resolver 代码

**#63349 — v2026.4.8: Telegram voice notes reach agent as raw .ogg, no transcript echo** ⭐NEW
- PR #63472（fix media: use default STT model）已合并
- 但 reporter 在 PR 合并后仍报问题未解决
- 需确认是否 #63472 完全覆盖

**#63486 — Matrix interaction is unresponsive** ⭐NEW
- 0 labels, 0 comments
- 无详情；需读取更多

### ⚠️ 已有进展 / 勿重复接

- **#63475 (Feishu multi-account probe timeout)** → PR #63481 已合并 ✅
- **#63450 (Gateway channel startup WS block ~80s)** → PR #63480 已合并 ✅
- **#63366 (WhatsApp dmPolicy allowlist 再次失效)** → PR #63466 已合 ✅
- **#62967 (gpt-5-mini reasoning_effort 'none')** → ⚠️ 已在文件中（#54844 相关？）
- **#61421 (Docs mention Dreaming, but not exposed in 2026.4.2)** → 已在追踪

---

## InStreet

**无**：`instreet.coze.site/skill.md` 本轮仍是 InStreet Agent API 文档（注册/心跳/Skill 规范），非 OpenClaw 用户实战讨论区。

---

## Discord

**无法访问**：Discord invite 页面仅返回服务器标题，无频道内容；GitHub Discussions 返回 404（已关闭）；本轮无替代数据源。

---

## 插件

**无新发现**：`openclaw/openclaw-weixin` 无公开 repo；主仓库 issues 已通过方向1覆盖；本轮未见新 plugin repo candidates。

---

## 结论

**最高优先级是 #63496**（WhatsApp creds.json 非原子写入导致每30分钟损坏），原因：
1. 极高频复现（49次/天），每次导致消息延迟/丢失
2. 根因和修复方案都明确（write→tmp→rename）
3. 代码位置清晰（S级别）
4. 0 comments，刚发布，竞争者少

**次高：#63214**（memory-core dreaming idempotencyKey 缺失）— v2026.4.8 regression，症状清晰，XS/S 难度

**第三：#63493**（message tool 静默丢弃 media 路径）— 需确认 PR #63497 覆盖范围，不覆盖则可接

**建议 aoao 优先接：**
1. **#63496**（S，WhatsApp 非原子写入）
2. **#63214**（XS/S，memory-core idempotencyKey）
3. **#63493**（S，确认 PR 覆盖范围后决定）
