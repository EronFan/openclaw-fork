# 全量扫描报告 2026-04-14T16:34 UTC / 2026-04-15 00:34 CST

## GitHub Issues（方向1）

**本轮发现 5 个新候选**，最高优先级如下：

### 🔥 最高优先级（安全 / regression / 阻塞性）

1. **#66601** — `lossless-claw` context engine 工厂在 v2026.4.14 返回 invalid ContextEngine，系统彻底不可用
   - **🔥 regression blocker**（v2026.4.14，in-place upgrade from 4.11）
   - 根因：`info.id must match registered id "lossless-claw"` 验证失败
   - 插件本身正常加载，错误在 factory consumer 端对 `info.id` 的校验逻辑 regression
   - 影响：全部 session 每次 turn 都 `candidate_failed` → `Embedded agent failed before reply`
   - 滚动回 4.11 问题立即消失；**多用户 confirmed**（3 条评论）
   - **无现有 PR 覆盖**；建议 aoao 接单

2. **#66669** — Control UI (webchat) 不渲染用户发送的图片附件，只显示空 bubble
   - **bug**（前端 UI regression）
   - 根因：前端 bundle (`dist/control-ui/assets/index-*.js`) 的 user message 组件未渲染 `attachments` 数组
   - AI 消息图片正常渲染，用户消息图片不显示
   - 后端/Gateway 正确处理图片（AI 能看到并响应图片内容）
   - **无现有 PR**；根因清晰（user message component 缺附件渲染逻辑）；建议 aoao 接单

3. **#66668** — `plugins uninstall` 对 `--link` 或手动安装的插件不删除文件
   - **bug**（功能缺口）
   - 根因：`uninstall` 只清理 `plugins.installs`（npm 安装）的文件；`--link`/手动复制不在其中
   - 影响：每次 `uninstall --link` 后需手动 `rm -rf ~/.openclaw/extensions/<id>/`
   - **作者已给出两条修复路线**；无现有 PR；建议 aoao 接单

### 中优先级（有影响力 / 未分类）

4. **#66671** — `session-status-tool.ts` 使用 source-tree-relative import，bundling 后崩溃
   - **bug**（size XS，agents）
   - 根因明确：`importRuntimeModule(import.meta.url, [...])` 打包后路径错误
   - **PR #66671 已开**（open，agents label）— 建议确认 merge 窗口

5. **#66665 / #66664** — maintainer 安全/bugfix PR
   - **#66665**（S, gateway, maintainer）：Harden MCP loopback request validation — **PR #66665 open**
   - **#66664**（S, agents, maintainer）：guard Anthropic Messages max tokens — **PR #66664 open**
   - 两条均为 maintainer 提交，建议跟进 merge 状态

### PR 覆盖情况（本轮更新）

| PR | 修复 | 覆盖 issue | 状态 |
|----|------|-----------|------|
| #66649 | fix(wizard): avoid setup crash on missing provider ids | #66641 | ✅ **MERGED** |
| #66663 | fix: filter binary content from Telegram captions to prevent token explosion | #66647 | 🔄 open |
| #66636 | fix(agents): tighten workspace file opens（maintainer, size:L）| 安全 | 🔄 **open，未合并** |
| #66671 | fix: replace source-tree-relative runtime import | #66671 self | 🔄 open |
| #66665 | Harden MCP loopback request validation | 安全 | 🔄 open |
| #66664 | fix: guard Anthropic Messages max tokens | #66664 self | 🔄 open |

**重要**：PR #66636（workspace 文件安全，size L，maintainer）在上一轮扫描时已 open，本轮仍未 merge。**建议确认是否需要 maintainer 介入**。

---

## 插件仓库（方向2）

**Tencent/openclaw-weixin**：发现 **2 个新 issue**（24小时内）

| Issue | 标题 | 备注 |
|-------|------|------|
| #65 | 微信消息接收乱序，网页端能收到微信收不到 | 2026-04-14 09:33 UTC；消息队列乱序问题；证据充分（附截图）；1 条评论 |
| #61 | 发送文件报错：`uploadFileAttachmentToWeixin: getUploadUrl returned no upload URL` | 2026-04-14 08:37 UTC；长期未解决（1 条评论） |

**PR 动态：**
- **#63**（open）: fix(inbound): preserve quoted context for voice messages with ref_msg
- **#62**（open）: feat: support sending voice messages (SILK/MP3/OGG)
- **#49**（open）: fix: preserve quote context (ref_msg) for voice messages

**分析**：#65 消息乱序问题证据充分（截图对比 webchat vs 微信），可能是微信长连接保活/idle timeout 机制问题。#61 文件上传问题长期 open（从 08:37 UTC），无 maintainer 响应。**#50（定时推送无法触发）本轮无新评论但仍 open，建议继续追踪**。

---

## 贡献者文件区域（方向3）
（无变化，本轮未发现新的 contributors 文件区问题）

---

## 方向4 — PR Merge 窗口追踪

| PR | 标题 | 优先级 | 状态 |
|----|------|--------|------|
| #66636 | fix(agents): tighten workspace file opens | 🔒 S | **OPEN，未合并** |
| #66665 | Harden MCP loopback request validation | S | open |
| #66664 | fix: guard Anthropic Messages max tokens | S | open |
| #66663 | fix: filter binary content from Telegram captions | regression | open |
| #66671 | fix: replace source-tree-relative runtime import | XS | open |
| #66649 | fix(wizard): avoid setup crash on missing provider ids | S | ✅ MERGED |

**扫描元数据**
- 本轮扫描时间：2026-04-14T16:34 UTC / 2026-04-15 00:34 CST
- 上次 PR 创建时间：2026-04-14T15:00:33Z（无新 PR）
- openclaw/openclaw 新增 open PR（过去 6h）：0
- 新增 issue（本轮）：#66601, #66669, #66668, #66671, #66665, #66664
