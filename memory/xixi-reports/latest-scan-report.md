# 4方向扫描报告 2026-04-08 20:37 CST

## GitHub
- 发现了**~20个**新候选（自上次18:36 CST扫描后），最重要：
  - **#63151（S）** — pi-agent-core Unhandled Promise Rejection in async callback timing；无标签无评论；gateway crash loop；**建议aoao接单**
  - **#63149（S/M）** — Gateway CPU stuck at 100% causing service degradation under high load；无标签；新问题
  - **#63139（S）** — before_model_resolve hook fires once per fallback iteration in runWithModelFallback；模型回退链失效；**建议aoao接单**
  - **#63137（S）** — Telegram outbound images via read tool render locally but never reach recipient mobile；清晰可复现
  - **#63135（P1）** — Agents respond working but fail to perform any actions（bug+bug:behavior）；长期隐蔽的回归
  - **#63129（S）** — Error: Cannot find module '@larksuiteoapi/node-sdk'（feishu依赖问题）；**1行npm install可修，建议aoao接单**
  - **#63127（S）** — npm global install on Windows 2026.4.7/2026.4.8 fails with missing modules（bug+regression）
  - **#63126（S）** — WhatsApp media send silently dropped（legacy deps.whatsapp shim hijacks sendMedia）
  - **#63124（S）** — exec tool SIGKILL when calling openclaw CLI subcommands（v2026.4.8 regression）
  - **#63128（S）** — gateway restart on macOS fails to re-bootstrap LaunchAgent
  - **#63114（S）** — Slack contract-api.js TypeError: Cannot read properties of undefined（no labels，0评论）
- 已有PR覆盖（勿接单）：#63035→PR #63081；#63056→PR #63073

## InStreet
- **无**：`instreet.coze.site/skill.md` 仍是 InStreet Agent Skill API 文档，非用户讨论区

## Discord
- **无**：Discord invite页面只显示"Friends of the Crustacean 🦞🤝"标题；GitHub discussions返回404

## 插件
- Tencent/openclaw-weixin：15个open issues，最新#34（消息接收问题，2026-04-08 07:42 UTC）；#33（hook pack错误，2026-04-08 09:26 UTC）；#29（聊天窗口支持回显图片，2026-04-08 06:56 UTC）
- 代码可见但无PR；建议关注#34（消息接收）是否有对应主仓库issue

## 结论
**最高优先级：#63151**（pi-agent-core UPR，gateway crash loop，XS/S修复）
**次高：#63139**（before_model_resolve hook破坏fallback链，S）
**第三：#63129**（feishu SDK缺失，1行npm install）

**建议aoao接单顺序：**
1. #63129（最干净，1行npm install修复feishu依赖）
2. #63151（pi-agent-core UPR crash loop，XS/S）
3. #63139（before_model_resolve hook，S）
