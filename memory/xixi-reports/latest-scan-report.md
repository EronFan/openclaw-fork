# 全量扫描报告 2026-04-11 22:03 (CST)

## GitHub Issues（方向1）
- 发现了 **6个新候选**，最重要是 **#64821（P1 security+crash）** 和 **#64814（P1 regression）**
- **#64821（P1）** Bug: tools.exec.security 被插件初始化日志污染 — 热重载把插件输出拼接进 config 值；bug+security+bug:crash 三标签；0评论；**建议 aoao 优先接单（S级，可本地复现）**
- **#64814（P1）** Bug: api.pluginConfig 在 extension plugin register() 中为 null，虽然 openclaw.json 已配置；bug+regression 双标签；**新 regression，建议 aoao 接单**
- **#64816（S）** Bug: 插件绑定的 skill 对 CLI 可见但 live session 中 agent available_skills 不可见；影响 skill 发现机制；0评论
- **#64818（S）** Bug: openclaw update 的 src/canvas-host/a2ui/.bundle.hash 破坏 preflight bisect 回溯；影响开发者 bisect 工作流
- **#64825（S）** Bug: TUI finalizeRun() 在 wasActiveRun=false 时不转换 UI，导致 streaming 指示器卡住
- **#64795（S）** Bug: heartbeat isolatedSession:true 静默复用同一 transcript 文件（每次运行覆盖）

## 插件仓库（方向2）
- 发现了 **2个新 open issue**（Tencent/openclaw-weixin 近2小时）
- **#54（P1）** Bug: 图片查看功能完全不可用（sharp 模块缺失）；Windows 环境；错误信息清晰：`ERR_MODULE_NOT_FOUND: Cannot find package 'sharp'`；影响所有微信发图场景；**建议 aoao 调研是否在上游 openclaw 层缺 sharp 依赖，或腾讯侧缺 peerDependency**
- **#53（P1）** Bug: AI 承诺创建 cron 定时提醒但实际未调用创建接口；根因分析已给出（承诺与执行分离 + LCM 压缩导致承诺内容丢失）；**代码不可见**，但根因在上游 openclaw cron 创建可靠性
- **PR #49** fix: preserve quote context (ref_msg) for voice messages；已有完整实现；**可 Approve 支持**

## 贡献者文件区域（方向3）
- 扫描了排名最末的 **10位贡献者**（贡献量 2~10 次，均为极低活跃账号）
- 名单：graysurf(4), giulio-leone(4), efe-buken(4), danielz1z(4), chziyue(4), kevinWangSheng(4), wes-davis(4), irtiq7(4), teconomix(4), jonisjongithub(4), benithors(3), arthurbr11(3), AdeboyeDN(3) 等
- **受限**: 部分账号（如 graysurf/giulio-leone/jonisjongithub）在主仓库无 commit 记录，可能是插件仓库或其他来源贡献；未能抽样到足够 commit 进行文件区域分析
- **结论**: 本轮末10名大多为极低活跃度或跨仓库贡献账号，末10名文件中无可操作的高优先级未认领 bug

## 追踪 PR 反馈（方向4）
- **近2小时新评论**: #63807, #64344, #64027, #64827 等有新评论活动
- **新 PR**: #64681（GPT-5.4 Parity test, size:XS）刚创建（14:04:56 UTC）
- 项目文件中所追踪 issue/PR 未检测到显著状态剧变
- 其他已追踪 PR 无新增 maintainer 评论

## 结论
- **最高优先级**: **#64821**（P1 security+crash，tools.exec.security 被热重载污染）；其次 **#64814**（P1 regression，api.pluginConfig null）；**#64810** 继续追踪（已在上一轮报告）
- **建议**: 派 aoao 接 #64821（security+crash 双标签，S级快速可修）；对 PR #49（weixin voice quote context）发支持评论；对 #64814 regression 安排 aoao 跟进
