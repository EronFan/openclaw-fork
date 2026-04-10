# 4方向扫描报告 2026-04-10 07:16 UTC

## GitHub

发现了 **12个**新候选（过去约2小时更新），最重要的是：

### 最高优先级：新发现

1. **#63955 — Agent "analysis paralysis"** — 分析阶段消耗完 token budget，无法过渡到执行阶段。4+ sessions 反复重复"我要写了"但无实际输出。
   - **可修性：S** — 根因清晰（heartbeat 中断 + 无跨 session 进度跟踪），涉及 memory-core 和心跳机制
   - **难度：M** — 需要理解 execution context 保持机制
   - **亮点**：用户已给出完整分析，包含 contributing factors 和 workaround

2. **#63936 — memory-core managed dreaming cron 不重建** — gateway 重启后 cron 被删除且永不重建，日志无错误（静默失败）。
   - **可修性：S** — 相关 issue #62920/#63465 同一症状，根因指向 `gateway:startup` hook 时序问题
   - **难度：S** — cron reconciliation 逻辑，8 plugin 时出现、7 plugin 正常，暗示 plugin load order
   - **亮点**：用户已做 source-level investigation，给出 hypothesis（`resolveCronServiceFromStartupEvent` returns null）

3. **#63946 — memory-wiki bridge import 返回 0 artifacts** — 缓存的 plugin restore 丢失 memory capability，导致 bridge 模式完全失效。
   - **可修性：S** — 关联 #63157（已知根因），用户已指出 `listActiveMemoryPublicArtifacts()` 因 capability 丢失返回空
   - **难度：M** — 需要理解 plugin capability 注册/恢复机制

4. **#63927 — ACP sessions_spawn thread binding 在 Discord 失败** — 清晰可复现，有完整 config + error message，workaround 存在（acpx CLI 路径可用）
   - **可修性：S** — thread binding adapter 层面问题
   - **难度：M** — 涉及 Discord channel + ACP session binding 交叉逻辑

### 已有人处理/关闭
- **#63931** — Discord OPUS_CHANNELS 缺失 → EronFan 已提交 PR #63950（一行修复），标记关闭
- **#63937** — Slack SecretRef 提前解析 → 已标记 Fixed closing
- **#63925** — WhatsApp watchdog timeout → 已标记 Fixed closing

### 其他候选
- **#63956** — Streaming 多个 chat bubble（bug:behavior）
- **#63948** — CLI 启动延迟 15-25s（Performance label）
- **#63935** — Google Gemini 400 错误
- **#63952** — kimi/moonshotai undefined length（已在已追踪列表）

## InStreet

- **无**：抓取内容为 InStreet 平台 Skill API 文档，非用户实战讨论

## Discord

- **无法访问**：Discord 服务器需要登录认证，web_fetch/browse 均返回 404；GitHub discussions 已关闭（410 Gone）
- 方向3无法执行，无替代数据源

## 插件

- **无法扫描**：openclaw-weixin 代码私有，repo 不公开；openclaw/openclaw-* 插件仓库无公开 issues
- **注**：openclaw-weixin fork 存在（EronFan 维护），但 issue 需认证访问

## 结论

**最高优先级：#63955 + #63936**

- **#63955**（analysis paralysis）：用户已给完整根因分析，涉及 memory-core 和心跳机制，修复路径清晰
- **#63936**（dreaming cron 不重建）：plugin load order 竞态条件，8 plugin 重现、7 plugin 不现，姐妹 issue #62920/#63465 已确认同类问题，建议打包修

建议 aoao 按 #63936 → #63927 → #63946 → #63955 顺序处理。

**本轮无阻塞**。
