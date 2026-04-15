# 全量扫描报告 2026-04-15 22:54 CST (第133轮)

## GitHub Issues（方向1）
- **发现了 8 个新候选**（最近 2 小时内创建/活跃）
- **最重要的是：**
  - 🔴 **#67252** feishu_doc write action 缺少分页，无法清空大文档所有 blocks（S级，14:54 UTC，10分钟前）— 根因清晰，`clearDocumentContent` 无循环处理
  - 🔴 **#67251** Windows CLI 子命令在 exec 环境挂死并收到 SIGKILL（2026.4.14 regression，14:51 UTC）— 影响所有 Windows 用户 CLI 体验
  - 🔴 **#67250** Control UI: streaming text disappears when tool calls display is hidden（4.14 regression，14:51 UTC）— streaming 逻辑回归
  - 🔴 **#67248** sessions_spawn(runtime="subagent") 仍失败（2026.4.14，14:51 UTC）— 已有历史追踪但仍未修复
  - 🟠 **#67247** Telegram Native command menu disappears after upgrade to 4.14（bug+regression，14:49 UTC）— regressions，命令菜单丢失
  - 🟠 **#67241** BlueBubbles attachment downloads fail silently on Node 22.20+（bug，14:38 UTC）— invalid onRequestStart method

## 插件仓库（方向2）
- Tencent/openclaw-weixin 发现了 **10+ open issues/PRs**
- **#49 fix: preserve quote context (ref_msg) for voice messages**（PR，by gaoyangz77，1 comment，14 Apr 09:46 UTC）— 与 #63 解决同一问题但来自不同贡献者，存在重复
- **#63 fix(inbound): preserve quoted context for voice messages with ref_msg**（PR，by draix，0 comments，14 Apr 04:35 UTC）— 与 #49 内容可能重叠，需确认合并意向
- **#66 微信消息重复：用户1条→处理2次**（issue，updated 15 Apr 04:01 UTC）— 已追踪 P60173，上轮已定位根因
- Tencent openclaw-weixin 新增 **#62 feat: support sending voice messages (SILK/MP3/OGG)**（PR，by lemoncat7，0 comments，14 Apr 03:46 UTC）

## 贡献者文件区域（方向3）
- gh contributors API 返回空数据（rate limit 或认证问题），本轮无法完成
- **注：** 建议排查 `gh auth refresh` 或使用 token 直接调用

## 追踪 PR 反馈（方向4）
- **PR #67200** fix(plugins): stabilize bundled setup runtimes（gumadeiras，4 comments）— maintainer 有活跃评论，接近可 merge
- **PR #67234** fix: extend isMinimaxVlmModel to support M2.5/M2.7/M2.7-highspeed（zhengyuliu047-rgb，1 comment）— 新增 MiniMax VLM 模型支持
- **PR #67245** fix(docs): correct imageGenerationModel → imageModel（notamicrodose，2 comments）— 文档修正，maintainer 已有反馈
- **PR #67254** fix(google): respect allowPrivateNetwork config for SSRF policy（Joel-Claw，0 comments）— 5分钟前新开，值得关注
- **PR #67255** feat: add yuanbao extension plugin（loongfay，1 comment）— **本轮最新 PR**，1分钟前创建
- 已追踪 PR 本轮无新 maintainer 人工反馈；现有追踪项均保持原状态

## 结论
**最高优先级是：**
1. 🔴 **#67252 feishu_doc write 缺分页**（根因清晰，S级，maintainer 可直接 review）
2. 🟠 **#67251 Windows SIGKILL exec**（regression，影响 CLI 核心路径）
3. 🟠 **#67247 Telegram command menu regression**（4.14 引入，影响核心交互）
4. 🔴 **#67200 PR maintainer 正在 review**（4 comments，接近 merge 窗口）

**建议：**
- feishu_doc #67252：fix 简单（加循环分页），可直接提 PR
- #67247 Telegram regression：maintainer PR 正在活跃 review，建议协助测试确认 regression 根因
- Tencent openclaw-weixin #49 vs #63：建议确认是否需要合并避免重复 work
