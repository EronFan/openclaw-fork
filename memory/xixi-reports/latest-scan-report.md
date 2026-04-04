# 4方向扫描报告 2026-04-04 18:52 GMT+8

---

## 一、GitHub OpenClaw 主库（openclaw/openclaw）

扫描范围：最近 3 小时内新 open issues/PRs（约 10:41–10:52 UTC）
优先级排序：regression > bug > usability gap > docs gap

### 🔴 P0 — Regression / Critical Bug

**#60799** `cron: v2026.4.2 silently drops jobs.json (plain-array format) and first add clobbers all data`
- 类型：regression
- 时间：10:11 UTC（2小时前）
- 描述：cron 在 v2026.4.2 版本下，jobs.json 为 plain-array 格式时静默丢数据，首次 add 覆盖所有已有数据
- 可修性：S — 问题定位清晰，jobs.json 读写逻辑在 src/cron/，回退格式或修复合并逻辑即可
- 建议：优先接，aoao 可直接看 cron/jobs 相关代码

**#60804** `Browser cannot attach/use healthy local Brave CDP on hardened Debian 13 VPS`
- 类型：bug（有复现步骤）
- 时间：10:21 UTC
- 描述：硬化的 Debian 13 VPS 上，Brave CDP 健康但 OpenClaw 无法 attach
- 可修性：M — 需要了解 CDP 连接机制，路径权限 / sandbox 问题
- 建议：需要 aoao 调研 CDP 连接逻辑

### 🟡 P1 — Bug / Usability Gap

**#60813** `fix(line): upgrade hardcoded error fallback to typed error routing`
- 类型：bug fix（无 label，已有人认领）
- 时间：10:47 UTC
- 描述：line 通道的错误兜底逻辑从硬编码升级为类型化路由
- 可修性：XS — size 无标记，推测 XS，但无 size label，需确认是否有人修
- 建议：确认 #60812（extend 到 Discord/Slack/Signal/WhatsApp）是否关联，同一主题可一起修

**#60812** `fix(channels): extend user-visible error fallback to Discord, Slack, Signal, WhatsApp`
- 类型：bug（error handling 扩展）
- 时间：10:47 UTC
- 描述：与 #60813 同主题，扩展错误兜底到多通道
- 可修性：S — 清晰的方向，channels 目录改 error routing
- 建议：与 #60813 打包看，aoao 可同时修

**#60816** `edit tool should classify concurrent identical edits as noop and distinguish them from both success and failure`
- 类型：usability gap / bug
- 时间：10:49 UTC
- 描述：edit tool 对并发相同编辑的分类不明确，应归为 noop 而非成功或失败
- 可修性：S — 逻辑改动在 edit tool，清晰可复现
- 建议：需要查 edit tool 代码，定位并发处理逻辑

### 🟢 P2 — Docs / Feature

**#60795** `模型切换后缓存/状态未正确隔离，导致输出风格残留`
- 类型：bug（状态隔离）
- 时间：09:55 UTC
- 描述：模型切换后缓存/状态未正确隔离，输出风格残留
- 可修性：M — 涉及模型状态管理，需了解模型 picker 逻辑
- 关联：#60818（model-picker stale fallbacks）、#60809（models stale fallbacks）同系列

---

## 二、InStreet（instreet.coze.site/skill.md）

状态：✅ 正常访问，内容更新（Skill 文档 2025 版）
内容摘要：
- 平台结构：论坛（广场/打工圣体/思辨/ Skill 分享/树洞）+ Playground（炒股/文学社/预言机）
- API 体系分两套：论坛用 `/api/v1/posts`，Playground 用 `/api/v1/arena/*`、`/api/v1/literary/*`、`/api/v1/oracle/*`
- 注册需解数学验证挑战题（防批量注册）
- 无新增 issue 或社区公告需要跟进

结论：**无行动项**，平台稳定运行。

---

## 三、Discord（discord.com/invite/clawd）

状态：⚠️ 仅能抓到 server 名称 "Friends of the Crustacean 🦞🤝"，无法获取频道内容
原因：Discord 通过 invite 链接只能拿到 server 名，频道内容需 bot token 或已加入 server
结论：**本次无法扫描**，建议后续通过已知 Discord channel 列表手动配置监测，或使用 bot API

---

## 四、插件扫描（openclaw-weixin）

状态：❌ 仓库不存在或无公开访问权限（gh api 返回 404）
结论：**无法扫描**，需要插件开发者主动提交 issue 或告知仓库位置

---

## 汇总：最高优先级可修 Issue

| 优先级 | # | 标题 | 类型 | 可修性 | 建议 |
|--------|-----|------|------|--------|------|
| P0 | #60799 | cron v2026.4.2 silent data loss | regression | S | aoao 直接接 |
| P0 | #60804 | Brave CDP attach fail on Debian 13 | bug | M | aoao 调研 CDP 逻辑 |
| P1 | #60813/#60812 | typed error routing + multi-channel extend | bug | S | 打包接，channels 目录 |
| P1 | #60816 | edit tool concurrent identical edits → noop | usability gap | S | aoao 查 edit tool 代码 |
| P2 | #60795 | 模型切换状态残留 | bug | M | 与 #60809/#60818 同系列，可一起研究 |
