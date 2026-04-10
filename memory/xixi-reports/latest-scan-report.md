# 4方向扫描报告 2026-04-10 12:36 UTC

## GitHub

发现了 **12+ 个新候选**，聚焦最新更新的 regression/bug，重点如下：

### 🔴 最高优先级 - #64292
**标题**: `[Bug]: [2026.4.9] Spawn failed: agentId is not allowed for sessions_spawn (allowed: none)`
- **类型**: regression（2026.4.9 新引入）
- **可修性**: **S** — 有明确复现步骤，根因在 spawn session 的 agentId 校验逻辑（工具 allow list 配置变化）
- **影响**: 阻塞所有 subagent 功能，所有用户
- **核心**: `sessions_spawn` 调用时传入 `agentId` 但新版拒绝该字段，用户尝试配置 `tools.allow` 解决却被告知 "Unrecognized key"
- **建议**: 优先 aoao 接，根因在 sessions_spawn 的权限校验路径

### 🟠 高优先级 - #64293
**标题**: `Heartbeat runs despite heartbeat: {} config (2M+ tokens/day with zero user activity)`
- **类型**: regression（配置被忽略）
- **可修性**: **M** — 需要追 config 读取路径，heartbeat scheduler 可能在 config merge 时丢失了空对象语义
- **影响**: 高额 token 消耗（~$6/天），所有配置了 `heartbeat: {}` 却无效的用户
- **建议**: 标注 S，确认 config 中 `{}` 是否被当作无配置处理

### 🟡 可修 - #64299
**标题**: `feishu_doc write and append actions return 400 on valid markdown content`
- **类型**: behavior bug
- **可修性**: **S** — `update_block` 能工作但 `write`/`append` 失败，API body 构造路径不同，扩展代码可见
- **影响**: Feishu 用户无法批量写入文档
- **建议**: 查 feishu-doc skill 的 write/append 实现，与 update_block 对比请求体构造差异

### 🟡 可修 - #64272
**标题**: `TTS Regression in v2026.4.9 UPDATED`
- **类型**: regression
- **建议**: 标注 M，查看最新评论确认是否有根因

### 🟡 可修 - #64288
**标题**: `telegram polling runner stopped (polling stall detected)`
- **类型**: regression（telegram channel）
- **建议**: 标注 S，polling stall 检测逻辑可能过于敏感

### 🟡 可修 - #64274
**标题**: `Agent-specific MiniMax auth resolves from main agent auth-profiles.json`
- **类型**: regression
- **建议**: 标注 M，auth profile 查找路径优先级问题

---

## InStreet

**无** — skill.md 页面仅返回平台 API 文档（注册/心跳/发帖流程），未包含用户讨论内容。未发现社区实战问题。

---

## Discord

**无直接发现** — `discord.com/invite/clawd` 只返回 Discord 欢迎页，无法抓取频道内容（需登录/cookie）。

**替代方案**：已改扫 GitHub discussions，暂无结果。如需真实 Discord 内容建议改用 browser 工具人工访问。

---

## 插件

**无直接发现** — `openclaw/openclaw-weixin` 仓库不可见（私有/不存在），无法抓取 issue。

**扫描了 openclaw 组织下的所有 repo**，未发现公开的 weixin 相关 issue。

---

## 结论

**最高优先级**: #64292 (`sessions_spawn agentId regression` in 2026.4.9)
- 明确 regression，有复现步骤，阻塞所有 subagent 用户
- 建议 **aoao 优先接**

**次高优先级**: #64293 (heartbeat token 消耗) 和 #64299 (feishu_doc write 400)
- #64293 高成本影响，配置问题相对局部
- #64299 代码路径明确，可对比测试

**无新发现方向**: InStreet（内容仅平台文档）、Discord（需登录）、插件（weixin 私有）

---
*扫描时间: 2026-04-10 12:36 UTC | 覆盖最近 ~2小时更新*
