# 4方向扫描报告 2026-04-10 21:36 Asia/Shanghai (2026-04-10 13:36 UTC)

## GitHub

发现了 **12+ 个新候选**（近2小时更新），重点如下：

### 🔴 最高优先级 - #64312
**标题**: `[Bug]: guarded runtime fetch drops multipart FormData fields, breaking OpenAI audio transcription`
- **类型**: bug + bug:behavior（无 regression 标签）
- **可修性**: **S** — 根因在 guarded fetch 过滤 multipart FormData；修复方向：检测 multipart 并绕过 SSRF guard
- **影响**: 所有通过 OpenAI 音频转录功能（Telegram/Feishu 等频道的语音消息）的用户；音频被静默丢弃
- **核心**: Guarded fetch（SSRF 防护）检测到 FormData 但处理不当，导致 multipart boundary 信息丢失
- **建议**: **aoao 接单**，根因清晰，1-2小时可 PR

### 🟠 高优先级 - #64306
**标题**: `[Bug]: CLI commands hang (status/health/doctor) - timeout in ensureCliPluginRegistryLoaded`
- **类型**: bug（无 regression 标签）
- **可修性**: **S** — `ensureCliPluginRegistryLoaded` 超时；CLI 核心路径问题
- **影响**: 所有 CLI 命令（status/health/doctor）挂起，用户无法诊断问题
- **建议**: **aoao 接单**，先本地复现

### 🟡 可修 - #64321
**标题**: `sessions.list slow with large session history (23s for 112MB)`
- **类型**: bug:behavior
- **可修性**: **M** — 性能问题，session history 大时线性扫描；可能需索引优化或分页
- **影响**: 用户运行 `sessions list` 时等待 23 秒（112MB session history）
- **建议**: 标注 M，需调研 sessions list 实现路径

### 🟡 可修 - #64308
**标题**: `claude-cli models fail with 'billing issue' even when local Claude CLI works`
- **类型**: bug
- **可修性**: 待确认 — claude-cli 后端计费错误分类问题
- **建议**: 确认是否已有 PR 在修

### 🟡 可修 - #64302
**标题**: `Compaction settings ignored; context overflow despite correct config`
- **类型**: bug:behavior（无 regression 标签）
- **可修性**: **S** — compaction 配置被忽略，上下文溢出
- **建议**: **aoao 接单**，先确认根因位置

### 已在追踪中，本轮新评论
- **#64292** (sessions_spawn agentId regression): maintainer 确认；已有用户确认回归
- **#64295** (memory-core dreaming idempotencyKey): martingarramon 已给精确 fix（+3行）；建议 aoao 接单
- **#64019** (dreaming narrative generation idempotencyKey): 第二用户确认；根因确认；**建议 aoao 接单**

---

## InStreet

**无** — `instreet.coze.site/skill.md` 内容仍为 InStreet Agent Skill/API 文档（注册/心跳/发帖流程），非用户实战讨论。未发现社区用户反馈。

---

## Discord

**无直接发现** — Discord 公共 invite 页面 (`discord.com/invite/clawd`) 只能抓到欢迎页，频道内容不可抓取（需登录）。

**替代**: GitHub discussions 仍返回 410 Gone，无替代公开讨论区。

---

## 插件

**无新发现** — `Tencent/openclaw-weixin` 仓库不可公开访问（gh 返回 not accessible）；代码不可见，无法评估 weixin 相关问题。

---

## 结论

**最高优先级**: #64312（guarded fetch drops multipart FormData，破坏音频转录）
- S 级，根因清晰（guarded fetch 对 multipart 处理不当）
- 影响所有使用语音转录的频道用户
- **建议 aoao 优先接单**

**次高优先级**: #64306（CLI hang in ensureCliPluginRegistryLoaded）
- CLI 核心路径阻塞，所有诊断命令挂起
- **建议 aoao 次优先接单**

**延续追踪**: #64019/#64295（dreaming idempotencyKey）— 已有 martingarramon 精确 fix，aoao 可直接参考提交

**无新发现方向**: InStreet（内容仅平台文档）、Discord（需登录）、插件（weixin 私有）

---
*扫描时间: 2026-04-10 13:36 UTC | 覆盖最近 ~2小时更新*
