# 4方向扫描报告 2026-04-06 06:01 CST (2026-04-05 22:01 UTC)

## GitHub
发现了 **7个** 新候选（排除已追踪/PR），其中最重要的是：

### ⭐ #61524 (S) — security: "full" + ask: "off" 仍触发混淆检测批准提示
- **根因**：代码中 `obfuscation.detected` 被无条件 OR 进 requiresAsk，即便 security=full 也强制弹批准
- **修复**：加一个 `hostSecurity !== "full"` 条件即可（已在 issue 中给出建议修复）
- **影响**：所有想完全禁用批准的可信单操作员环境无法实现
- **难度**：S，逻辑简单，修改两处
- **代码位置**：`src/agents/bash-tools.exec-host-gateway.ts` ~line 126-133 和 exec-host-node.ts

### #61514 (S) — Open in Canvas / copy markdown 图标覆盖文字（regression）
- **清晰**：截图明确，v2026.4.2，所有浏览器复现，2025-04-01 引入
- **根因**：CSS z-index/position 问题
- **难度**：S，UI fix，无需懂业务逻辑
- **建议**：aoao 可直接修

### #61508 (M) — WebChat WebSocket 1006 断开，长模型响应时 keepalive 缺失
- **影响**：UI 卡在 "..." spinner，后续消息队列但不处理，需刷新恢复
- **根因**：gateway WebSocket 服务端没有发送 ping/keepalive 帧
- **环境**：macOS M2，Opus 长响应 5-20 分钟后必现
- **难度**：M，需了解 WebSocket 基础设施和 gateway ping 配置

### #61505 (?) — Discord handler 卡在 "awaiting gateway readiness"
- **现象**：standalone discord.js 正常，OpenClaw 内卡住
- **已尝试修复**：`@discordjs/rest`, `@discordjs/ws` 等手动安装解决部分依赖，但仍有此问题
- **难度**：M/M+，需深度了解 gateway readiness 信号机制
- **关联** #58290（已追踪 Discord bot never reaches ready state）

### #61520 (S) — Config IO 静默吞掉可能指示严重问题的错误
- **标签**：enhancement，但实际是静默错误传播问题
- **根因**：`config/io` 层对错误打日志后继续执行，不向上传递
- **难度**：S，logging 改进

### #61509 (S) — exec allowlist /bin/sh -lc wrapper 后无法匹配内层命令
- **注**：已在上一轮报告（P325），本轮更新 body 详情（有明确 repro 步骤）
- **仍值得追踪**：修复方案需处理 wrapper 解包逻辑

**已有 PR/已覆盖（勿重复）**：
- #61518 ✅ fix(web-fetch): honor HTTP proxy env（已 merge）
- #61517 ✅ fix(ollama): use SSRF-guarded fetch（size:XS）
- #61515 ✅ fix(skills): resolve bundled runtime overlay paths（size:S）
- #61512 ✅ fix: use Array.sort instead of toSorted（size:XS）
- #61510 ✅ feat(webchat): add KaTeX math rendering（size:S）
- #61507 ✅ feat(google): add support for Gemma models（size:S）
- #61504 ✅ fix(security): prevent external content marker sanitization bypass（size:XS）

---

## InStreet
**无**。instreet.coze.site/skill.md 是 API skill 文档（非用户讨论区），本轮未见新讨论内容。

---

## Discord
**无**。Discord 公共频道需登录不可抓取；GitHub Discussions 返回 410 Gone；本轮无新可行动讨论。

---

## 插件
**无新发现**。openclaw/openclaw-weixin 仓库不存在公开 repo；未发现新的 plugin 相关公开 issue；weixin 代码仍不可见。

---

## 结论
最高优先级是 **#61524**（security bypass，清晰的逻辑修复，S 级难度）

次优先 **#61514**（Canvas 图标重叠，UI fix，最简单）

第三 **#61508**（WebSocket 1006 keepalive，用户真实受影响，M 级）

**建议**：
1. aoao 优先接 **#61514**（UI fix，立竿见影，XS/S 级）
2. **#61524** 由 aoao 接（安全相关，修复清晰，S 级）
3. **#61508** 需要了解 gateway WS 基础设施，建议后续调研

