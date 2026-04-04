# OPENCLAW-PROJECT.md

## 目标
范总进入 OpenClaw contributors 前 20。

---

## 已追踪 Issue

| # | 标题 | 优先级 | 难度 | 状态 | 备注 |
|---|------|--------|------|------|------|
| 54952 | - | S | - | ❌ 已关闭/不存在 | 2026-04-03 17:47 UTC 确认 404 |
| 54964 | - | S | - | ❌ 已关闭/不存在 | 2026-04-03 17:47 UTC 确认 404 |
| 55008 | - | S | - | ✅ 已合并/修复 | 2026-04-03 21:17 UTC：skills 回归 bug 已由 maintainer 在 branch 上修复（commit bb2ea2f7e4 + b14be82db1）；PR 最终只保留 docs 变更 |
| 55013 | - | S | - | 🔍 PR 有 Greptile review | 2026-04-03 19:17 UTC Greptile 发现：feishu.md 和 configuration-reference.md 两处均将 `groupPolicy` 错误描述为"选择 agent"，实为 access-control 机制 |
| 55153 | ... | S | - | 覆盖中 | - |
| 55137 | ... | S | - | 覆盖中 | - |
| 55466 | ... | S | - | 覆盖中 | - |
| 55458 | ... | S | - | 覆盖中 | - |
| 55479 | ... | S | - | 覆盖中 | - |

---

## 当前优先级

### GitHub 新候选（2026-04-03 23:58 UTC 扫描 — 4月4日 07:58 CST）

| # | 标题 | 来源 | 优先级 | 难度 | 备注 |
|---|------|------|--------|------|------|
| #60596 | ensurePluginAllowlisted no-ops when plugins.allow is undefined | GitHub | S | XS | 安装插件后 allowlist 从不初始化；每次 gateway 启动都产生警告；一行修复：`allow ??= []` |
| #60594 | WebChat: WebSocket drops every 1-5 min on Safari, loses messages/events | GitHub | S | M | Safari Tab Throttling 导致 WS 频繁断开；断线后不回填消息；v2026.4.2 用户可见 |
| #60593 | Recurring Anthropic streaming JSON parse errors — failover often fails to recover | GitHub | S | M | Sonnet 4.5/Opus JSON parse 错误反复出现；failover 不触发时用户看到原始错误；v2026.4.2 |
| #60585 | ACP runtime sessions fail with 'acpx exited with code 1' — sessions_spawn runtime:"acp" broken | GitHub | S | M | 2026.4.2 Task Flow 改动导致 acpx 集成破裂；sessions_spawn runtime:"acp" 完全无法使用 |
| #60584 | Cron jobs timeout after ~150s despite timeoutSeconds=300 | GitHub | S | M | Bailian/Qwen3.5-plus cron 在 150s 左右超时；pi-agent-core 可能有硬编码 120s 超时 |
| #60580 | [Bug]: Agent repeats own content across turns (4.2) | GitHub | S | M | v2026.4.2 regression；对话历史重建时丢失 assistant turns；Intermittent；Anthropic Opus 4.6 |
| #60570 | tools.exec.host=auto blocks agent-requested host=node | GitHub | S | S | 严格相等检查阻止了 node 显式请求；已有 community PR #60579（gotexis）修复中 |
| #60579 | fix: allow agent-requested exec host when configured target is auto | GitHub PR | S | XS | Community PR 修复 #60570；20 tests pass；可 review 并向 maintainer 协作 |
| #60583 | fix(cron): resume interrupted recurring jobs on first restart | GitHub PR | S | S | Community PR（joelnishanth）修复 #60495；精确分析+完整测试；可协作 |
| #60004 | v2026.4.2: Slack plugin fails to load (@slack/web-api not found) | GitHub | M | M | v2026.4.2 打包变更导致 @slack/* 只在 extensions/slack/node_modules 下；影响所有 Slack 用户 |
| #59995 | Telegram direct chat leaks internal assistant dialogue | GitHub | M | M | Telegram DM 持续泄漏内部 assistant 注释；隐私问题；多工具调用时尤其明显 |
| #59850 | grammy module not installed causes ERR_MODULE_NOT_FOUND for all users | GitHub | M | M | grammy 在 startup 被静态加载；任何 URL 粘贴都会触发崩溃；动态 import 修复 |
| #59946 | Subagent killed by LLM provider streaming idle timeout — no retry | GitHub | M | M | Copilot 等 provider 60s 空闲断开；subagent 直接死亡无 retry；父 session 收到截断输出 |
| #60496 | Control UI: Long command outputs push approval buttons off screen | GitHub | M | XS | sticky buttons 或 collapsible output 即可；已在上一周期标记 |
| #60572 | Multi-Slot Memory Architecture | GitHub | L | L | 重大 feature request；非一人可完成 |

### InStreet 社区
- 无新发现（instreet.coze.site/skill.md 是平台 API 文档，非用户讨论区）

### Discord / Discussions
- Discord 仍需登录无法直接抓取
- GitHub discussions API 返回 410（已禁用）
- 建议：改扫 GitHub PR reviews 和 community forum

### 插件仓库
- WeChat/openclaw-weixin 代码不可见；通过 issue 反推
- 新发现：#60593 Streaming JSON parse errors 在 v2026.4.2 反复出现（Anthropic 相关）

---

## 扫描记录
- 2026-04-03 23:58 UTC：新增 #60596 #60594 #60593 #60585 #60584 #60580；#60579（PR 修复 #60570）、#60583（PR 修复 #60495）已有 community 作者；#60572 大型 feature 标记 L

### GitHub 新候选（2026-04-03 19:50 UTC 扫描）

| # | 标题 | 来源 | 优先级 | 难度 | 备注 |
|---|------|------|--------|------|------|
| #60497 | Agent fabricates successful output after exec tool failure instead of reporting error | GitHub | S | M | exec 失败后 agent 捏造文件创建确认和假输出；严重行为 bug；清晰可复现 |
| #60494 | [Bug][Regression] WebChat renders raw <tool_call> XML tags in chat bubbles - v2026.4.2 | GitHub | S | S | v2026.4.2 回归；每次 tool call 都显示原始 XML；Telegram 正常；agent 执行后常停止响应 |
| #60498 | skills.load.extraDirs: most skills not injected into available_skills system prompt | GitHub | S | M | extraDirs 63 个 skill 仅 3 个出现在 available_skills；可能是注入上限或过滤 bug |
| #60495 | [Bug] Cron job not resumed after restart when interrupted during execution | GitHub | S | M | 重启时中断的 cron job 被静默跳过；runMissedJobs skipJobIds 逻辑问题；清晰可复现 |
| #60484 | Routed replies bypass reply directive normalization, leaking [[reply_to_current]] | GitHub | S | S | route-reply.ts 未调用 reply directive normalization；可能导致空发送或 raw directive 泄漏 |
| #60487 | Large attachments silently dropped when agent session is cold/expired | GitHub | S | M | 冷 session/过期时大附件静默丢失；数据丢失 bug |
| #60496 | Control UI: Long command outputs push approval buttons off screen | GitHub | M | XS | approval card 按钮被长输出推出视口；sticky buttons 或 collapse 即可 |
| #60490 | [Bug] Gateway not starting on Windows – Dashboard unreachable | GitHub | M | M | Windows 11 上 gateway 注册但不运行；dashboard 拒绝连接；reinstall 后复现 |

### InStreet 社区
- 无 OpenClaw 相关新发现（instreet.coze.site/skill.md 是平台 API 文档，非用户讨论区）

### Discord / Discussions
- Discord 仍需登录无法直接抓取
- GitHub discussions API 返回 410（已禁用）

### 插件仓库
- openclaw-weixin 相关活跃问题：#60416（SDK 兼容性）、#59797（4.1 登录 regression）、#54303 #56478 #57619 #58314 #57384
- 模式：2026.4.x 版本兼容性问题是重灾区；代码不可见，仅通过 issue 反推
- 新 PR：#60493（fix(qqbot): support HTML entities in media tags）值得关注

---

## 最高优先级建议（2026-04-03 19:50 UTC 扫描）

1. **#60393** — web_fetch Fake-IP 阻塞：清晰可本地复现，影响 Clash/代理用户群体，修复范围可控
2. **#60380** — Feishu parseInteractiveCardContent：Feishu 用户高频场景，解析逻辑缺口明确
3. **#60362** — Telegram message too long：不处理永久错误导致 retry 循环，逻辑清晰

---

## 扫描记录
- 2026-04-03 15:48 UTC：新增 #60393 #60380 #60344 #60362 #60339 #60378 #60354
- 2026-04-03 17:00 UTC：新增 #60407 #60400 #60398 #60397 #60416 #60380
- 2026-04-03 17:48 UTC：新增 #60448 #60450 #60447 #60414 #60408 #60423 #60426；InStreet 无发现；Discord 无法访问；WeChat 插件问题持续活跃
- 2026-04-03 19:17 UTC：#55008 Greptile 发现 P1 regression（feishu skills 被误删）；#55013 groupPolicy 描述错误（两文件均有）
- 2026-04-03 21:17 UTC：#55008 skills 回归 bug 已由 maintainer 修复并合并；#55013 groupPolicy 描述错误（两文件均有）仍未修复；#54952 #54964 无新反馈

---

## 当前优先级（2026-04-03 17:48 UTC 扫描更新）

### GitHub 新候选（17:48 UTC 扫描，新增最高优先级）

| # | 标题 | 来源 | 优先级 | 难度 | 备注 |
|---|------|------|--------|------|------|
| #60448 | [安全] Internal metadata leaking to AI context (sender JSON visible in AI prompt) | GitHub | S | M | 安全+隐私问题；sender JSON 泄漏到 AI 提示词；清晰可复现；新发现 |
| #60450 | v2026.3.28: Runaway API calls burned entire monthly budget (所有 provider) | GitHub | S | M | 认证失效→failover 死循环→烧掉全部预算；auth/failover 系统缺陷；新发现 |
| #60447 | cron edit --tools fails with agentTurn payload (isolated sessions cannot get exec) | GitHub | S | S | CLI 参数组合校验 bug；--message + --tools 冲突；新发现 |
| #60414 | TypeError: Cannot read properties of undefined (reading 'properties') on every message | GitHub | S | M | session init 阶段崩溃；LLM 从未被调用；v2026.3.31 和 v2026.4.2 均复现；新发现 |
| #60408 | Browser screenshot MEDIA: auto-delivery ignores thread context, leaks to parent channel | GitHub | M | M | Slack thread 截图泄漏到父 channel；安全隐私问题；新发现 |
| #60423 | Uncaught exception in media understanding could crash entire reply pipeline | GitHub | M | XS | try/catch 包裹 applyMediaUnderstandingIfNeeded 即可；极简单；新发现 |
| #60426 | exec approval timeout: followup dispatch fails with gateway timeout (60s) | GitHub | M | M | 超时后 agent 响应无法投递到用户 channel；dispatch routing 缺失；新发现 |
| #60400 | [Regression] 2026.4.2 所有 channel 静默初始化失败（来自上一周期） | GitHub | S | M | 已在上一周期标记 |
| #60407 | [Regression] Exec 命令成功但返回无输出/SIGKILL（来自上一周期） | GitHub | S | M | 已在上一周期标记 |
| #60416 | Plugin SDK 兼容性问题: openclaw-weixin 2026.4.2 加载失败（来自上一周期） | GitHub | M | XS | 已在上一周期标记 |

### InStreet 社区
- 无新发现（内容为 InStreet 平台 API 文档，无 OpenClaw 讨论）

### Discord / Discussions
- GitHub discussions 页面返回 404（已关闭）；Discord 需要登录无法抓取
- 建议：尝试抓取 GitHub discussions API 或改扫 Discord open channels

### 插件仓库
- WeChat/openclaw-weixin 相关活跃问题：
  - #60416（2026.4.2 SDK 兼容性，代码不可见）
  - #59797（4.1 登录 regression）
  - #54303（定时任务微信投递失败）
  - #56478（isolated cron session 无法发微信）
  - #57619（subagent/cron 消息不投递给微信）
  - #58314（微信插件缺少 inferTargetChatType 导致重复 session）
  - #57384（微信插件多 tool 调用后丢失最后一条回复）
- 模式：2026.4.x 版本兼容性问题是重灾区（WeChat 插件与新版本 SDK 不兼容）
- openclaw-weixin 代码不公开，无法直接读代码定位，需通过 issue 反推

---

## 最高优先级建议（本次扫描）

1. **#60448** — 元数据泄漏到 AI context：安全+隐私问题，必须修；sender JSON 直接可见于 AI 提示词
2. **#60450** — 预算烧穿 bug：auth 失效触发 failover 死循环；高危 financial impact；需了解 auth/failover 系统
3. **#60447** — cron edit --tools：CLI 参数设计 bug，难度 S，清晰可复现
4. **#60423** — Media understanding 崩溃：try/catch 即可，XS 难度，可快速提 PR
5. **#60414** — TypeError on every message：session init 阶段问题；影响所有用户消息；M 难度

### GitHub 新候选

| # | 标题 | 来源 | 优先级 | 难度 | 备注 |
|---|------|------|--------|------|------|
| #60407 | [Bug][Regression] Exec 命令成功但返回"Command still running"或无输出 | GitHub | S | M | Windows 100%复现；SIGKILL 相关；code 0 但无输出；新发现 |
| #60400 | [Bug][Regression] 2026.4.2 所有 channel 静默初始化失败 | GitHub | S | M | macOS 确认；config validate 通过但零日志零初始化；新发现 |
| #60398 | gateway install 在外部 APFS 卷上失败（错误码5） | GitHub | S | S | macOS launchd 限制；install 应自动写到 boot 卷；有 workaround；新发现 |
| #60397 | Telegram 显示 OK 但入站 DM 从不触发回复（无日志） | GitHub | S | M | 与 #60400 高度相关；channel 初始化问题变体；新发现 |
| #60416 | Plugin SDK: @tencent-weixin/openclaw-weixin 加载失败（2026.4.2） | GitHub | M | XS | resolvePreferredOpenClawTmpDir 函数不存在；⚠️代码不可见；新发现 |
| #60380 | [Bug] Feishu: parseInteractiveCardContent 在 fallback post-format 上失败 | GitHub | S | S | 来自上一周期；media-*.js 解析器缺处理逻辑；值得关注 |

### InStreet 社区
- 无新发现（网站"闭店装修"中，无法访问）

### Discord / Discussions
- 无法访问（Discord 需要登录验证；GitHub discussions gh api 返回空）

### 插件仓库
- openclaw-weixin 相关问题持续活跃：#60416（新, 2026.4.2 SDK 兼容性）、#59797（4.1 登录 regression）
- 注意：openclaw-weixin 代码不可见，但 issue 可追踪；多个版本兼容性问题的模式值得关注
- openclaw-weixin 当前 open issues 约 16 个

---

## 最高优先级建议（本次扫描）

1. **#60407** — Exec 无输出 bug：regression，影响所有 Windows exec 用户，100% 复现，建议 aoao 优先接
2. **#60400** — Channel 静默初始化失败：regression，影响所有 2026.4.2 用户，建议 aoao 接
3. **#60380** — Feishu parseInteractiveCardContent：难度 S，路径清晰，Feishu 用户高频场景
4. **#60398** — gateway install APFS 错误：需要 macOS 环境，可选
5. **#60416** — 微信插件 SDK 兼容性：代码不可见，需先确认 OpenClaw SDK 侧是否有函数移除

---

## 当前优先级（2026-04-03 22:56 UTC 扫描）

### GitHub 新候选（2026-04-03 22:56 UTC 扫描）

| # | 标题 | 来源 | 优先级 | 难度 | 备注 |
|---|------|------|--------|------|------|
| #60570 | exec host=auto blocks agent-requested host=node — strict equality check | GitHub | S | XS | 精确根因已给出；isRequestedExecTargetAllowed 函数；4行修复 |
| #60542 | Persisted main session row can become stale and wedge new input (cross-surface) | GitHub | S | M | 高严重度；#60250 关联但更严重；跨 Telegram+control dashboard 均 wedge |
| #60505 | High pre-processing latency (8-12s) on webchat after gateway restart, not in v2026.2.26 | GitHub | S | M | 回归 bug；preprocessing 阶段累积延迟；session store 重读疑似根因 |
| #60543 | Webchat sidebar 'main' session freezes after session reset — stale references | GitHub | M | M | 复位后 sidebar 引用旧 session ID；点 main 页面冻住 |
| #60549 | TUI sessions lost on reconnect — 'No session found' for existing session | GitHub | M | M | 断连后 in-memory store 丢失 session；session 文件存在但无法恢复 |
| #60540 | Browser screenshot fails on Chrome 146+ with managed browser (fromSurface:false) | GitHub | M | XS | 精确根因：fromSurface:false → 改为 fromSurface:true 即可；快照正常 |
| #60576 | fix(infra): treat undefined/null unhandled rejections as non-fatal | GitHub | M | XS | 新 PR，size:XS；unhandled rejection 误判为 fatal |
| #60574 | fix(hooks): remove hooks token from Tailscale Funnel push endpoint URL | GitHub | M | XS | 新 PR，size:XS；token 泄漏到 URL 中 |

### 已追踪/已覆盖
- #60550 - Read tool path validation misses filePath/file（已有 PR #60554 在修）
- #60494 - WebChat raw XML tags（已有 PR #60547 在修，已被认领）
- #60504 - MC Skills UI wrong profile path（已有 volunteer Dharit13）
- #60496 - Control UI buttons off screen（已有 volunteer GuneetGill）

### InStreet 社区
- 无新发现（instreet.coze.site/skill.md 为平台 API 文档，无 OpenClaw 用户讨论）

### Discord / Discussions
- 无法访问（Discord 需登录；GitHub discussions API 返回 410）

### 插件仓库
- openclaw-weixin：无公开 issues（仓库 private）；无新活动
- 新 XS PR 发现：#60576（unhandled rejection 误判）、#60574（hooks token URL 泄漏）

### 最高优先级建议（2026-04-03 22:56 UTC 扫描）
1. **#60570** — exec host=auto → node 切换阻塞：XS，精确根因+修复建议已给出，aoao 可直接上手
2. **#60542** — Session 持久化状态陈旧导致跨 surface wedge：高严重度；与 #60250 同族；建议先摸 session registry 写入逻辑
3. **#60540** — Browser screenshot Chrome 146+ 失败：XS，fromSurface 参数改一下即可；简单验证可本地测
4. **#60576** / **#60574** — 新 PR，两个 XS，可以 review 并 contrib

---

### GitHub 新候选（2026-04-03 21:54 UTC 扫描，新增最高优先级）

| # | 标题 | 来源 | 优先级 | 难度 | 备注 |
|---|------|------|--------|------|------|
| #60550 | Read tool path validation misses filePath and file aliases | GitHub | S | XS | 假阳性警告；已有精确修复建议（4行）；LLM 用 filePath/file 时触发 |
| #60521 | allowUnsafeExternalContent flag ignored in /hooks/agent dispatch path | GitHub | S | XS | 代码注释已给出精确根因+修复（一行）；Atlas HQ 自用路径被误拦截 |
| #60250 | BUG: Completed run can remain persisted as running, blocking new input and stop | GitHub | S | M | 回归 bug；session 状态机 bug； wedge 导致无法 stop；与 #60542 关联 |
| #60525 | iMessage: is_from_me:true messages mis-attributed + garbage prefixes + echo | GitHub | M | M | macOS 专属；3个独立 bug（garbage bytes、sender 归属、echo loop）；平台相关 |
| #60494 | [Regression] WebChat renders raw <tool_call> XML tags in chat bubbles | GitHub | S | S | 已有人在修（Dharit13）；避免撞车；Telegram 正常；v2026.4.2 回归 |
| #60552 | runEmbeddedPiAgent/runEmbeddedAttempt blindly forward params.sessionKey | GitHub | M | S | sessionKey 未回填；可能是 session 丢失 root cause 之一 |
| #60549 | TUI sessions lost on reconnect — gateway returns 'No session found' | GitHub | M | M | TUI 断连后 session 丢失；用户体验影响大 |

### InStreet 社区
- 无新发现（https://instreet.coze.site/skill.md 为平台 API 文档，非用户讨论区）

### Discord / Discussions
- Discord 仍需登录无法直接抓取
- GitHub discussions API 返回 410（已禁用）

### 插件仓库
- openclaw-weixin 无公开新 issues（仓库为 private）
- 主仓库活跃 PR：#60551（Strip leaked reasoning preambles，size:S）刚合并

### 活跃 PR 需关注（避免撞车）
- #60547（fix webchat strip <tool_call> XML - size:S）已修 #60494
- #60538/#60536（fix health probe WARN - size:XS）已修 #60510

### 最高优先级建议（2026-04-03 21:54 UTC 扫描）
1. **#60550** — Read tool path validation：修复极小（XS），精确建议已给出，aoxao 可直接改
2. **#60521** — allowUnsafeExternalContent：注释已给精确修复（一行），Atlas HQ 自用场景
3. **#60250** — Completed run stuck as running：回归严重，但需摸 session 持久化逻辑

---

## 扫描记录
- 2026-04-03 21:54 UTC：新增 #60550 #60521 #60525 #60552 #60549；#60547/#60538/#60536 已修 #60494/#60510；#60494 已有人接（Dharit13）
- 2026-04-03 22:56 UTC：新增 #60570 #60542 #60505 #60543 #60549 #60540；发现 #60576 #60574 为 XS 待修机会；Weixin 插件无公开 issues

---

## 扫描记录
- 2026-04-04 01:03 UTC：新增 #60614 #60607 #60611 #60612 #60618；#60610（PR修复#60596）、#60615（PR修复#60495）已有 community 作者

### GitHub 新候选（2026-04-04 01:03 UTC 扫描）

| # | 标题 | 来源 | 优先级 | 难度 | 备注 |
|---|------|------|--------|------|------|
| #60614 | BUG: openclaw agent --session-id silently ignored when --agent is specified | GitHub | S | XS | CLI 路由 bug；--session-id 被 main session 覆盖；已有清晰日志和复现步骤 |
| #60607 | [Bug] Agent completes task but sends no reply to user (dispatch complete with queuedFinal=false, replies=0) | GitHub | S | M | replyPayloads.length===0 时返回 void 0；timeout 后 error 被静默吞掉；根因已在描述中 |
| #60618 | macOS App: Auto-reconnect to Gateway after restart | GitHub | M | S | macOS launchd plist 重生导致 proxy/NVM 问题；建议 auto-reconnect |
| #60611 | Gateway proxy environment variables lost after launchctl restart | GitHub | M | XS | macOS launchctl plist 重生；proxy env 被清空 |
| #60612 | Doctor warns about NVM node but cannot be fixed | GitHub | L | XS | 纯 cosmetic/usability issue；Doctor 无法 suppress |

### PR 覆盖（已有人在修）
| # | 修复 | 作者 | 状态 |
|---|------|------|------|
| #60610 | fix: initialize plugins.allow when undefined | Kagura | open, size:XS |
| #60615 | fix(cron): replay interrupted recurring jobs on first restart | oliviareid-svg | open, size:XS |
| #60606 | fix(cron): validate agentId against configured agents | huangfeng1995 | open, size:XS |
| #60619 | fix(outbound): strip leaked <tool_call> XML tags from chat bubbles | oliviareid-svg | open, size:XS |

### InStreet 社区
- 无新发现（instreet.coze.site/skill.md 是平台 API 文档，非用户讨论区）

### Discord / Discussions
- Discord 仍需登录无法直接抓取（页面仅返回 "Friends of the Crustacean"）
- GitHub discussions API 返回 410（已禁用）
- 建议：改扫 GitHub PR reviews 和 community forum

### 插件仓库
- WeChat/openclaw-weixin 仓库无法访问（私有/不存在）
- 建议：关注 GitHub 主仓库 #60614 #60607 等问题在插件场景的复现

## 扫描记录
- 2026-04-04 06:20 UTC：#58228 被 maintainer 关闭（too-many-prs）；Greptile review 发现 3 个 P1 bug；main 直接修复并 push，新 PR #60634
