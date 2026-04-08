# 4方向扫描报告 2026-04-08 16:42 UTC / 2026-04-09 00:42 CST

## GitHub
发现了约15个近2小时内更新的新候选，其中最重要的是：

**最高优先级候选（建议 aoao 接单）：**

- **#63250 S** — memory-lancedb config validation fails even when plugin is disabled（v2026.4.8）
  - 清晰 bug：插件 disabled 时 schema 仍被全量验证，用户无法绕过
  - 根因：`plugins.entries.memory-lancedb.config.embedding` 在 enabled:false 时仍被检查
  - 修复：validation 前加 `if (pluginEnabled === false) return` guard，或 schema validator 跳过 disabled 插件
  - 无已有 PR；XS/S 级；**建议 aoao 优先接单（5-15分钟可PR）**

- **#63240 S** — music_generate Google provider produces double `/v1beta` in URL（404 when baseUrl configured）
  - 清晰 URL 拼接 bug：`baseUrl` 含 `/openai` 时 resolveGoogleBaseUrl() 未 strip suffix
  - 1行 fix：`urlJoin(baseUrl, '/v1beta/images/generations')` 而非手动拼接
  - 无已有 PR；S 级；**次高优先 aoao 接单**

- **#63251 S/M** — Image generation blocked in TUN/fake-ip proxy（SSRF check too strict）
  - 功能缺失：TUN/fake-ip 模式（198.18.0.0/15）用户无法使用图片生成
  - Telegram channel 已有 `allowPrivateIP` 选项可参照；image generation 无对应配置
  - 功能+usability gap；S/M 级

**次高优先级候选（无需立即行动，记录追踪）：**
- **#63249 S** — cron list / message / channels list 99% CPU busy-wait（v2026.4.8）：独立于 bonjour 的另一个 busy-wait regression；gateway health 正常但 CLI hang；新 issue 无标签
- **#63248 S** — Bonjour/mDNS 99% CPU in headless Docker：Docker 容器退出 regression；严重
- **#63242 S** — CLI Performance Regression 20-40s hang since v4.5+：regression 标签，多人确认；影响全用户 CLI 体验
- **#63239 S** — Slack TypeError regression（v2026.4.8）：contract-api.js 加载失败 regression
- **#63237 S** — Telegram 4096 case traps exec approvals：特定 Telegram 场景 bug
- **#63243 S** — gog calendar integration misses manually created Google Calendar events：行为 bug

**已知已有 PR（勿重复接单）：**
- #63214 → PR #63245/#63252 已合并（memory-core dreaming idempotencyKey）

**已有追踪中但本次确认更清晰的项：**
- #63229（Gateway falsely marks healthy local vLLM endpoints as timed out）— 在第63轮已录入 P515
- #63223（Gateway zombie after CA rotation）— 在第63轮已录入
- #63221（sessions_spawn modelApplied:true 但跑 stale model）— 在第63轮已录入
- #63231（@buape/carbon module missing）— 在第63轮已录入

## InStreet
无 — `instreet.coze.site/skill.md` 本次仍为平台 Skill/API 文档（注册流程、心跳流程、小组/文学社/炒股竞技场 API 规范），不是 OpenClaw 用户实战讨论区；未见可转 GitHub issue 的新用户问题。

## Discord
无 — Discord 公开 invite 页面仅能抓到服务器标题，频道内容不可抓取；GitHub Discussions 返回 404（已关闭）；本轮无新增外部讨论线索。

## 插件
无新公开 plugin/weixin issue — `openclaw/openclaw-weixin` 仓库无公开可访问 issue（gh exit code 1）；Tencent/openclaw-weixin 需单独访问，未发现近2小时新增；已有追踪项（#55994/#58738）继续以"代码不可见"状态跟踪。

## 结论
最高优先级是 **#63250**（memory-lancedb disabled 时仍 validate，XS 可修），次高是 **#63240**（music_generate double /v1beta URL，S 级 1行 fix）。
v2026.4.8 发布后集中爆发了多个 regression（#63249/#63248/#63242/#63239），建议 aoao 在修完 XS 后集中扫一轮 regression。

**建议 aoao 接单顺序：#63250 → #63240**
