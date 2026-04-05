# 4方向扫描报告 2026-04-05 16:17 CST

## GitHub

发现了**10+个新候选**（过去2小时内更新），最重要：

### 🔴 高优先级（直接可修/高影响）

1. **#61238** - Critical Data Loss Due to Silent Daily Session Reset
   - 标签: bug + bug:behavior
   - 难度: **M**
   - 根因：OpenClaw 每天 4:00 AM 自动 reset 会话，无警告、无 discoverable opt-out；备份存在但无法恢复到活跃会话
   - 影响：8+ 次 reset，15,000+ 消息永久丢失
   - 建议：**建议 aoao 接单**，先本地复现确认行为，再调研 session reset 配置机制

2. **#61233** - allow-always does not persist — each command triggers new approval
   - 标签: 无标签（纯 bug）
   - 难度: **S/M**
   - 根因：`allow-always` 保存的是命令 hash（每次不同），不是稳定模式匹配；allow-always 形同 Allow Once
   - 建议：**建议 aoao 接单**，exec-approvals 持久化逻辑，fix 方向明确

3. **#61223** - Ollama thinking tokens cause silent message drop + client queue lockup
   - 标签: 无标签
   - 难度: **M**
   - 根因极清晰：`dist/stream-*.js` 只读 `chunk.message.content`，忽略 `chunk.message.thinking`；Ollama 推理模型在 reasoning phase 发 `thinking` 空 `content`，导致 streamStarted 不翻转，assistant turn 以空内容结束
   - Bug 2：chatRunId 未清除导致后续所有消息卡在队列
   - 建议：**建议 aoao 接单**，需要本地 Ollama 实例复现，但根因文件明确

### 🟡 中等优先级 regression/bug

4. **#61219** - LINE channel fails to start after upgrading to v2026.4.2 (regression)
   - 标签: bug + regression
   - 难度: **M**
   - 错误: "Bundled plugin public surface access blocked for line via line/runtime-api.js: no bundled plugin manifest found for line"
   - 同期 #61218（beta-blocker）可能是同一 regression 两个视角
   - 建议：确认 #61218 PR 是否在修；如未修，建议 aoao 调研 LINE runtime contract 注册逻辑

5. **#59850** - grammy module not installed causes ERR_MODULE_NOT_FOUND for all users
   - 标签: 无标签
   - 难度: **S**（动态 import 重构，但 fix 方案清晰）
   - 根因：`sticker-cache-*.js` 静态 import grammy，grammy 加载失败时所有 URL 粘贴 webchat 都崩（即使用户不用 Telegram）
   - 建议：**建议 aoao 接单**，改动态 import，技术方案已在 issue 中

6. **#61240** - BREW NEEDS TO BE REMOVE AS THE MAIN INSTALLER (regression)
   - 标签: bug + regression
   - 难度: **S**（偏文档/多包管理器说明，实际是 usability gap）
   - brew 在 Linux root/container 环境下不可用，无其他安装选项
   - 建议：先确认是修安装脚本还是加文档说明 npm/curl 备用路径

### 有 PR 在处理中的（不重复占坑）

- **#61206** → PR #61221 已修复（cron tool JSON Schema）
- **#61118** → PR #61239 已修复（cron isolated timeout proportional）

## InStreet

**无**。`https://instreet.coze.site/skill.md` 当前仍是 InStreet Agent Skill/API 文档（注册流程、心跳流程、小组/文学社 API 等），不是 OpenClaw 用户讨论区。本轮未发现可转 GitHub issue 的真实用户故障。

## Discord

**无**。Discord invite 页面（`discord.com/invite/clawd`）只能抓到服务器标题，频道内容无法直接抓取（需要认证登录）。GitHub Discussions 返回 410 Gone。暂无可公开抓取的新讨论。

## 插件

**无新增**。本轮插件方向（`openclaw/openclaw-weixin` 等）未检出近 2 小时新增的公开 issue。weixin 代码仍不可见，已有追踪项继续为 #55994（代码不可见状态）。

## 结论

**最高优先级**：**#61238（Silent Daily Session Reset 数据丢失）**
- Critical 严重度，清晰可复现（默认配置下每晚 4 AM 触发），影响面极广
- fix 方向：至少加 in-client 警告 + discoverable opt-out

**次高优先级**：**#61233（allow-always 不持久化）**
- 安全/可用性 bug，exec approval 核心功能受损
- fix 方向明确（command hash → 稳定 pattern 匹配）

**建议 aoao 接单顺序**：#61233 → #59850 → #61223 → #61238

**阻塞**：无。本轮扫描未遇到阻塞。
