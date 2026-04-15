# 全量扫描报告 2026-04-15 09:49 CST

## GitHub Issues（方向1）
- 发现了 **10+** 个新候选，最重要的 3 个：
  - **#66926 (S)** google-generative-ai tagged reasoning mode breaks tool calling — BUG 根因清晰：`BUILTIN_REASONING_OUTPUT_MODES` 硬编码 "tagged" 格式，导致模型把 tool calls 写成文本而非实际调用。可 2 行修复或改 system prompt。**建议派单**
  - **#66925 (S)** registerMemoryCapability is overwrite-only — active-memory 覆盖 memory-core 的 publicArtifacts，导致 wiki bridge import 返回 0。**建议派单**
  - **#66916 (regression)** Slack approval buttons 对长命令失效 + sessions.resolve 误判 Slack user ID 为 session key。**建议派单**
- 其他新 issue：#66927 (feature), #66924, #66923 (GPT-4.1 family 未注册), #66922 (xAI grok 忽略 IDENTITY.md), #66920/#66917 (WhatsApp group 消息丢失), #66915 (edit tool 错误提示) 等

## 插件仓库（方向2）
- openclaw-weixin repo 已 404（代码不公开，无法直接扫描 issue）
- 无其他最近更新的相关插件仓库

## 贡献者文件区域（方向3）
- 扫描排名最末 10 人：huntharo(70), mcaxtr(69), bmendonca3(69), jalehman(68), onutc(67), eleqtrizit(64), osolmaz(63), Glucksberg(59), altaywtf(54), quotentiroler(45)
- GitHub search API 限制，未能获取具体文件区
- 建议后续手动对核心文件区 (WhatsApp/Telegram/memory-core) 做定向 bug 搜索

## 追踪 PR 反馈（方向4）
- **多个新 PR 正在 review**：
  - PR #66924 (google/gemma fix)
  - PR #66921 (security model_spawn denylist)
  - PR #66919 (config HMAC integrity)
  - PR #66918 (Discord stale approval)
  - PR #66913 (memory-lancedb full IDs)
- 需持续追踪 merge 时机

## 结论
最高优先级是 **#66926 (google-generative-ai tool calling regression)**，根因清晰，修复简单，立即可派单。

次优先：**#66925 (wiki bridge)** 和 **#66916 (Slack regression)**。

建议立即派出 subagent 修复 #66926。