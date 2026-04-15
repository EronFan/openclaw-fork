# 全量扫描报告 2026-04-15 13:44 CST (05:44 UTC)

## GitHub Issues（方向1）
- **发现了 2 个新候选**：
  1. **#66975** 🔴 S regression — Telegram bot commands disappear after upgrading to 2026.4.14：Changelog 提到"Telegram/native commands: restore plugin-registry-backed auto defaults" + "keep Telegram command-sync cache process-local"，但升级后命令完全不显示，Bot Menu 按钮也丢失。已有一评论。**建议立即接单**。
  2. **#65428** 🔴 S — resolveCliAuthEpoch() hashes accessToken + refreshToken + expiresAt causing session reset：session 在 OAuth token refresh 后静默 reset，累积上下文全部丢失。描述非常详细，根因清晰（应只 hash refreshToken）。已在 P60144 区域追踪过，但 #65428 是新 issue 编号且有新鲜 activity（2小时窗口内更新）。
  3. **#67002** — [Feature] Independent workspace for every channel：enhancement，无标签，低优先级，跳过。
- 已追踪项状态：本轮未见 freshly updated 的已追踪 issue；#66975 是新候选且有 regression 标签值得关注。

## 插件仓库（方向2）
- **无**：openclaw/openclaw-plugin 和 openclaw/openclaw-plugin-weixin 均返回 404；Tencent/openclaw-weixin 仓库存在但近 2 小时无新 activity。
- openclaw-weixin 最新 issue/PR 更新不在 2 小时窗口内。

## 贡献者文件区域（方向3）
- **无新发现**：扫描了贡献量最低的 10 位 contributor（mneves75, joe2643, darkamenosa, sliverp, pejmanjohn, pandego, lml2468, Whoaa512, aether-ai-agent, chinar-amrutkar，每人 9-11 contributions），其最近 commit 均未命中高相关 open bug。

## 追踪 PR 反馈（方向4）
- **#66985** fix(agents): resolve requestedNode to canonical ID — 刚创建 05:09 UTC，size M，外部 author，0 comments，**尚无 maintainer review**，值得关注 merge 时机。
- **#66976** fix(whatsapp): remove redundant root Baileys install blocker — 1 comment，**无 maintainer 标签**，WhatsApp regression 相关。
- **#66948** fix(memory-core): default dreaming storage to "separate" — 1 comment，**无 maintainer 标签**。
- **#67005** fix(ollama): simplify cloud onboarding — maintainer label + size M，已 comments=2，刚更新 05:47 UTC，**maintainer 已 review**，值得跟进。
- **#67003** fix(security): 7 P1 hardening fixes — maintainer label + size L，已 comments=2，刚更新 05:47 UTC，**maintainer 已 review**。

## 结论
- **最高优先级是 #66975**（Telegram commands regression，2026.4.14 changelog 明确相关，1行级 regression，用户完全失去内置命令）。
- 次高优先级 #65428（OAuth session reset，根因极清晰，refreshToken rotation 不应 invalid session）。
- 方向4 追踪建议：重点跟 **#67005** 和 **#67003**（maintainer 已 review，随时可 merge 的窗口期）。
