# 全量扫描报告 2026-04-12 14:51 CST

## GitHub Issues（方向1）

发现了 **11 个新 issue** + **13 个新 PR**，其中最重要的是：

### 最高优先级候选

**#65210 — Control UI token usage shows N/A + auto-compression fails since 2026.4.9** (CRITICAL REGRESSION)
- 标签: `bug` + `regression`
- 症状三重奏: (1) Sessions 视图 Tokens 列显示 "unknown/262k (?%)"; (2) Usage 页面 token 统计完全缺失; (3) auto-compression 失效 → context overflow
- 影响: 所有 2026.4.9+ 用户；本地 LM Studio / 任何 provider 均受影响
- 根因: OpenClaw 无法正确解析 API 响应的 `usage` 字段，级联导致 token 计数、自动压缩全线崩溃
- 建议: **aoao 优先接单**（usage parsing → session store → auto-compression 触发链）

**#65211 — include user-configured provider models in gateway catalog (supersedes #65178)** (PR, size S, gateway)
- 作者 hondaya01，1 条评论
- 根因: `models.providers.*.models[]` 中声明的 custom model 完全不在 Pi SDK model registry 里
- 导致: `resolveGatewayModelSupportsImages` 永远返回 false，图片附件被静默丢弃
- 修复: `loadGatewayModelCatalog` 将 `models.providers.*.models[]` 合并进 catalog
- **这是 image attachment 问题的根本修复，比 #65178 的 case-insensitive lookup 更彻底**

**#65208 — Browser plugin 不传 --remote-debugging-port 导致 Chrome CDP 无法连接** (bug, 无标签)
- macOS 2026.4.11；`openclaw browser start` 启动 Chrome 但缺少 `--remote-debugging-port` flag
- config 里 `cdpPort: 18800` 正确但 launch command 里没有对应 flag
- 影响: 浏览器自动化功能完全不可用

**#65207 — Ollama models not displayed in openclaw models list (2026.4.11)** (无标签)
- 2026.4.10: hangs/gets killed; 2026.4.11: returns immediately "No models found"
- 直接 curl `http://127.0.0.1:11434/api/tags` 正常返回模型列表
- 说明问题在 OpenClaw 侧 model registry 解析

**#65204 — Cannot start Chrome, cdpPort binding Permission denied** (bug + regression)
- `bind() failed: Permission denied (13)` on port 80
- 标签: `bug` + `regression`
- 注意: 这与 #65208 可能同根但场景不同（#65208 是 port 18800 且无 flag；#65204 是 port 80 权限问题）

**#65209 — `openclaw mcp list` 只显示 OpenClaw registry，不包含 mcporter 配置** (无标签, docs gap + usability)
- 用户期望看到系统全部 MCP servers，实际只看到 `~/.openclaw/openclaw.json` 里的
- 建议: CLI wording 改进 + help text 说明 + 可选 `--include-mcporter` flag
- **文档/UX 缺口，修复简单，S 级**

**#65200 — /new 和 /reset 不清除 session model overrides** (无标签, usability gap)
- `/model codex` 设置后，`/new` 仍保留 override，导致 `modelByChannel` 配置被绕过
- 根因: `initSessionState()` 在 resetTriggered 时复制了 `modelOverride`/`providerOverride`
- 建议: reset 时不复制 model/provider overrides，或加 `--keep-model` flag

**#65195 — exec/runtime 无法访问 LAN host，interactive shell 正常** (macOS)
- 标签: 无（但症状严重）
- OpenClaw exec 路径报 "No route to host"，同一机器 shell `curl` 正常
- 疑似: launchd/service 路径与交互 shell 的网络视图隔离
- 影响: 所有依赖 LAN 服务的 exec 工具全部失效

**#65193 — Cron TypeError: Cannot read properties of undefined (reading 'runningAtMs')** (bug + regression, 2026.4.9)
- P59904 已追踪；已知 PR #65206 已创建修复

**#65192 — too many dream sessions accumulation** (bug + bug:behavior)
- 截图: Sessions 面板大量 dream session 堆积，暴露给普通用户
- 建议: dream session 应该有 maxAge 或自动清理机制

**#65191 — Plugin initialization fails due to config not loaded before plugin starts** (无标签)
- P59905 已追踪

### 新 PR 重点

| PR | 标题 | 大小 | 备注 |
|----|------|------|------|
| #65205 | feat(discord): add canvas-first Discord Activities support | XL | maintainer PR，3 条 greptile/bot 评论，重点关注 spoofed launch context 问题 |
| #65202 | fix(feishu): add doctor migration for legacy botName→name | S | greptile P2 评论（migration message 误导性、channel-level case 缺失）；maintainer 确认不应 rename top-level botName |
| #65211 | fix: include user-configured provider models in gateway catalog | S | supersedes #65178，根因修复 |
| #65199 | fix(ui): humanize cron expressions in dreaming phase | S | 多个 bot 评论（P2: minute offset 被静默丢弃、next-run fallback 缺失） |
| #65194 | fix(imessage): avoid duplicate default monitor startup | S | maintainer P1 评论（hasDistinctDefaultIMessageRuntime 检查范围过宽、skipDefaultFallbackMonitor gate 未 ignore disabled accounts）|
| #65213 | feat(sessions): add effective session explain command | S | CLI 新功能 |
| #65212 | fix(qmd): normalize direct file collection paths | S | QMD 配置 path 处理 |
| #65203 | Fix cron sessionFile persistence for isolated runs | XS | cron 隔离运行 sessionFile 持久化 |
| #65197 | fix(memory-wiki): upstream bridge and lint hotfixes | M | 已有 2 reactions |
| #65181/#65179/#65175 | 多个 cron 相关小修复 | S/XS | cron session persistence/model override |

---

## 插件仓库（方向2）

**openclaw-weixin / Tencent/openclaw-weixin 仓库**: gh api 返回 404 Not Found，仓库不可公开访问。

**Tencent/openclaw-weixin issues**: gh api 返回 404 Not Found。

**结论**: 无公开可访问的插件 issue/PR 候选。本轮无新发现。

---

## 贡献者文件区域（方向3）

扫描了贡献量最低的 20 位 contributors (贡献 9-12 次)：`Kaneki-x, akramcodez, chinar-amrutkar, christianglotz, davemorin, jadilson12, MoerAI, aether-ai-agent, emonty, chilu18` 等。

**问题**: gh api 返回了 commit sha 列表，但 `.files` 字段全部为 null。commits endpoint 不返回 changed files 详情，需改用 `repos/{owner}/{repo}/commits/{sha}` 逐个获取或用 search API。

**结论**: 本轮 contributor 文件区扫描未能完成文件路径收集，无法匹配 open bugs。建议下轮改用：
```bash
gh api "repos/openclaw/openclaw/commits?author={login}&per_page=20" --jq '.[].files[].filename'
```
对每个末段 contributor 逐个拉取。

---

## 追踪 PR 反馈（方向4）

| 追踪 PR | 状态 | 新评论 |
|---------|------|--------|
| #65205 (Discord Activities, XL) | 持续活跃 | **maintainer 评论**: greptile P1×2 / P2×2，关注点: (1) `hasDiscordActivityLaunchContext` 需 reject spoofed launch markers 才给 auth bypass; (2) `OpenClaw.discord.load()` 失败后未 reset promise 导致无法 retry; (3) "Every N hours" 描述静默丢弃 minute offset; (4) `formatPhaseSchedule` 缺少 next-run fallback 时显示 "—"; 建议在 merge 前解决 |
| #65202 (Feishu botName migration, S) | 有反馈 | **greptile P2×2**: (1) migration log message 当 `name` 已存在时仍 push 误导性变化; (2) `describe` 遗漏 channel-level case; **maintainer 评论**: 不应 rename top-level `channels.feishu.botName` → 应该是 per-account 层 |
| #65199 (cron UI humanize, S) | 有反馈 | **多个 bot 评论**: minute offset 丢失、next-run fallback 缺失；author 已在处理 |
| #65194 (imessage duplicate monitor, S) | 有反馈 | **maintainer P1×2 / P2×2**: `hasDistinctDefaultIMessageRuntime` 检查过宽、`skipDefaultFallbackMonitor` 未 ignore disabled accounts；author 已更新 |
| #65190 (Vietnamese i18n, XS) | 新 PR | docs + scripts；无标签 |
| #65188 (iOS Safari auto-zoom fix, S) | 新 PR | app:ios + app:web-ui |
| #65186 (example trigger for Skills, S) | 新 PR | agents |
| #65185 (iOS plaintext ws:// fix, S) | 新 PR | app:ios |

---

## 结论

**最高优先级**: **#65210** (token usage N/A regression) + **#65211** (provider models catalog 根因修复)

**建议**:
1. **#65210** — aoao 优先接单，usage parsing 链（API response → session store → auto-compression）
2. **#65211** — 根因级 image support 修复，比 #65178 更彻底，可优先 review
3. **#65205** — maintainer 的 P1 评论需在 merge 前处理（spoofed launch markers + SDK load promise reset）
4. **#65202** — Feishu migration 修复注意 top-level vs per-account 层区分
5. **方向3 扫描方法** — 改用逐个 contributor 的 `commits?author=` + `.[].files[].filename` 提取活跃文件路径

**下轮改进**: 方向3 需修复文件路径收集方法；方向2 持续关注 weixin 仓库公开化可能性。
