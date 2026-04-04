# 4方向扫描报告 2026-04-04 14:00 (Asia/Shanghai)

## GitHub
- 发现了**2个**新候选，其中最重要的是：
  - **#60416**（新，P1）- Plugin SDK 兼容性问题：@tencent-weixin/openclaw-weixin@2.1.5 在 OpenClaw 2026.4.2 下加载失败。错误：`TypeError: (0 , _pluginSdk.resolvePreferredOpenClawTmpDir) is not a function`。OpenClaw 2026.4.2 移除了 `resolvePreferredOpenClawTmpDir` 函数但 weixin 插件仍在调用。**代码不可见**，但根因清晰（SDK API breaking change）。
  - **#59528**（新，P2）- The bundled plugins openshell does not work correctly since version 2026.03.13：openshell sandbox 状态始终为 stopped，backend=openshell 时无法创建 sandbox。WSL + Ubuntu 24.04 + Docker Desktop 环境，2026.04.01 版本。

## InStreet
- 发现了**0个**新实战问题。`https://instreet.coze.site/skill.md` 仍是 InStreet Agent Skill 平台/API 文档（社交网络、炒股竞技场、文学社、预言机等），不是 OpenClaw 用户讨论区。

## Discord
- 发现了**0个**新讨论。Discord invite 页面（https://discord.com/invite/clawd）仅能抓到服务器标题"Friends of the Crustacean 🦞🤝"，无法读取 #bugs/#help/#beta-releases 等频道内容。GitHub Discussions 返回 404（未启用）。

## 插件
- 发现了**1个**新公开 issue：
  - **#60416**（新，P1）- weixin 插件 SDK 兼容性 regression，OpenClaw 2026.4.2 破坏性变更移除了 `resolvePreferredOpenClawTmpDir`，影响所有 weixin 用户。⚠️ 代码不可见，但错误栈清晰，fix 需要在 OpenClaw 侧恢复该 SDK 函数或 weixin 侧调用新 API。

## 结论
最高优先级是 **#60416**（weixin SDK 兼容 regression），虽然代码不可见，但这是 OpenClaw 2026.4.2 引入的 breaking change，根因明确，影响所有 weixin 用户。建议排查 OpenClaw 2026.4.2 源码中 `resolvePreferredOpenClawTmpDir` 是否被移除/重命名，确认是否需要恢复该 SDK 兼容层函数。

次优先级是 **#59528**（openshell sandbox regression），属于 bundled plugin 行为问题，可本地复现。
