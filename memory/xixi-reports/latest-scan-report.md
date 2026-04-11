# 全量扫描报告 2026-04-11 23:03 (CST)

## GitHub Issues（方向1）

共发现 **30 个** 近2小时更新的 open issues。最高优先级候选如下：

### 🔴 最高优先级（立即 action）

**#64821** — SECURITY+CRASH：tools.exec.security 被插件日志污染（hot-reload concatenates plugin output into config value）
- 标签：bug + **security** + **bug:crash**
- 0评论0分配
- 根因：config hot-reload 时，`tools.exec.security` 原本值 `"full"` 被替换为 `插件初始化日志输出 + "full"`
- 影响：exec 安全策略被静默破坏，RCE 风险；且日志输出堆积导致 config 值越来越大，最终触发 crash
- **建议 aoao 立即接单（最高优先 S 级）**

**#64853** — CLI commands hang on Windows（15:00:55Z 最新鲜）
- 无标签，0评论
- 与 #64821 描述的 hot-reload corruption 高度疑似同根因（Windows 上更快触发）
- **建议 aoao 确认 #64821 的 fix 是否覆盖本 issue**

### 🟠 高优先级 regression（新发现）

**#64852** — google-vertex OAuth 2026.4.9→4.10 回归（401 CREDENTIALS_MISSING）
- 标签：bug + regression
- Token getMe 验证通过但 downstream 请求 401
- **建议 aoao 接单**

**#64841** — Disabled memory-lancedb 仍触发 config validation crash
- 标签：bug + bug:crash + regression
- 已禁用的 lancedb 条目仍被 validation 检查，导致升级后 crash
- **建议 aoao 接单**

**#64840** — Model fallback 不触发 HTTP 400 model_not_supported
- regression：400 错误未触发 fallback chain
- 已有类似问题历史（#32533/#49079/#62141）
- **建议 aoao 接单**

**#64831** — Cron jobs 不稳定 + Telegram 漏发
- 标签：bug + regression
- Cron 执行不一致，chat-triggered exec 不稳定，Telegram catch-up delivery 缺失
- **建议 aoao 接单**

**#64844** — /new session 忽略 agents.defaults.model.primary
- regression：注入错误模型
- **建议 aoao 接单**

**#64839** — qwen3.6-plus via bailian 无法处理图片
- regression：图片工具报 Unknown model + QQ media URL 被 block
- **建议 aoao 接单**

### 🟡 中等优先级（新发现）

**#64850** — ACP runtime backend unavailable persists（qwen-code agent 无法 spawn）
- 标签：bug + bug:behavior
- v2026.4.10 regression
- **建议 aoao 接单**

**#64845** — Memory dreaming narrative generation fails（idempotencyKey 缺失）
- memory 系统新功能报错
- **建议 aoao 调研根因**

**#64838** — File editor CTRL-F 隐藏文件而非触发浏览器 find
- UI bug
- **建议 aoao 接单（XS）**

**#64836** — Auth config lost after npm upgrade
- 升级流程问题
- **建议 aoao 接单**

**#64835** — memory_search 返回 0 结果（vec0 virtual table 未填充）
- regression
- **建议 aoao 接单**

**#64833** — OpenAI Codex OAuth invalid_scope error
- **建议 aoao 接单**

**#64810** — Heartbeat 吞掉 Telegram 回复（在 progress 中的消息）
- regression：Heartbeat/interrupt 机制破坏 Telegram topic sessions 中进行中的回复
- **建议 aoao 接单**

## 插件仓库（方向2）

**openclaw-weixin（Tencent/openclaw-weixin）** 仓库可访问，发现 **4 个** 近24小时新 issue：

### 新发现（未追踪）
**Tencent/openclaw-weixin #54** — Bug: 图片查看功能完全不可用（sharp 模块缺失）
- 2026-04-11T14:03:13Z（非常新鲜）
- sharp npm 模块缺失，图片查看功能完全失效
- **建议 aoao 接单（weixin 代码不可见，但 sharp 缺失是 npm 层面问题）**

**Tencent/openclaw-weixin #53** — AI 承诺设置定时提醒后实际未创建 cron 任务
- 2026-04-11T12:01:40Z
- 与主仓库 #54303（定时任务微信投递失败）相关但独立
- **建议 aoao 接单（weixin 代码不可见，根因在主仓库 cron→weixin 投递层）**

### 已追踪
- **#50**（openclaw 定时推送无法在微信触发）→ 已在 P273 追踪，本轮确认 #53 是独立问题（#53 是 cron 未创建，#50 是推送不触发）

## 贡献者文件区域（方向3）

gh API 未返回 bottom 10 contributors 的 commit 历史（API 返回空，可能是贡献数据同步延迟）。尝试的 contributor 列表：

`quotentiroler(45), eleqtrizit(53), altaywtf(54), Glucksberg(59), onutc(61), osolmaz(61), jalehman(63), mcaxtr(64), bmendonca3(69)`

本轮无法完成方向3分析，**建议下一轮重试**。

## 追踪 PR 反馈（方向4）

### 新鲜 PR 列表（近2小时活跃）
- **#64846** fix(tools): tolerate duplicate sessionKey/label in sessions_send（XS, agents）
- **#64843** fix(tui): recover footer state after stale run final（XS）
- **#64842** fix(tui): clear stale streaming status（XS）
- **#64837** docs(parity): GPT 5.4 Parity architecture diagrams（XS, docs）
- **#64832** fix(agents): isolatedSession should rotate transcript files per run（M, agents）
- **#64820** fix(feishu): break circular module init causing ReferenceError（M, channel:feishu）⚠️ Feishu 循环引用修复
- **#64817** fix: surface_error failover throws FailoverError to prevent UI hang（M）
- **#64813** feat: pass `user` field through to API request body（XS, agents）
- **#64811** feat(bluesky): add Bluesky DM channel plugin（XL, docs）
- **#64805** feat(feishu): add token and context usage to streaming card footer（M, channel:feishu）

### 关键 PR 分析
**#64846** — sessions_spawn 的 sessions_send 重复处理，与我们追踪的 P208 (#57661 session_send timeout) / P232 (#57928 session tool events) 相关
- **建议 aoao 确认 #64846 是否覆盖 P208/P232**

**#64820** — Feishu 循环引用修复，与我们追踪的 P17/#55825 webchat memory leak / P116/#56074 Feishu heartbeat 无关（是新的 circular init 问题）
- **建议 aoao 给支持评论**

**#64832** — isolatedSession transcript rotation，影响 cron isolated sessions
- **建议 aoao 给支持评论**

### Maintainer 评论
本轮 gh api 查询未返回新的 maintainer PR review comments，可能需要 PR 详情接口再查。

## 结论

**最高优先级是 #64821（tools.exec.security 被污染），这是安全+crash 双重严重性，0评论，清晰根因，建议 aoao 立即接单。**

其次关注：
1. **#64853**（Windows CLI hang）— 确认为 #64821 同根因后并入
2. **#64852**（google-vertex OAuth regression）
3. **#64841**（memory-lancedb disabled still crashes）
4. **Tencent/openclaw-weixin #54**（sharp 模块缺失，weixin 图片查看失效）

**建议：**
- aoao 优先接 #64821 → #64853 → #64852 三连环
- xixi 继续盯 #62141（Anthropic 503 fallback chain 坏）的根因研究
