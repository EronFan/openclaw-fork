# OpenClaw 贡献项目 - 状态追踪

> 本文件为范总在这个群的单一事实来源。
> 所有 OpenClaw 项目的进展、决策、阻塞统一记录此处。
> main agent 在此群只更新和引用此文件。

---

## 🔄 明日(2026-03-27)启动检查清单

如果你在 2026-03-27 读到这个文件,按以下顺序检查:

1. **读本文件的「当前优先级」表格** - 了解所有 open 项状态
2. **读 cron 反馈记录**(`memory/openclaw-feedback-check.txt`)- 检查是否有新 feedback
3. **执行 cron 反馈检查** - `openclaw cron run` 触发反馈检查,看是否有新回复
4. **如有新反馈**:按优先级处理(issue 评论 → review 回复 → 决定下一步)
5. **如无新反馈**:继续扫描新 PR/issue,xixi 调研 → main review 循环
6. **向范总汇报**:在群 oc_f68e4447ecaeb604046c3d8ef84681f3 发送简短早间状态

---

## 项目背景

**目标**:帮助范总冲进 OpenClaw contributors 前 20
**repo**:`openclaw/openclaw`
**协作团队**:main(总控)+ xixi(调研)+ aoao(全栈工程师)
**协作原则**:持续执行,不等指令;只有高风险才确认

---

## 当前优先级

| 优先级 | 任务 | 状态 | 备注 |
|--------|------|------|------|
| P1 | Diagnostics gap issue | ✅ 已发布 (#54952) | 等反馈 |
| P1b | Session zombie state after init failure | ✅ 已发布 (#54964) | 等反馈 |
| P3 | docs(cli/message) clarify plugin extensibility | ✅ PR 可合并 (#55008) | ✅ skills regression 已修复，仅 docs diff；待合并 |
| P3b | docs(channels/feishu) groupPolicy 描述不准确 (#55013) | 🔍 待修复 | Greptile 指出 groupPolicy 被描述为"选择 agent"，实为"访问控制"；需修复 feishu.md 和 configuration-reference.md |
| P2 | docs(channels/feishu) routing fallback clarification | ✅ PR 已创建 (#55013) | 等 review |
| P4 | Review #55153 (Kimi malformed-args fix) | ✅ Approve ✅ 已发 review | 等 author 回复 |
| P5 | Review #55137 (ACP terminal ANSI stripping) | ✅ Approve+question ✅ 已发 review | 等 author 确认 sanitize 不一致问题 |
| P6 | Review #55466 (Feishu CardKit streaming card 文本读取) | ✅ 已确认 author 修复 ✅ Approve+已确认 | ✅ PR 可 merge,等 CI 通过 |
| P7 | 研究 #55792(网关重启后消息丢失) | 🔍 新发现 | 高优先级用户体验问题 |
| P8 | 研究 #55811(Telegram重试日志干扰) | 🔍 新发现 | 中等优先级可用性问题 |
| P9 | 监控 #38902(HTTP 422错误) | 🔍 活跃讨论 | 高优先级,已有19评论 |
| P10 | Review #55816(pi-* 0.63.0 regression) | 🔍 新发现 | 高优先级,已有根因和修复方案 |
| P11 | 研究 #55808(WhatsApp echo loop) | 🔍 新发现 | 中等优先级,已有workaround |
| P12 | #55844 Channels not initializing on gateway startup | 🔍 新发现 | 高优先级regression,channels: {} in health |
| P13 | #55842 Gateway crash loop - RegExpCompiler OOM | 🔍 新发现 | 高优先级regression,v2026.3.13→3.24升级路径 |
| P14 | #55834 Model fallback fails when cooldown | 🔍 新发现 | 可用性问题,cooldown导致fallback失败 |
| P15 | #55829 exec tool orphaned grep processes | 🔍 新发现 | 资源泄漏,管道子进程不被回收 |
| P16 | #55825 webchat显示内部memory上下文 | 🔍 新发现 | 隐私/可用性问题,memory片段泄露到UI |
| P17 | #55813 Beta 2 broken (ENOENT /app) | 🔍 新发现 | regression,有bug标签,auto-upgrade触发 |
| P18 | #55805 plugins install npm fallback fails | 🔍 新发现 | 行为bug,clawhub失败后未fallback到npm |
| P19 | #55873 Discord health-monitor restart crash (maxAttempts=0) | 🔍 新发现 | 高优先级regression,health-monitor重启后gateway立即crash |
| P20 | #55862 Gateway stuck in retry loop after provider outage | 🔍 新发现 | 无自恢复能力,provider恢复后仍需手动重启gateway |
| P21 | #55863 plugins.entries rejects configSchema fields | 🔍 新发现 | 阻塞所有需要运行时配置的插件(如memory-qdrant) |
| P22 | #55889 AI agent sends empty {} instead of {"command": "..."} after extended session | 🔍 新发现 | 高优先级regression,长时间会话后工具调用失败 |
| P23 | #55907 Bug: `openclaw config set` wraps negative number keys in extra quotes | 🔍 新发现 | CLI bug,影响Telegram supergroup ID配置 |
| P24 | #55903 Telegram: message tool fails file attachment with incorrect 'buttons' validation error | 🔍 新发现 | Telegram bug,文件附件功能被错误阻止 |
| P25 | #55887 Discord: before_dispatch hook bypasses requireMention gating | 🔍 新发现 | 安全/权限问题,hook绕过mention要求检查 |
| P26 | #55900 web_fetch blocked by SSRF when proxy uses RFC 2544 fake-IP | 🔍 新发现 | 可用性问题,代理场景下web_fetch被错误阻止 |
| P27 | #55890 autoThreadName config not recognized despite being in release notes | 🔍 新发现 | 配置schema问题,功能已宣布但不被识别 |
| P28 | #55942 NVIDIA NIM Kimi 2.5 tool execution completely broken in OpenClaw > 2026.2.25 | 🔍 新发现 | 高优先级regression,影响NVIDIA NIM用户,有明确版本范围 |
| P29 | #55938 Browser relay 18792 returns 502 even when browser status is running=true | 🔍 新发现 | 高优先级可用性问题,影响macOS用户的浏览器功能 |
| P30 | #55943 subagent sessions don't trigger session-memory hook | 🔍 新发现 | 功能缺失,子代理记忆文件不生成 |
| P31 | #55941 Auth profile cooldown blocks model fallback - Sonnet blocked by Opus rate limit | 🔍 新发现 | 高优先级可用性问题,模型回退链失效 |
| P32 | #55931 sessions_spawn creates subagent with sourceChannel = "webchat" instead of original message channel | 🔍 新发现 | 高优先级路由问题,影响多频道部署的消息路由 |
| P33 | #55930 Empty Parameter Tool Calling Failure | 🔍 新发现 | 高优先级可用性问题,Agent反复使用空参数调用工具 |
| P34 | #55929 session-memory hook not loading: hooks.internal.enabled defaults to undefined | 🔍 新发现 | 中等优先级,内置hook加载问题 |
| P35 | #55981 sessions_send announce step posts to wrong chat in multi-agent setup | 🔍 新发现 | 高优先级隐私/UX问题,多代理架构中消息路由错误 |
| P36 | #55976 message tool schema: buttons incorrectly marked as required for all actions | 🔍 新发现 | 高优先级regression,schema验证问题,之前修复尝试#54981和#55804被关闭 |
| P37 | #55969 Image tool error: No media-understanding provider registered for openrouter | 🔍 新发现 | 中等优先级可用性问题,图像分析功能失败 |
| P38 | #55966 Telegram inbound media ENOSPC leaves zero-byte voice file and later crashes transcription with EOF | 🔍 新发现 | 中等优先级bug,磁盘空间不足处理不当 |
| P39 | #55964 Telegram replies intent text but does not execute tools on 2026.3.24 | 🔍 新发现 | 高优先级bug,Telegram工具执行完全失败 |
| P40 | #55963 session-memory hook: UTC date in filename + subagent_ended not handled | 🔍 新发现 | 中等优先级bug,时区和子代理事件处理问题 |
| P41 | #55956 Voice Call Plugin: Telnyx transcription field mapping is wrong | 🔍 新发现 | 中等优先级bug,语音转录字段映射错误 |
| P42 | #55954 Feature: agent-optimized CLI mode for programmatic/tool calls | 🔍 新发现 | 低优先级功能请求,CLI优化 |
| P43 | #55919 Anthropic 429 'Extra usage required for long context' misclassified as transient rate limit | 🔍 新发现 | 高优先级可用性问题,错误分类导致用户得到错误建议 |
| P44 | [#56173](https://github.com/openclaw/openclaw/issues/56173) 严重安全漏洞:/pair approve绕过admin scope guard | ✅ GHSA已提交 (2026-03-28) | CVSS 9.9/10.0,Critical severity;根因:`approveDevicePairing()`依赖`options?.callerScopes`,plugin command path未传入`ctx.gatewayClientScopes`;有`operator.pairing`无`operator.admin`者可提权;aoao验证通过,security advisory已由范总通过GitHub PVR渠道提交;等待maintainer私下联系;⚠️ PR #56234**不覆盖**此漏洞(#56234仅修复audit检查,fix仍待确认) |
| P45 | #55994 weixin通道regression:message action=send被误判为poll | 🔒 代码不可见 | bug+regression标签,Beta release blocker;⚠️ weixin插件代码不在公共仓库,无法定位根因;错误来自`message-action-runner.ts`的`enforcePollParamsPresence()`,但weixin插件本身未找到;建议从openclaw-weixin私有插件仓库继续调查 |
| P46 | #55993 功能请求:Include sessionKey和metadata在session log文件头 | 🔍 新发现 | 中等优先级,改善session日志可追溯性 |
| P47 | #56010 Telegram voice notes are not transcribed; inbound message arrives only as <media:audio> | 🔍 新发现 | 高优先级regression,Telegram语音消息转录功能失效 |
| P48 | #56032 Subagent completion replies silently fail to deliver to Telegram group chats | 🔍 新发现 | 高优先级bug,子代理完成消息无法发送到Telegram群聊 |
| P49 | #56033 plugins uninstall does not remove channels.<pluginId> config | 🔍 新发现 | 中等优先级bug,插件卸载后配置残留 |
| P50 | #56027 Plugin hot-reload clobbers tool send channel registry | 🔍 新发现 | 高优先级bug,插件热重载导致channel registry丢失 |
| P51 | #56029 Subagents inherit full workspace context - no way to scope what's injected | 🔍 新发现 | 高优先级可用性问题,子代理继承全部workspace文件导致token浪费 |
| P52 | #56028 fix(sessions): honor spawned tree lineage across agents | 🔍 新发现 | 中等优先级,agents+size:S标签,已有1条评论 |
| P53 | #56030 fix(discord): restore uploadUrlRequest arg to RateLimitError in voice-message | 🔍 新发现 | 低优先级,channel:discord+size:XS标签,已有1条评论 |
| P54 | #56031 fix(pi-runner): use post-hook assistant for expect-final payloads | 🔍 新发现 | 中等优先级,agents+size:S标签,已有1条评论 |
| P55 | #56034 Session maintenance prunes active/running sessions | 🔍 新发现 | 高优先级bug,会话维护错误地清理活跃会话 |
| P56 | #56035 macOS companion app forces Remote mode on first launch when local CLI gateway is running | 🔍 新发现 | 中等优先级,macOS用户体验问题 |
| P57 | #56036 fix: inject context.agentId into toToolDefinitions hook dispatch | 🔍 新发现 | 中等优先级,agents+size:XS标签,已有1条评论 |
| P58 | #56038 [Feature Request]: 微信渠道支持发送TTS语音消息为原生语音条 | 🔍 新发现 | 低优先级功能请求 |
| P59 | #56039 message tool: buttons field incorrectly marked as required in tool schema when Telegram inlineButtons capability is enabled | 🔍 新发现 | 高优先级bug,schema验证问题 |
| P60 | #56040 msteams: Teams streaming protocol causes lost messages with tool-using agents | 🔍 新发现 | 高优先级bug,Teams流式协议导致消息丢失 |
| P61 | #56041 msteams: blockStreaming config has no effect (onBlockReply not wired) | 🔍 新发现 | 中等优先级bug,配置无效 |
| P62 | #56043 docs(nextcloud-talk): document required response feature | 🔍 新发现 | 低优先级,docs+channel:nextcloud-talk+size:XS标签,已有1条评论 |
| P63 | #56044 Recent update broke /stop and interrupt behavior - collect mode swallows user messages | 🔍 新发现 | 高优先级regression,/stop和中断功能失效 |
| P64 | #56045 Cron job output continues to be delivered after jobs are deleted; persists with zero active jobs | 🔍 新发现 | 高优先级bug,cron作业删除后仍持续交付 |
| P325 | #58739 Exec approvals UI toggle ignored after 2026.3.31 | 🔍 新发现(方向1 GitHub) | 高优先级 regression,exec approvals/allow-always 持久化失效,Slack exec 被阻塞 |
| P326 | #58738 ClawBot 微信服务号无响应,已扫码绑定但收发消息失败 | 🔒 代码不可见(方向4 插件) | weixin 相关回归,v2026.3.31 后绑定成功但消息不收发 |
| P327 | 方向2 InStreet 社区 | 无 | 本轮抓到的仍是 Skill/API 文档,不是 OpenClaw 用户实战讨论 |
| P328 | 方向3 Discord / GitHub Discussions | 无 | Discord 公共频道不可直接抓取;fallback 后本轮无新的可行动讨论 |
| P329 | 方向4 插件方向补充 | 无 | 除 #58738 外,本轮未见新的公开 plugin/weixin 候选;weixin 代码仍不可见 |
| P330 | 2026-04-02 08:03 GitHub 扫描 | 无 | 受限于 GitHub 未登录页与 gh CLI 审批限制,本轮未可靠抓到最近 2 小时新增且未追踪的 open issue/PR;已对照当前追踪项,暂不新增候选 |
| P331 | 2026-04-02 08:03 InStreet 扫描 | 无 | `https://instreet.coze.site/skill.md` 当前仍是 InStreet Agent Skill/API 文档,不是 OpenClaw 用户讨论区;未发现可转 GitHub issue 的实战问题 |
| P332 | 2026-04-02 08:03 Discord / Discussions 扫描 | 无 | Discord invite 页面仅能抓到服务器标题,无法读取 #bugs/#help/#beta-releases;fallback 到 GitHub Discussions 仍为 404,本轮无新增讨论 |
| P333 | 2026-04-02 08:03 插件方向扫描 | 无 | 公开可抓取结果里未发现最近 2 小时新增的 plugin/weixin 候选;weixin 代码仍不可见,已有项继续以 #55994/#58738 为主 |
| P334 | 2026-04-05 13:00 UTC GitHub 扫描 | 方向1 | 新候选10+;重点:#61336(feishu_doc write XS),#61338(skills macOS detection XS),#61340(secrets persistence S),#61343(cron duplicate execution S),#61339(Windows token regression Critical) |
| P335 | 2026-04-05 13:00 UTC InStreet 扫描 | 方向2 | 无—instreet.coze.site/skill.md 是 Agent API 文档,非用户讨论 |
| P336 | 2026-04-05 13:00 UTC Discord 扫描 | 方向3 | 无—Discord 需要登录;GitHub discussions 已关闭(410);已用 GitHub issues 替代覆盖 |
| P337 | 2026-04-05 13:00 UTC 插件扫描 | 方向4 | 无—openclaw/openclaw-weixin 不存在公开 repo;已用主仓库 issues 替代 |
| P65 | #56046 Signal channel: message tool action=send fails with 'Outbound not configured for channel: signal' | 🔍 新发现 | 高优先级bug,Signal通道发送功能失败 |
| P66 | #58290 Discord bot never reaches ready state | 🔍 新发现(方向1) | 严重bug,bot卡在awaiting gateway readiness |
| P67 | #58286 供应链安全漏洞 | 🔍 新发现(方向1) | build-time plugin deps绕过lockfile易受攻击 |
| P66 | #56047 Feature: expose Anthropic unified rate-limit headers in session status / API | 🔍 新发现 | 低优先级功能请求 |
| P67 | #56048 fix(xai): move bundled provider to Responses and add x_search | 🔍 新发现 | 高优先级,docs+cli+commands+agents+maintainer+size:XL标签 |
| P68 | #56021 github-copilot OpenAI Responses replay can emit orphan function_call_output | 🔍 新发现 | 中等优先级bug,GitHub Copilot回复重放导致工具ID格式错误 |
| P69 | #56017 feat(i18n): add Simplified Chinese (zh-CN) localization | 💡 新功能 | XL size feature,添加简体中文本地化 |
| P70 | #56063 Heartbeat delivery to Feishu fails | 🔍 新发现 | 高优先级,Feishu心跳功能不可用 |
| P71 | #56061 Telegram long-poll hangs indefinitely on dead TCP socket | 🔍 新发现 | 高优先级,Telegram连接可靠性问题 |
| P72 | #56058 agents.defaults.model.fallbacks not used on Anthropic 529 overload_error | 🔍 新发现 | 高优先级,模型回退链失效 |
| P73 | #56057 Channel WebSocket abnormal closure crashes entire gateway process | 🔍 新发现 | 高优先级,gateway稳定性问题 |
| P74 | #56054 WhatsApp Baileys: perpetual status 499 reconnection loop | 🔍 新发现 | 高优先级,WhatsApp连接稳定性问题 |
| P75 | #56053 Model fallback chain does not trigger on HTTP 402 | 🔍 新发现 | 高优先级,模型回退链失效 |
| P76 | #56052 Unable to pair telegram channel | 🔍 新发现 | 高优先级regression,影响新用户设置 |
| P77 | #56049 Heartbeat handler re-triggers on subagent auto-announcement events | 🔍 新发现 | 高优先级,心跳系统问题 |
| P78 | #56045 Cron job output continues after deletion | 🔍 新发现 | 高优先级,cron系统稳定性问题 |
| P79 | #56044 Recent update broke /stop and interrupt behavior | 🔍 新发现 | 高优先级regression,影响核心交互功能 |
| P80 | #56040 msteams streaming protocol causes lost messages | 🔍 新发现 | 高优先级,消息完整性受损 |
| P81 | #55282 Slack Socket Mode regression | 🔍 新发现 | 高优先级regression,Slack功能问题 |
| P82 | #54931 Discord health-monitor crash loop | 🔍 新发现 | 高优先级regression,Discord稳定性问题 |
| P83 | #54688 kimi-coding/kimi-k2.5 tool calling broken | 🔍 新发现 | 高优先级regression,Kimi工具调用失效 |
| P84 | #59027 Bundled plugins telegram and amazon-bedrock fail to load after 2026.3.31 | 🔍 新发现(方向4/插件) | 高优先级打包/运行时回归;bundled plugin 缺少 grammy / @aws-sdk/client-bedrock 依赖,升级后直接加载失败 |
| P85 | #57950 browser.request missing at runtime even though browser plugin is loaded | 🔍 新发现(方向1/GitHub) | 高优先级可用性问题;browser plugin 已加载但 gateway 未暴露 browser.request,CLI/browser 功能整体不可用 |
| P86 | #58356 system.run.prepare broken after update to 2026.3.28 | 🔍 新发现(方向1/GitHub) | 高优先级节点执行回归;paired macOS node 的 exec/system.run 能力升级后消失,降级也无法恢复 |
| P87 | 方向2 InStreet 社区 | 无 | 本轮抓取到 skill.md 规范文档更新,未发现新的真实用户故障讨论或未提 issue 的实战问题 |
| P88 | 方向3 Discord / GitHub Discussions | 无 | Discord 公共内容不可直接抓取,GitHub Discussions 返回 404,本轮无新增可行动讨论 |
| P84 | #59018 TUI session resets spontaneously, loses context and switches agent | 🔍 新发现(方向1 GitHub) | 高优先级回归,直接摧毁长会话上下文,刚发布,值得优先确认是否与 2026.4.1 会话生命周期/agent 切换逻辑有关 |
| P85 | #59017 2026.4.1 silently sandboxes all skills, breaks 35+ skills | 🔍 新发现(方向1 GitHub) | 高优先级回归/可用性灾难,影响面极广;偏向默认配置/迁移路径设计问题 |
| P86 | InStreet:无新实战问题 | i️ 无(方向2 InStreet) | 本次抓到的是 skill/API 文档,不是社区讨论;暂无可转 GitHub issue 的新用户问题 |
| P87 | Discord:改扫 GitHub discussions 仍无 | i️ 无(方向3 Discord/Discussions) | Discord 频道无法直接抓取,GitHub Discussions 返回 404,本轮无新增外部讨论线索 |
| P88 | 插件方向:本轮无新的 plugin/weixin 候选 | i️ 无(方向4 插件) | plugin label 近 2 小时为 0;weixin 相关搜索未见新的近2小时候选,代码仍不可见 |
| P84 | #53204 sessions_send announce retry blocks agent session | 🔍 新发现 | 高优先级,会话阻塞问题 |
| P85 | #50111 Discord native slash commands respond 'Done' instead of executing | 🔍 新发现 | 高优先级,Discord命令功能问题 |
| P86 | #45963 exec bypasses approval flow security issue | 🔍 新发现 | 高优先级安全漏洞 |
| P87 | #56064 fix: use American English spelling in code comments | 🔍 新发现 | channel:telegram+app:web-ui+gateway+agents+size:XS |
| P88 | #56060 feat(telegram): add child thread-binding placement via createForumTopic | 🔍 新发现 | channel:telegram+size:S |
| P89 | #56050 feat(plugins): add before_skill_install hook for external security scanners | 🔍 新发现 | agents+maintainer+size:M |
| P90 | #56048 fix(xai): move bundled provider to Responses and add x_search | 🔍 新发现 | docs+cli+commands+agents+maintainer+size:XL |
| P91 | #56043 docs(nextcloud-talk): document required response feature | 🔍 新发现 | docs+channel:nextcloud-talk+size:XS |
| P92 | #56036 fix: inject context.agentId into toToolDefinitions hook dispatch | 🔍 新发现 | agents+size:XS |
| P93 | #56031 fix(pi-runner): use post-hook assistant for expect-final payloads | 🔍 新发现 | agents+size:S |
| P94 | #56030 fix(discord): restore uploadUrlRequest arg to RateLimitError | 🔍 新发现 | channel:discord+size:XS |
| P95 | #56028 fix(sessions): honor spawned tree lineage across agents | 🔍 新发现 | agents+size:S |
| P96 | #56071 fix(msteams): reset stream state after tool calls to prevent message loss | 🔍 新发现 | 高优先级,msteams消息完整性修复 |
| P97 | #55967 feat(plugins): add api.runtime.agent.abort for aborting agent runs | 🔍 新发现 | 高优先级,插件API增强 |
| P98 | #56076 fix(matrix): align outbound direct-room selection | 🔍 新发现 | 中等优先级,Matrix修复 |
| P99 | #56074 Bug: Feishu heartbeat target ID incorrectly resolves to string 'heartbeat' instead of open_id | 🔍 新发现 | 高优先级,Feishu心跳功能问题 |
| P100 | #52770 fix(gateway): guard getRuntimeSnapshot() and preserve probe intent in health refresh | 🔍 新发现 | 中等优先级,gateway稳定性 |
| P101 | #56072 Daily session reset silently discards context without memory flush or compaction | 🔍 新发现 | 高优先级,上下文管理问题 |
| P102 | #46737 feat(slack): add Block Kit table block support for markdown tables | 🔍 新发现 | 中等优先级,Slack功能增强 |
| P103 | #56077 fix(diffs): stage bundled runtime deps after updates | 🔍 新发现 | 中等优先级,技术修复 |
| P104 | #58990 Feishu channel 长任务零反馈 / 无typing / 无进度提示 | 🔍 新发现(方向1) | 高优先级可用性问题,用户长时间无感知,且提到 Feishu DM 复用旧 session 上下文 |
| P105 | #58985 Web chat 图片上传/识别在 v2026.3.31 回归损坏 | 🔍 新发现(方向1) | 高优先级 regression,v2026.3.28 正常、v2026.3.31 失效,日志指向 bundled plugin public surface 解析错误 |
| P106 | InStreet:本轮无新实战问题 | i️ 扫描完成(方向2) | `https://instreet.coze.site/skill.md` 当前仅见 Skill/API 文档与流程说明,未见可追踪的真实用户讨论;暂不新增 issue 候选 |
| P107 | Discord:本轮无新讨论 | i️ 扫描完成(方向3) | Discord invite 页面可访问但频道内容不可抓取;fallback 到 GitHub discussions 也未发现可用讨论入口,暂记无 |
| P108 | 插件方向:本轮无新增公开 issue | i️ 扫描完成(方向4) | `openclaw-weixin` 公开 issue/API 未检出可访问的新条目;已追踪 weixin 相关项仍为 #55994(代码不可见) |
| P104 | #40377 feat(continuity): harden adaptive reply threading and subagent delivery continuity | 🔍 新发现 | 中等优先级,可用性改进 |
| P105 | #51523 feat(matrix): add subagent hooks for ACP room-binding | 🔍 新发现 | 中等优先级,Matrix功能增强 |
| P106 | #49529 Add configurable Gemini safety settings for Google provider | 🔍 新发现 | 中等优先级,模型安全性配置 |
| P107 | #56095 Feishu plugin registered 4 times on every Gateway startup | 🔍 新发现 | 性能问题,Feishu插件重复注册影响启动时间 |
| P108 | #56089 Baileys WhatsApp Web outbound sends fail with "No active WhatsApp Web listener" despite linked/connected status | 🔍 新发现 | 高优先级regression,WhatsApp Web出站发送功能失效 |
| P109 | #56087 Unknown error message with multiple mac profiles | 🔍 新发现 | bug+bug:crash标签,可能影响macOS用户 |
| P110 | #56078 Cron Job Output Not Saved in OpenClaw 2026.3.24 | 🔍 新发现 | bug+regression标签,cron输出保存问题,与#56045相关 |
| P111 | #56086 Discord health-monitor triggers full gateway restart instead of surgical reconnect | 🔍 新发现 | 高优先级稳定性问题,Discord健康监测导致频繁完整重启 |
| P112 | #56079 restart can persist mismatched sessionId/sessionFile for main session, breaking webchat history | 🔍 新发现 | 会话管理问题,影响webchat历史功能 |
| P113 | #56091 Telnyx outbound conversation calls: events skipped as replays, no STT, custom voice ID ignored | 🔍 新发现 | 语音功能完全失效,Telnyx出站通话问题 |
| P114 | #56071 fix(msteams): reset stream state after tool calls to prevent message loss | 🔍 新发现 | 高优先级,msteams消息完整性修复PR |
| P115 | #55967 feat(plugins): add api.runtime.agent.abort for aborting agent runs | 🔍 新发现 | 高优先级,插件API增强PR |
| P116 | #56074 Feishu heartbeat target ID incorrectly resolves to string 'heartbeat' instead of open_id | 🔍 新发现 | 高优先级,Feishu心跳功能问题 |
| P117 | #56072 Daily session reset silently discards context without memory flush or compaction | 🔍 新发现 | 高优先级,上下文管理问题 |
| P118 | #56112 Provider-level cooldown still blocks healthy models within same provider (Anthropic Opus outage skips Sonnet) | 🔍 新发现 | 高优先级可用性问题,provider级别cooldown阻止健康模型 |
| P119 | #56111 Feature Request: Post-compaction system event hook for automatic state recovery | 🔍 新发现 | 中等优先级功能请求,改善上下文压缩后状态恢复 |
| P120 | #56109 tool-shell PATH can diverge from login shell, causing wrong/missing openclaw binary | 🔍 新发现 | 高优先级bug,工具shell PATH解析不一致 |
| P121 | #56108 Microsoft Teams channel crashes on startup in OpenClaw 2026.3.24 | 🔍 新发现 | 高优先级regression,Teams通道启动崩溃 |
| P122 | #56106 Transcript JSONL encoding corrupted on Windows (GBK/UTF-8 mix) | 🔍 新发现 | 高优先级Windows bug,中文编码损坏 |
| P123 | #56105 streaming: "partial" drops text when reply contains MEDIA + text in Telegram forum topics | 🔍 新发现 | 中等优先级bug,Telegram论坛话题流式文本丢失 |
| P124 | #56102 ACP server rejects MCP protocolVersion: 2025-11-25 from VS Code 1.113 / Cursor | 🔍 新发现 | 高优先级regression,VS Code/Cursor连接失败 |
| P125 | #56100 Feature Request: Memory System Initialization for Ephemeral A2A Sessions | 🔍 新发现 | 中等优先级功能请求,A2A会话内存初始化 |
| P126 | #56097 feat: Add Tavily Crawl, Map, and Research API support | 🔍 新发现 | 中等优先级功能请求,Tavily API支持 |
| P127 | #56096 Bug: Telegram sendChatAction infinite retry loop with no backoff | ✅ 处理中 | 高优先级bug,已有用户提交修复commit `fd7598898` |
| P128 | #56095 Feishu plugin registered 4 times on every Gateway startup | 🔍 新发现 | 性能问题,Feishu插件重复注册 |
| P129 | #56094 [Feature]: Silent Agent Helpdesk Runtime | 🔍 新发现 | 中等优先级功能请求,静默帮助台运行时 |
| P130 | #56093 Model switch confirmation shows misleading warning when override is applied | 🔍 新发现 | 中等优先级bug,模型切换确认警告误导性 |
| P131 | #56091 Telnyx outbound conversation calls: events skipped as replays, no STT, custom voice ID ignored | 🔍 新发现 | 高优先级,Telnyx语音功能问题 |
| P132 | #56089 Baileys WhatsApp Web outbound sends fail with "No active WhatsApp Web listener" | 🔍 新发现 | 高优先级regression,WhatsApp Web出站发送失败 |
| P133 | #56087 Unknown error message with multiple mac profiles | 🔍 新发现 | bug+bug:crash标签,macOS配置文件错误 |
| P134 | #56086 Discord health-monitor triggers full gateway restart instead of surgical reconnect | 🔍 新发现 | 高优先级稳定性问题,Discord健康监测导致完整重启 |
| P135 | #56079 restart can persist mismatched sessionId/sessionFile for main session | 🔍 新发现 | 会话管理问题,webchat历史功能受影响 |
| P136 | #56078 Cron Job Output Not Saved in OpenClaw 2026.3.24 | 🔍 新发现 | bug+regression标签,cron输出保存问题 |
| P137 | #56127 [Bug]: WhatsApp plugin runtime is unavailable: missing light-runtime-api for plugin 'whatsapp' | 🔍 新发现 | 高优先级regression,WhatsApp插件自动加载导致agent崩溃,即使未配置WhatsApp |
| P138 | #56124 Audio preflight transcription not triggering in mention-gated Telegram groups | 🔍 新发现 | 高优先级bug,Telegram群组中语音消息预转录功能失效,影响mention检测 |
| P139 | #56118 Node browser proxy: Chrome MCP existing-session fails with Connection closed - consent dialog never appears | 🔍 新发现 | 高优先级,node浏览器代理功能问题,Chrome MCP连接失败 |
| P140 | #56117 [Bug]: Feishu push messages display literal 'NO_REPLY' text when no reply context exists | 🔍 新发现 | 高优先级bug,Feishu推送消息显示字面'NO_REPLY'文本,影响用户体验 |
| P141 | #56114 Feishu plugin tools re-register repeatedly on config hot-reload | 🔍 新发现 | 高优先级bug+bug:behavior,Feishu插件工具在配置热重载时重复注册 |
| P142 | #56121 Cron sessions stuck in status=running after completion | 🔍 新发现 | 高优先级bug,cron会话在完成后仍停留在running状态 |
| P143 | #56119 Fix/webchat session isolation | 🔍 新发现 | 中等优先级,app:web-ui+gateway+size:S标签,webchat会话隔离修复 |
| P144 | #56128 fix(gateway): use agent workspace dir in session transcript cwd | 🔍 新发现 | 中等优先级,gateway+size:L标签,gateway修复 |
| P145 | #56092 fix: route system-event-triggered heartbeats to configured session | 🔍 新发现 | 中等优先级,size:L标签,系统事件触发的心跳路由修复 |
| P146 | #56126 Feature: Batch API support for non-urgent cron jobs (50% cost reduction) | 🔍 新发现 | 低优先级功能请求,批量API支持非紧急cron作业 |
| P147 | #56125 Feature: Per-task model routing (route simple tasks to cheaper models) | 🔍 新发现 | 低优先级功能请求,按任务模型路由 |
| P148 | #56123 feat: add pluggable compaction provider registry | 🔍 新发现 | 中等优先级,docs+gateway+extensions:lobster+agents+size:S,可插拔压缩provider注册表 |
| P149 | #56116 Improve Feishu streaming visibility and filter scratchpad text | 🔍 新发现 | 中等优先级,channel:feishu+size:M,改进Feishu流式可见性和过滤草稿文本 |
| P150 | #56115 Feature request: Announce-mode prompt guard for cron jobs | 🔍 新发现 | 低优先级功能请求,cron作业的宣告模式提示保护 |
| P151 | #56127 **P0** WhatsApp regression:插件未配置也加载,导致所有消息路由 crash(v2026.3.24)| 🔍 新发现 | ⚠️ P0/严重regression,未配置WhatsApp也会加载崩溃,能本地复现 |
| P152 | #56142 **P1** Slack block_actions 按钮无法 wake session(根因已定位,Telegram 有对比参考)| 🔍 新发现 | 高优先级,Telegram 有类似修复可参照 |
| P153 | #56143 **P1** Discord ACP thread-bound sessions 完成时 threadId 丢失,completion 错路由到 Telegram | 🔍 新发现 | 高优先级,跨平台 thread 路由 bug |
| P154 | #56137 **P1** Gateway config reload 时 crash - onAbort 未 catch Max reconnect attempts (0) error | 🔍 新发现 | 高优先级,配置热重载 regression |
| P155 | #56131 **P2** session reset archives 无法被 sessions_history 发现,context recovery 失效 | 🔍 新发现 | 中等优先级,session 上下文恢复功能失效 |
| P156 | #56219 **P1** Telegram plugin fails to load after upgrade to 2026.3.27 | 🔍 新发现 | regression+bug,升级到2026.3.27后Telegram通道加载失败 |
| P157 | #56208 **P1** plugin tools unavailable in sub-agent sessions due to lifecycle ordering | 🔍 新发现 | regression+bug,subagent中plugin工具不可用,与我们multi-agent协作直接相关 |
| P158 | #56215 **P2** WebSocket connections leak - CLOSE_WAIT/FIN_WAIT_2 zombie connections | 🔍 新发现 | 资源泄漏,gateway WebSocket连接泄漏 |
| P159 | #56226 **P2** hooks.mappings[].channel rejects valid runtime channel plugins like feishu | 🔍 新发现 | bug:behavior,hooks配置拒绝有效的运行时插件 |
| P160 | #56227 **P2** Gateway restart failure should keep previous instance running | 🔍 新发现 | usability gap,gateway重启失败时应有保底机制 |
| P161 | [PR #56234](https://github.com/openclaw/openclaw/pull/56234) review | ✅ Done | 修复 #55612/#55578,新增 security audit 两种 CRITICAL 场景检查(dmPolicy=open + session.dmScope=main multi-user);**不覆盖 #56173**(GHSA是plugin auth bypass,需代码修复而非audit检查增强);可在GHSA备注"被#56234覆盖了#55612/#55578" |
| P162 | [PR #56203](https://github.com/openclaw/openclaw/pull/56203) review | ✅ Done | 修复 sessions_send 同时传 sessionKey+label 时直接报错(业务逻辑 bug,+47/-7);**不等同于解决我们的超时问题**--超时是另一类问题(可能是 RPC timeout 或 #53204 announce retry 阻塞);两个需分开追踪 |
| P163 | PR #56203 & #56234 & #56247 人为评论 | ✅ Done (2026-03-28 15:13) | 为 #56203 和 #56247 各发了一条有价值的人为评论;为 #56247(hooks.mappings[].channel schema问题)也发了支持评论 |
| P164 | PR #56247 支持 | ✅ Done | hooks.mappings[].channel 拒绝 feishu 插件ID的 schema 问题,影响我们 Feishu 路由配置;+3/-8行,runtime validation 兜底 |
| P165 | PR #56244 支持 | ✅ Done | 修复 #56114(Feishu工具热重载重复注册),1文件4行,模块级boolean guard;#56114 已在P114追踪 |
| P166 | PR #56204 支持 | ✅ Done | 修复 #55816(pi-* 0.63.0 getApiKey callback被streamFn覆盖丢弃),+14/-0;#55816 已在P57追踪 |
| P167 | PR #56250 支持 | ✅ Done | 修复 #55929(hooks.internal.enabled默认为undefined导致session-memory hook不加载),4文件5行;#55929 已在P34追踪 |
| P168 | #56347 **P1** Subagent announce delivery fails with 'Outbound not configured for channel' on Telegram | 🔍 新发现 | bug,plugin registry mismatch(pinned vs active),影响 subagent completion 交付;根因:`createChannelRegistryLoader` 应使用 pinned registry |
| P169 | #56326 **P1** sessions_spawn exposes ACP-only fields and breaks runtime=subagent | 🔍 新发现 | bug,PR #56342 已修复中;影响 subagent spawning |
| P170 | #56338 **P2** Feishu requireMention=false is invalid(仍需 @bot)| 🔍 新发现 | regression+bug,requireMention=false 配置无效 |
| P171 | #56341 **P2** message_sent typed hook not firing for Telegram delivery(v2026.3.24)| 🔍 新发现 | bug,message_sent hook 不触发,hooks 功能失效 |
| P172 | [#57157](https://github.com/openclaw/openclaw/issues/57157) `/summary` 命令硬编码 qwen3.3-30B | 🔍 新发现 | bug:默认模型写死在`src/cmds/summary.ts`,不读config;建议改为读`agentConfig.model`或更通用的云端模型;⚠️ 注意:aoao收到的任务是"weixin regression"但实际#57157是summary bug,已更正 |
| P180 | [#57188](https://github.com/openclaw/openclaw/issues/57188) **P0** 2026.3.28 更新后 Linux VPS systemd 环境 gateway 完全崩溃 | 🔍 新发现 | regression:更新后 `openclaw gateway install` 失败(systemctl --user 在 root-level systemd 下不可用),`doctor --repair` 无法恢复,必须快照回滚;完整 outage,影响所有 channel;根因疑似 #56772/#57023 |
| P181 | [#57186](https://github.com/openclaw/openclaw/issues/57186) voice-call 工具/CLI EADDRINUSE port 3334 | 🔍 新发现 | bug:gateway 启动时已占用 3334 端口,voice_call 工具再次尝试绑定同一端口导致冲突;建议复用 gateway 现有 webhook server;workaround:直接调用 Twilio REST API 但会丢失 conversation loop |
| P173 | #57321 **P0** Matrix delivery-recovery crash(永久性消息丢失)| 🔍 新发现 | bug+crash+data loss:Session keys normalize room IDs to lowercase,delivery-recovery 使用小写 ID 重试导致 403,sync loop crash;Matrix channel 完全失效;可修性 M |
| P174 | #57303 **P0** Kubernetes gateway OOM regression | 🔍 新发现 | bug+regression+OOM:2026.3.28 在 Kubernetes 部署中 Node/V8 heap OOM,阻止升级;可修性 M |
| P175 | #57333 **P1** Webchat 消息路由错误 | 🔍 新发现 | bug:Webchat 消息被路由到活跃的 subagent 而不是 main session;可修性 M |
| P176 | #57306 **P1** sessions_spawn model 参数失效 | 🔍 新发现 | bug:model 参数触发生模型切换错误而不是设置初始模型;可修性 M |
| P177 | #57291 **P1** Discord reconnect crash | 🔍 新发现 | bug:maxAttempts=0 导致 "Max reconnect attempts (0) reached after code 1005";可修性 S |
| P178 | #56960 **P1** openai-codex refresh_token_reused loop | 🔍 新发现 | bug:refresh_token_reused 错误导致每 30-90 秒重试,event loop blockage;可修性 M |
| P179 | #57349 **P0** Heap exhaustion after extended uptime(OOM during filesystem scan)| 🔍 新发现 | bug:Gateway 运行 ~17-20 小时后 heap 增长到 ~4GB OOM,崩溃在 `AfterScanDir` webchat UI 打开时加速;可修性 M |
| P180 | #57334 **P1** Memory-core session indexer skips .jsonl.reset/.jsonl.deleted files | 🔍 新发现 | bug+regression:只有 211/485 个 session 文件被索引,主会话全被排除;可修性 S;相关 PR #57341 |
| P181 | #57353 **P1** SSH commands SIGKILL'd when stdout exceeds ~1.2KB burst | 🔍 新发现 | bug:SSH 输出 burst >1.2KB 时 pipe 填充比 drain 快,session watchdog 杀进程;可修性 M |
| P182 | #57348 **P2** VS Code ACP prompts hang with OpenClaw on Windows | 🔍 新发现 | bug:WebSocket 连接失败,HTTP fallback 后仍然挂起;可修性 M;相关 #55523 |
| P183 | #57339 **P2** Telegram plugin approval buttons don't work | 🔍 新发现 | bug:TelegramExecApprovalHandler 只处理 exec.approval,忽略 plugin.approval;可修性 M;相关 PR #57340 |
| P184 | #57391 **P0** Infinite crash loop(unrecognized key in openclaw.json causes infinite gateway crash loop)| 🔍 新发现 | P0:openclaw.json 中未知 key 导致 gateway 无限崩溃循环,无恢复机制;需立即调查 |
| P185 | #57386 **P1** Google Chat regression(webhook 401 Unauthorized 2026.3.23+)| 🔍 新发现 | Google Chat webhook 所有版本返回 401 |
| P186 | #57461 MCP tools return data in structuredContent only - Cursor and Claude.ai only read content | 🔍 新发现 | 高优先级可用性问题,影响MCP客户端 |
| P187 | #57471 runWithModelFallback() treats LiveSessionModelSwitchError as candidate_failed, causing unnecessary fallback chain | 🔍 新发现 | 中等优先级bug,模型回退链误判错误错误类型 |
| P188 | #57501 isolated session 模型切换死循环 | 🔍 新发现 | 高优先级bug;PR #57455 已覆盖类似问题 |
| P189 | #57498 Image recognition bypasses OpenRouter attribution headers | 🔍 新发现 | 高优先级bug,计费问题 |
| P190 | #57491 Cron delivery fails with 'Unknown Channel' | 🔍 新发现 | 高优先级bug,cron系统问题 |
| P191 | #57490 Cron job model override silently broken | 🔍 新发现 | 高优先级bug,cron模型覆盖问题 |
| P192 | #57489 modelByChannel override reverted by live session model switch | 🔍 新发现 | 高优先级regression,2026.3.28 |
| P193 | #57551 **P0** kimi无限递归重试(edit工具参数错误导致无限重试,token耗尽)| 🔍 新发现 | P0:edit工具参数错误导致kimi无限重试,token被耗尽 |
| P194 | #57550 **P0** HTTP API Token auth broken("missing scope: operator.write",CVE修复 collateral damage)| 🔍 新发现 | P0:2026.3.28升级后所有RESTful HTTP API集成中断 |
| P195 | #57540 **P1** Isolated cron sessions fail with LiveSessionModelSwitchError | 🔍 新发现 | cron模型切换失效 |
| P196 | #57538 **P1** claude-haiku-4-5 missing from bundled catalog(cost regression 5-6x)| 🔍 新发现 | catalog缺失导致cost regression |
| P197 | #57536 **P1** feishu tenant_access_token获取失败(返回400)| 🔍 新发现 | regression:feishu插件鉴权失败 |
| P198 | #57452 **P1** Telegram media download被SSRF guard拦截 | 🔍 新发现 | SSRF guard误拦截Telegram媒体下载 |
| P199 | #57523 **P1** Kimi k2p5 provider完全失效("Unexpected event order: message_start before message_stop")| 🔍 新发现 | Kimi chat完全不可用,所有Kimi用户受影响 |
| P200 | #57573 **P1** Kimi web search multi-turn tool calls失败(reasoning_content missing)| 🔍 新发现 | 多-turn对话中web search失败 |
| P201 | #57571 **P1** Cron isolated sessions ignore payload.model override | 🔍 新发现 | cron model参数失效 |
| P202 | #57570 **P1** openclaw config命令无响应 | 🔍 新发现 | config命令失效 |
| P203 | #57567 **P1** Configuration Migration Failure During Upgrade (v3.24 → v3.28) | 🔍 新发现 | 升级流程阻塞 |
| P227 | #57898 ARE YOU GOING TO FRIGGING KEEP BREAKING THIS THING OR WE CAN GET A STABLE VERSION??????? | 🔍 新发现 | P1(用户情绪严重,bug+regression标签,已有contributor回复询问debug信息)
| P228 | #57925 v2026.3.28: Discord extension silently skipped during gateway startup - zero channels load despite valid config | 🔍 新发现 | P1(regression,升级到2026.3.28后Discord扩展被静默跳过)
| P229 | #57920 Stale ended subagent runs persist in childSessions, ghost agents on Floor | 🔍 新发现 | P2(UI问题,子代理运行结束后在childSessions中残留)
| P230 | #57683 [Bug]: 400 gemini-2.5-pro thinking_budget to 0 | 🔍 新发现 | P1(bug+bug:behavior标签,已有2个用户确认同样的问题)
| P231 | #57918 [Bug]: Announce delivery constructs malformed recipient "group:<chatId>" for Telegram forum topic sessions | 🔍 新发现 | P1(bug+bug:behavior标签,Telegram forum topic中announce delivery格式错误)
| P232 | #57917 Control UI model switch misparses aliases like gpt-5.4 as anthropic/* | 🔍 新发现 | P3(控制UI模型切换时错误解析gpt-5.4别名)
| P233 | #57916 Subagent announce: swap dispatch order to queue-first when parent session is busy | 🔍 新发现 | P3(父会话繁忙时,子代理announce应使用队列优先调度)
| P234 | #57908 [Feature]: Allow prompt-level selection of LLM service provider | 🔍 新发现 | P3(功能请求,enhancement标签)
| P235 | #57776 [Bug]: Matrix device verification fails with "m.mismatched_sas" despite matching emoji | 🔍 新发现 | P1(bug+regression标签,Matrix设备验证失败,maintainer正在调查)
| P236 | #57907 openclaw configure --section model leaves stale claude-cli/ prefix in model config | 🔍 新发现 | P3(CLI bug,配置命令残留stale prefix)
| P237 | #57906 Model fallback retries primary too aggressively before moving to next fallback | 🔍 新发现 | P2(模型回退问题,primary重试过于激进)
| P238 | #57905 Gateway enters infinite model-switch loop when all auth profiles fail | 🔍 新发现 | P2(模型切换问题,所有auth profiles失败时进入无限循环)
| P239 | #57901 Safeguard compaction ignores compaction.model config - uses session model instead | 🔍 新发现 | P2(compaction配置问题,safeguard compaction忽略compaction.model)
| P240 | #57900 Subagent runs don't use model fallback chain on 429/rate-limit errors | 🔍 新发现 | P2(子代理模型回退问题,429/rate-limit错误时不使用fallback链)
| P241 | #57892 iMessage bridge drops inbound messages during high session lane activity | 🔍 新发现 | P2(iMessage消息丢失问题,会话繁忙时入站消息被丢弃)
| P242 | #57896 [Bug]: Gateway restart leaves stale exec config - onRestart passes activate:false to activateRuntimeSecrets | 🔍 新发现 | P2(Gateway重启后exec配置残留,activate:false传递错误)
| P243 | #57894 [Feature] Time-based session context window (send only recent N hours of conversation) | 🔍 新发现 | P3(功能请求,基于时间的会话上下文窗口)
| P244 | #57893 [Bug] Feishu slash commands not working in multi-account setup | 🔍 新发现 | P2(Feishu多账户设置下斜杠命令无法工作)
| P245 | #57890 feat(cron): add structured job-completion record to detect partial/incomplete cron cycles | 🔍 新发现 | P3(cron功能增强,结构化job-completion记录)
| P204 | #57681 **P1** Noddling forever on macOS with different providers/models | 🔍 新发现 | macOS上agent卡死问题 |
| P205 | #57678 **P2** SKILL.md frontmatter YAML parse failure silently drops skill | 🔍 新发现 | skill注册问题 |
| P206 | #57675 **P1** Telegram DM fails with deactivated_workspace on macOS | 🔍 新发现 | regression,Telegram DM功能失效 |
| P207 | #57663 **P1** MiniMax M2.7 persistent 408 timeouts not surfaced to user | 🔍 新发现 | regression,4+分钟延迟 |
| P208 | #57661 **P1** agent-to-agent session_send timeout | 🔍 新发现 | bug,与我们multi-agent协作相关 |
| P209 | #57660 **P1** Telegram polling stall detector fires too aggressively (110s) | 🔍 新发现 | bug,消息投递失败 |
| P210 | #57659 **P1** Corrupted session causes infinite WebSocket 500 retry loop | 🔍 新发现 | bug,会话数据损坏 |
| P211 | #57627 **P0** Web UI chat desynchronization - messages sent to wrong session | 🔍 新发现 | 严重bug,消息路由错误 |
| P212 | #57626 **P1** Model switch to unresponsive Ollama cascades into infinite loop | 🔍 新发现 | regression,session损坏 |
| P213 | #57620 **P1** deleteAfterRun only disables jobs, doesn't delete them | 🔍 新发现 | cron系统bug |
| P214 | #57619 **P1** Subagent/cron messages not delivered to WeChat (openclaw-weixin) | 🔍 新发现 | weixin regression |
| P215 | #57618 **P1** Mattermost config rejected after upgrade to 2026.3.28 | 🔍 新发现 | regression,schema breaking change |
| P216 | #57617 **P1** Parent session stuck after subagent prompt-error abort | 🔍 新发现 | 子代理abort后父session卡死 |
| P217 | #57613 **P1** heartbeat.model/cron --model overrides blocked | 🔍 新发现 | regression,model override失效 |
| P218 | #57606 **P1** Telegram long-poll hangs indefinitely on dead TCP socket | 🔍 新发现 | bug,连接可靠性问题 |
| P219 | #57602 **P1** Channel WebSocket abnormal closure crashes gateway | 🔍 新发现 | bug,gateway稳定性问题 |
| P220 | #57601 **P1** Cron jobs via CLI don't send scheduled messages to Telegram | 🔍 新发现 | bug,cron delivery问题 |
| P221 | #57599 **P2** skills list --json writes to stderr | 🔍 新发现 | CLI bug,已有PR #57632 修复 |
| P222 | #57594 **P2** Zalo channel rejects valid non-numeric chat_id values | 🔍 新发现 | bug,Zalo outbound失败 |
| P223 | #57589 **P2** Openclaw command shows incorrect current version | 🔍 新发现 | bug,已有PR #57665 修复 |
| P224 | #57588 **P1** Security: fetch-auth bearer token fallback attaches tokens to arbitrary URLs | 🔍 新发现 | 安全问题,缺少fail-closed默认 |
| P225 | #57586 **P2** Node system.run fails: Remote app does not advertise system.run.prepare | 🔍 新发现 | bug,Node功能问题 |
| P226 | #57581 **P1** LiveSessionModelSwitch blocks isolated cron sessions | 🔍 新发现 | bug,cron model override失效 |
| P227 | #57964 **P1** repeated characters collapse (dashboard/tui) | 🔍 新发现 | bug+regression,显示问题 |
| P228 | #57963 **P1** Cron exec timeout kills workspace backup step silently | 🔍 新发现 | bug,备份步骤被静默终止 |
| P229 | #57961 **P1** Live session model switch detector blocks programmatic fallback | 🔍 新发现 | bug,rate limits时fallback被阻塞 |
| P230 | #57956 **P1** Anthropic type: "token" auth broken in v2026.3.28 | 🔍 新发现 | bug+regression,HTTP 401错误 |
| P231 | #57950 **P0** browser.request missing at runtime despite browser plugin loaded | 🔍 新发现 | bug+bug:crash,浏览器功能完全失效 |
| P232 | #57947 **P1** Cron payload model override ignored | 🔍 新发现 | bug+regression,cron model参数失效 |
| P233 | #57945 **P1** Isolated agentTurn cron jobs fail (templates not bundled) | 🔍 新发现 | bug,npm package缺少模板 |
| P234 | #57939 **P1** Gateway default model not updated after models set + restart | 🔍 新发现 | bug,配置持久化问题 |
| P235 | #57935 **P1** Telegram incoming messages not received after gateway restart | 🔍 新发现 | regression,Telegram消息接收失效 |
| P236 | #57928 **P1** session.tool/session.message events don't carry originating sessionKey | 🔍 新发现 | bug,subagent会话追踪问题 |
| P237 | [#57989](https://github.com/openclaw/openclaw/issues/57989) Bug: WhatsApp linked device does not receive group messages | 🔍 新发现 | 高优先级,WhatsApp 群组消息失效 |
| P238 | [#57988](https://github.com/openclaw/openclaw/issues/57988) Bug: Heartbeat read tool called without path | 🔍 新发现 | 高优先级,心跳工具参数错误 |
| P239 | [#57981](https://github.com/openclaw/openclaw/issues/57981) xAI/openai-responses crashes with 422 when tool results include image blocks | 🔍 新发现 | 高优先级 regression,工具执行失败 |
| P240 | [#57975](https://github.com/openclaw/openclaw/issues/57975) Bug: The search for AI is not working | 🔍 新发现 | 高优先级,搜索功能失效 |
| P241 | [#57974](https://github.com/openclaw/openclaw/issues/57974) control-ui sessions.list polling saturates gateway | 🔍 新发现 | 高优先级,性能问题 |
| P242 | [#57973](https://github.com/openclaw/openclaw/issues/57973) Bug: edit tool 100% failure in 2026.3.30 | 🔍 新发现 | 高优先级 regression,编辑工具完全失效 |
| P243 | [#57968](https://ciw.githubusercontent.com/openclaw/openclaw/issues/57968) Cron payload.model override ignored | 🔍 新发现 | 高优先级,cron 模型覆盖失效 |
| P244 | [#58006](https://github.com/openclaw/openclaw/issues/58006) [Bug] read tool cannot read newly created files immediately after write | 🔍 新发现 | 高优先级,文件系统一致性问题 |
| P245 | [#57981](https://github.com/openclaw/openclaw/issues/57981) [Bug]: xAI/openai-responses crashes with 422 when tool results include image blocks | 🔍 新发现 | 高优先级 regression,xAI 工具调用失效 |
| P246 | [#57994](https://github.com/openclaw/openclaw/issues/57994) [Bug]: browser.request unknown method | 🔍 新发现 | 高优先级,浏览器自动化功能失效 |
| P247 | [#57973](https://github.com/openclaw/openclaw/issues/57973) [Bug]: edit tool 100% failure failure in 2026.3.30 | 🔍 新发现 | 高优先级 regression,编辑工具完全失效 |
| P248 | #58087 **P1** SecretRef-backed model provider headers regression(v2026.3.28,100% reproducible)| 🔍 新发现 | SecretRef-backed headers 发送 "secretref-managed" 而非真实值,致 401 认证失败 |
| P249 | #58084 **P1** HTTP 400 JSON schema invalid - blocks all tool use | 🔍 新发现 | 所有工具调用被阻塞,agent 无法正常运行 |
| P250 | #58085 **P1** sessions_spawn returns (allowed: none) for subagent runtime | 🔍 新发现 | 阻塞 task parallelization |
| P251 | #58083 **P1** Cron isolated jobs lose true isolation(sessionKey 泄露)| 🔍 新发现 | 模型冲突,isolated cron 会话失效 |
| P252 | #58090 **P1** openclaw doctor wipes session.resetByType config | 🔍 新发现 | 配置漂移 |
| P253 | #58095 **P1** pa-coding reactions field invalid | 🔍 新发现 | 字段名错误,easy fix |
| P254 | #58119 **P0** 微信通道每天 contextToken 过期断连,需手动重连 | 🔍 新发现 | P0:微信通道每天自动断连,contextToken过期,需手动重连;影响长期运行的微信集成 |
| P255 | #58109 **P0** v2026.3.28 - Voice transcription broken + web search config stripped on update | 🔍 新发现 | P0:regression,v2026.3.28升级后语音转录失效+web search配置被清除;严重升级阻塞 |
| P256 | #58107 **P1** Multiple Feishu group agents - only main reply delivered | 🔍 新发现 | P1:多agent部署中只有main agent回复送达,其他agent的回复被静默丢弃;regression+bug标签 |
| P257 | #58108 **P1** Third-party plugin @cc-soul/openclaw ships obfuscated code, auto-starts background daemon | 🔍 新发现 | P1:安全漏洞,第三方插件混淆代码+自动启动后台守护进程;需要安全审查 |
| P258 | #58106 **P1** OpenRouter models hidden in model picker | 🔍 新发现 | P1:PI auth discovery无法解析keyRef auth profiles,导致OpenRouter模型在模型选择器中不可见 |
| P259 | #58115 **P1** Bug: voice_call tool fails with EADDRINUSE | 🔍 新发现 | P1:voice_call工具在任何agent session调用时都因EADDRINUSE失败;端口冲突问题 |
| P260 | #58117 **P3** [Feature]: Mistral Voxtral TTS provider support | 🔍 新发现 | P3:功能请求,添加Mistral Voxtral TTS provider支持 |
| P261 | #58114 **P3** test(plugins): reset providers runtime modules per case | 🔍 新发现 | P3:测试改进,每次测试重置providers runtime modules |
| P262 | #58110 **P3** Feature Request: Multi-Agent Support with Chat-Style UI | 🔍 新发现 | P3:功能请求,支持Chat-Style UI的多代理架构 |
| P263 | #58113 **P3** Bug: memory-lancedb-pro 与 LCM 并发初始化导致事务嵌套冲突 | 🔍 新发现 | P3:LanceDB内存提供者与LCM并发初始化时事务嵌套冲突 |
| P264 | #58111 **[P3]** macOS launchd service uses hybrid node/dist paths | 🔍 新发现 | P3:从NVM切换到Homebrew后,macOS launchd服务使用混合node/dist路径 |
| P265 | #58104 **P3** [Feature]: Feishu built-in skill missing | 🔍 新发现 | P3:Feishu内置skill feishu-sheet在dist/extensions/feishu/skills/中缺失 |
| P266 | #58105 **P3** Cron: support multi-channel delivery (fanout) | 🔍 新发现 | P3:功能请求,支持cron多渠道投递(fanout模式) |
| P267 | #57490 **P1** Cron job model override silently broken by LiveSessionModelSwitchError | 🔍 新发现 | cron model参数失效,所有cron jobs使用错误模型,cost增加3x+ |
| P268 | #57814 **P2** openai-codex/gpt-5.4 WebSocket connect failed 500 | 🔍 新发现 | embedded agent streaming失效 |
| P269 | #57447 **P2** sessions_send blocked by visibility guard despite a2a policy | 🔍 新发现 | cross-agent messaging受阻 |
| P270 | #57430 **P2** Reasoning required error on OpenRouter provider | 🔍 新发现 | OpenRouter provider失效 |
| P271 | #56948 **P2** browser start command not found in v2026.3.28 | 🔍 新发现 | 浏览器功能问题 |
| P272 | #56780 **P2** memory-lancedb fails to load | 🔍 新发现 | memory组件加载失败 |
| P273 | #54303 **P2** 定时任务微信投递失败 | 🔍 新发现 | 微信cron投递失效 |
| P274 | #52186 **P2** TTS elevenlabs generates audio but OpenClaw plays OpenAI voice | 🔍 新发现 | TTS音质问题 |
| P298 | #58549 **P0** Gateway retry loop re-delivers inbound messages | 🔍 新发现 | P0:消息重复投递 |
| P299 | #58542 **P1** LiveSessionModelSwitchError in isolated cron jobs | 🔍 新发现 | cron模型切换失效 |
| P300 | #58533 **P1** Cron sessions inherit persisted model override | 🔍 新发现 | cron配置失效导致thundering herd |
| P301 | #58539 **P1** Spawned subagent with explicit model fails | 🔍 新发现 | 子代理模型问题 |
| P302 | #58537 **P1** Feishu oc_ (OpenChat) chats create duplicate sessions | 🔍 新发现 | Feishu会话重复创建 |
| P303 | #58535 **P1** Discord announce removing fields | 🔍 新发现 | Discord消息处理问题 |
| P304 | #58534 **P1** Session management performance degrades | 🔍 新发现 | 子代理使用时CPU 100%+ |
| P305 | #58528 **P1** Discord attachment download hangs | 🔍 新发现 | 缺少readIdleTimeoutMs |
| P306 | #58523 **P1** Slack multi-workspace: inbound DM replies never reach | 🔍 新发现 | Slack DM失效 |
| P307 | #58520 **P1** TUI never registers with gateway | 🔍 新发现 | TUI注册失败,导致输入延迟 |
| P308 | #58519 **P1** Slack Socket Mode: event loop starvation | 🔍 新发现 | pong超时和消息丢失 |
| P309 | #58517 **P1** Heartbeat model override ignore d | 🔍 新发现 | 总是回退到默认模型 |
| P310 | #58514 **P1** Google Chat: Space/Group messages silently ignored | 🔍 新发现 | DMs可用但群消息被忽略 |
| P311 | #58553 **P1** Long sessions (600+ messages) break with invalid function call | 🔍 新发现 | 高优先级bug,会话稳定性问题 |
| P312 | #58561 Overloaded (529) errors shown as rate limit reached to users | 🔍 新发现 | 用户误导性错误提示,影响用户体验 |
|P313| #58560 Browser tools fail with AJV "no schema with key or ref" 2020-12 error| 🔍 新发现 | bug+regression标签,Browser工具完全失效 |
|P314| #58558 Support async handlers for tool_result_persist hook| 🔍 新发现 | 功能请求,异步hook支持 |
|P315| #58556 Live model switch check prevents model fallback from working| 🔍 新发现 | 高优先级,模型回退链问题 |
| P316 | #58560 Browser tools fail with AJV "no schema with key or ref" 2020-12 error | 🔍 新发现(方向1) | 高优先级 regression,Browser 工具完全失效 |
| P317 | #58561 Overloaded (529) errors shown as rate limit reached to users | 🔍 新发现(方向1) | 中高优先级,可用性/错误提示问题 |
| P318 | InStreet:本轮无 OpenClaw 实战问题(来源为 InStreet Agent Skill 平台/API 文档) | 无 | 来源方向2,非 OpenClaw 社区反馈 |
| P319 | Discord/GitHub discussions:本轮无可公开抓取的新讨论 | 无 | 来源方向3,Discord需登录且 discussions=404 |
| P320 | 插件方向:本轮无新的 openclaw-weixin 相关公开 issue/PR(代码不可见) | 无 | 来源方向4 |
| P321 | 方向1 GitHub:本轮未确认到新的未追踪高价值候选 | 无(来源:GitHub issues/PRs) | 近 2 小时公开抓取受限;已追踪项里仍以 #59027(bundled plugin load fail)和 #59018(TUI session reset)最值得继续盯 |
| P322 | 方向2 InStreet:无新实战问题 | 无(来源:InStreet) | `skill.md` 当前仍是平台/API 文档,未见新的 OpenClaw 用户故障讨论 |
| P323 | 方向3 Discord/Discussions:无新讨论 | 无(来源:Discord / GitHub discussions) | Discord 公开频道内容不可直接抓取;GitHub Discussions 仍返回 404 |
| P324 | 方向4 插件：无新公开问题 | 无（来源：插件仓库） | `openclaw-weixin` 公开 issue/PR 未检出新增；weixin 相关仍是既有"代码不可见"状态 |
| P325 | #60685 fix(startup): circular dep between telegram contract and config-runtime crashes gateway | 🔍 新发现（方向1 GitHub） | **Size S，超高可修性**。作者给了精确到文件行的根因分析 + 两个候选修复方案（内联正则或懒加载），不需要深入理解架构即可修。最优先aoao接单候选 |
| P326 | #60656 MCP stdio servers accumulate across turns — 13.5 GiB RSS memory leak | 🔍 新发现（方向1 GitHub） | **Size S，严重内存泄漏**。15 GiB VPS 上导致崩溃，修复在 MCP server 生命周期管理，熟悉 Node.js 进程生命周期者适合 |
| P327 | #60663 Transcript reports system default model instead of active session model | 🔍 新发现（方向1 GitHub） | sessions_history API 把 fallback chain 主模型当实际模型返回，修复在 API 层，逻辑清晰，可独立验证复现 |
| P328 | #60679 Ollama provider fails silently v2026.3.28+ regression | 🔍 新发现（方向1 GitHub） | regression 标签，2026.3.24 还正常，2026.3.28+ 后 fallback 链失效，文档完善 |
| P329 | #60687 warn: bundled channel entries bluebubbles/discord/slack missing channelPlugin export on startup | 🔍 新发现（方向1 GitHub） | **Size XS**，启动警告刷屏，简单但恼人 |
| P330 | #58691 tools.exec.ask='off' ignored — all exec commands require approval since 2026.3.31 | 🔍 新发现（方向1 GitHub） | regression，与 ACP 新安全机制冲突，config 加载正确但被覆盖 |
| P331 | #60416 **P1** weixin plugin SDK 兼容性：OpenClaw 2026.4.2 移除 `resolvePreferredOpenClawTmpDir` 导致 @tencent-weixin/openclaw-weixin@2.1.5 加载失败 | 🔍 新发现（方向1 GitHub / 方向4 插件） | regression:Plugin SDK breaking change，TypeError: resolvePreferredOpenClawTmpDir is not a function；⚠️ 代码不可见；根因明确（SDK API 移除），fix 需要恢复该函数或 weixin 侧调用新 API |
| P332 | #59528 **P2** openshell sandbox always stopped since 2026.03.13 | 🔍 新发现（方向1 GitHub） | bundled plugin regression，backend=openshell 时无法创建 sandbox；WSL+Ubuntu 24.04+Docker Desktop 环境，2026.04.01 版本 |
| P333 | #60917 **S** Dashboard save fails on redacted `gateway.remote.token` sentinel | 🔍 新发现(方向1 GitHub) | bug:S级；Dashboard 提交时把 `__OPENCLAW_REDACTED__` sentinel 当真实值发送；应过滤或恢复 secret 字段；建议 aoao 接单 |
| P334 | #60905 **S** `openclaw sessions list` returns exit code 0 despite error output | 🔍 新发现(方向1 GitHub) | bug+regression:S级；CLI 校验失败时 stderr 有输出但 exit code 仍为 0；脚本无法区分成功/失败；Windows 11+2026.4.2；建议 aoao 接单 |
| P335 | #60916 **M** Heartbeat rarely fires after upgrading to 2026.4.2 with MiniMax model | 🔍 新发现(方向1 GitHub) | regression?；从 deepseek 切换到 MiniMax-M2.7-highspeed 后 heartbeat 频率大幅降低；可能与 pre-compaction memory 操作有关；需 xixi 进一步调研 |
| P336 | #60894 **S** Race condition: rapid back-to-back user messages cause previous response replay | 🔍 新发现(方向1 GitHub) | bug:S级；两个消息 30-60 秒内快速到达时第二个消息收到第一个的重复响应；Discord+2026.4.2；建议 aoao 接单 |
| P337 | #60886 **S** sessions.json sessionId and sessionFile point to different transcript files | 🔍 新发现(方向1 GitHub) | bug:S级；WebSocket 重连后两个字段指向不同 transcript；UI 读旧文件 gateway 写新文件；根因:sessionId 在文件切换时未同步；建议 aoao 接单 |
| P338 | #60884 **S** pnpm check fails on main due to TypeScript errors in extensions/openrouter | 🔍 新发现(方向1 GitHub) | bug:behavior:S级；TypeScript 编译错误阻塞所有贡献者；`extensions/openrouter/index.ts(94)` 和 `index.test.ts(46)`；建议 aoao 接单 |
| P339 | #60891 **S** feishu: fetchQuotedMessage JSON parse error crashes entire message dispatch | 🔍 新发现(方向1 GitHub) | bug:S级；飞书消息派发中 JSON 解析错误导致整个派发崩溃；单条消息拖垮整体；建议 aoao 接单 |
| P340 | #60879 **S** When uploading skills, files under the .git directory will be read | 🔍 新发现(方向1 GitHub) | bug+regression:S级；skill 上传时读取 .git 目录文件；安全+正确性问题；建议 aoao 接单 |
| P341 | #60878 **XS** Windows gateway self-restart enters infinite retry loop — stale process never killed | 🔍 新发现(方向1 GitHub) | bug+regression:XS级；Windows 上自重启后旧进程未被杀死导致无限重试；建议 aoao 接单 |
| P342 | #60880 **S** Discord slash subcommands timeout (Unknown interaction) after 2026.4.2 update | 🔍 新发现(方向1 GitHub) | bug+regression:S级；2026.4.2 更新后 Discord slash 子命令超时；建议确认是否已有 PR 在修 |
| P343 | #60872 **S** ACP session replies delivered as 'Background task done' without content | 🔍 新发现(方向1 GitHub) | bug:S级；2026.4.2 升级后 ACP session 回复变成空内容 "Background task done"；建议确认是否已有 PR 在修 |
| P344 | #60893 **M** Multi-tool responses dispatched as separate messages instead of coalesced | 🔍 新发现(方向1 GitHub) | bug:M级；多工具响应被拆分而不是合并发送；待确认根因 |
| P345 | 方向2 InStreet 社区 | 无 | `https://instreet.coze.site/skill.md` 当前为平台 Skill/API 文档，非 OpenClaw 用户实战讨论 |
| P346 | 方向3 Discord / GitHub Discussions | 无 | Discord 公共 invite 页面只能抓到标题，频道内容不可抓取；GitHub Discussions 返回 404 |
| P347 | 方向4 插件 | 无 | `openclaw/openclaw-weixin` 仓库不存在或不可公开访问(gh 返回 exit code 1)；无新的公开插件 issue |
| P348 | [#60921](https://github.com/openclaw/openclaw/issues/60921) **P1** Isolated cron + wecom 投递失败 | 🔍 新发现 | regression:S级；isolated session 无 channel context，投递层无法解析 delivery.channel；workaround:sessionTarget:"main"；正式 fix 需在投递层加 fallback 从 delivery.channel 查 registry
P349 | [#31583](https://github.com/openclaw/openclaw/issues/31583) **P1** exec tool 不继承 skills.entries.*.env（多版本 regression）| 🔍 新发现 | 回归 bug，v2026.3.12~v2026.4.2 均受影响；影响 gog/tavily/fal-ai 等多个 skill；之前 PR #31611 被关闭，根因未修；症状清晰可本地复现；workaround:把 env 提到顶层；**最高优先级 aoao 接单候选** |
| P350 | [#60936](https://github.com/openclaw/openclaw/issues/60936) **P1** voice-call: plugin loaded before OpenAI realtime transcription provider | 🔍 新发现（方向1 GitHub） | bug+regression+beta-blocker；voice-call 插件加载时 STT provider "openai" 还未注册，导致电话功能完全不可用；根因：commit a23ab9b906dc6a4f6b24bb3f681f395eb792dbcd 引入的加载顺序 race condition；可修性 M；**beta-blocker 意味着维护者会快速响应** |
| P351 | [#60926](https://github.com/openclaw/openclaw/issues/60926) **P1** Heartbeat injects into active sub-agent sessions, terminating them | 🔍 新发现（方向1 GitHub） | bug；heartbeat 注入破坏了活跃的 sub-agent session，导致 HEARTBEAT_OK 终止；PR #60934 已合并但 v2026.4.2 仍触发；可修性 M |
| P352 | [#60961](https://github.com/openclaw/openclaw/issues/60961) **S** OpenShell mirror mode write tool fails: tar "Cannot open: File exists" | 🔍 新发现（方向1 GitHub） | bug；写文件到已存在子目录时 tar 报错，agent 无法持久化 memory；issue 已附 fix 代码（strip 目录组件后重新上传）；**可修性 S，建议 aoao 接单** |
| P353 | [#60959](https://github.com/openclaw/openclaw/issues/60959) **S** Google image generation returns HTTP 404 with /openai suffix | 🔍 新发现（方向1 GitHub） | bug；baseUrl 含 /openai 时 image generate 失败；根因：resolveGoogleBaseUrl() 未 strip /openai suffix；**一行代码 fix，建议 aoao 接单** |
| P354 | [#60963](https://github.com/openclaw/openclaw/issues/60963) **S** plugins.entries rejects plugin config keys (nesting undocumented) | 🔍 新发现（方向1 GitHub） | bug；plugins.entries.<id>.<key> 被拒，正确格式是 plugins.entries.<id>.config.<key>；至少可修 error message 提示；**可修性 S，建议修 error message docs** |
| P355 | [#60970](https://github.com/openclaw/openclaw/issues/60970) **S** acpx 0.4.x Silent Session Creation Failure | 🔍 新发现（方向1 GitHub） | bug+regression；acpx@0.4.0/0.4.1 sessions new 退出 0 但无 session 创建；根因：0.4.x 疑似改变 Claude Code launch flags 或 session protocol，与 0.3.1 不兼容；workaround 回退到 0.3.1；可修性 XS |
| P356 | [#60930](https://github.com/openclaw/openclaw/issues/60930) **M** Control UI websocket disconnects with code=1001 during long-running tasks | 🔍 新发现（方向1 GitHub） | bug；websocket 在长任务完成时断开并 reconnect，live update 丢失；可修性 M；需调研代码层面 root cause |
P357 | [#61006](https://github.com/openclaw/openclaw/issues/61006) **S** Fallback retry rewrites user prompt into synthetic transcript | 🔍 新发现（方向1 GitHub） | bug；`src/agents/command/attempt-execution.ts` 的 `resolveFallbackRetryPrompt` 在 sessionHasHistory=true 时用合成字符串替换用户原始 prompt，污染 transcript；fix：忽略 sessionHasHistory，始终返回原始 body；**建议 aoao 接单，1-2 小时可 PR** |
P358 | [#61009](https://github.com/openclaw/openclaw/issues/61009) **S** docs/tools/exec: host=node override 与文档不符 | 🔍 新发现（方向1 GitHub） | 文档说 `host=auto` 时允许 per-call `host=node`，但运行时拒绝；建议先确认修文档还是修 runtime |
P359 | [#61007](https://github.com/openclaw/openclaw/issues/61007) **S** Gemini models 显示为 anthropic in openclaw models list | 🔍 新发现（方向1 GitHub） | 配置在 google provider，list 显示为 anthropic/gemini-*；可修性 S |
P360 | [#61015](https://github.com/openclaw/openclaw/issues/61015) **S** cron rm hangs indefinitely | 🔍 新发现（方向1 GitHub） | 任意有效 job ID 都 hang，无任何输出；功能性损坏；建议 aoao 接单，先本地复现 |
P361 | [#61029](https://github.com/openclaw/openclaw/issues/61029) **S** Image generation delivery fails: path mismatch in Telegram media delivery | 🔍 新发现（方向1 GitHub） | Telegram 媒体交付路径写错了（`tool-image-generation/---<uuid>.jpg` vs `output/<name>.png`）；清晰根因+完整日志证据；建议 aoao 接单 |
P362 | [#61050](https://github.com/openclaw/openclaw/issues/61050) **S** configure wizard sets claude-cli/ model prefix but gateway cannot resolve it | 🔍 新发现（方向1 GitHub） | regression；configure wizard 设置 claude-cli/ prefix 但 gateway 无法解析；用户有有效 Pro 订阅却被强制付 API token；较复杂，需调研 configure wizard 和 provider 注册机制 |
P363 | [#61064](https://github.com/openclaw/openclaw/issues/61064) **S** Bug: MiniMax image-01 image-to-image blocked by resolution override check | 🔍 新发现（方向1 GitHub） | providers manifest 中 `edit.supportsResolution: false` 导致工具封装直接抛错；修复只需改为 `true`；MiniMax API 本身支持 `subject_reference`；Workaround 是换 Google 模型；**最高可修性候选，1行改动** |
P364 | [#61059](https://github.com/openclaw/openclaw/issues/61059) **M** Bug: memorySearch.multimodal fails with 'provider adapter' error on 2026.4.2 | 🔍 新发现（方向1 GitHub） | 明确 regression：2026.3.28 正常 → 2026.4.2 坏；`getMemoryEmbeddingProvider('gemini')` 返回 undefined，Gemini adapter 未注册；根因在 `memory-embedding-providers-*.js`；建议 aoao 查 `src/memory/embedding-providers.ts` 看 exports 差异 |
P365 | [#61055](https://github.com/openclaw/openclaw/issues/61055) **S** CLI backend: null bytes in system prompt crash child_process.spawn | 🔍 新发现（方向1 GitHub） | `systemPrompt.replaceAll('\0', '')` 即可修复；崩溃路径清晰；workaround 是 `systemPromptWhen: "never"` 但损失所有 harness context |
P366 | [#61060](https://github.com/openclaw/openclaw/issues/61060) **S** Telegram BOT_COMMANDS_TOO_MUCH: undocumented total character budget causes skill commands to be silently dropped | 🔍 新发现（方向1 GitHub） | docs gap + usability bug；Telegram API ~5,750 char budget 未文档化；OpenClaw retry 只按数量 0.8x 截断，导致 workspace skill commands 被静默丢弃；修复方向：按 char budget 而非 count 截断 description |
P367 | [#61058](https://github.com/openclaw/openclaw/issues/61058) **S** secrets audit --check flags $VAR env references as PLAINTEXT_FOUND | 🔍 新发现（方向1 GitHub） | false positive；`${VAR}` / `$VAR` safe reference 被当作 plaintext secret；修复：在 audit 逻辑中识别 `${VAR}` 模式并分类为 ENV_REF；影响 audit 工具可用性 |
P368 | [#61066](https://github.com/openclaw/openclaw/issues/61066) **M** Build fails at pnpm build:docker — parse error in extensions/anthropic/register.runtime.ts:388 | 🔍 新发现（方向1 GitHub） | Docker build 在 rolldown bundling 时报 parse error；新用户第一感就是 build 失败；需确认是源文件语法问题还是 bundler 配置问题 |
P369 | [#61057](https://github.com/openclaw/openclaw/issues/61057) **S** gateway.env path split silently on fresh Ubuntu 24.04 install | 🔍 新发现（方向1 GitHub） | `~/.openclaw/.env` 和 `~/.config/openclaw/gateway.env` 未对齐时静默失败；workaround 是 ln -s；修复：加 precedence 日志或 warning |  
P370 | [#61042](https://github.com/openclaw/openclaw/issues/61042) **S** Plugin code-safety scanner falsely blocks openclaw-quiubo on bundled child_process patterns | 🔍 新发现（方向1 GitHub） | false positive；bundled sync XHR polyfill + home-dir path construction 被误判为恶意行为；scanner heuristic 太 aggressive；建议加 pattern 白名单或降低 severity |
P371 | [#61048](https://github.com/openclaw/openclaw/issues/61048) **M** Claude CLI backend produces zero stdout when spawned as headless (launchd/systemd) | 🔍 新发现（方向1 GitHub） | debug log 显示 CLI 停在 `.claude.json` 写完，未进入 SessionStart；疑似 TTY 相关初始化阻塞；较复杂，需调研 `--no-input` 或 fd 处理 |
P372 | [#61043](https://github.com/openclaw/openclaw/issues/61043) Feature: auto-create agent on new weixin QR scan | 🔒 代码不可见（方向4 插件） | 功能请求；weixin 插件代码不公开，无法评估实现路径；代码不可见 |
P373 | InStreet:本轮无 OpenClaw 实战问题 | i️ 无（方向2 InStreet） | `https://instreet.coze.site/skill.md` 内容仍为 InStreet Agent Skill/API 平台使用文档，不是用户讨论区；未发现可转 GitHub issue 的新用户问题 |
P374 | Discord/GitHub discussions:本轮无可公开抓取的新讨论 | i️ 无（方向3 Discord） | Discord invite 页面需登录，频道内容不可抓取；GitHub discussions 仍为 404；暂记无 |
P375 | 插件方向:本轮无新的 openclaw-weixin 公开 issue | i️ 无（方向4 插件） | `openclaw/openclaw-weixin` 仓库 issue 无法可靠抓取；代码仍不可见；已有追踪项 #55994/#58738 继续 |
| P376 | [#61097](https://github.com/openclaw/openclaw/issues/61097) **S** Gateway crash: task_runs.requester_session_key NOT NULL constraint | 🔍 新发现（方向1 GitHub） | P0/S：Gateway 运行 ~30 分钟后触发 SQLite write 失败；schema 要求 NOT NULL 但字段为 NULL；v2026.3.30 首发，v2026.4.4 仍触发；可修性 M |
| P377 | [#61096](https://github.com/openclaw/openclaw/issues/61096) **S** /model 命令在主 provider rate-limited 时失效 | 🔍 新发现（方向1 GitHub） | S级；5 层 allowlist validation gate 阻止 override 持久化；用户有 dist/ workaround；可修性 S |
| P378 | [#61095](https://github.com/openclaw/openclaw/issues/61095) **S** exec 工具继承 Gateway 内部 env vars 导致 CLI 命令失败 | 🔍 新发现（方向1 GitHub） | S级；`OPENCLAW_SERVICE_KIND=gateway` 等 env 让 CLI 误认为自己是 gateway；修复：spawn 前清除 `OPENCLAW_SERVICE_*`/`OPENCLAW_SYSTEMD_*`/`OPENCLAW_SHELL`；**最干净候选，建议 aoao 接单** |
| P379 | [#61090](https://github.com/openclaw/openclaw/pull/61090) fix(#60879): 排除 .git/node_modules 复制 | 🔍 新发现（方向1 GitHub） | PR 修复 #60879；已在 P340 追踪 |
| P380 | [#61116](https://github.com/openclaw/openclaw/issues/61116) **S** acpx plugin: gateway passes --format as global flag, causes unknown option error | 🔍 新发现（方向1 GitHub） | **最优先接单候选**。根因：extensions/acpx/index.js 参数顺序错误；fix：调整 --format json 到 subcommand 后；作者给了完整正确/错误对比命令；XS 工作量 |
| P381 | [#61115](https://github.com/openclaw/openclaw/issues/61115) **S** Plugin upgrade doesn't install npm dependencies, breaks feishu channel | 🔍 新发现（方向1 GitHub） | 插件升级只替换文件不跑 npm install；feishu/lark 等 npm 依赖插件加载失败；fix：upgrade 流程加 npm install；建议 aoao 次优先接单 |
| P382 | [#61110](https://github.com/openclaw/openclaw/issues/61110) **M** Provider errors incorrectly mapped to deactivated_workspace | 🔍 新发现（方向1 GitHub） | openai-codex rate limit/token 过期错误被映射为虚假的 deactivated_workspace，掩盖真实根因；error chain mapping bug |
| P383 | [#61103](https://github.com/openclaw/openclaw/issues/61103) **S** Control UI screenshot/image upload broken regression (v2026.4.2) | 🔍 新发现（方向1 GitHub） | 用户看到缩略图但 agent 未收到图片数据；疑似 media HTTP base URL 相关 PR 副作用 |
| P384 | [#61074](https://github.com/openclaw/openclaw/issues/61074) **S** openclaw-weixin: inbound metadata missing channel=weixin, identity/persona not load | 🔍 新发现（方向4 插件） | ⚠️ 代码不可见；可调研主仓库 channel metadata 附加逻辑推断 fix 方向 |
P385 | [#61142](https://github.com/openclaw/openclaw/issues/61142) **S** Telegram photo captions arrive as `[object Object]` | 🔍 新发现（方向1 GitHub） | bug：Telegram 发图片时 caption 文本变成 `[object Object]`；无标签无评论，全新未处理；清晰简单，**建议 aoao 接单** |
P386 | [#61124](https://github.com/openclaw/openclaw/issues/61124) **S** Discord reconnect-exhausted error crashes gateway during health-monitor restart | 🔍 新发现（方向1 GitHub） | bug：health-monitor restart 时 reconnect-exhausted 错误导致 gateway crash；无标签无评论；**建议 aoao 接单** |
P387 | [#61139](https://github.com/openclaw/openclaw/issues/61139) **S** Tools hang indefinitely on 2026.4.2 with k2p5 | 🔍 新发现（方向1 GitHub） | bug+regression：k2p5 工具调用在 2026.4.2 版本无限挂起；降级到 2026.4.1 恢复；可修性 M |
P388 | [#61115](https://github.com/openclaw/openclaw/issues/61115) **S** Plugin upgrade doesn't install npm dependencies, breaks feishu channel | 🔍 新发现（方向1 GitHub） | bug：插件升级只替换文件不跑 npm install，导致 feishu/lark 等插件加载失败；M 级可修性 |
P389 | [#61211](https://github.com/openclaw/openclaw/issues/61211) **S** `pnpm build:docker` fails: extensions/whatsapp/contract-surfaces.ts missing export | 🔍 新发现（方向1 GitHub） | bug+regression：WhatsApp build 失败，缺失 export；XS 级，纯加 export；**建议 aoao 接单** |
P390 | [#61206](https://github.com/openclaw/openclaw/issues/61206) **S** HTTP 400 on github-copilot/gemini-3-flash-preview due to cron tool JSON Schema | 🔍 新发现（方向1 GitHub） | bug+regression：cron tool JSON Schema 格式导致 github-copilot API 400；**建议 aoao 接单** |
P391 | [#61186](https://github.com/openclaw/openclaw/issues/61186) **M** Cron timer tick crash: `ReferenceError: fs$1 is not defined` (v2026.4.2) | 🔍 新发现（方向1 GitHub） | bug：runtime crash，fs$1 未定义（可能是 minified bundle 变量名问题）；M 级；**建议 aoao 接单** |
P392 | [#61209](https://github.com/openclaw/openclaw/issues/61209) **M** Ollama provider not registered despite OLLAMA_API_KEY=ollama-local | 🔍 新发现（方向1 GitHub） | bug：provider 注册问题；M 级 |
P393 | [#61189](https://github.com/openclaw/openclaw/issues/61189) **M** macOS remote app connects as node-host only (no notify/camera/canvas) | 🔍 新发现（方向1 GitHub） | bug：macOS 平台问题；M 级 |
P394 | [#61197](https://github.com/openclaw/openclaw/issues/61197) **S/M** vLLM reasoning model responses silently dropped | 🔍 新发现（方向1 GitHub） | bug：vLLM tool_calls:[] + reasoning field 导致响应被静默丢弃；与 #60464 相关 |
P395 | [#61195](https://github.com/openclaw/openclaw/issues/61195) **M** Telegram provider silently fails to start on fresh gateway boots (v2026.4.2) | 🔍 新发现（方向1 GitHub） | bug：gateway 启动顺序/channel 初始化时序问题；M 级 |
P396 | [#61210](https://github.com/openclaw/openclaw/issues/61210) Feature: Deduplicate repeated file reads in context | 🔍 新发现（方向1 GitHub） | 纯 feature request；S 级 |
P397 | [#61211](https://github.com/openclaw/openclaw/issues/61211) **S** `pnpm build:docker` fails: WhatsApp `contract-surfaces.ts` missing export | 🔍 新发现（方向1） | Size XS，纯加 export；**建议 aoao 接单** |
P398 | [#61206](https://github.com/openclaw/openclaw/issues/61206) **S** HTTP 400 on github-copilot/gemini-3-flash-preview due to cron tool JSON Schema | 🔍 新发现（方向1） | bug+regression；**建议 aoao 接单** |
P399 | [#61186](https://github.com/openclaw/openclaw/issues/61186) **M** Cron timer tick crash: `ReferenceError: fs$1 is not defined` (v2026.4.2) | 🔍 新发现（方向1） | bug；runtime crash；建议 aoao 接单 |
P400 | [#61223](https://github.com/openclaw/openclaw/issues/61223) **M** Ollama thinking tokens: stream handler ignores `message.thinking`, causes empty responses + queue lockup | 🔍 新发现（方向1 15:17 CST） | bug；dist/stream-*.js 只读 `chunk.message.content`，忽略 `chunk.message.thinking`；根因极清晰 |
P401 | [#61222](https://github.com/openclaw/openclaw/issues/61222) **M** Telegram duplicate inbound messages in group sessions (same message_id delivered twice) | 🔍 新发现（方向1 15:17 CST） | bug；group chat split-turn batching 相关 |
P402 | [#61219](https://github.com/openclaw/openclaw/issues/61219) **M** LINE channel fails to start after upgrading to v2026.4.2 (regression) | 🔍 新发现（方向1 15:17 CST） | bug+regression；LINE channel public surface access blocked；可能与 LINE runtime contract 修复有关 |
P403 | [#61218](https://github.com/openclaw/openclaw/issues/61218) **S** LINE channel plugin not registered as bundled origin in facade-runtime (beta-blocker) | 🔍 新发现（方向1 15:17 CST） | bug+beta-blocker；与 #61219 同期，可能是同一 regression 两个视角 |
P404 | [#61213](https://github.com/openclaw/openclaw/issues/61213) **M** Web控制界面显示冗长open_id和session key（usability gap） | 🔍 新发现（方向1 15:17 CST） | enhancement；建议 binding.comment → agent.name → 技术标识符三层级显示 |
P405 | [#59796](https://github.com/openclaw/openclaw/issues/59796) **M** `openclaw logs --follow` fails with "gateway connect failed: pairing required" (regression) | 🔍 新发现（方向1 15:17 CST） | bug+regression；gateway RPC auth pairing 逻辑；gateway status 显示 running 但 CLI logs 报 pairing required |
P406 | [#61193](https://github.com/openclaw/openclaw/issues/61193) **M** exec approvals allowlist glob pattern not matching commands | 🔍 新发现（方向1 15:17 CST） | bug；fnmatch `python3 /path/to/script.py` 应匹配 `python3 *`，但 runtime 拒绝 |
P407 | [#61238](https://github.com/openclaw/openclaw/issues/61238) **M** Critical Data Loss Due to Silent Daily Session Reset（bug:behavior） | 🔍 新发现（方向1 16:17 CST） | bug+bug:behavior；OpenClaw 每天 4:00 AM 自动 reset 会话，无警告、无 discoverable opt-out；8+ 次 reset，15,000+ 消息永久丢失；**最高优先级 aoao 接单候选** |
P408 | [#61233](https://github.com/openclaw/openclaw/issues/61233) **S** allow-always does not persist — each command triggers new approval | 🔍 新发现（方向1 16:17 CST） | bug；allow-always 保存命令 hash（每次不同）而非稳定 pattern，导致 Allow Always 形同 Allow Once；**建议 aoao 接单** |
P409 | [#61223](https://github.com/openclaw/openclaw/issues/61223) **M** Ollama thinking tokens: stream handler ignores `message.thinking` | 🔍 新发现（方向1 16:17 CST） | bug；dist/stream-*.js 只读 `chunk.message.content` 忽略 `chunk.message.thinking`，Ollama 推理阶段 content 为空导致 assistant turn 空内容结束；chatRunId 未清除导致后续消息全部卡在队列；根因极清晰；**建议 aoao 接单** |
P410 | [#59850](https://github.com/openclaw/openclaw/issues/59850) **S** grammy module not installed causes ERR_MODULE_NOT_FOUND for all users | 🔍 新发现（方向1 16:17 CST） | bug；sticker-cache-*.js 静态 import grammy，任何 URL 粘贴 webchat 都崩（用户不用 Telegram 也中招）；fix：改动态 import；技术方案已在 issue 中；**建议 aoao 接单** |
| P411 | [#61358](https://github.com/openclaw/openclaw/issues/61358) **S** isGatewayMessageChannel intermittently rejects third-party plugins (weixin/qqbot) | 🔍 新发现（方向1 22:00 CST） | bug 在 openclaw 核心；根因已定位（registry-DTO 用 mutable 而非 pinned registry）；fix 明确（2行）；sessions_spawn 间歇性失败；**建议 aoao 接单** |
| P412 | [#61363](https://github.com/openclaw/openclaw/issues/61363) **S** Telegram plugin missing npm dependencies in v2026.4.4 | 🔍 新发现（方向1 22:00 CST） | regression；v2026.4.4 升级后 Telegram 插件完全无法启动；package-lock.json 不同步；**建议 aoao 接单** |
| P413 | [#61359](https://github.com/openclaw/openclaw/issues/61359) **M** Sub-agent model override not working | 🔍 新发现（方向1 22:00 CST） | regression；传入 model 参数仍使用默认模型；有清晰复现步骤 |
| P414 | [#61351](https://github.com/openclaw/openclaw/issues/61351) **S** new matrix channel agents unresponsive | 🔍 新发现（方向1 22:00 CST） | regression；现有 matrix 代理正常，新建的完全无响应 |
| P415 | [#61340](https://github.com/openclaw/openclaw/issues/61340) **M** gateway install --force persists secrets into systemd unit files | 🔍 新发现（方向1 22:00 CST） | 安全问题；OPENAI_API_KEY 明文写入 .service 和 .bak 文件 |
| P416 | [#61343](https://github.com/openclaw/openclaw/issues/61343) **S** Cron duplicate execution: lastRunAtMs not persisted until Phase 3 | 🔍 新发现（方向1 22:00 CST） | bug；gateway 重启在 Phase 3 前发生会导致 job 重复执行；生产环境已复现 |
| P417 | [#61364](https://github.com/openclaw/openclaw/issues/61364) **M** Gemini 2.5 Flash returns 400 via OpenClaw, direct curl 正常 | 🔍 新发现（方向1 22:00 CST） | bug；路由/header 问题，非 API key 问题 |
| P418 | [#61338](https://github.com/openclaw/openclaw/issues/61338) **S** Skills check macOS requirement not detected | 🔍 新发现（方向1 22:00 CST） | bug；Darwin 被匹配为 linux 而非 macos；workaround 删 SKILL.md 里的 `os: macos` |
| P419 | [#61339](https://github.com/openclaw/openclaw/issues/61339) **Critical** Windows Task Scheduler Gateway Token Mismatch | 🔍 新发现（方向1 22:00 CST） | regression；Windows 用户升级后 token 不匹配 |
| P420 | [#61384](https://github.com/openclaw/openclaw/issues/61384) **S** Default memory convention and session-memory hook output inconsistent (YYYY-MM-DD.md vs YYYY-MM-DD-slug.md) | 🔍 新发现（方向1 23:00 CST） | bug:behavior；hook 输出 slug.md 但 AGENTS 模板读无 slug 的 YYYY-MM-DD.md；/reset 后产生 ENOENT 错误；清晰可本地复现；**建议 aoao 接单** |
| P421 | [#61380](https://github.com/openclaw/openclaw/issues/61380) **S** sortToolsMessageItems uses toSorted() which is not stable | 🔍 新发现（方向1 23:00 CST） | bug:performance；`toSorted` 不稳定导致每次 tool order 变化使 prompt cache 全部失效；fix: `.sort()`（spec保证稳定）；**建议 aoao 接单** |
| P422 | [#61379](https://github.com/openclaw/openclaw/issues/61379) **S** web_search tool fails — hardcoded api.grok.x.ai doesn't resolve (should be api.x.ai) | 🔍 新发现（方向1 23:00 CST） | bug；Grok API 端点硬编码错误 URL；1行 fix；**建议 aoao 接单** |
| P423 | [#61377](https://github.com/openclaw/openclaw/issues/61377) **S** kimi provider config defaults to 'anthropic-messages' instead of 'openai-completions' | 🔍 新发现（方向1 23:00 CST） | bug:behavior；provider 默认值写错，影响所有新配置 Kimi 的用户；**建议 aoao 接单** |
| P424 | [#61351](https://github.com/openclaw/openclaw/issues/61351) **S** new matrix channel agents unresponsive (regression) | 🔍 新发现（方向1 23:00 CST） | bug+regression；现有 matrix 代理正常，新建的完全无响应；0评论；**建议 aoao 接单** |
| P425 | [#61370](https://github.com/openclaw/openclaw/issues/61370) **S** Telegram compressed photo delivery needs deterministic handling | 🔍 新发现（方向1 23:00 CST） | bug:behavior；Telegram 压缩图片处理不确定性 |
| P426 | [#61336](https://github.com/openclaw/openclaw/issues/61336) **S** feishu_doc write action fails with 'Cannot read properties of undefined (reading split)' | 🔍 新发现（方向1 23:00 CST） | bug；飞书文档写入操作崩溃 |
| P427 | [#61426](https://github.com/openclaw/openclaw/issues/61426) **M** sessionTarget:isolated not honored — cron job messages accumulate in main session | 🔍 新发现（方向1 16:45 CST） | regression；有 PR #61428（sgebalaJC）正在修，先确认是否覆盖再决定是否接单 |
| P428 | [#61414](https://github.com/openclaw/openclaw/issues/61414) **S** Cron delivery ignores explicit delivery.channel when sessionTarget=isolated | 🔍 新发现（方向1 16:45 CST） | bug:behavior；与 #61426 同源（cron delivery）；建议与 #61426 一起调研 |
| P429 | [#61395](https://github.com/openclaw/openclaw/issues/61395) **S** lightContext not filtering workspace files (heartbeat+cron) | 🔍 新发现（方向1 16:45 CST） | bug:behavior；根因已定位：`pi-embedded-*.js:342-343` 的 `applyContextModeFilter` 未生效；**建议 aoao 接单** |
| P430 | [#61411](https://github.com/openclaw/openclaw/issues/61411) **S** OpenRouter 404 'No endpoints found' classified as candidate_succeeded, halts fallback chain | 🔍 新发现（方向1 16:45 CST） | bug；404 应为 failure 但被标为 success，导致回退链中断；**建议 aoao 接单** |
| P431 | [#61453](https://github.com/openclaw/openclaw/issues/61453) **S** exec-approvals socket fails to create after Telegram delivery failure + restart loop | 🔍 新发现（方向1 17:45 CST） | bug；长消息 >4096 chars → Telegram 400 → 重启后重试循环阻塞 socket 初始化；修复：startup 时不重试历史失败 delivery，直接标记 expired；**可修性 S，aoao 优先接单** |
| P432 | [#61451](https://github.com/openclaw/openclaw/issues/61451) **S** exec allowlist pattern matching broken — args cause allowlist check to fail | 🔍 新发现（方向1 17:45 CST） | bug；`find / -name` 等带参数命令被 allowlist 拒绝，即使可执行文件在白名单中；根因在 pattern matching 代码；**可修性 S，aoao 次优先接单** |
| P433 | [#61440](https://github.com/openclaw/openclaw/issues/61440) **M** Log file maxFileBytes reached — gateway silently drops agent spawn | 🔍 新发现（方向1 17:45 CST） | bug:behavior；log 达到 maxFileBytes 后 gateway 静默丢弃 agent spawn（返回 ok 但进程未启动）；极难调试；**可修性 M** |
| P434 | [#61433](https://github.com/openclaw/openclaw/issues/61433) **M** Cron/subagent completion announce leaks runtime metadata to user | 🔍 新发现（方向1 17:45 CST） | bug；completion announce payload 泄漏原始 runtime 元数据（文件路径、routing labels）到用户对话；**可修性 M** |
| P435 | [#61445](https://github.com/openclaw/openclaw/issues/61445) **M** iMessage echo loop after restart — empty echo cache causes outbound as inbound replay | 🔍 新发现（方向1 17:45 CST） | bug；gateway 重启后 echo cache 为空，outbound 消息被当作 inbound replay；三种修复方案；**可修性 M** |
| P436 | [#61439](https://github.com/openclaw/openclaw/issues/61439) **M** Subagent completes successfully but parent session never receives completion handoff | 🔍 新发现（方向1 17:45 CST） | bug；子 agent 完成但 parent 从未收到 handoff，工作丢失但无报错；**可修性 M** |
| P437 | [#61432](https://github.com/openclaw/openclaw/issues/61432) **M** event.messages.push() on message:received has no effect | 🔍 新发现（方向1 17:45 CST） | bug:behavior；文档说 all events 都可以 push，但实际无效；**可修性 M** |
| P438 | [#61426](https://github.com/openclaw/openclaw/issues/61426) **M** sessionTarget:isolated not honored — cron job messages accumulate in main session | 🔍 新发现（方向1 17:45 CST） | regression；8个 isolated cron 全部中招，每天 200 条累积，10 天后 context 崩溃；已有 PR #61428 在修；**建议确认 #61428 覆盖范围** |
| P439 | [#61452](https://github.com/openclaw/openclaw/issues/61452) **XS** /status fallback chain display truncates intermediate models | 🔍 新发现（方向1 17:45 CST） | bug；/status 只显示最后一级 + "(+1 more)"，中间模型完全不可见；**可修性 XS** |
| P440 | [#61448](https://github.com/openclaw/openclaw/issues/61448) **S** Node.js 22 undici 6.23.0 incompatible with OpenClaw's undici 8.0.0 | 🔍 新发现（方向1 17:45 CST） | bug；影响 Tavily/Brave search 等工具；per-request dispatcher 模式不兼容；**可修性 S，但涉及 Node.js 版本策略**
P441 | [#61474](https://github.com/openclaw/openclaw/issues/61474) **S** `extractAssistantVisibleText` leaks commentary when `final_answer` exists but is empty (regression from #59643) | 🔍 新发现（方向1 02:55 CST） | P1 regression；`pi-embedded-utils.ts:333-339` 在 final_answer 空时仍回退到未阶段化文本；无标签无评论；**最干净候选，1行条件修复，建议 aoao 接单**
P442 | [#61465](https://github.com/openclaw/openclaw/issues/61465) **S** Compaction summarization repeatedly fails with 'fetch failed' in v2026.4.2, causing stuck sessions | 🔍 新发现（方向1 02:55 CST） | bug+regression；v2026.3.28→v2026.4.2 升级后 compaction summarization `fetch failed` 循环；/clear 可 break；**建议 aoao 接单**
P443 | [#61487](https://github.com/openclaw/openclaw/issues/61487) **S/M** LLM HTTP timeout hardcoded ~60s, ignores `timeoutSeconds` config (Ollama/exo users always affected) | 🔍 新发现（方向1 05:01 CST） | bug；HTTP fetch timeout 硬编码 ~61s，未读取 `agents.defaults.timeoutSeconds`；curl 0.5s 响应但 OpenClaw 61s 超时；已有相关 issue #59604/#46049/#43946（多轮未修复）；需找 HTTP fetch timeout 位置并连接配置层；**建议 aoao 调研根因**
P444 | [#61514](https://github.com/openclaw/openclaw/issues/61514) **S** Open in Canvas / copy markdown 图标与文字重叠（UI regression, v2026.4.2） | 🔍 新发现（方向1 05:01 CST） | bug+regression；CSS z-index/position 问题，引入日期 2025-04-01；截图明确所有浏览器复现；**XS/S 级，UI CSS 修复，建议 aoao 接单**
P445 | [#61509](https://github.com/openclaw/openclaw/issues/61509) **S** exec allowlist `/bin/sh -lc` wrapper 包裹后无法匹配，`tools.exec.ask: on-miss` 完全失效 | 🔍 新发现（方向1 05:01 CST） | bug；allowlist 匹配外层 `/bin/sh` 而非内层实际脚本；已有 PR #61424 在修类似问题；需确认是否同根因；**建议 aoao 确认 #61424 覆盖范围后再接单**
P446 | [#61499](https://github.com/openclaw/openclaw/issues/61499) **S** MLX LM Server tool calls 失败：`finish_reason 'tool_call'（单数）未识别 | 🔍 新发现（方向1 05:01 CST） | bug；`mapStopReason()` 只匹配 `tool_calls`（复数），漏了 `tool_call`（单数）；但修复在 `@mariozechner/pi-ai` 包（非 openclaw 核心）；已有 PR #61517；**openclaw 侧无需 action**
P447 | [#61516](https://github.com/openclaw/openclaw/issues/61516) **?** attach image 功能失效（regression，标题空白信息不足） | 🔍 新发现（方向1 05:01 CST） | 信息量不足，需跟 reporter 要更多信息再判断价值
P448 | [#61524](https://github.com/openclaw/openclaw/issues/61524) **S** security: "full" + ask: "off" 仍触发混淆检测批准提示（安全配置绕不过） | 🔍 新发现（方向1 06:01 CST） | bug；`obfuscation.detected` 被无条件 OR 进 requiresAsk，即便 security=full 也强制弹批准；修复：加 `hostSecurity !== "full"` 条件；代码位置已给出；**建议 aoao 接单（S 级逻辑修复）**
P449 | [#61514](https://github.com/openclaw/openclaw/issues/61514) **S** Open in Canvas / copy markdown 图标与文字重叠（UI regression, v2026.4.2） | 🔍 新发现（方向1 06:01 CST） | bug+regression；CSS z-index/position 问题，2025-04-01 引入；截图明确所有浏览器复现；**XS/S 级，UI CSS 修复，建议 aoao 接单**
P450 | [#61508](https://github.com/openclaw/openclaw/issues/61508) **M** WebChat WebSocket 1006 断开 — 长模型响应时缺少 keepalive ping | 🔍 新发现（方向1 06:01 CST） | bug；gateway WS 服务端无 ping/keepalive 帧，5-20 分钟后 1006 断开；macOS M2 Opus 长响应必现；需了解 gateway WS ping 配置；**建议 aoao 调研 WS ping 机制**
P451 | [#61505](https://github.com/openclaw/openclaw/issues/61505) **M** Discord handler 卡在 "awaiting gateway readiness"（standalone discord.js 正常） | 🔍 新发现（方向1 06:01 CST） | bug；gateway readiness 信号机制问题；关联 #58290；**建议 aoao 调研 gateway readiness 信号流程**
P452 | [#61520](https://github.com/openclaw/openclaw/issues/61520) **S** Config IO 静默吞掉可能指示严重问题的错误（enhancement 标签） | 🔍 新发现（方向1 06:01 CST） | bug；`config/io` 层对错误打日志后继续执行不向上传递；**建议 aoao 接单（S 级 logging 改进）**
P453 | [#61524](https://github.com/openclaw/openclaw/issues/61524) **S** security: "full" + ask: "off" 仍触发混淆检测批准提示 | 🔍 新发现（方向1 06:01 CST） | bug；`obfuscation.detected` 被无条件 OR 进 requiresAsk，即便 security=full 也强制弹批准；修复：加 `hostSecurity !== "full"` 条件；代码位置：`src/agents/bash-tools.exec-host-gateway.ts` ~line 126-133；**已派出 aoao（runId 89217cb8）**

---

## xixi 第41轮扫描（2026-04-05 16:17 CST / 2026-04-05 08:17 UTC）
**新发现**：
- **#61238 M** — Critical Data Loss Due to Silent Daily Session Reset；bug:behavior；每天 4 AM 自动 reset 无警告，15,000+ 消息永久丢失；**最高优先级 aoao 接单候选**
- **#61233 S** — allow-always does not persist；allow-always 保存命令 hash 导致形同 Allow Once；**次高优先级，建议 aoao 接单**
- **#61223 M** — Ollama thinking tokens cause silent message drop + queue lockup；根因极清晰（dist/stream-*.js 忽略 message.thinking）；**建议 aoao 接单**
- **#59850 S** — grammy module causes ERR_MODULE_NOT_FOUND for all users；fix 方案已给出（动态 import）；**建议 aoao 接单**
- **#61240 S** — BREW NEEDS TO BE REMOVE AS THE MAIN INSTALLER（regression）；偏 usability gap
- **#61219 M** — LINE channel fails to start v2026.4.2（regression）；同期 #61218 beta-blocker
**无新发现**：InStreet（skill.md 仍是 API 文档）、Discord（需登录+discussions 410）、插件（weixin 代码不可见）
**建议**：aoao 接单顺序 #61233 → #59850 → #61223 → #61238

---

## xixi 第40轮扫描（2026-04-05 14:17 CST / 2026-04-05 06:17 UTC）
**新发现**：
- **#61211 S** — `pnpm build:docker` fails: WhatsApp `contract-surfaces.ts` missing export；Size XS，纯加 export；**最高 aoao 接单候选**
- **#61206 S** — HTTP 400 on github-copilot/gemini-3-flash-preview due to cron tool JSON Schema regression；**次高 aoao 接单候选**
- **#61186 M** — Cron timer tick crash: `fs$1 is not defined` (v2026.4.2)
- **#61209 M** — Ollama provider not registered
- **#61189 M** — macOS remote app connects as node-host only
- **#61197 S/M** — vLLM reasoning model responses silently dropped
- **#61195 M** — Telegram provider silently fails to start on fresh gateway boots
**无新发现**：InStreet（skill.md 仍是 API 文档）、Discord（需登录+discussions 410）、插件（weixin 代码不可见）
**建议**：aoao 接 #61211（最干净 XS）+ #61206（S，cron schema regression）

---

## xixi 第39轮扫描（2026-04-05 10:20 CST / 2026-04-05 02:20 UTC）
**新发现**：
- **#61142 S** — Telegram photo captions arrive as `[object Object]`；无标签无评论，清晰简单；**最高 aoao 接单候选**
- **#61124 S** — Discord reconnect-exhausted crash during health-monitor restart；gateway crash，无标签；次高 aoao 接单候选
- **#61139 S** — k2p5 tools hang indefinitely on 2026.4.2（regression，降级到 2026.4.1 恢复）；M 级
- **#61115 S** — Plugin upgrade 不跑 npm install，feishu 等 npm 依赖插件加载失败；M 级
**无新发现**：InStreet（skill.md 仍是 API 文档）、Discord（需登录+discussions 410）、插件（weixin issue 不可抓取）
**建议**：aoao 接 #61142（最简单清晰）+ #61124（gateway crash 高优）

---

## xixi 第38轮扫描（2026-04-05 08:20 CST / 2026-04-05 00:20 UTC）
**新发现**：
- **#61095 S** — exec 工具继承 Gateway env vars，`OPENCLAW_SERVICE_*` 等导致 CLI 命令失败；修复：spawn 前清除相关 env；**最干净，1-2 小时可 PR**
- **#61097 S** — Gateway crash: `task_runs.requester_session_key` NOT NULL constraint；P0 清晰可复现；可修性 M
- **#61096 S** — /model 命令在主 provider rate-limited 时失效；5 层 allowlist gate 阻止 override
**无新发现**：InStreet 正常、Discord 不可扫、插件无新候选

---

## xixi 第37轮扫描（2026-04-05 07:20 CST / 2026-04-04 23:20 UTC）
**新发现**：
- **#61064 S** — MiniMax image-01 image-to-image 被 `supportsResolution: false` 误拦，1行可修；**最高可修候选**
- **#61059 M** — memorySearch.multimodal regression（2026.3.28→2026.4.2），Gemini adapter 未注册
- **#61055 S** — null byte 导致 CLI backend crash，`replaceAll('\0','')` 即可修
- **#61060 S** — Telegram 命令菜单超过 ~5,750 char 被静默丢弃 workspace skill commands
- **#61058 S** — secrets audit 误报 `${VAR}` 为 plaintext
- **#61066 M** — Docker build parse error in extensions/anthropic/register.runtime.ts:388
- **#61057 S** — Ubuntu 24.04 双路径静默配置失效
- **#61042 S** — plugin safety scanner 误拦 openclaw-quiubo
- **#61048 M** — Claude CLI headless 零 stdout（TTY 初始化阻塞）
- **#61043** — weixin auto-create agent 功能请求（代码不可见）
**无新发现**：InStreet（skill.md 仍是 API 文档）、Discord（需登录+discussions 404）、插件（weixin issue 不可抓取）
**建议**：aoao 接 #61064（最干净）+ #61055（最小改动）
**新发现**：
- **#61029 S** — Image generation Telegram 交付路径 mismatch（`tool-image-generation/---<uuid>.jpg` vs `output/<name>.png`），清晰 bug，有完整日志
- **#61050 S** — configure wizard claude-cli/ prefix regression（Pro 订阅用户被强制付 API token）
- **#61026** — Manual session stop 触发 false timeout error 并级联触发 model failover
- **#61028** — Cron jobs 在 gateway 重启后立即触发，timezone 在 catch-up 阶段被忽略
- **#61024** — fix: show 0% instead of 100%（已有 PR，size XS）
- **#61048** — Claude CLI backend zero stdout（launchd/systemd TTY 问题，较复杂）
**已有 PR 覆盖（跳过）**：#61037/#61038（Matrix infinite self-message loop）
**新发现**：
- **#60936 P1** — voice-call beta-blocker regression（STT provider 加载顺序 race condition，beta-blocker 维护者会快速响应）
- **#60926 P1** — Heartbeat 破坏 sub-agent session（PR #60934 已合并但 v2026.4.2 仍触发）
- **#60961 S** — OpenShell mirror mode 写文件失败（issue 已附 fix 代码）
- **#60959 S** — Google image generation 404（一行代码 fix）
- **#60963 S** — plugins.entries error message 可改进
- **#60970 S** — acpx 0.4.x session 创建静默失败（workaround 回退 0.3.1）

---

## xixi 第34轮补充（2026-04-04 23:26 UTC）

**新发现**：
- **#60921 P1** — Isolated cron + wecom 投递失败；根因：isolated session 无 channel context，delivery.channel 显式配置也被忽略；fix：在投递层从 delivery.channel 直接查 registry
- **#60905 P1** — sessions list exit code 0；XS 易修，CLI error path 未设置 process.exit(1)

**本轮无重大变化**：InStreet 正常、Discord 不可扫、插件无新候选

---

## 项目背景

**核心问题**:Feishu 群聊未显式绑定时,inbound routing 的实际行为缺乏 operator-facing 可见性。操作者无法确认是哪条 routing rule(显式 binding 还是 fallback)赢了。

**最终定位**:不是已确认的 bug,而是 **diagnostics / observability gap**。

---

## P1: Diagnostics Gap Issue

### 核心立场
- **不是**:confirmed routing bug
- **是**:diagnostics/observability gap - 当前行为未必错误,但操作者难以确认 winning routing rule
- **关键句**:`This report is not asserting wrong routing yet; it is asking for a clearer operator-facing way to confirm which routing rule won.`

### 已产出物
- [x] P1 英文 issue 草稿 v2(可直接贴 GitHub)
- [x] 方向已收敛:走 diagnostics gap 路线,不先定 bug
- [x] **已发布**:https://github.com/openclaw/openclaw/issues/54952

### 待办
- [ ] 观察 maintainer 反馈
- [ ] 基于反馈决定后续动作

---

## P2: Group Session Key Docs PR

### 核心立场
- canonical session key 与 routing 结果的关系需要 docs 澄清
- 最小改动补丁

### 已产出物
- [x] P2 最小 docs patch 大纲

### 待办
- [ ] 等 P1 issue 发售后,基于反馈决定提交时机
- [ ] 准备最小补丁 PR

---

## 决策记录

| 日期 | 决策 | 理由 |
|------|------|------|
| 2026-03-24 | P1 不按"routing bug"立题 | 证据不足时易被当误报 |
| 2026-03-24 | 走 diagnostics gap / docs gap 路线 | 避免被 fallback 设计解释掉 |
| 2026-03-24 | 先发 P1 issue,再发 P2 docs PR | 顺序已定 |
| 2026-03-24 | session key ≠ routing rule 解释器 | 关键结论,文档统一口径 |

---

## 每日进度日志
### 2026-04-05 14:56（gh feedback 检查 + xixi 第40轮新发现）
- **gh 反馈**：4 issues 全部无新动态（#54952/#54964 0条评论；#55008 EronFan 已知确认 skills regression 完全修复；#55013 Greptile review 与上轮相同）
- **xixi 第40轮新发现（14:17 CST）**：#61211（最高优先 XS，WhatsApp build fail）+ #61206（S，cron JSON Schema 400）+ #61186（M，Cron fs$1 crash）+ #61209/#61189/#61197/#61195（M/S 级）
- **已更新**：OPENCLAW-PROJECT.md 新增 P397-P399（3个新候选）
- **aoao 任务**：派出 #61211（最高优先 XS）和 #61206（S）去执行

### 2026-04-05 15:56（gh feedback 检查 + xixi 第40轮续扫确认）
- **gh 反馈**：4 issues 全部无新动态（#54952/#54964 0条；#55008 5条 EronFan 确认 skills regression 修复已知；#55013 1条 Greptile review 已知）
- **xixi 第40轮续扫确认（15:17 CST）**：3个新候选不在上轮优先级表格中：#61213（M，Web UI open_id/usability gap）、#59796（M，logs --follow pairing required regression）、#61193（M，exec approvals glob pattern 不匹配）
- **已更新**：OPENCLAW-PROJECT.md 新增 P404-P406（3个新候选）；P400-P403 已在上一轮录入
- **aoao 任务**：无新任务（新候选均为 M 级需特定环境）；#61218（LINE beta-blocker）已在上一轮派出

### 2026-04-05 15:26（gh feedback 检查 + xixi 第40轮续扫）
- **gh 反馈**：4 issues 全部无新动态（#54952/#54964 0条；#55008 5条 EronFan 确认 skills regression 修复已知；#55013 1条 Greptile review 已知）
- **xixi 第40轮续扫新发现（15:17 CST）**：#61223（M，Ollama thinking stream handler）、#61222（M，Telegram 重复消息）、#61219（M，LINE regression）、#61218（S，LINE beta-blocker，与 #61219 同源）
- **已更新**：OPENCLAW-PROJECT.md 新增 P400-P403（4个新候选）
- **#61211 状态**：aoao 已修复（commit dcb2bbf913），push 失败（token scope 问题），记录在 P59800
- **aoao 任务**：sessions_spawn 派出 #61218（LINE beta-blocker S 级）

### 2026-04-05 14:27（gh feedback 检查 + xixi 第40轮新发现）
- **gh 反馈**：4 issues 全部无新动态（#54952/#54964 0条评论；#55008 EronFan 确认 skills regression 完全修复；#55013 Greptile review 与上轮相同）
- **xixi 第40轮新发现（14:17 CST）**：#61211（WhatsApp build fail XS，纯加 export）、#61206（cron JSON Schema 400，S）、#61186（Cron fs$1 crash M）、#61209（Ollama 注册 M）、#61189（macOS node-host M）、#61197（vLLM reasoning drop S/M）、#61195（Telegram 启动静默失败 M）、#61210（feature dedup S）
- **已更新**：OPENCLAW-PROJECT.md 新增 P389-P396（8个新候选）
- **aoao 任务**：派出 #61211（最高优先 XS）和 #61206（S）去执行

### 2026-04-06 03:13（gh feedback 检查 + xixi 第47轮扫描）
- **gh 反馈**：4个 issues (#54952/#54964/#55008/#55013) 用 repo agentprotocol/apg 查询全部返回 404（应为 openclaw/openclaw）；无新反馈
- **xixi 第47轮扫描**（2026-04-05 18:55 UTC）：#61474 S（commentary 泄漏，1行 fix）和 #61465 S（compaction fetch failed regression）为最高优先
- **已派出**：aoao sessions_spawn 接单 #61474（最干净 fix）和 #61465（compaction regression）；runId ca319fca / 4796fe34

### 2026-04-06 06:16（gh feedback 检查 + xixi 第48轮续扫）
- **gh 反馈**：4 issues (#54952/#54964/#55008/#55013) 全部无新动态；#55008 EronFan 确认 skills regression 完全修复已知；#55013 Greptile review 已知
- **xixi 第48轮续扫**（2026-04-06 06:01 CST）：7个新候选；最高 #61524 S（security bypass）+ #61514 S（Canvas icon overlap）+ #61508 M（WS 1006 keepalive）；无 InStreet/Discord/插件新发现
- **已更新**：OPENCLAW-PROJECT.md 新增 P453（#61524 security bypass）；last-processed-report.md 已更新
- **已派出**：aoao sessions_spawn 接单 #61514（Canvas UI fix，runId 8466cbf3）和 #61524（security bypass，runId 89217cb8）

### 2026-04-06 10:26（gh feedback 检查 + xixi 无新报告）
- **gh 反馈**：4 issues (#54952 0条 / #54964 0条 / #55008 EronFan 确认 skills regression 修复已知 / #55013 Greptile review 已知) 全部无新动态
- **xixi 状态**：latest-scan-report.md 仍为 06:01 CST 报告，last-processed-report.md 已同步，无更新的扫描报告
- **结论**：无新反馈，无新 xixi 报告，正常继续

### 2026-04-06 02:55（xixi 第47轮扫描）
- **xixi 4方向扫描**（2026-04-05 18:55 UTC / 2026-04-06 02:55 CST）：
  - **GitHub**：4个全新未追踪 issue（#61474 S / #61470 无标签 / #61465 S / #61455 bug:crash）；#61474（commentary 泄漏 regression）和 #61465（compaction fetch failed regression）为最高优先 aoao 接单候选；#61472（OpenRouter 404 fallback fix，S）和 #61463（phase-aware text extraction，M）值得 review
  - **InStreet**：无（skill.md 仍为 API 文档）
  - **Discord**：无（需登录，discussions 404）
  - **插件**：无（weixin 代码不可见）
- **已更新**：OPENCLAW-PROJECT.md 新增 P441（#61474 commentary 泄漏）和 P442（#61465 compaction fetch failed）；xixi-reports/latest-scan-report.md 已更新
- **建议**：aoao 优先接单 #61474（最干净 fix）和 #61465（compaction regression）

### 2026-04-06 02:12（gh feedback 检查 + xixi 第46轮新发现）
- **gh 反馈**：4 issues 全部无新动态（#54952 0条；#54964 0条；#55008 Greptile review 已知；#55013 Greptile review 已知）
- **xixi 第46轮新发现（2026-04-05 17:45 UTC）**：P431-P440 共10个新候选（#61453 S/#61451 S/#61440 M/#61433 M/#61445 M/#61439 M/#61432 M/#61426 M/#61452 XS/#61448 S）
- **已更新**：OPENCLAW-PROJECT.md 新增 P431-P440（10个新候选）；last-processed-report.md 已更新
- **aoao 任务**：sessions_spawn 派出 #61453（exec-approvals socket，优先）和 #61451（allowlist args bug，次优先）

### 2026-04-06 01:12（gh feedback 检查 + xixi 第45轮新发现）
- **gh 反馈**：4 issues 全部无新动态（#54952 0条；#54964 0条；#55008 Greptile review 已知；#55013 Greptile review 已知）
- **xixi 第45轮新发现（2026-04-06 00:45 CST）**：P427-P430 共4个新候选（#61426 M/#61414 S/#61395 S/#61411 S）
- **已更新**：OPENCLAW-PROJECT.md 新增 P427-P430（4个新候选）；last-processed-report.md 已更新
- **aoao 任务**：sessions_spawn 两次均超时（gateway unreachable）；#61395（lightContext bug，根因已定位）和 #61411（OpenRouter fallback chain）待下次可送达时派出

### 2026-04-05 10:27（gh feedback 检查 + xixi 第39轮报告）
- **gh 反馈**：4 issues 全部无**新**动态（#54952/#54964 无评论；#55008 确认 skills regression 完全修复已知；#55013 Greptile review 内容与上轮相同）
- **xixi 第39轮新发现**：#61142（最优先 Telegram caption bug）+ #61124（Discord gateway crash）+ #61139（k2p5 tools hang）+ #61115（plugin upgrade npm install 缺失）
- **已更新**：OPENCLAW-PROJECT.md 新增 P385-P388（4个新 S 级）；xixi 报告链已补充第38/39轮
- **aoao 任务**：sessions_spawn 派出 #61142（最高优先）和 #61124（次高）

---

### 2026-04-05 00:29（gh feedback 检查 + xixi 第35轮报告）
- **gh 反馈**：4 issues (#54952/#54964/#55008/#55013) 全部无新动态
- **xixi 第35轮新发现**：#31583 升级为最高优先级（exec tool 不继承 skills.entries.*.env，多版本 regression v2026.3.12~v2026.4.2）；候选集合与上轮相同（#42054、#60929、#60921、#60905）
- **已更新**：OPENCLAW-PROJECT.md 新增 P349（#31583）；last-processed-report.md 已更新
- **aoao 任务**：#60921（来自上轮）仍在追踪；#31583 新增为 aoao 候选

### 2026-04-04 23:44（gh feedback 检查 + xixi 第34轮报告）
- **gh 反馈**：4 issues (#54952/#54964/#55008/#55013) 全部无新动态
- **xixi 第34轮新发现**：#60921 P1（isolated cron + wecom 投递失败，regression）；#60905 P1（sessions list exit code 0，XS）
- **已更新**：OPENCLAW-PROJECT.md 新增 P348（#60921）；last-processed-report.md 已更新
- **aoao 候选**：#60921（isolated cron投递失败，channel上下文缺失）

### 2026-04-04 13:47（gh feedback 检查 - #55008 和 #55013 有重要更新）
- **#55008 新动态**：Greptile review 指出 P1 regression（误删 feishu skills 注册）+ P2（中文文档直接编辑违规），但 maintainer EronFan 已确认修复：
  - commit `bb2ea2f7e4` — 恢复 `extensions/feishu/openclaw.plugin.json` 中 `"skills": ["./skills"]`
  - commit `b14be82db1` — 同步恢复 generated metadata
  - **结论：PR diff 现在只包含 docs 变更，skills regression 完全修复，PR 可合并 ✅**
- **#55013 新动态**：Greptile review 指出两文件中 `groupPolicy` 描述不准确（说它"选择 agent"实际是"访问控制"），groupPolicy 控制 `open/allowlist/disabled`，不决定哪个 agent 处理消息
  - 需要 ling 修复 `docs/channels/feishu.md` 和 `docs/gateway/configuration-reference.md` 中 groupPolicy 的描述
- **#54952 / #54964**：0 条评论，无新进展

### 2026-04-04 13:17（xixi 第30轮扫描 + gh feedback 超时）
- **xixi 4方向扫描**（2026-04-04 05:17 UTC）：
  - **方向1 GitHub**：发现 #60685（S，telegram 循环依赖启动崩溃，根因清晰）+ #60656（S，MCP 内存泄漏 13.5 GiB）+ #60663（Transcript 模型报告错误）+ #60679（Ollama 静默失败 regression）+ #60687（XS，启动警告）+ #58691（exec.ask=off 被忽略 regression）
  - **方向2 InStreet**：无
  - **方向3 Discord/Discussions**：无（需登录，GitHub discussions 返回 404）
  - **方向4 插件**：无新公开问题
- **gh 反馈检查**：4个 issues (#54952/#54964/#55008/#55013) 全部超时（timeout 15s），无法获取评论
- **已更新**：OPENCLAW-PROJECT.md 新增 P325-P330（当前优先级表格）
- **已保存**：last-processed-report.md
- **aoao 任务**：sessions_send 失败（gateway closed: pairing required），aoao 不可达；待 gateway 恢复后补派

### 2026-03-31 18:14(sessions_send 发送失败)
- **问题**:main 会话的 Feishu 群聊会话已结束(status: done)
- **会话 key**:agent:main:feishu:default:direct:ou_5abeeb52afc248214694d8d79ab20df8
- **结束时间**:2026-03-31 02:33 UTC(约 16 小时前)
- **影响**:无法通过 sessions_send 向 main 发送扫描报告
- **扫描报告**:见下方 2026-03-31 18:14(4方向扫描 - 第29轮扫描)
- **项目文件**:已更新 OPENCLAW-PROJECT.md(P46-P60待添加到当前优先级表格)

### 2026-03-31 18:14(4方向扫描 - 第29轮扫描)
- **xixi 4方向扫描**(2026-03-30 18:14 UTC):
- **方向1(GitHub issues/PRs)**:发现20+个最近2小时内更新的issues/PRs(#584xx-#585xx),其中10+个为高优先级新发现
  - **P0 #58519** - Slack Socket Mode: event loop starvation causes pong timeouts and silent message loss
  - **P0 #58496** - [Critical Bug] Session Model Override Prevents Fallback Mechanism
  - **P1 #58493** - HTTP /v1/chat/completions: Bearer token auth succeeds but agent run fails with 'missing scope: operator.write'
  - **P1 #58486** - Claude MAX OAuth credentials leak to non-Anthropic providers (OpenRouter)
  - **P1 #58518** - LiveSessionModelSwitchError triggers for isolated sessions on heartbeat/cron
  - **P1 #58517** - Heartbeat model override ignored - always falls back to default model
  - **P1 #58514** - Google Chat: Space/Group messages silently ignored
  - **P1 #58513/58511/58506** - Cron sessions inherit persisted model override instead of honoring payload.model
  - **P1 #58512/58510** - resolvePersistedLiveSelection() overrides emergency failover decisions
  - **P1 #58508** - url-fetch SSRF policy blocks api.telegram.org file CDN
  - **P1 #58507** - Config validation rejects enrichGroupParticipantsFromContacts in 2026.3.28
  - **P1 #58485** - Isolated cron sessions ignore `payload.model` override
  - **P1 #58484** - Heartbeat session gets permanently stuck on fallback model after single failure
  - **P1 #58481** - WhatsApp WebSocket drops on WSL2 - missing TCP keepalive
  - **P1 #58480** - WhatsApp creds.json corrupted on every reconnect - race condition
  - **P1 #58479** - Approval dialog succeeds in Control UI, but exec never consumes approval
  - **P1 #58470** - Gateway startup doesn't clear stale 'running' status in sessions.json
  - **值得Review的PRs**:#58499(Browser CDP修复)、#58489(Telegram Topic路由修复)
- **方向2(InStreet社区)**:扫描到 InStreet Agent Skill 平台(https://instreet.coze.site/skill.md),未发现 OpenClaw 相关实战问题
- **方向3(Discord/GitHub discussions)**:Discord 需要登录认证无法直接访问;GitHub discussions 无有效数据
- **方向4(插件仓库)**:web_search 未发现 openclaw-weixin 相关仓库的新issues
- **xixi 结论**:本次扫描发现10+个高优先级新issues,最高优先级是#58519(Slack消息丢失)+ #58496(Session Model Override阻止回退)+ #58493(HTTP API权限regression)
- **建议**:aoao优先修复#58519(Slack消息静默丢失)+ #58496(会话模型覆盖阻止fallback)+ #58493(API权限regression)
- 已更新:P46-P60(待添加到当前优先级表格)

### 2026-03-31 18:30(sessions_send 发送失败)
- **问题**:main 会话的 Feishu 群聊会话已结束(status: done)
- **会话 key**:agent:main:feishu:group:oc_f68e4447ecaeb604046c3d8ef84681f3
- **结束时间**:2026-03-31 02:33 UTC(约 8 小时前)
- **影响**:无法通过 sessions_send 向 main 发送扫描报告
- **扫描报告**:已保存在本次 cron 的回复中
- **项目文件**:已更新 OPENCLAW-PROJECT.md(P275-P278)

### 2026-03-31 19:31(sessions_send 发送失败)
- **问题**:main 会话的 Feishu 群聊会话可能已结束或不可达
- **会话 key**:agent:main:feishu:group:oc_f68e4447ecaeb604046c3d8ef84681f3
- **超时时间**:2026-03-31 11:31 UTC(runId: ebb73fac-ae60-42ee-81e9-e6a3dad39071)
- **影响**:无法通过 sessions_send 向 main 发送扫描报告
- **扫描报告**:已保存在本次 cron 的回复中
- **项目文件**:已更新 OPENCLAW-PROJECT.md(P280)

### 2026-03-31 19:28(4方向扫描 - 第28轮扫描)

- **xixi 4方向扫描**(2026-03-31 11:28 UTC):
- **方向1(GitHub issues/PRs)**:发现大量最近2小时内更新的issues/PRs(从#58202到#58339),但都在项目文件中已追踪(P66-P274),无新增未追踪项
- **方向2(InStreet社区)**:扫描到 InStreet Agent Skill 平台(https://instreet.coze.site/skill.md),这是一个独立的中文 AI Agent 社交网络,包含论坛、Playground(炒股竞技场、文学社、预言机)、小组、关注系统;未发现 OpenClaw 相关实战问题
- **方向3(Discord/GitHub discussions)**:Discord 需要登录认证无法直接访问;GitHub discussions 页面返回 404(未启用)
- **方向4(插件仓库)**:发现多个 openclaw-weixin 相关仓库:
  - Xueheng-Li/openclaw-wechat
  - hao-ji-xing/openclaw-weixin(有近期 issues,#14 创建于 2026-03-30)
  - freestylefly/openclaw-wechat
  - laolin5564/openclaw-wechat
- **xixi 结论**:本次扫描没有发现新的未追踪的 GitHub issues;InStreet 是独立的 AI Agent 社区平台;插件仓库中发现多个 openclaw-weixin 相关项目,hao-ji-xing 仓库有近期 issues
- **建议**:检查 hao-ji-xing/openclaw-weixin 的 issue #14(2026-03-30),可能包含 weixin 相关 bug

### 2026-03-31 18:30(sessions_send 发送失败)
- **问题**:main 会话的 Feishu 群聊会话已结束(status: done)
- **会话 key**:agent:main:feishu:group:oc_f68e4447ecaeb604046c3d8ef84681f3
- **结束时间**:2026-03-31 02:33 UTC(约 17 小时前)
- **影响**:无法通过 sessions_send 向 main 发送扫描报告
- **扫描报告**:已保存在本次 cron 的回复中
- **项目文件**:已更新 OPENCLAW-PROJECT.md(P279)

### 2026-03-31 18:28(4方向扫描 - 第27轮新发现)

- **xixi 4方向扫描**(2026-03-31 10:28 UTC):
- **方向1(GitHub issues/PRs)**:发现4个最近2小时内更新的PRs(无新issues)
  - **#58236(新)** - fix(nostr): verify inbound dm signatures before pairing replies(S,maintainer)
  - **#58224(新)** - fix(media): drop auth headers on cross-origin redirects(S,maintainer)
  - **#58220(新)** - fix(agents): reject escaping symlinks in ssh sandbox uploads(S,maintainer)
  - **#58177(新)** - fix(config): redact Nostr privateKey in config views(M,maintainer)
- **方向2(InStreet社区)**:无(扫描到InStreet Agent Skill平台文档,未发现OpenClaw相关问题)
- **方向3(Discord/GitHub discussions)**:无(web_search返回的Discord相关issues均为老issues,不在最近2小时更新范围内)
- **方向4(插件仓库)**:无(web_search返回的weixin相关issues均为老issues,不在最近2小时更新范围内)
- **xixi 结论**:本次扫描发现4个新PRs(均为security/safety相关修复),无新issues;这些PRs由maintainer vincentkoc提交,涉及Nostr、media、agents、config模块
- **建议**:关注这些PRs的review进展,#58220(SSH sandbox symlink安全)和#58236(Nostr DM签名验证)值得重点review
- 已更新:P275-P278

### 2026-03-31 15:28(4方向扫描 - 第26轮新发现)
- **xixi 4方向扫描**(2026-03-31 07:28 UTC):
- **方向1(GitHub issues)**:发现30+个最近2小时内创建/更新的issues/PRs
  - **#58173(新)** - [Bug]: Discord bot tokens auto-reset due to excessive reconnects without backoff(高优先级)
  - **#58190(新)** - CLI `openclaw browser start` fails: `unknown method: browser.request`(高优先级)
  - **#58189(新)** - [Bug]: When I use VLLM to deploy QWEN3-31B, I get stuck in a loop(高优先级)
  - **#58176(新)** - [Bug]: Generic CLI-backed subagent completions can return `(no output)`(高优先级)
  - **#58152(新)** - Control UI: session model override dropdown does not take effect (webchat)(高优先级)
  - **#58187(新)** - fix(config): DATABASE_URL missing warning fires 3310+ times per run(中等优先级)
  - **#58158(新)** - macOS 2026.3.28 - camera.snap not in node command allowlist(高优先级)
  - **#58164(新)** - Control UI 语音输入按钮点击无(中等优先级)
  - **#58150(新)** - [Bug]: RISC-V64: OpenClaw fails with LLM request failed: network connection error(高优先级)
  - **相关PR发现**:
    - **#58208** - fix: omit disabled OpenAI reasoning payloads
    - **#58207** - fix: scope session create aliases to requested agent
    - **#58205** - Fix subagent sessions send reactivation
    - **#58203** - fix(exec): unwrap arch and xcrun dispatch wrappers
    - **#58202** - fix(exec): block proxy-style env overrides
    - **#58198** - fix(discord): add total timeout for large attachment downloads
    - **#58194** - fix(agents): persist generic CLI transcript for completion capture(修复#58176)
    - **#58178** - fix(agents): handle LiveSessionModelSwitchError in subagent execution
- **方向2(InStreet社区)**:无(扫描到InStreet平台文档,未发现OpenClaw相关问题)
- **方向3(Discord/GitHub discussions)**:无(Discord需要登录认证无法直接访问;GitHub Discussions为空)
- **方向4(插件仓库)**:无(openclaw-weixin仓库不存在或不可公开访问)
- **xixi 结论**:本次扫描发现9个新issues(排除已有追踪项),其中最高优先级是#58173(Discord bot tokens auto-reset)+ #58190(浏览器功能失效)+ #58176(子代理完成消息丢失)
- **建议**:aoao优先修复#58173(Discord bot重连无退避,导致token被自动重置)+ #58190(CLI browser start失败)+ #58176(Generic CLI-backed subagent completions返回no output)
- 已更新:P272-P280

### 2026-03-31 14:04(4方向扫描 - 第24轮新发现)
- **xixi 4方向扫描**(2026-03-31 06:04 UTC):
- **GitHub 8个新候选**:
  - **#57490 P1** - Cron job model override broken by LiveSessionModelSwitchError(cost增加3x+)
  - **#57814 P2** - openai-codex/gpt-5.4 WebSocket connect failed 500(streaming失效)
  - **#57447 P2** - sessions_send blocked by visibility guard(cross-agent messaging受阻)
  - **#57430 P2** - Reasoning required error on OpenRouter provider
  - **#56948 P2** - browser start command not found in v2026.3.28
  - **#56780 P2** - memory-lancedb fails to load
  - **#54303 P2** - 定时任务微信投递失败
  - **#52186 P2** - TTS elevenlabs generates audio but OpenClaw plays OpenAI voice
- **InStreet**:1个实战问题(n8n + Browser-use 内网穿透方案讨论)
- **Discord**:0
- **插件**:0
- **结论**:#57490 是最高优先级(P1,cron model失效导致cost增加3x+)
- 已更新:P267-P274
- aoao 会话仍不可达(持续超时 >10 小时)

### 2026-03-31 12:28(4方向扫描 - 第23轮新发现)
- **xixi 4方向扫描**(2026-03-31 04:28 UTC):
- **GitHub 22个新候选**(6个P0/P1,6个P3,10个PRs):
  - **#58119 P0** - 微信通道每天 contextToken 过期断连,需手动重连(bug)
  - **#58109 P0** - v2026.3.28 - Voice transcription broken + web search config stripped on update(regression)
  - **#58107 P1** - Multiple Feishu group agents - only main reply delivered(bug+regression)
  - **#58108 P1** - Third-party plugin @cc-soul/openclaw ships obfuscated code, auto-starts background daemon(安全漏洞)
  - **#58106 P1** - OpenRouter models hidden in model picker(PI auth discovery失败)
  - **#58115 P1** - Bug: voice_call tool fails with EADDRINUSE(端口冲突)
  - **#58117 P3** - [Feature]: Mistral Voxtral TTS provider support
  - **#58114 P3** - test(plugins): reset providers runtime modules per case
  - **#58110 P3** - Feature Request: Multi-Agent Support with Chat-Style UI
  - **#58113 P3** - Bug: memory-lancedb-pro 与 LCM 并发初始化导致事务嵌套冲突
  - **#58111 P3** - macOS launchd service uses hybrid node/dist paths
  - **#58104 P3** - [Feature]: Feishu built-in skill: feishu-sheet is missing
  - **#58105 P3** - Cron: support multi-channel delivery (fanout)
- **InStreet**:0(扫描到InStreet Agent平台文档,未发现OpenClaw相关内容)
- **Discord**:0(需要登录认证,无法抓取)
- **插件**:0(openclaw-weixin仓库404,代码不公开)
- **结论**:#58109和#58119是最高优先级,都是P0级严重问题
- 已更新:P254-P266

### 2026-03-31 11:28(4方向扫描 - 第22轮新发现)
- **xixi 4方向扫描**(2026-03-31 03:28 UTC):
- **GitHub 6个新候选**:
  - **#58087 P1** - SecretRef-backed model provider headers regression(v2026.3.28,100% reproducible,401认证失败)
  - **#58084 P1** - HTTP 400 JSON schema invalid - blocks all tool use(所有工具调用被阻塞)
  - **#58085 P1** - sessions_spawn returns (allowed: none) for subagent runtime(阻塞 task parallelization)
  - **#58083 P1** - Cron isolated jobs lose true isolation(sessionKey 泄露,模型冲突)
  - **#58090 P1** - openclaw doctor wipes session.resetByType config(配置漂移)
  - **#58095 P1** - pa-coding reactions field invalid(字段名错误)
- **InStreet**:0
- **Discord**:0
- **插件**:0
- **结论**:#58087 和 #58084 是最高优先级,都严重影响核心功能
- 已更新:P248-P253
- aoao 会话仍不可达(session ended 2026-03-30 03:02,持续超时)

### 2026-03-30 19:55(4方向扫描 - 第21轮新发现)
- **xixi 4方向扫描**(2026-03-30 11:55 UTC):
- **GitHub 23个新候选**(17个P1,6个P2):
  - **#57627 P0** - CRITICAL: Web UI chat desynchronization - messages sent to wrong session
  - **#57626 P1** - Model switch to unresponsive Ollama cascades into infinite loop, corrupts session
  - **#57675 P1** - Telegram DM fails with deactivated_workspace on macOS
  - **#57663 P1** - MiniMax M2.7 persistent 408 timeouts not surfaced (4+ minute delays)
  - **#57661 P1** - agent-to-agent session_send timeout
  - **#57660 P1** - Telegram polling stall detector fires too aggressively (110s)
  - **#57659 P1** - Corrupted session causes infinite WebSocket 500 retry loop
  - **#57620 P1** - deleteAfterRun only disables jobs, doesn't delete them
  - **#57619 P1** - Subagent/cron messages not delivered to WeChat (openclaw-weixin)
  - **#57618 P1** - Mattermost config rejected after upgrade to 2026.3.28
  - **#57617 P1** - Parent session stuck after subagent abort
  - **#57613 P1** - heartbeat.model/cron --model overrides blocked
  - **#57606 P1** - Telegram long-poll hangs indefinitely on dead TCP socket
  - **#57602 P1** - Channel WebSocket abnormal closure crashes gateway
  - **#57601 P1** - Cron jobs via CLI don't send scheduled messages to Telegram
  - **#57588 P1** - Security: fetch-auth bearer token fallback attaches tokens to arbitrary URLs
  - **#57581 P1** - LiveSessionModelSwitch blocks isolated cron sessions
  - **#57678 P2** - SKILL.md frontmatter YAML parse failure silently drops skill
  - **#57599 P2** - skills list --json writes to stderr (已有PR #57632)
  - **#57594 P2** - Zalo channel rejects valid non-numeric chat_id values
  - **#57589 P2** - Openclaw command shows incorrect current version (已有PR #57665)
  - **#57586 P2** - Node system.run fails: Remote app does not advertise system.run.prepare
- **InStreet**:0
- **Discord**:无法访问
- **插件**:0
- **建议**:aoao优先修复#57627(Web UI消息路由错误)+ #57626(Ollama无限循环)+ #57675(Telegram DM失效)
- 已更新:P204-P226

### 2026-03-31 06:25(main 转发超时)
- **第三次转发超时**:sessions_send 返回 timeout(runId: bb5962d4-51b9-4aa2-af84-5afe7ddcbf85)
- **尝试转发的 bug**(来自 xixi 第 21 轮扫描):
  - **#57950 P0** - browser.request missing at runtime despite browser plugin loaded
  - **#57956 P1** - Anthropic type: "token" auth profiles broken in v2026.3.28
  - **#57947 P1** - Cron payload model override ignored
  - **#57945 P1** - Isolated agentTurn cron jobs fail
  - **#57939 P1** - Gateway default model not updated after models set + restart
  - **#57935 P1** - Telegram incoming messages not received after gateway restart
  - **#57928 P1** - session.tool/session.message events don't carry originating sessionKey
- **根因分析**:可能是 aoao session 的 deliveryContext.channel 配置问题(预期是 `feishu`,实际可能是 `webchat`)
- **下一步**:需要修复 aoao session 配置或重启 session

### 2026-03-31 03:43(main 转发超时)
- **第一次转发超时**:sessions_send 返回 timeout(runId: bc7e8079-3752-44bc-b5a5-c3b12a38a5d2)
- **第二次转发超时**:sessions_send 返回 timeout(runId: dc66d32d-f4fc-4136-a484-b716b7ec52e3)
- **尝试转发的 bug**(来自 xixi 第 21 轮扫描):
  - **#57627 P0** - Web UI chat desynchronization - messages sent to wrong session
  - **#57626 P1** - Model switch to unresponsive Ollama cascades into infinite loop
  - **#57675 P1** - Telegram DM fails with deactivated_workspace on macOS
  - **#57663 P1** - MiniMax M2.7 persistent 408 timeouts not surfaced
  - **#57661 P1** - agent-to-agent session_send timeout(与我们 multi-agent 协作直接相关)
  - **#57660 P1** - Telegram polling stall detector fires too aggressively (110s)
- **根因分析**:aoao session 的 deliveryContext.channel 是 `webchat`,应该是 `feishu`(AGENTS.md 配置)
- **下一步**:需要修复 aoao session 配置或重启 session

### 2026-03-30 16:17(4方向扫描 - 第19轮新发现)
- **xixi 4方向扫描**(2026-03-30 08:17 UTC):
- **GitHub 12个新候选**(9个P1,3个P2):
  - **#57523 P1** - Kimi k2p5 provider完全失效(event order错误)
  - **#57573 P1** - Kimi web search multi-turn失败(reasoning_content缺失)
  - **#57571 P1** - Cron isolated sessions ignore payload.model override
  - **#57570 P1** - openclaw config命令无响应
  - **#57567 P1** - Configuration Migration Failure (v3.24 → v3.28)
- **InStreet**:0
- **Discord**:0
- **插件**:0
- **建议**:aoao优先修复#57523(Kimi完全失效)+ #57567(升级阻塞)
- 已更新:P199-P203

### 2026-03-30 15:31(4方向扫描 - 第18轮新发现)
- **xixi 4方向扫描**(2026-03-30 06:55 UTC):
- **GitHub 85个新候选**(过去2小时更新),重点:
  - **#57551 P0** - kimi无限递归重试(edit工具参数错误导致token耗尽)
  - **#57550 P0** - HTTP API Token auth broken(CVE修复 collateral damage,所有RESTful API中断)
  - **#57540 P1** - Isolated cron sessions fail with LiveSessionModelSwitchError
  - **#57538 P1** - claude-haiku-4-5 missing from bundled catalog(cost regression 5-6x)
  - **#57536 P1** - feishu tenant_access_token获取失败(返回400)
  - **#57452 P1** - Telegram media download被SSRF guard拦截
- **InStreet**:0个实战问题
- **Discord**:无法访问
- **插件**:#57536(feishu鉴权)、#57452(SSRF)
- **结论**:#57551和#57550是最高优先级,都是2026.3.28严重regression
- 已更新:P193-P198

### 2026-03-30 13:55(社区机会扫描 - 第17轮新发现)
- **xixi 4方向扫描**(2026-03-30 05:55 UTC):
- **方向1(GitHub issues)**:发现大量最近2小时内更新的issues/PRs,其中10个新issue + 10个新PR
  - **#57501(新)** - isolated session 模型切换死循环(高优先级bug,模型切换逻辑问题)
  - **#57498(新)** - Image recognition bypasses OpenRouter attribution headers(高优先级bug,计费问题)
  - **#57497(新)** - Feature Request: Support PostgreSQL for Session Storage(功能请求)
  - **#57492(新)** - fix(types): skills.test-helpers.ts references removed(类型修复)
  - **#57491(新)** - Cron delivery fails with 'Unknown Channel'(高优先级bug,cron系统问题)
  - **#57490(新)** - Cron job model override silently broken(高优先级bug,cron模型覆盖问题)
  - **#57489(新)** - modelByChannel override reverted by live session model switch(高优先级regression,2026.3.28)
  - **#57471(今天早些发现)** - runWithModelFallback() treats LiveSessionModelSwitchError as candidate_failed(中等优先级bug)
  - **#57461(今天早些发现)** - MCP tools return data in structuredContent only(高优先级可用性问题)
  - **新PRs**:#57507(multi-kind plugins)、#57508(facade recursion guard)、#57505(Matrix bot loops)、#57496(Google provider config)、#57479(AuthVault)、#57502(Discord targetResolver)、#57499(Azure reasoning replay)、#57493(memory cli context)、#57488(bundled channels allowlist)、#57484(WhatsApp commentary)
- **方向2(InStreet社区)**:无(扫描到InStreet平台文档,未发现OpenClaw相关问题)
- **方向3(Discord/GitHub discussions)**:无(web_search搜索到的结果都是已知的GitHub issues,Discord需要认证无法直接访问)
- **方向4(插件仓库)**:无法访问(openclaw/openclaw-weixin 仓库不存在或不可公开访问)
- **xixi 结论**:本次扫描发现10个新issues(3个高优先级:#57501、#57498、#57491/#57490/#57489)和10个新PRs;最高优先级是#57501(isolated session模型切换死循环)和#57498(OpenRouter计费绕过)

### 2026-03-30 12:42(社区机会扫描 - 第16轮新发现)
- **xixi 4方向扫描**(2026-03-30 04:42 UTC):
- **方向1(GitHub issues)**:发现4个最近2小时内更新的issues/PRs,其中2个为新发现
  - **#57461(今天创建)** - MCP tools return data in structuredContent only - Cursor and Claude.ai only read content(高优先级可用性问题,影响MCP客户端)
  - **#57471(今天创建)** - runWithModelFallback() treats LiveSessionModelSwitchError as candidate_failed, causing unnecessary fallback chain(中等优先级bug,模型回退链误判错误类型)
  - **#55224(之前已记录)** - [Bug] Tool parameters randomly dropped in long sessions (exec/write/sessions_spawn)
  - **#57219(之前已记录)** - plugins.allow allowlist silently blocks bundled Telegram channel plugin
  - **#26534(老issue,stale)** - Add DingTalk as a first-install channel option
- **方向2(InStreet社区)**:无(扫描到InStreet平台文档,未发现OpenClaw相关问题)
- **方向3(Discord/GitHub discussions)**:无(web_search搜索到的结果都是已知的GitHub issues,没有新的Discord社区讨论)
- **方向4(插件仓库)**:无法访问(openclaw/openclaw-weixin 仓库返回 404,可能不存在或不可公开访问)
- **xixix 结论**:本次扫描发现2个新创建的issues(#57461、#57471),都是今天扫描范围内创建的,值得关注;#57461影响MCP客户端(Cursor/Claude.ai),#57471影响模型回退链行为

### 2026-03-30 10:42(社区机会扫描 - 第15轮新发现)
- **xixi 4方向扫描**(2026-03-30 02:42 UTC):
- **方向1(GitHub issues)**:发现50个最近2小时内更新的issues/PRs,其中45个为新发现
  - **#57391(P0)** - Bug: unrecognized key in openclaw.json causes infinite gateway crash loop with no recovery(最严重,无法恢复)
  - **#57412** - Regression in 2026.3.28: Telegram image/media download fails(Telegram功能失效)
  - **#57410** - Compaction results in full context reset instead of compression(上下文管理问题)
  - **#57408** - Bug: project-local .env is ignored in 2026.3.28(配置问题)
  - **#57399** - Bug: OAuth token refresh silently fails for openai-codex provider(认证问题)
  - **#57398** - Bug: Gateway startup hangs on(网关启动问题)
  - **#57397** - Bug: Openclaw + Browserless (Docker) Browser CDP connection fails(浏览器连接问题)
  - **#57396** - Bug: image_generate tool-result auto delivery may miss local media(工具问题)
  - **#57394** - fix(plugins): infinite recursion in facade module loader crashes xai, sglang, vllm(插件加载器严重bug)
  - **#57386** - Bug: Google Chat webhook returns 401 Unauthorized(Google Chat问题)
  - 其他36个issues/PRs详见表格
- **方向2(InStreet社区)**:无(扫描到InStreet平台文档,未发现OpenClaw相关问题)
- **方向3(Discord/GitHub discussions)**:无(GitHub discussions需要登录认证,web_fetch无法访问)
- **方向4(插件仓库)**:发现2个weixin相关issues
  - **#57384** - [Bug]: openclaw-weixin may lose the final reply after multi-tool agent turns(高优先级bug)
  - **#57401** - OpenClaw Skill 微信交流群(enhancement)
- **xixi 4方向扫描**(2026-03-30 01:42 UTC):
- **方向1(GitHub issues)**:发现27个最近2小时内更新的issues,其中23个为新发现
  - **P0 #57391** - 无限崩溃循环:unrecognized key in openclaw.json causes infinite gateway crash loop with no recovery(最严重,无法恢复)
  - **#57386** - Google Chat回归:webhook returns 401 Unauthorized - all versions 2026.3.23+(bug+regression标签)
  - **#57385** - Subagent completion不路由:Sub-agent completion announces don't route to originating Telegram session
  - **#57384** - weixin通道回归:openclaw-weixin may lose the final reply after multi-tool agent turns
  - 其他19个issues详见表格
- **方向2(InStreet社区)**:无(扫描到InStreet平台文档,未发现OpenClaw相关问题)
- **方向3(Discord/GitHub discussions)**:无(GitHub discussions无有效数据,Discord未抓取)
- **方向4(插件仓库)**:weixin相关issue(#57384)已在方向1中记录

### 2026-03-30 12:33(反馈检查 - #55008 maintainer EronFan 确认 skills regression 完全修复,PR 可合并)
- **#55008 新动态**:EronFan (2026-03-30T01:23:46Z = 北京 09:23) 再次确认 skills regression 完全修复:
  - `bb2ea2f7e4` - 恢复 `extensions/feishu/openclaw.plugin.json` 中 `"skills": ["./skills"]`
  - `b14be82db1` - 在 `src/plugins/bundled-plugin-metadata.generated.ts` 中同步恢复
  - **结论:PR diff 现在只包含 docs 变更,skills 注册问题已完全修复,4 个 feishu skills 可正常注册**
  - **状态:PR 可合并 ✅**
- **#55008 补充动态**:EronFan (2026-03-30T00:59:38Z = 北京 08:59) 解释修复原因:
  - feishu skills (feishu-doc, feishu-drive, feishu-perm, feishu-wiki) 在 `extensions/feishu/skills/` 目录中
  - 需要 `skills` 字段才能被发现
  - commit `bb2ea2f7e4` 恢复了 `openclaw.plugin.json` 中的 skills 字段和对应的 generated metadata
- **#55013**:仍只有 Greptile 旧评论(2026-03-26),无 maintainer 人为反馈
- **#54952 / #54964**:0 条评论,无新进展
- **#55008 新动态**:EronFan (2026-03-30T01:23:46Z = 北京 09:23) 再次确认 skills regression 完全修复:
  - `bb2ea2f7e4` - 恢复 `extensions/feishu/openclaw.plugin.json` 中 `"skills": ["./skills"]`
  - `b14be82db1` - 在 `src/plugins/bundled-plugin-metadata.generated.ts` 中同步恢复
  - **结论:PR diff 现在只包含 docs 变更,skills 注册问题已完全修复,4 个 feishu skills 可正常注册**
  - **状态:PR 可合并 ✅**
- **#55013**:仍只有 Greptile 旧评论(2026-03-26),无 maintainer 人为反馈
- **#54952 / #54964**:0 条评论,无新进展

### 2026-03-30 09:58(反馈检查 - #55008 maintainer 确认 skills regression 完全修复)
- **#55008 新动态**:EronFan (2026-03-30T01:23:46Z = 北京 09:23) 在 PR #55008 发了一条重要评论:
  - 标题:**"✅ Skills regression fully fixed"**
  - 内容:Two commits have been applied to `docs/clarify-message-channel-plugin-extensibility` - skills regression 已完全修复
  - **状态:PR 可能即将合并,这是正面进展**
- **#55013**:仍只有 Greptile 旧评论(2026-03-26),无 maintainer 人为反馈
- **#54952 / #54964**:0 条评论,无新进展

### 2026-03-30 09:57(4方向扫描 - GitHub 新发现)
- **xixi 新发现 P0 #57391** - Infinite crash loop:unrecognized key in openclaw.json causes infinite gateway crash loop with no recovery
- **#57386** - Google Chat regression:webhook returns 401 Unauthorized all versions 2026.3.23+
- **#57384** - weixin 相关 issue
- 4方向扫描:GitHub(27个新候选)、InStreet(无)、Discord(无)、插件(weixin)
- aoao 状态:#57291 PR 已提交 #57352,确认收到第一批任务

### 2026-03-30 08:53(社区机会扫描 - 第二轮新发现)
- **xixi 新发现 5 个问题**(2026-03-30 00:42 UTC):
- **P0 #57349** - Heap exhaustion OOM during filesystem scan(Gateway 运行 17-20 小时后 OOM,webchat 打开时加速崩溃)
- **P1 #57334** - Memory-core session indexer skips .jsonl.reset/.deleted files(只有 211/485 个 session 被索引)
- **P1 #57353** - SSH commands SIGKILL'd when stdout exceeds ~1.2KB burst
- **P2 #57348** - VS Code ACP prompts hang on Windows(WebSocket 1006 + ECONNREFUSED)
- **P2 #57339** - Telegram plugin approval buttons don't work(只处理 exec.approval,忽略 plugin.approval)

### 2026-03-30 07:46(社区机会扫描 - 第 12 小时新发现)
- **xixi 新发现 6 个高优先级问题**(2026-03-29 21:42-23:42 UTC):
- **P0 #57321** - Matrix delivery-recovery crash(永久性消息丢失,room ID 大小写问题)
- **P0 #57303** - Kubernetes gateway OOM regression(2026.3.28 内存溢出)
- **P1 #57333** - Webchat 消息路由到 subagent 而不是 main
- **P1 #57306** - sessions_spawn model 参数失效
- **P1 #57291** - Discord WebSocket 重连崩溃(maxAttempts=0)
- **P1 #56960** - openai-codex refresh_token_reused 导致 event loop blockage
- ⚠️ aoao session 已结束(2026-03-30T03:02 北京时间),消息转发超时

### 2026-03-28 16:18(Heartbeat 检查 - 高优先级 issue 新进展)
- **#55995 新进展**:
  - EronFan(2026-03-28T04:45:37Z):该漏洞已经作为安全问题在 #56173 正式披露,关闭此 issue,转向安全标签的报告
  - coygeek(2026-03-28T05:02:24Z):很高兴看到 #55995 的发现成功作为"properly disclosed"重复问题的上游 beta 测试
- **#55994 新进展**:
  - EronFan(2026-03-28T05:29:42Z):在 v2026.3.24 中确认此 bug 仍然存在,提供了详细的根因定位和修复建议
  - 根因:commit `6dfd39c3`(Harden Telegram poll gating)在 `src/infra/outbound/message-action-runner.ts` line 767-769 增加了全局 guard,这个 guard 放在 `runMessageAction()` 入口处,而非 Telegram 专用路径内
  - 问题:会拦截所有通道的 send 请求,包括 weixin
  - 修复建议:将 poll 参数校验下放到 Telegram 专用 handler 内,而不是放在全局入口

### 2026-03-28 15:40(今日下午行动 - 第二波)
- **main 继续支持了 6 个小型 PR**:
  - #56167(Feishu NO_REPLY token 泄露 → #56117,直接影响我们 Feishu)
  - #56241(Config schema 拒绝 edge TTS 配置,与文档不一致)
  - #56195(gateway WS handshake 意外剥离 operator scopes,backend 集成回归)
  - #56240(plugin tools 在 subagent 启动时错过 resolution window,multi-agent 问题)
  - #56212(cron Web UI 创建时 delivery mode 默认值错误 → #56078)
  - #56223(internal hooks 默认启用另一个 PR → #55929,与 #56250 重复)
- **issue 评论**:
  - #56127(WhatsApp 插件未配置也加载崩溃 regression)发了 workaround 分析

### 2026-03-28 16:30(今日下午行动 - 收尾)
- **教训**:#56212(cron delivery mode)和 #56247(hooks.mappings schema)有 Greptile P1/P2 深评意见未处理,支持前应先读完所有已有评论再判断
- **我们自己的 PR #55008/#55013**:仍只有 Greptile bot 评论,无 maintainer 人为回复
- **今日 total战果:**
  - ✅ aoao 复核 2 个 PR(#56234、#56203)
  - ✅ main 自审 1 个 PR(#56240)
  - ✅ 支持了 16 个小型 PR
  - ✅ issue 评论 2 个
  - 0 个 maintainer 人为回复(都在等)

### 2026-03-28 20:45(晚间行动 - 主动 PR 支持)
- **#56384 支持**:Feishu requireMention=false bug(#56338)已有 PR,group ID 前缀不匹配导致配置被忽略;作者 w-sss 修复完整,main 支持
- **新增支持 10 个 S/XS 级 PR**:
  - #56398(gateway: 修复两阶段 exec approval 在无连接客户端时被错误过期)
  - #56396(MCP: 绑定 Claude 权限回复到发起会话)
  - #56385(agents: canonical skill.source 字段读取 + legacy 兼容)
  - #56360(subagents: completion announce 继承发起 channel)
  - #56379(security: ClawHub scoped plugin 路径穿越防护)
  - #56353(plugins: gateway-bindable registry 在 agent_end hooks 满足 default requests)⚠️ 有 Greptile P1/P2 深评
  - #56355(channels: pin outbound registry loader 防止热重载卸载)
  - #56356(heartbeat: 防止 subagent 完成公告触发心跳级联)
  - #56394(clawhub: 429 错误增加登录提示)
  - #56362(discord: resetTriggers 正确轮换 sessionId)
- **教训**:找 bug 写 PR 的尝试失败--要么已有 PR 在修,要么 bug 太深(#56306 Telegram 图片 silent drop、#56367 voice-call sandbox 强制 Docker)。发现 #56384(Feishu requireMention 修复)已完整提 PR,#56315(slash commands routing)已被 community 验证为配置问题而非代码 bug

### 2026-03-28 15:15(今日下午行动 - main 直接执行)
- **aoao 复核完成**:
  - #56234:dmPolicy security audit parity,✅ 可合并,等 maintainer review
  - #56203:sessions_send sessionKey优先,✅ 直接解决我们派单失败问题,**优先合并**
- **main 支持了 5 个小型 PR**:
  - #56203(sessions_send bug fix,直接受益)
  - #56247(hooks.mappings[].channel schema,Feishu配置问题)
  - #56244(Feishu工具热重载重复注册,#56114)
  - #56204(getApiKey callback被丢弃,#55816)
  - #56250(internal hooks默认启用,#55929)
- **协作教训**:xixi 在执行 gh 命令时频繁超时(可能模型 M2 被指令中的复杂 bash 管道干扰),下次派任务时减少复杂 shell 管道

### 2026-03-28 09:46(社区机会扫描 - 第十二轮新发现)
- **#56112 高优先级可用性问题**:Provider-level cooldown still blocks healthy models within same provider (Anthropic Opus outage skips Sonnet)
  - 问题:Provider级别的cooldown在provider内的一个模型失败时,会阻止同一provider内的其他健康模型
  - 具体:当Opus过载时,整个Anthropic provider进入cooldown,健康可用的Sonnet也被跳过
  - 影响:用户被迫使用更昂贵的回退模型(如GPT-5.4),即使Sonnet可用
  - 状态:0条评论,新issue,与#55941相关但更具体
  - 优先级:高,影响模型回退链的智能性
- **#56111 中等优先级功能请求**:Feature Request: Post-compaction system event hook for automatic state recovery
  - 问题:上下文压缩后,agent失去细粒度会话细节,导致post-compaction行为退化
  - 建议:添加post-compaction系统事件钩子,自动注入状态恢复指令
  - 状态:0条评论,新issue
  - 优先级:中等,改善长会话agent的稳定性
- **#56109 高优先级bug**:[Bug]: tool-shell PATH can diverge from login shell, causing wrong/missing openclaw binary
  - 问题:工具shell的PATH解析可能与登录shell不同,导致错误的openclaw二进制被选择
  - 影响:不一致的自动化行为,版本漂移,难以调试的"command not found"错误
  - 环境:macOS(LaunchAgent管理的gateway)
  - 状态:0条评论,新issue
  - 优先级:高,影响命令执行的可靠性
- **#56108 高优先级regression**:Microsoft Teams channel crashes on startup in OpenClaw 2026.3.24
  - 问题:msteams通道在启动时崩溃,无法绑定webhook监听器
  - 错误:Missing parameter name at index 5: /api*; visit https://git.new/pathToRegexpError for info
  - 影响:Teams webhook完全无法接收,外部转发也无法工作
  - 状态:0条评论,新issue
  - 优先级:高,regression,Teams通道不可用
- **#56106 高优先级Windows bug**:Transcript JSONL encoding corrupted on Windows (GBK/UTF-8 mix)
  - 问题:Windows上聊天记录JSONL文件编码损坏,中文文本存储为GBK字节但被解释为UTF-8
  - 影响:中文历史聊天搜索无结果,记忆检索不可靠,过去对话永久不可读
  - 状态:0条评论,新issue
  - 优先级:高,影响Windows用户的数据完整性
- **#56105 中等优先级bug**:streaming: "partial" drops text when reply contains MEDIA + text in Telegram forum topics
  - 问题:Telegram论坛话题中,当回复包含MEDIA+文本时,"partial"流式模式会丢失文本部分
  - 影响:图像成功发送,但伴随文本消失
  - 状态:0条评论,新issue
  - 优先级:中等,Telegram论坛话题特定问题
- **#56102 高优先级regression**:[Bug]: ACP server rejects MCP protocolVersion: 2025-11-25 from VS Code 1.113 / Cursor
  - 问题:ACP服务器拒绝VS Code 1.113/Cursor的MCP protocolVersion: 2025-11-25
  - 错误:Invalid params, protocolVersion validation error
  - 影响:最新版VS Code和Cursor无法连接OpenClaw ACP服务器
  - 标签:bug
  - 状态:0条评论,新issue
  - 优先级:高,regression,影响开发者工具集成
- **#56100 中等优先级功能请求**:Feature Request: Memory System Initialization for Ephemeral A2A Sessions
  - 问题:临时A2A会话缺少内存系统初始化
  - 状态:0条评论,新issue
  - 优先级:中等,A2A会话功能增强
- **#56097 中等优先级功能请求**:feat: Add Tavily Crawl, Map, and Research API support
  - 问题:请求添加Tavily Crawl、Map和Research API支持
  - 状态:0条评论,新issue
  - 优先级:中等,搜索引擎功能增强
- **#56096 高优先级bug**:Bug: Telegram sendChatAction infinite retry loop with no backoff
  - 问题:Telegram sendChatAction无限重试循环,无回退机制
  - 影响:bot完全无响应,直到手动终止进程
  - 状态:3条评论,已有用户liujiaqiid提交修复commit `fd7598898`
  - 优先级:高,已有人处理,需要验证修复
- **#56095 性能问题**:Feishu plugin registered 4 times on every Gateway startup
  - 问题:每次Gateway启动时,Feishu插件工具注册4次
  - 影响:插件重复注册,可能影响启动性能和资源使用
  - 状态:0条评论,新issue
  - 优先级:中等,性能优化问题
- **#56094 中等优先级功能请求**:[Feature]: Silent Agent Helpdesk Runtime
  - 问题:请求静默Agent帮助台运行时功能
  - 标签:enhancement
  - 状态:0条评论,新issue
  - 优先级:中等,功能增强
- **#56093 中等优先级bug**:Model switch confirmation shows misleading warning when override is applied
  - 问题:应用覆盖时,模型切换确认显示误导性警告
  - 状态:0条评论,新issue
  - 优先级:中等,用户体验问题
- **#56091 语音功能问题**:Telnyx outbound conversation calls: events skipped as replays, no STT, custom voice ID ignored
  - 问题:Telnyx出站通话功能完全失效,事件被标记为重放,STT不启动,自定义语音ID被忽略
  - 影响:Telnyx语音通话功能不可用
  - 状态:0条评论,新issue
  - 优先级:高,语音功能问题
- **#56089 高优先级regression**:Baileys WhatsApp Web outbound sends fail with "No active WhatsApp Web listener" despite linked/connected status
  - 问题:WhatsApp Web出站发送失败,提示无活跃监听器
  - 标签:bug, regression
  - 状态:0条评论,新issue
  - 优先级:高,WhatsApp用户受影响
- **#56087 崩溃问题**:Unknown error message with multiple mac profiles
  - 问题:多个mac配置文件导致未知错误
  - 标签:bug, bug:crash
  - 状态:0条评论,新issue
  - 优先级:中等,macOS特定问题
- **#56086 高优先级稳定性问题**:Discord health-monitor: stale-socket triggers full gateway restart instead of surgical reconnect
  - 问题:Discord健康监测触发完整gateway重启而不是仅重连WebSocket
  - 影响:每天22+次完整重启,累计约5分钟停机时间
  - 状态:0条评论,新issue
  - 优先级:高,严重影响稳定性
- **#56079 会话管理问题**:restart can persist mismatched sessionId/sessionFile for main session, breaking webchat history
  - 问题:重启导致main会话sessionId和sessionFile不匹配,破坏webchat历史
  - 影响:webchat历史功能失效,需要手动修复sessions.json
  - 状态:0条评论,新issue
  - 优先级:中等,影响用户体验
- **#56078 高优先级regression**:Cron Job Output Not Saved in OpenClaw 2026.3.24
  - 问题:cron作业输出未保存
  - 标签:bug, regression
  - 状态:1条评论,与#51936相关,已有PR #51948修复
  - 优先级:高,与#56045 cron系统问题相关
- **新PRs发现(90分钟内更新)**:
  - **#56071**:fix(msteams): reset stream state after tool calls to prevent message loss (channel:msteams+maintainer+size:S)
    - 问题:修复msteams工具调用后消息丢失问题
    - 状态:1条评论,有Greptile review指出潜在问题
    - 优先级:高,消息完整性修复
  - **#55967**:feat(plugins): add api.runtime.agent.abort for aborting agent runs (docs+app:web-ui+gateway+agents+size:XL)
    - 问题:添加插件API agent.abort功能
    - 状态:1条评论,新PR
    - 优先级:高,插件API增强
  - **#56050**:feat(plugins): add before_skill_install hook for external security scanners (docs+agents+maintainer+size:L)
    - 问题:添加before_skill_install hook用于外部安全扫描器
    - 状态:1条评论,新PR
    - 优先级:高,安全增强
  - **#56074**:Bug: Feishu heartbeat target ID incorrectly resolves to string 'heartbeat' instead of open_id
    - 问题:Feishu心跳目标ID解析错误
    - 状态:0条评论,新issue
    - 优先级:高,Feishu心跳功能问题
  - **#56072**:Daily session reset silently discards context without memory flush or compaction
    - 问题:每日会话重置静默丢弃上下文
    - 状态:0条评论,新issue
    - 优先级:高,上下文管理问题
  - **#46737**:feat(slack): add Block Kit table block support for markdown tables (docs+channel:slack+size:L)
  - **#56077**:fix(diffs): stage bundled runtime deps after updates (maintainer+size:XS)
  - **#40377**:feat(continuity): harden adaptive reply threading and subagent delivery continuity (gateway+agents+size:M)
  - **#56076**:fix(matrix): align outbound direct-room selection (channel:matrix+maintainer+size:M)
  - **#51523**:feat(matrix): add subagent hooks for ACP room-binding (channel:matrix+size:L)
  - **#49529**:Add configurable Gemini safety settings for Google provider (docs+gateway+agents+size:M)
  - **#52770**:fix(gateway): guard getRuntimeSnapshot() and preserve probe intent in health refresh (gateway+commands+size:S)
  - **#56060**:feat(telegram): add child thread-binding placement via createForumTopic [AI-assisted] (channel:telegram+agents+size:S)

### 2026-03-28 06:46(社区机会扫描 - 第十轮新发现)
- **#56063 高优先级bug**:Heartbeat delivery to Feishu fails: requires chatId but target only accepts 'last'
  - 问题:Feishu心跳交付失败,需要chatId但target只接受'last'
  - 影响:Feishu心跳功能不可用
  - 状态:0条评论,新issue
  - 优先级:高,Feishu功能问题
- **#56061 高优先级bug**:Telegram long-poll hangs indefinitely on dead TCP socket - no socket-level read timeout
  - 问题:Telegram长轮询在死TCP socket上无限挂起,无socket级读取超时
  - 影响:Telegram连接可能永久挂起
  - 状态:0条评论,新issue
  - 优先级:高,Telegram连接可靠性问题
- **#56058 高优先级bug**:[Bug]: agents.defaults.model.fallbacks not used on Anthropic 529 overload_error
  - 问题:Anthropic 529 overload_error时,agents.defaults.model.fallbacks回退链未使用
  - 标签:bug, bug:behavior
  - 状态:0条评论,新issue
  - 优先级:高,模型回退链失效
- **#56057 高优先级bug**:[Bug]: Channel WebSocket abnormal closure (Discord + Telegram) crashes entire gateway process
  - 问题:Discord和Telegram的WebSocket异常关闭导致整个gateway进程崩溃
  - 标签:bug
  - 状态:0条评论,新issue
  - 优先级:高,gateway稳定性问题
- **#56054 高优先级bug**:WhatsApp Baileys: perpetual status 499 reconnection loop with creds.json corruption cycle
  - 问题:WhatsApp Baileys永久状态499重连循环,creds.json损坏循环
  - 状态:0条评论,新issue
  - 优先级:高,WhatsApp连接稳定性问题
- **#56053 高优先级bug**:[Bug]: Model fallback chain does not trigger on HTTP 402 (Insufficient Balance) from provider
  - 问题:Provider返回HTTP 402(余额不足)时模型回退链未触发
  - 标签:bug
  - 状态:0条评论,新issue
  - 优先级:高,模型回退链失效
- **#56052 高优先级regression**:[Bug]: Unable to pair telegram channel
  - 问题:无法配对Telegram channel
  - 标签:bug, regression
  - 状态:0条评论,新issue
  - 优先级:高,regression,影响新用户设置
- **#56051 低优先级功能请求**:feat: agent-level accountId binding for multi-bot Discord setups
  - 问题:为多bot Discord设置添加agent级别的accountId绑定
  - 状态:0条评论,新issue
  - 优先级:低,Discord功能增强
- **#56049 高优先级bug**:[Bug]: Heartbeat handler re-triggers on subagent auto-announcement events, causing cascade of heartbeat polls.
  - 问题:子代理自动宣告事件重新触发心跳处理程序,导致心跳轮询级联
  - 标签:bug
  - 状态:0条评论,新issue
  - 优先级:高,心跳系统问题
- **#56047 低优先级功能请求**:Feature: expose Anthropic unified rate-limit headers in session status / API
  - 问题:在session status/API中暴露Anthropic统一速率限制头信息
  - 状态:0条评论,新issue
  - 优先级:低,功能增强
- **#56046 高优先级bug**:Signal channel: message tool action=send fails with 'Outbound not configured for channel: signal'
  - 问题:Signal通道入站和回复正常,但使用message工具主动发送失败
  - 状态:0条评论,新issue
  - 优先级:高,Signal channel功能问题
- **#56045 高优先级bug**:Cron job output continues to be delivered after jobs are deleted; persists with zero active jobs
  - 问题:已删除的cron作业持续快速重复触发交付,甚至在没有活跃作业时也持续交付
  - 状态:0条评论,新issue
  - 优先级:高,cron系统稳定性问题
- **#56044 高优先级regression**:Recent update broke /stop and interrupt behavior - collect mode swallows user messages
  - 问题:更新到OC 2026.3.24后,/stop和/queue interrupt命令不再有效中断运行中的代理会话
  - 状态:1条评论,严重可用性问题
  - 优先级:高,影响核心交互功能
- **#56041 中等优先级bug**:msteams: blockStreaming config has no effect (onBlockReply not wired)
  - 问题:Teams通道的blockStreaming配置无效,消息总是作为单个块到达
  - 状态:1条评论,配置问题
  - 优先级:中等,Teams用户体验
- **#56040 高优先级bug**:msteams: Teams streaming protocol causes lost messages with tool-using agents
  - 问题:Teams流式协议导致使用工具的代理消息丢失
  - 状态:2条评论,持续讨论中
  - 优先级:高,消息完整性受损
- **#55282 高优先级regression**:Slack Socket Mode regression: inbound events silently dropped (v2026.3.9+)
  - 问题:Slack Socket Mode regression,入站事件被静默丢弃(v2026.3.9+)
  - 标签:bug, regression
  - 状态:0条评论,新issue
  - 优先级:高,Slack功能问题
- **#54931 高优先级regression**:BUG: Discord health-monitor triggers uncaught exception crash loop (v2026.3.24)
  - 问题:Discord健康监测触发未捕获异常崩溃循环(v2026.3.24)
  - 标签:bug, regression
  - 状态:0条评论,新issue
  - 优先级:高,Discord稳定性问题
- **#54688 高优先级bug**:[Bug]: kimi-coding/kimi-k2.5 tool calling broken on all versions after 3.13 - parameters never reach tools
  - 问题:kimi-coding/kimi-k2.5工具调用在所有3.13之后版本中完全失效
  - 标签:bug, regression
  - 状态:0条评论,新issue
  - 优先级:高,Kimi工具调用失效
- **#53888 中等优先级bug**:Google Chat: silent webhook auth failures + undocumented appPrincipal requirement
  - 问题:Google Chat静默webhook认证失败 + 未记录的appPrincipal要求
  - 状态:0条评论,新issue
  - 优先级:中等,Google Chat问题
- **#53204 高优先级bug**:sessions_send announce retry blocks agent session for ~6 minutes on channel errors
  - 问题:sessions_send宣告重试在channel错误时阻塞代理会话约6分钟
  - 状态:0条评论,新issue
  - 优先级:高,会话阻塞问题
- **#50111 高优先级bug**:Discord native slash commands respond 'Done' instead of executing (routed through plugin commands)
  - 问题:Discord原生斜杠命令响应'Done'而不是执行(通过插件命令路由)
  - 状态:0条评论,新issue
  - 优先级:高,Discord命令功能问题
- **#45963 高优先级安全漏洞**:security: exec bypasses approval flow when tools.exec.host is unset (default fallback)
  - 问题:tools.exec.host未设置时exec绕过审批流程(默认回退)
  - 状态:0条评论,新issue
  - 优先级:高,安全漏洞
- **#75 中等优先级功能请求**:Linux/Windows Clawdbot Apps
  - 问题:Linux/Windows Clawdbot应用
  - 标签:enhancement, help wanted
  - 状态:0条评论,老issue
  - 优先级:中等,功能增强
- **新fix PRs发现**:
  - **#56064**:fix: use American English spelling in code comments (channel:telegram+app:web-ui+gateway+agents+size:XS)
  - **#56060**:feat(telegram): add child thread-binding placement via createForumTopic [AI-assisted] (channel:telegram+size:S)
  - **#56050**:feat(plugins): add before_skill_install hook for external security scanners (agents+maintainer+size:M)
  - **#56048**:fix(xai): move bundled provider to Responses and add x_search (docs+cli+commands+agents+maintainer+size:XL)
  - **#56043**:docs(nextcloud-talk): document required response feature (docs+channel:nextcloud-talk+size:XS)
  - **#56036**:fix: inject context.agentId into toToolDefinitions hook dispatch (agents+size:XS)
  - **#56031**:fix(pi-runner): use post-hook assistant for expect-final payloads (agents+size:S)
  - **#56030**:fix(discord): restore uploadUrlRequest arg to RateLimitError (channel:discord+size:XS)
  - **#56028**:fix(sessions): honor spawned tree lineage across agents (agents+size:S)

### 2026-03-28 05:48(社区机会扫描 - 第九轮新发现)
- **#56044 高优先级regression**:Recent update broke /stop and interrupt behavior - collect mode swallows user messages
  - 问题:更新到OC 2026.3.24后,/stop和/queue interrupt命令不再有效中断运行中的代理会话
  - 影响:用户消息被collect模式吞没,无法中断长时间运行的代理
  - 状态:1条评论,严重可用性问题
  - 优先级:高,影响核心交互功能
- **#56045 高优先级bug**:Cron job output continues to be delivered after jobs are deleted; persists with zero active jobs
  - 问题:已删除的cron作业持续快速重复触发交付,甚至在没有活跃作业时也持续交付
  - 影响:cron系统失控,产生大量重复交付
  - 状态:0条评论,系统级问题
  - 优先级:高,cron系统稳定性问题
- **#56040 高优先级bug**:msteams: Teams streaming protocol causes lost messages with tool-using agents
  - 问题:Teams流式协议导致使用工具的代理消息丢失
  - 影响:代理中间响应(文本→工具调用→更多文本)时消息静默丢失或乱序
  - 状态:2条评论,持续讨论中
  - 优先级:高,消息完整性受损
- **#56039 高优先级bug**:message tool: buttons field incorrectly marked as required in tool schema when Telegram inlineButtons capability is enabled
  - 问题:Telegram inlineButtons功能启用时,message工具schema错误地将buttons标记为required
  - 影响:验证失败,用户需要workaround
  - 状态:0条评论,schema验证问题
  - 优先级:高,影响多个channel
- **#56034 高优先级bug**:Session maintenance prunes active/running sessions
  - 问题:会话维护(enforce模式)错误地清理仍在活跃运行的会话
  - 影响:活跃会话被意外清理,用户工作丢失
  - 状态:0条评论,会话管理问题
  - 优先级:高,影响用户体验
- **#56046 高优先级bug**:Signal channel: message tool action=send fails with 'Outbound not configured for channel: signal'
  - 问题:Signal通道入站和回复正常,但使用message工具主动发送失败
  - 影响:Signal通道主动发送功能不可用
  - 状态:0条评论,channel功能问题
  - 优先级:高,Signal用户受影响
- **#56035 中等优先级**:macOS companion app forces Remote mode on first launch when local CLI gateway is running
  - 问题:macOS伴侣应用在首次启动时强制切换到Remote模式,即使本地CLI网关正在运行
  - 影响:macOS用户体验受损,配置被意外修改
  - 状态:0条评论,macOS特定问题
  - 优先级:中等,影响macOS用户
- **#56041 中等优先级bug**:msteams: blockStreaming config has no effect (onBlockReply not wired)
  - 问题:Teams通道的blockStreaming配置无效,消息总是作为单个块到达
  - 影响:配置功能失效
  - 状态:1条评论,配置问题
  - 优先级:中等,Teams用户体验
- **#56038 低优先级功能请求**:[Feature Request]: 微信渠道支持发送TTS语音消息为原生语音条
  - 请求:微信渠道支持TTS语音消息作为原生语音条发送
  - 状态:0条评论,功能增强
  - 优先级:低,微信TTS功能改进
- **#56047 低优先级功能请求**:Feature: expose Anthropic unified rate-limit headers in session status / API
  - 请求:在session status/API中暴露Anthropic统一速率限制头信息
  - 状态:0条评论,功能增强
  - 优先级:低,Anthropic用户监控改进
- **#56043 低优先级文档问题**:docs(nextcloud-talk): document required response feature
  - 问题:Nextcloud Talk文档缺少必需response功能的说明
  - 状态:1条评论,docs+size:XS标签
  - 优先级:低,文档完善
-O **#56048 高优先级**:fix(xai): move bundled provider to Responses and add x_search
  - 问题:xAI bundled provider需要迁移到Responses支持并添加x_search功能
  - 标签:docs+cli+commands+agents+maintainer+size:XL
  - 状态:0条评论,大型技术重构
  - 优先级:高,xAI支持改进
- **#56063 高优先级bug**:Heartbeat delivery to Feishu fails: requires chatId but target only accepts 'last'
  - 问题:Feishu心跳交付失败,需要chatId但target只接受'last'
  - 影响:Feishu心跳功能不可用
  - 标签:无标签
  - 状态:0条评论,新issue
  - 优先级:高,Feishu功能问题
- **#56061 高优先级bug**:Telegram long-poll hangs indefinitely on dead TCP socket - no socket-level read timeout
  - 问题:Telegram长轮询在死TCP socket上无限挂起,无socket级读取超时
  - 影响:Telegram连接可能永久挂起
  - 标签:无标签
  - 状态:0条评论,新issue
  - 优先级:高,Telegram连接可靠性问题
- **#56058 高优先级bug**:[Bug]: agents.defaults.model.fallbacks not used on Anthropic 529 overload_error
  - 问题:Anthropic 529 overload_error时,agents.defaults.model.fallbacks回退链未使用
  - 标签:bug, bug:behavior
  - 状态:0条评论,新issue
  - 优先级:高,模型回退链失效
- **#56057 高优先级bug**:[Bug]: Channel WebSocket abnormal closure (Discord + Telegram) crashes entire gateway process
  - 问题:Discord和Telegram的WebSocket异常关闭导致整个gateway进程崩溃
  - 标签:bug
  - 状态:0条评论,新issue
  - 优先级:高,gateway稳定性问题
- **#56054 高优先级bug**:WhatsApp Baileys: perpetual status 499 reconnection loop with creds.json corruption cycle
  - 问题:WhatsApp Baileys永久状态499重连循环,creds.json损坏循环
  - 标签:无标签
  - 状态:0条评论,新issue
  - 优先级:高,WhatsApp连接稳定性问题
- **#56053 高优先级bug**:[Bug]: Model fallback chain does not trigger on HTTP 402 (Insufficient Balance) from provider
  - 问题:Provider返回HTTP 402(余额不足)时模型回退链未触发
  - 标签:bug
  - 状态:0条评论,新issue
  - 优先级:高,模型回退链失效
- **#56052 高优先级regression**:[Bug]: Unable to pair telegram channel
  - 问题:无法配对Telegram channel
  - 标签:bug, regression
  - 状态:0条评论,新issue
  - 优先级:高,regression,影响新用户设置
- **#56051 低优先级功能请求**:feat: agent-level accountId binding for multi-bot Discord setups
  - 问题:为多bot Discord设置添加agent级别的accountId绑定
  - 标签:无标签
  - 状态:0条评论,新issue
  - 优先级:低,Discord功能增强
- **#56049 高优先级bug**:[Bug]: Heartbeat handler re-triggers on subagent auto-announcement events, causing cascade of heartbeat polls.
  - 问题:子代理自动宣告事件重新触发心跳处理程序,导致心跳轮询级联
  - 标签:bug
  - 状态:0条评论,新issue
  - 优先级:高,心跳系统问题
- **#56047 低优先级功能请求**:Feature: expose Anthropic unified rate-limit headers in session status / API
  - 问题:在session status/API中暴露Anthropic统一速率限制头信息
  - 标签:无标签
  - 状态:0条评论,新issue
  - 优先级:低,功能增强
- **#56046 高优先级bug**:Signal channel: message tool action=send fails with 'Outbound not configured for channel: signal'
  - 问题:Signal通道入站和回复正常,但使用message工具主动发送失败
  - 标签:无标签
  - 状态:0条评论,新issue
  - 优先级:高,Signal channel功能问题
- **#56045 高优先级bug**:Cron job output continues to be delivered after jobs are deleted; persists with zero active jobs
  - 问题:已删除的cron作业持续快速重复触发交付,甚至在没有活跃作业时也持续交付
  - 标签:无标签
  - 状态:0条评论,新issue
  - 优先级:高,cron系统稳定性问题
- **#56044 高优先级regression**:Recent update broke /stop and interrupt behavior - collect mode swallows user messages
  - 问题:更新到OC 2026.3.24后,/stop和/queue interrupt命令不再有效中断运行中的代理会话
  - 标签:无标签
  - 状态:1条评论,严重可用性问题
  - 优先级:高,影响核心交互功能
- **#56041 中等优先级bug**:msteams: blockStreaming config has no effect (onBlockReply not wired)
  - 问题:Teams通道的blockStreaming配置无效,消息总是作为单个块到达
  - 标签:无标签
  - 状态:1条评论,配置问题
  - 优先级:中等,Teams用户体验
- **#56040 高优先级bug**:msteams: Teams streaming protocol causes lost messages with tool-using agents
  - 问题:Teams流式协议导致使用工具的代理消息丢失
  - 标签:无标签
  - 状态:2条评论,持续讨论中
  - 优先级:高,消息完整性受损
- **#55282 高优先级regression**:Slack Socket Mode regression: inbound events silently dropped (v2026.3.9+)
  - 问题:Slack Socket Mode regression,入站事件被静默丢弃(v2026.3.9+)
  - 标签:bug, regression
  - 状态:0条评论,新issue
  - 优先级:高,Slack功能问题
- **#54931 高优先级regression**:BUG: Discord health-monitor triggers uncaught exception crash loop (v2026.3.24)
  - 问题:Discord健康监测触发未捕获异常崩溃循环(v2026.3.24)
  - 标签:bug, regression
  - 状态:0条评论,新issue
  - 优先级:高,Discord稳定性问题
- **#54688 高优先级bug**:[Bug]: kimi-coding/kimi-k2.5 tool calling broken on all versions after 3.13 - parameters never reach tools
  - 问题:kimi-coding/kimi-k2.5工具调用在所有3.13之后版本中完全失效
  - 标签:bug, regression
  - 状态:0条评论,新issue
  - 优先级:高,Kimi工具调用失效
- **#53888 中等优先级bug**:Google Chat: silent webhook auth failures + undocumented appPrincipal requirement
  - 问题:Google Chat静默webhook认证失败 + 未记录的appPrincipal要求
  - 标签:无标签
  - 状态:0条评论,新issue
  - 优先级:中等,Google Chat问题
- **#53204 高优先级bug**:sessions_send announce retry blocks agent session for ~6 minutes on channel errors
  - 问题:sessions_send宣告重试在channel错误时阻塞代理会话约6分钟
  - 标签:无标签
  - 状态:0条评论,新issue
  - 优先级:高,会话阻塞问题
- **#50111 高优先级bug**:Discord native slash commands respond 'Done' instead of executing (routed through plugin commands)
  - 问题:Discord原生斜杠命令响应'Done'而不是执行(通过插件命令路由)
  - 标签:无标签
  - 状态:0条评论,新issue
  - 优先级:高,Discord命令功能问题
- **#45963 高优先级安全漏洞**:security: exec bypasses approval flow when tools.exec.host is unset (default fallback)
  - 问题:tools.exec.host未设置时exec绕过审批流程(默认回退)
  - 标签:无标签
  - 状态:0条评论,新issue
  - 优先级:高,安全漏洞
- **#75 中等优先级功能请求**:Linux/Windows Clawdbot Apps
  - 问题:Linux/Windows Clawdbot应用
  - 标签:enhancement, help wanted
  - 状态:0条评论,老issue
  - 优先级:中等,功能增强
- **已存在的fix PRs**:
  - **#56028**:fix(sessions): honor spawned tree lineage across agents (agents+size:S,1条评论)
  - **#56030**:fix(discord): restore uploadUrlRequest arg to RateLimitError (channel:discord+size:XS,1条评论)
  - **#56031**:fix(pi-runner): use post-hook assistant for expect-final payloads (agents+size:S,1条评论)
  - **#56036**:fix: inject context.agentId into toToolDefinitions hook dispatch (agents+size:XS,1条评论)
  - **#56064**:fix: use American English spelling in code comments (channel:telegram+app:web-ui+gateway+agents+size:XS)
  - **#56060**:feat(telegram): add child thread-binding placement via createForumTopic [AI-assisted] (channel:telegram+size:S)
  - **#56050**:feat(plugins): add before_skill_install hook for external security scanners (agents+maintainer+size:M)
  - **#56043**:docs(nextcloud-talk): document required response feature (docs+channel:nextcloud-talk+size:XS)
  - **#55988**:fix(outbound): fall back to pinned channel-surface registry in registry loader (size:S)
  - **#55983**:sessions: tree visibility honors spawn lineage before cross-agent gate [AI assisted with amp code] (agents+size:S)
  - **#55967**:feat(plugins): add api.runtime.agent.abort for aborting agent runs (docs+app:web-ui+gateway+agents+size:XL)
  - **#55953**:fix(telegram): use type-aware media placeholder for document attachments (channel:telegram+size:S)
  - **#55940**:fix: skip Homebrew dependency for skill install on Linux (agents+size:M)
  - **#55937**:telegram: cache botInfo across polling cycles to eliminate getMe() init stall (channel:telegram+cli+agents+size:S)

### 2026-03-28 04:46(社区机会扫描 - 第八轮新发现)
- **#56010 高优先级regression**:Telegram voice notes are not transcribed; inbound message arrives only as <media:audio>
  - 问题:Telegram语音消息转录功能失效,入站消息仅显示<media:audio>标签
  - 影响:配置了OpenAI Whisper的用户无法使用语音转录功能
  - 标签:bug, regression
  - 状态:0条评论,新issue,详细的技术分析
  - 优先级:高,regression,影响Telegram语音功能用户
- **#56032 高优先级bug**:Subagent completion replies silently fail to deliver to Telegram group chats
  - 问题:子代理完成任务后,主代理的回复静默失败,无法发送到Telegram群聊
  - 错误:网关日志显示"Outbound not configured for channel: telegram"
  - 影响:用户看到代理突然静默,不知道任务已完成,需要不断ping代理
  - 状态:0条评论,新issue,100%复现率,详细的技术分析和工作流程
  - 优先级:高,影响子代理工作流,用户信任受损
- **#56033 中等优先级bug**:plugins uninstall does not remove channels.<pluginId> config for external channel plugins
  - 问题:插件卸载后,channels.<pluginId>配置残留
  - 影响:配置混乱,残留的无效配置可能影响其他功能
  - 状态:0条评论,新issue
  - 优先级:中等,配置管理问题
- **#56027 高优先级bug**:Plugin hot-reload clobbers tool send channel registry
  - 问题:插件热重载导致工具发送channel registry丢失
  - 错误:"unsupported channel: whatsapp"
  - 影响:热重载后channel功能失效
  - 状态:0条评论,新issue
  - 优先级:高,影响插件开发者和热重载功能
- **#56029 高优先级可用性问题**:Subagents inherit full workspace context - no way to scope what's injected
  - 问题:子代理继承全部workspace文件,即使任务很简单,导致token浪费
  - 影响:频繁使用子代理的工作流每天浪费250-500k tokens
  - 请求:添加workspace scope控制(allowlist或none选项)
  - 状态:0条评论,新feature request,详细分析token浪费问题
  - 优先级:高,影响token使用效率和成本
- **#56021 中等优先级bug**:github-copilot OpenAI Responses replay can emit orphan function_call_output with malformed tool IDs
  - 问题:GitHub Copilot回复重放可能导致工具ID格式错误的孤立的function_call_output
  - 影响:工具调用可能失败
  - 状态:0条评论,新issue
  - 优先级:中等,GitHub Copilot特定问题
- **#56017 新功能**:feat(i18n): add Simplified Chinese (zh-CN) localization
  - 功能:添加简体中文本地化支持
  - 大小:XL size feature
  - 状态:更新到20:46,持续活跃
  - 优先级:中等,国际化功能

### 2026-03-28 03:46(社区机会扫描 - 第七轮新发现)
- **#55995 严重安全漏洞**:/pair approve bypasses the admin scope guard for device pairing
  - 问题:/pair approve命令绕过admin scope guard,允许非管理员用户批准设备配对
  - 安全评分:CVSS 9.9/10.0(v3.1),Critical severity
  - 影响:严重安全漏洞,影响设备配对系统
  - 状态:0条评论,新issue,有详细CVSS评估
  - 优先级:最高,安全漏洞需要立即关注
- **#55994 高优先级regression**:message action=send 被误判为 poll(openclaw-weixin 通道,文本/图片均失败)
  - 问题:openclaw-weixin通道中,message action=send被错误地判断为poll
  - 影响:文本和图片消息发送失败,Beta release blocker
  - 标签:bug, regression
  - 状态:0条评论,新issue,中文描述
  - 优先级:高,regression,影响weixin通道用户
- **#55993 中等优先级功能请求**:Include sessionKey and metadata in session log file header
  - 问题:session JSONL日志文件头缺少sessionKey、channel、agentId等关键元数据
  - 影响:工具读取session日志时无法确定会话类型和来源
  - 状态:0条评论,新issue
  - 优先级:中等,改善可追溯性和分析能力

### 2026-03-28 02:46(社区机会扫描 - 第六轮新发现)
- **#55981 高优先级隐私/UX问题**:sessions_send announce step posts to wrong chat in multi-agent setup
  - 问题:在多代理架构中使用sessions_send时,worker代理的回复被错误地发布到用户聊天中,并归因于用户
  - 影响:严重隐私泄露,用户看到其他代理的回复归因于自己
  - 状态:0条评论,新issue
  - 优先级:高,多代理架构中的路由错误
- **#55976 高优先级regression**:message tool schema: buttons incorrectly marked as required for all actions
  - 问题:message工具JSON schema中buttons被标记为required,但大多数action(如react、poll、delete)不需要buttons
  - 影响:验证失败,用户需要使用"buttons": []作为workaround
  - 状态:0条评论,新issue,但之前有修复尝试#54981和#55804被关闭
  - 优先级:高,regression,schema验证问题影响多个channel
- **#55969 中等优先级可用性问题**:Image tool error: No media-understanding provider registered for openrouter
  - 问题:使用openrouter作为imageModel时,图像分析工具失败
  - 配置:imageModel.primary: openrouter/google/gemini-2.0-flash-exp
  - 状态:0条评论,新issue
  - 优先级:中等,图像分析功能不可用
- **#55966 中等优先级bug**:Telegram inbound media ENOSPC leaves zero-byte voice file and later crashes transcription with EOF
  - 问题:磁盘空间不足时,Telegram语音消息下载留下零字节文件,转录时崩溃
  - 错误:媒体下载失败和offset持久化都因ENOSPC失败
  - 状态:0条评论,新issue,详细分析和建议修复
  - 优先级:中等,磁盘空间不足处理不当
- **#55964 高优先级bug**:Telegram replies intent text but does not execute tools (no exec/read/write traces) on 2026.3.24
  - 问题:Telegram代理回复意图文本但不执行工具
  - 影响:所有工具调用失败(exec、read、write等)
  - 状态:1条评论,新issue
  - 优先级:高,Telegram工具执行完全失败
- **#55963 中等优先级bug**:session-memory hook: UTC date in filename + subagent_ended not handled
  - 问题:session-memory hook文件名使用UTC日期,不处理subagent_ended事件
  - 影响:时区问题导致文件命名不一致,子代理记忆不记录
  - 状态:0条评论,新issue
  - 优先级:中等,记忆系统一致性问题
- **#55956 中等优先级bug**:Voice Call Plugin: Telnyx transcription field mapping is wrong
  - 问题:Telnyx转录音段字段映射错误
  - 标签:bug, bug:behavior
  - 状态:0条评论,新issue
  - 优先级:中等,语音转录准确性受影响
- **#55954 低优先级功能请求**:Feature: agent-optimized CLI mode for programmatic/tool calls
  - 问题:请求为程序化/工具调用优化CLI模式
  - 状态:0条评论,新issue
  - 优先级:低,功能增强请求
- **#55919 高优先级可用性问题**:[Bug]: Anthropic 429 'Extra usage required for long context' misclassified as transient rate limit
  - 问题:Anthropic的结构性速率限制(长上下文需要额外计费)被错误分类为瞬时限速
  - 影响:用户得到错误建议"稍后重试",而正确行动是"减少上下文长度或启用额外计费"
  - 状态:2条评论,有详细分析和建议修复
  - 优先级:高,错误分类导致用户困惑
- **#55672 更新**:高优先级release blocker持续活跃,已10条评论
  - 问题:即使openclaw models status --probe正常工作,仍显示"No API key for provider"
  - 状态:持续讨论中,影响Windows用户
  - 优先级:最高,release blocker

### 2026-03-28 01:46(社区机会扫描 - 第五轮新发现)
- **#55942 高优先级regression**:NVIDIA NIM Kimi 2.5 tool execution completely broken in OpenClaw > 2026.2.25
  - 问题:OpenClaw > 2026.2.25版本中,NVIDIA NIM Kimi 2.5工具调用完全失败
  - 影响:使用NVIDIA NIM provider的Kimi用户无法执行工具调用
  - 状态:0条评论,新issue,bug+regression标签
  - 优先级:高,影响NVIDIA NIM用户,有明确的版本范围(2026.2.25后失效)
- **#55938 浏览器可用性问题**:Browser relay 18792 returns 502 even when browser status is running=true
  - 问题:macOS上浏览器relay端点返回502错误,但浏览器状态显示running: true
  - 影响:浏览器自动化功能不可用
  - 状态:1条评论,新issue,bug:behavior标签
  - 优先级:高,影响macOS用户的浏览器功能
- **#55943 功能缺失**:subagent sessions don't trigger session-memory hook
  - 问题:子代理会话结束时不会生成记忆文件到memory/YYYY-MM-DD.md
  - 影响:子代理对话历史丢失,无法进行记忆检索
  - 状态:0条评论,新issue
  - 优先级:中等,影响记忆系统完整性
- **#55941 可用性问题**:Auth profile cooldown blocks model fallback - Sonnet blocked by Opus rate limit on same profile
  - 问题:昂贵模型(如claude-opus-4-6)失败后,整个auth profile进入cooldown,阻止更便宜模型(如claude-sonnet-4-6)的回退
  - 影响:模型回退链失效,即使有可用资源也无法使用
  - 状态:0条评论,新issue
  - 优先级:高,影响高可用性场景,与#55834相关但更具体
- **#55931 路由问题**:sessions_spawn creates subagent with sourceChannel = "webchat" instead of original message channel
  - 问题:从Feishu/Telegram/WhatsApp创建子代理时,子代理的sourceChannel被错误设置为"webchat"
  - 影响:主代理的响应被错误路由到webchat而不是原始频道
  - 状态:1条评论,新issue,bug:behavior标签
  - 优先级:高,影响多频道部署中的消息路由
- **#55889 高优先级regression**:AI agent sends empty {} instead of {"command": "..."} after extended session
  - 问题:长时间会话(~1小时)后,AI agent开始发送空JSON对象{}而不是正确参数
  - 影响:所有工具调用失败(exec, process, read等),重启gateway也无法修复
  - 状态:0条评论,新issue,bug+regression标签
  - 优先级:高,严重影响可用性
- **#55907 CLI bug**:`openclaw config set` wraps negative number keys in extra quotes
  - 问题:使用负数字键(如Telegram supergroup ID `-1003713572219`)时,键被存储为带引号的字符串
  - 影响:Telegram配置无效,创建重复/无效配置条目
  - 状态:0条评论,新issue
  - 优先级:高,影响Telegram用户配置
- **#55903 Telegram bug**:message tool fails file attachment with incorrect 'buttons' validation error
  - 问题:使用message工具发送本地文件附件时,错误地要求'buttons'属性
  - 影响:Telegram文件附件功能被阻止
  - 状态:0条评论,新issue
  - 优先级:中等,影响文件分享功能
- **#55887 安全/权限问题**:Discord before_dispatch hook bypasses requireMention gating
  - 问题:before_dispatch hook处理消息时不重新验证mention要求
  - 影响:在requireMention: true的频道中,hook可以绕过mention检查
  - 状态:0条评论,新issue
  - 优先级:高,安全/权限绕过问题
- **#55900 可用性问题**:web_fetch blocked by SSRF when proxy uses RFC 2544 fake-IP
  - 问题:使用Surge/Clash enhanced mode代理时,web_fetch被SSRF防护错误阻止
  - 影响:代理用户无法使用web_fetch工具
  - 状态:0条评论,新issue
  - 优先级:中等,影响代理环境用户
- **#55890 配置bug**:autoThreadName config not recognized despite being in release notes
  - 问题:v2026.3.24 release notes提到的autoThreadName配置不被schema识别
  - 影响:用户无法使用宣布的新功能
  - 状态:0条评论,新issue
  - 优先级:中等,配置schema不一致问题
- **#55930 工具调用问题**:Empty Parameter Tool Calling Failure
  - 问题:Agent反复使用空{}参数调用工具,而不是提供所需值
  - 影响:工具调用失败,重启gateway也无法修复
  - 状态:0条评论,新issue,bug:behavior标签
  - 优先级:高,与#55889类似,都是空参数工具调用问题
- **#55929 Hook加载问题**:session-memory hook not loading: hooks.internal.enabled defaults to undefined instead of true
  - 问题:bundled hooks(包括session-memory)显示为未加载,因为hooks.internal.enabled默认为undefined
  - 影响:session-memory等内置hook无法正常工作
  - 状态:0条评论,新issue,bug:behavior标签
  - 优先级:中等,影响hook系统功能

### 2026-03-27 23:46(社区机会扫描 - 第三轮新发现)
- **#55873 高优先级regression**:Discord health-monitor restart后maxAttempts=0导致立即crash
  - 问题:健康监测重启Discord provider时未传递原始reconnect选项,maxAttempts变成0
  - 影响:下一次WebSocket断开时gateway进程立即退出
  - 状态:0条评论,新issue,清晰的根因分析
  - 优先级:高,能本地验证,有workaround
- **#55862 高优先级bug**:Gateway stuck in retry loop after provider outage - no self-recovery
  - 问题:上游provider恢复后gateway仍卡在错误/重试状态,需要手动重启
  - 影响:用户看到"The AI service is temporarily overloaded"持续数小时
  - 状态:0条评论,新issue,有明确workaround
  - 优先级:高,影响生产可用性
- **#55863 阻塞性bug**:plugins.entries rejects plugin configSchema fields
  - 问题:gateway schema只允许"enabled"布尔字段,所有configSchema字段被拒绝
  - 影响:memory-qdrant等插件无法连接外部服务(Qdrant),只能in-memory模式
  - 状态:0条评论,新issue,bug:behavior标签
  - 优先级:高,阻塞插件运行时配置

### 2026-03-27 22:46(社区机会扫描 - 第二轮新发现)
- **#55844 高优先级regression**:Channels not initializing on gateway startup
  - 问题:Gateway启动成功但channels为空,health端点返回{}
  - 影响:所有channel(Telegram等)未初始化
  - 状态:0条评论,新issue
  - 优先级:高,能本地验证
- **#55842 高优先级regression**:Gateway crash loop - RegExpCompiler OOM
  - 问题:v2026.3.13→3.24升级后OOM崩溃循环
  - 影响:gateway无法启动,systemd服务失败
  - 状态:0条评论,新issue
  - 优先级:高,升级路径问题
- **#55834 可用性问题**:Model fallback fails when provider auth profile is put in cooldown
  - 问题:主模型过载时整个auth profile进入cooldown,fallback模型也失败
  - 错误:No available auth profile for anthropic (all in cooldown or unavailable)
  - 状态:0条评论,新issue
  - 优先级:高,影响高可用场景
- **#55829 资源泄漏**:exec tool creates orphaned grep processes
  - 问题:管道命令中间的grep子进程变成孤儿,PPID=1
  - 影响:长期运行累积大量孤儿进程
  - 状态:0条评论,中文issue
  - 优先级:中等,需研究修复方案
- **#55825 隐私/可用性问题**:webchat显示内部memory上下文
  - 问题:memory检索结果被渲染到用户聊天界面
  - 影响:内部上下文泄露给终端用户
  - 状态:1条评论(说明影响范围)
  - 优先级:高,隐私问题
- **#55813 regression**:2025.3.24 Beta 2 is broken
  - 问题:auto-upgrade触发ENOENT: no such file or directory, mkdir '/app'
  - 标签:bug, regression
  - 状态:0条评论,新issue
  - 优先级:高,regression
- **#55805 行为bug**:plugins install fails npm fallback
  - 问题:clawhub resolution失败后未fallback到npm
  - 状态:0条评论,有bug标签
  - 优先级:中等
- **#55811已有PR**:Telegram sendChatAction retry spam → #55838 PR已创建修复
  - PR: fix(telegram): backoff for transient network errors in sendChatAction
  - 状态:PR已存在,跳过重复工作

### 2026-03-27 22:46(社区机会扫描 - 新增发现)
- **#55816 高优先级regression**:pi-* 0.63.0升级后自定义provider失败
  - 问题:升级后自定义provider(openai-completions API)报错"No API key for provider"
  - 根因:streamFn被替换后API key解析丢失
  - 建议修复:在streamFn赋值后设置getApiKey回调
  - 状态:0条评论,新issue,清晰的根因分析
  - 优先级:高,能本地验证,已有明确修复方案
- **#55808 WhatsApp echo loop bug**:selfChatMode: true时仍回音
  - 问题:WhatsApp自聊时出站消息被回传为入站(~107ms延迟)
  - 根因:WhatsApp Web投递确认被当作新消息处理
  - 建议:入站路由层实现消息ID去重
  - 状态:0条评论,新issue
  - 优先级:中等,已有workaround(用单独号码)
- **#55815 修复了#55786**:REACTION_INVALID警告问题已被修复
  - 作者karanuppal已提交PR修复
  - 跳过重复工作
- **#55817 session transcript gap**:会话轮换后立即确保transcript存在
  - 小型修复(size: S),有测试覆盖
  - 状态:0评论,可review
- **#55792 高优先级问题**:网关重启后消息丢失问题
  - 问题:网关重启期间(30-60秒)的入站消息被静默丢弃
  - 影响:用户发送消息后无响应,不知道消息丢失
  - 建议:重启后检查上次bot消息后的消息历史进行补发
  - 状态:0条评论,新issue
  - 优先级:高,影响用户体验和消息完整性
- **#55811 Telegram重试问题**:Telegram API临时故障时每3秒重试并产生ERROR日志
  - 问题:固定3秒重试间隔,ERROR级别日志误导性
  - 建议:实现指数退避、WARN级别日志、断路器机制
  - 状态:0条评论,新issue
  - 优先级:中等,可用性问题
- **#38902 活跃问题更新**:HTTP 422错误仍有新讨论
  - 最新评论:用户尝试代理转发解决内容格式问题,但工具调用仍有问题
  - 状态:19条评论,仍在活跃讨论
  - 优先级:高,影响本地模型用户
- **#55809 MiniMax M2.7修复**:修复流式输出中reasoning_content泄漏问题
  - 状态:已有PR,已有人处理
  - 优先级:低,跳过
- **#55810 Docker挂载传播**:添加workspaceMountPropagation配置
  - 状态:有自动化review,技术性改进
  - 优先级:低,跳过

### 2026-03-27 20:52(社区机会扫描 - 发现高优先级安全漏洞)
- **#55782 安全漏洞发现**:Aisle安全分析识别出2个高风险安全问题(环境变量秘密泄露和allowlist绕过)
  - 问题1:Inline credential strings can be coerced into env SecretRef(${VAR})
  - 问题2:Auth-profile SecretRef can exfiltrate arbitrary environment variables(allowlist bypass)
  - 安全分析:https://github.com/openclaw/openclaw/pull/55782#issuecomment-4142352022
- **行动**:将 #55782 添加到高优先级安全审查列表,需要立即审查并可能提交修复

### 2026-03-27 20:56(社区机会扫描 - 新增监控项)
- **#55786 可用性问题**:Telegram `REACTION_INVALID` 警告未遵守 `suppressToolErrors: true` 配置
  - 影响:用户看到 "⚠️ ✉️ Message: 🫡 failed" 而不是静默忽略
  - 状态:0条评论,可能是新bug
  - 备注:代码路径在打包文件中,较复杂;考虑作为待研究项
- **#55787 regression**:gpt-5.2/5.4 用户首次tool call后出现400错误(已有人认领,跳过)
- **#55788**:OpenAI Codex音频功能修复(已有人认领,跳过)

### 2026-03-27 19:06(新增 action 项)
- **#55479 review comment**:确认 specialist 注入 bug,提出具体验证问题(单一路径 vs 双重路径),comment:https://github.com/openclaw/openclaw/issues/55479#issuecomment-4141840828
- **#55458 review comment**:肯定 diagnostics 方向,指出"No functional tests added"缺口,建议补 test 或加 code comment,comment:https://github.com/openclaw/openclaw/issues/55458#issuecomment-4141841622
- 范总授权:以后发现新机会直接执行,无需确认

### 2026-03-27 11:40(#55466 作者回复确认修复)
- **#55466 新动态**:author `guoqunabc` 发了 2 个新 commit 修复全部 3 项 review 问题
  - commit `e7ea88f7`:修复 schema 1.0 jsonCard.elements 顶层提取
  - commit `cf582f3a5`:移除 rows 类型声明
- **#55466 状态**:main 确认所有问题已修复,发评论 ✅ "looks good to merge"
- feishu CI job(extension-fast-feishu)PASS;main CI 失败为已知 pre-existing 问题

### 2026-03-27 10:08(主动 review)
- **#55466 review**:EronFan ✅ Approve + 3 suggestions - 指出 top-level json_card.elements 缺失提取、rows 字段未递归、类型安全可改进;评论已提交

### 2026-03-27 03:56(定时检查)
- **#55153 新 review**:EronFan ✅ Approve,确认 fix 逻辑正确;minor note:PR 描述措辞可更清晰(描述说检查"最终参数"但实际检查"累积文本当前状态")- 非 blocker
- **#55137 新 review**:EronFan ✅ Approve + question,指出 `formatToolTitle`(用 `escapeInlineControlChars`)与 `resolvePermissionRequest`(用 `sanitizeTerminalText`)对相同输入可能产生不同输出,询问是否有意为之 - ling 之前 review 也提过此问题
- **#54952 / #54964 / #55008 / #55013**:仍 0 条 maintainer 新评论(Greptile/Codex 评论为已知已处理项)

### 2026-03-26 19:49(定时检查)
- **Greptile 反馈 #55008**:P1 回归风险 - 误删 feishu skills 注册 + 中文文档手动编辑违规;ling 已推送修复 commit(`2c203a8d7`),Greptile 评论已变 stale
- **Greptile 反馈 #55013**:两文档 groupPolicy 描述不准确;ling 已推送修复 commit(`be76c12366`),Greptile 评论已变 stale
- **Issue #54952 / #54964**:仍 0 条 maintainer 评论,无新进展
- **待办**:等 maintainer 手动 re-review 或 PR merge

### 2026-03-26 20:54(main 发出 #55153 + #55137 review)
- **main 直接发出两个 review**(ling 未响应,由 main 直接完成):
  - #55153 ✅ Approve review:https://github.com/openclaw/openclaw/pull/55153#pullrequestreview-4013906237
  - #55137 ✅ Approve+question review:https://github.com/openclaw/openclaw/pull/55137#pullrequestreview-4013909717
- **下一步**:持续扫描新 PR/issue,每 30 分钟 cron 检查所有 open 项反馈
- **ling 进展**:
  - ✅ PR #55008:恢复 `extensions/feishu/openclaw.plugin.json` 中被误删的 `"skills": ["./skills"]` 行 → Commit `bac6026fd3`
  - ✅ PR #55013:修正 4 个文档中 groupPolicy 描述,明确为"访问控制检查(open/allowlist/disabled)"而非"选择 agent" → Commit `feeea5f817`
- **main 动作**:更新本文件,向范总汇报

### 2026-03-26 18:02(推进检查)
- **进展更新**:
  - P1 issue #54952:🟡 已发布,尚无 maintainer 反馈(0 comments)
  - P2 issue #54964:🟡 已发布,尚无 maintainer 反馈(0 comments)
  - P3 PR #55008:🟡 收到 Greptile 自动化 review,有重要反馈需要处理
  - P4 PR #55013:🟡 收到 Greptile 和 ChatGPT-Codex review,有内容准确性反馈需要处理
- **待办**:
  - 处理 PR #55008 的自动化 review 反馈(feishu skills 意外删除问题)
  - 处理 PR #55013 的 review 反馈(groupPolicy 角色描述不准确问题)

### 2026-03-26
- **完成**:P1 issue 已正式发布到 GitHub(#54952)
- **状态**:🟢 已发布,等待 maintainer 反馈

### 2026-03-25
- **完成**:workspace 整理、晨报 cron 增强、晚间收口 cron、新增 10:30 贡献推进检查 cron
- **完成**:P1 英文 issue 草稿 v2 已就绪
- **结论**:P1 / P2 顺序已定,diagnostics gap 方向已收敛

### 2026-03-24
- **完成**:xixi 调研收敛,aoao 风险审查,2 份 GitHub 可发英文草稿
- **关键**:从疑似 bug 收敛为 docs/diagnostics/observability gap

---

## Agent 分工

| Agent | 职责 |
|-------|------|
| main | 总体协调、发布、汇报 |
| xixi | 调研、线索收敛、证据整理 |
| aoao | 风险审查、误判拦截、PR review |

---

## 搁置提案

| 日期 | 提案 | 状态 | 备注 |
|------|------|------|------|
| 2026-03-27 | OpenClaw 配置页缺少 Provider 格式说明字段 | ⏸️ 暂时搁置 | 范总明确暂不推进 |

---

## 定时任务清单

| Cron | 频率 | 职责 | 状态 |
|------|------|------|------|
| OpenClaw 反馈检查 | 每 30 分钟 | 检查已发 issue/PR 的 maintainer 新评论 | ✅ |
| OpenClaw 社区机会扫描 | 每 4 小时 | 主动扫最近 6h 新 issue/PR,找新贡献机会 | ✅ |
| 每日 8 点晨报 | 每天 8:00 | 推送项目状态汇总 | ✅ |

## 下一步行动

### 最高优先级(立即行动)
1. 🔴 **#55995**:严重安全漏洞,/pair approve绕过admin scope guard,CVSS 9.9/10.0
2. 🔴 **#55672**:Release blocker - "No API key for provider"即使probe正常工作
3. 🔴 **#56057**:Channel WebSocket异常关闭导致整个gateway进程崩溃,gateway稳定性问题
4. 🔴 **#56063**:Feishu心跳交付失败,Feishu功能问题
5. 🔴 **#56061**:Telegram长轮询在死TCP socket上无限挂起,连接可靠性问题
6. 🔴 **#56044**:Recent update broke /stop and interrupt behavior,高优先级regression
7. 🔴 **#56045**:Cron job output continues after deletion,高优先级cron系统问题
8. 🔴 **#56040**:msteams streaming protocol causes lost messages,高优先级消息丢失
9. 🔴 **#56052**:Unable to pair telegram channel,高优先级regression,影响新用户设置
10. 🔴 **#56032**:Subagent completion replies silently fail to deliver to Telegram group chats
11. 🔴 **#56010**:Telegram voice notes are not transcribed,高优先级regression
12. 🔴 **#56027**:Plugin hot-reload clobbers tool send channel registry
13. 🔴 **#56029**:Subagents inherit full workspace context,高token浪费问题
14. 🔴 **#56039**:message tool buttons incorrectly marked as required,高优先级schema问题
15. 🔴 **#56034**:Session maintenance prunes active sessions,高优先级会话管理问题
16. 🔴 **#56046**:Signal channel message tool fails,高优先级channel功能问题
17. 🔴 **#56049**:Heartbeat handler re-triggers on subagent auto-announcement,心跳系统问题
18. 🔴 **#56054**:WhatsApp Baileys永久状态499重连循环,连接稳定性问题
19. 🔴 **#56058**:agents.defaults.model.fallbacks未在Anthropic 529时使用,模型回退链失效
20. 🔴 **#56053**:Model fallback chain未在HTTP 402时触发,模型回退链失效
21. 🔴 **#55964**:Telegram工具执行完全失败,高优先级bug
22. 🔴 **#55981**:sessions_send announce错误,隐私/UX问题
23. 🔴 **#55919**:Anthropic 429错误分类,用户得到错误建议
24. 🔴 **#55976**:message tool schema regression,高优先级,之前修复尝试失败
25. 🔴 **#56071**:fix(msteams): reset stream state after tool calls to prevent message loss,高优先级消息完整性修复
26. 🔴 **#55967**:feat(plugins): add api.runtime.agent.abort for aborting agent runs,高优先级插件API增强
27. 🔴 **#56074**:Feishu heartbeat target ID incorrectly resolves,高优先级Feishu心跳功能问题
28. 🔴 **#56072**:Daily session reset silently discards context,高优先级上下文管理问题
29. 🔴 **#56089**:Baileys WhatsApp Web出站发送失败,高优先级regression
30. 🔴 **#56086**:Discord health-monitor触发完整gateway重启,高优先级稳定性问题
31. 🔴 **#56091**:Telnyx出站通话功能完全失效,高优先级语音功能问题
32. 🔴 **#56078**:Cron Job Output Not Saved,高优先级regression
33. 🔴 **#56079**:重启导致sessionId/sessionFile不匹配,影响webchat历史
34. 🔴 **#56127**:WhatsApp插件自动加载导致agent崩溃,高优先级regression,影响所有用户
35. 🔴 **#56124**:Telegram mention-gated群组语音转录失效,高优先级bug
36. 🔴 **#56118**:Node浏览器代理Chrome MCP连接失败,高优先级node功能问题
37. 🔴 **#56117**:Feishu推送消息显示'NO_REPLY'文本,高优先级显示问题
38. 🔴 **#56114**:Feishu插件工具重复注册,高优先级bug
39. 🔴 **#56121**:Cron会话完成后仍停留在running状态,高优先级状态管理问题
40. 🔴 **#56112**:Provider-level cooldown阻止健康模型,高优先级可用性问题
41. 🔴 **#56109**:tool-shell PATH解析不一致,高优先级命令执行问题
42. 🔴 **#56108**:Microsoft Teams通道启动崩溃,高优先级regression
43. 🔴 **#56106**:Windows中文编码损坏,高优先级Windows bug
44. 🔴 **#56102**:ACP服务器拒绝VS Code/Cursor连接,高优先级regression
45. 🔴 **#56096**:Telegram sendChatAction无限重试循环,高优先级bug
46. 🔴 **#56095**:Feishu插件重复注册,性能问题
47. 🔴 **#56094**:静默Agent帮助台运行时功能请求,中等优先级
48. 🔴 **#56093**:模型切换确认误导性警告,中等优先级bug
49. 🔴 **#56119**:webchat会话隔离修复,中等优先级
50. 🔴 **#56128**:gateway workspace dir修复,中等优先级
51. 🔴 **#56092**:系统事件心跳路由修复,中等优先级
52. 🔴 **#56123**:可插拔压缩provider注册表,中等优先级功能增强
53. 🔴 **#56116**:Feishu流式可见性改进,中等优先级功能增强

### 高优先级(今日处理)
29. 🔴 **#55782**:安全漏洞审查(Pi auth secret ref)
30. 🔴 **#55825**:webchat memory泄露到UI,隐私问题
31. 🔴 **#55887**:Discord hook绕过requireMention,安全/权限问题
32. 🔴 **#55931**:sessions_spawn sourceChannel错误,路由问题
33. 🔴 **#55941**:Auth profile cooldown阻塞model fallback,可用性问题
34. 🔴 **#56033**:plugins uninstall配置残留问题
35. 🔴 **#56021**:github-copilot OpenAI Responses replay问题
36. 🔴 **#55282**:Slack Socket Mode regression,入站事件静默丢弃
37. 🔴 **#54931**:Discord health-monitor crash loop,稳定性问题
38. 🔴 **#54688**:kimi-coding/kimi-k2.5工具调用完全失效
39. 🔴 **#53204**:sessions_send announce重试阻塞代理会话
40. 🔴 **#50111**:Discord原生斜杠命令响应'Done'而不是执行
41. 🔴 **#45963**:exec绕过审批流程安全漏洞

### 中等优先级(本周处理)
42. 🔍 **#55976**:message tool schema问题,验证bug
43. 🔍 **#55969**:image tool错误,可用性问题
44. 🔍 **#55966**:Telegram ENOSPC处理,bug
45. 🔍 **#55963**:session-memory hook时区问题,记忆系统
46. 🔍 **#55956**:Voice Call Plugin字段映射,bug
47. 🔍 **#56076**:fix(matrix): align outbound direct-room selection,Matrix修复
48. 🔍 **#52770**:fix(gateway): guard getRuntimeSnapshot(),gateway稳定性
49. 🔍 **#46737**:feat(slack): add Block Kit table block support,Slack功能增强
50. 🔍 **#56077**:fix(diffs): stage bundled runtime deps,技术修复
51. 🔍 **#40377**:feat(continuity): harden adaptive reply threading,可用性改进
52. 🔍 **#51523**:feat(matrix): add subagent hooks for ACP room-binding,Matrix功能增强
53. 🔍 **#49529**:Add configurable Gemini safety settings,模型安全性配置

### 持续监控
15. 🔁 **持续**:每 30 分钟 cron 检查所有 open 项新反馈
16. 🔍 **持续**:每 4 小时社区机会扫描,有新货直接 action
17. 📍 **盯 #55698**:高优先级新 regression,优先验证
18. 📍 **待发**:#55143(acp-router bug)等 xixi 提供 minimal repro 后再动

### 其他待处理
54. 🔍 **#55792**:网关重启后消息丢失
55. 🔍 **#55811**:Telegram重试日志干扰(已有PR #55838修复)
56. 🔍 **#55786**:suppressToolErrors配置不一致
57. 🔴 **#55816**:pi-* 0.63.0 regression
58. 🔍 **#55808**:WhatsApp echo loop(已有workaround)
59. 🔴 **#55844**:channels not initializing regression
60. 🔴 **#55842**:RegExpCompiler OOM crash loop
61. 🔍 **#55834**:model fallback cooldown fails
62. 🔍 **#55829**:exec orphaned grep processes
63. 🔍 **#55813**:Beta 2 ENOENT /app regression
64. 🔍 **#55805**:plugins install npm fallback
65. 🔍 **#55873**:Discord health-monitor maxAttempts=0 crash
66. 🔍 **#55862**:Gateway stuck in retry loop
67. 🔍 **#55863**:plugins.entries rejects configSchema fields
68. 🔴 **#55889**:AI agent sends empty {} regression
69. 🔍 **#55907**:openclaw config set负数字键bug
70. 🔍 **#55903**:Telegram文件附件buttons验证错误
71. 🔍 **#55900**:web_fetch SSRF与代理冲突
72. 🔍 **#55890**:autoThreadName配置不被识别
73. 🔴 **#55942**:NVIDIA NIM Kimi 2.5工具调用完全失败
74. 🔍 **#55938**:浏览器relay 502错误
75. 🔍 **#55943**:子代理session-memory hook不触发
76. 🔴 **#55930**:空参数工具调用失败
77. 🔍 **#55929**:session-memory hook加载问题
78. 🔍 **#55954**:CLI优化功能请求(低优先级)
79. 🔴 **#55995**:严重安全漏洞,/pair admin scope guard绕过
80. 🔍 **#55994**:weixin通道regression,message action=send误判为poll
81. 🔍 **#55993**:session log文件头元数据功能请求
82. 🔴 **#56010**:Telegram语音消息转录失效
83. 🔴 **#56032**:子代理完成消息无法发送到Telegram群聊
84. 🔍 **#56033**:插件卸载配置残留
85. 🔴 **#56027**:插件热重载channel registry丢失
86. 🔴 **#56029**:子代理token浪费问题
87. 🔍 **#56021**:github-copilot OpenAI Responses replay问题
88. 🔍 **#56017**:简体中文本地化PR
89. 🔍 **#56095**:Feishu插件重复注册问题
90. 🔍 **#56087**:mac配置文件错误问题
91. 🔍 **#56050**:before_skill_install hook安全增强PR
92. 🔍 **#46737**:Slack Block Kit表格支持PR
93. 🔍 **#56077**:bundled runtime deps暂存修复
94. 🔍 **#40377**:自适应回复线程增强PR
95. 🔍 **#56076**:Matrix出站房间选择修复
96. 🔍 **#51523**:Matrix子代理hook增强PR
97. 🔍 **#56060**:Telegram子线程绑定功能PR
98. 🔍 **#56071**:msteams消息丢失修复PR
99. 🔍 **#55967**:插件agent.abort API增强PR
100. 🔍 **#56074**:Feishu心跳目标ID解析错误
101. 🔍 **#56072**:每日会话重置上下文丢失问题

## 今日完成(2026-03-26)

- ✅ 发布 P1 issue #54952(Diagnostics gap)和 #54964(Session zombie)
- ✅ 提交 PR #55008(message channel docs fix)和 #55013(feishu routing docs fix)
- ✅ ling 修复了 Greptile review 指出的 feishu skills 误删和 groupPolicy 描述错误
- ✅ main 发出 #55153 review(Approve)和 #55137 review(Approve + question)
- ✅ main 在 #55143 留 constructive comment,询问作者 minimal repro
- ✅ aoao 复核了两个 review,判断准确
- ✅ cron 反馈检查已修复(isolated session + 900s timeout + no deliver)

### 2026-03-28 07:46(社区机会扫描 - 第十一轮新发现)
- **新PR发现(90分钟内更新)**:
  - **#46737**:feat(slack): add Block Kit table block support for markdown tables (23:44:08Z)
    - 标签:docs, channel: slack, channel: twitch, size: L
    - 状态:新PR,添加Slack Block Kit表格块支持
    - 优先级:中等,Slack功能增强
  - **#56077**:fix(diffs): stage bundled runtime deps after updates (23:43:38Z)
    - 标签:maintainer, size: XS
    - 状态:新PR,修复更新后打包运行时依赖的暂存问题
    - 优先级:中等,技术修复
  - **#40377**:feat(continuity): harden adaptive reply threading and subagent delivery continuity (23:43:08Z)
    - 标签:app: macos, app: web-ui, gateway, agents, channel: feishu, size: M
    - 状态:新PR,增强自适应回复线程和子代理交付连续性
    - 优先级:中等,可用性改进
  - **#56071**:fix(msteams): reset stream state after tool calls to prevent message loss (23:39:56Z)
    - 标签:channel: msteams, maintainer, size: S
    - 状态:新PR,修复msteams工具调用后重置流状态防止消息丢失
    - 优先级:高,msteams消息完整性修复
  - **#55967**:feat(plugins): add api.runtime.agent.abort for aborting agent runs (23:39:27Z)
    - 标签:docs, app: web-ui, gateway, agents, size: XL
    - 状态:新PR,为插件API添加agent.abort功能
    - 优先级:高,插件API增强
  - **#56076**:fix(matrix): align outbound direct-room selection (23:36:00Z)
    - 标签:channel: matrix, maintainer, size: M
    - 状态:新PR,修复Matrix出站直连房间选择问题
    - 优先级:中等,Matrix修复
  - **#56050**:feat(plugins): add before_skill_install hook for external security scanners (23:26:45Z)
    - 标签:docs, agents, maintainer, size: L
    - 状态:新PR,添加before_skill_install hook用于外部安全扫描器
    - 优先级:高,安全增强
  - **#51523**:feat(matrix): add subagent hooks for ACP room-binding (23:24:22Z)
    - 标签:channel: matrix, size: L
    - 状态:新PR,为Matrix添加子代理hook用于ACP房间绑定
    - 优先级:中等,Matrix功能增强
  - **#49529**:Add configurable Gemini safety settings for Google provider (23:24:22Z)
    - 标签:docs, gateway, agents, size: M
    - 状态:新PR,为Google provider添加可配置的Gemini安全设置
    - 优先级:中等,模型安全性配置
  - **#56074**:Bug: Feishu heartbeat target ID incorrectly resolves to string 'heartbeat' instead of open_id (23:23:34Z)
    - 标签:无
    - 状态:0条评论,新issue,Feishu心跳目标ID解析错误
    - 优先级:高,Feishu心跳功能问题
  - **#52770**:fix(gateway): guard getRuntimeSnapshot() and preserve probe intent in health refresh (23:23:14Z)
    - 标签:gateway, commands, size: S
    - 状态:新PR,修复gateway健康检查和运行时快照问题
    - 优先级:中等,gateway稳定性
  - **#56060**:feat(telegram): add child thread-binding placement via createForumTopic [AI-assisted] (23:22:36Z)
    - 标签:channel: telegram, agents, size: S
    - 状态:新PR,为Telegram添加通过createForumTopic的子线程绑定功能
    - 优先级:中等,Telegram功能增强
  - **#56072**:Daily session reset silently discards context without memory flush or compaction (23:21:59Z)
    - 标签:无
    - 状态:0条评论,新issue,每日会话重置静默丢弃上下文
    - 优先级:高,上下文管理问题

- **已存在的issue/PR(之前已记录)**:
  - #53747, #53864, #52037, #55346, #56021, #56075, #55347已在先前扫描中记录

- **扫描结论**:
  - 本次扫描发现12个新PR在90分钟内更新,其中#56071(msteams消息丢失修复)和#55967(agent.abort API)为高优先级
  - 所有issue均已在先前扫描中记录,无新增高优先级issue
  - 建议:关注#56071和#55967 PR,可能提供review机会

### 2026-03-28 10:46(社区机会扫描 - 第十三轮新发现)
- **#56127 高优先级regression**:[Bug]: Agent failed before reply: WhatsApp plugin runtime is unavailable: missing light-runtime-api for plugin 'whatsapp'
  - 问题:WhatsApp插件未配置时自动加载,导致agent在每条消息上崩溃
  - 影响:即使从未配置或安装WhatsApp,agent也会因WhatsAPp runtime错误而崩溃
  - 标签:bug, regression
  - 状态:0条评论,新issue
  - 优先级:高,影响所有用户,即使未使用WhatsApp
- **#56124 高优先级bug**:Bug: Audio preflight transcription not triggering in mention-gated Telegram groups
  - 问题:Telegram mention-gated群组中语音消息预转录功能不触发
  - 影响:语音消息被静默跳过,无转录发生
  - 配置:tools.media.audio.enabled: true, requireMention: true
  - 状态:0条评论,新issue
  - 优先级:高,Telegram语音转录功能失效
- **#56118 高优先级bug**:Node browser proxy: Chrome MCP existing-session (user profile) fails with Connection closed - consent dialog never appears
  - 问题:Node浏览器代理Chrome MCP连接失败,Chrome从不显示授权对话框
  - 影响:远程节点浏览器功能不可用
  - 状态:0条评论,新issue
  - 优先级:高,node浏览器代理功能问题
- **#56117 高优先级bug**:[Bug]: Feishu push messages display literal 'NO_REPLY' text when no reply context exists
  - 问题:Feishu推送消息显示字面'NO_REPLY'文本
  - 影响:用户体验受损,显示内部技术文本
  - 状态:0条评论,新issue
  - 优先级:高,Feishu显示问题
- **#56114 高优先级bug**:Feishu plugin tools re-register repeatedly on config hot-reload
  - 问题:Feishu插件工具在配置热重载时重复注册
  - 标签:bug, bug:behavior
  - 状态:0条评论,新issue
  - 优先级:高,Feishu插件重复注册问题
- **#56121 高优先级bug**:Cron sessions stuck in status=running after completion
  - 问题:cron会话在完成后仍停留在running状态
  - 状态:0条评论,新issue
  - 优先级:高,cron会话状态管理问题
- **#56119 中等优先级**:Fix/webchat session isolation
  - 标签:app:web-ui, gateway, size:S
  - 状态:0条评论,新issue
  - 优先级:中等,webchat会话隔离修复
- **#56128 中等优先级**:fix(gateway): use agent workspace dir in session transcript cwd
  - 标签:gateway, size:L
  - 状态:0条评论,新issue
  - 优先级:中等,gateway修复
- **#56092 中等优先级**:fix: route system-event-triggered heartbeats to configured session
  - 标签:size:L
  - 状态:0条评论,新issue
  - 优先级:中等,心跳路由修复
- **#56126 低优先级功能请求**:Feature: Batch API support for non-urgent cron jobs (50% cost reduction)
  - 状态:0条评论,新issue
  - 优先级:低,功能请求
- **#56125 低优先级功能请求**:Feature: Per-task model routing (route simple tasks to cheaper models)
  - 状态:0条评论,新issue
  - 优先级:低,功能请求
- **#56123 中等优先级功能增强**:feat: add pluggable compaction provider registry
  - 标签:docs, gateway, extensions:lobster, agents, size:S
  - 状态:0条评论,新issue
  - 优先级:中等,可插拔压缩provider
- **#56116 中等优先级功能增强**:Improve Feishu streaming visibility and filter scratchpad text
  - 标签:channel:feishu, size:M
  - 状态:0条评论,新issue
  - 优先级:中等,Feishu流式可见性改进
- **#56115 低优先级功能请求**:Feature request: Announce-mode prompt guard for cron jobs
  - 状态:0条评论,新issue
  - 优先级:低,功能请求

- **扫描结论**:
  - 本次扫描发现多个高优先级issue,特别是#56127(WhatsApp插件自动加载导致崩溃)和#56124(Telegram语音转录失效)
  - #56127是regression,影响所有用户,即使未使用WhatsApp
  - #56124影响Telegram语音功能用户,配置了requireMention的群组中语音转录失效
  - 建议:重点关注#56127,这是高优先级regression,能本地复现且严重度高

### 2026-03-29 11:23(反馈检查 - 重要 maintainer feedback)
- **#55008 新动态**:EronFan (2026-03-29 02:58:50Z) 在 #55008 PR 发了一条重要评论:
  - 标题:**"Maintainer attention needed: skills entry incorrectly removed"**
  - 指出 PR 移除 `extensions/feishu/openclaw.plugin.json` 中的 `"skills": ["./skills"]` 是**真实 bug**
  - 影响:feishu 的 4 个 skills(feishu-doc, feishu-drive, feishu-perm, feishu-wiki)将无法注册
  - 状态:PR 作者认为这是避免 double registration,但 maintainer 认为这是 regression
  - **优先级:高,这是 maintainer 明确指出的真实 bug,需要 PR 作者回应**
- **#55013**:仍只有 Greptile 旧评论,无 maintainer 人为反馈
- **#54952 / #54964**:0 条评论,无新进展

### 2026-03-29 08:56(早间行动 - 社区 PR 支持)
- **支持了 6 个新 PR:**
  - #56685 ✅ Approve:修复 subagent context file list 文档与源码不一致(XS,docs)
  - #56666 ✅ Approve:修复 pinned channel registry 导致的 "Outbound not configured" bug(XS)
  - #56686 ✅ Approve:WhatsApp quoted outbound replies 功能修复(M,完整测试覆盖)
  - #56668 ✅ Approve:WebSocket ping keepalive 防止长时间 tool call 时连接断开(XS,gateway)
  - #56683 ✅ Approve:修复 401/403 auth failures 被误分类为 rate limits(XS,fix #47720)
  - #56667 ✅ Approve:Mistral onboarding 改用 mistral-conversations API 避免 HTTP 422(XS)
  - #56677 ✅ Approve:Slack streaming mutual exclusion 防止重复消息投递(XS)
- **新发现 issue(待评估):**
  - #56684:Claude-mem integration duplicates session init(memory/multi-agent 问题)
  - #56682:webchat session context lost after Gateway restart(SIGUSR1 热重启问题)
  - #56676:read tool allowed but not executed, agent fakes output(严重 bug,多渠道复现)
  - #56680:TTS directive parser treats literal [[tts:...]] examples as active(行为 bug)
  - #56670:openai-completions streaming token usage always zero(影响 auto-compaction)
  - #56658:OpenAI Codex OAuth missing `model.request` scope(认证问题)
- **教训:** gh CLI 有时超时,但 curl 方式稳定;批量支持多个 PR 效率更高


## 项目协作规则(2026-03-29 范总明确,下述规则高于一切)

### 核心原则:决策权在 main,不在范总
main 对以下事项有完全决定权,**不需要问范总**:
- 判断某个 bug 值得修 → 立即派 aoao 去执行
- 判断某个 PR 值得支持 → 立即发 Approve 评论
- 判断某个 issue 值得提 → 立即写并发布
- 范总问"要不要 XXX" → 默认答案是"已经在做了",除非有明显风险

### 流转规则(已写入 xixi cron 任务消息)
**xixi cron 发现可用 bug → 发给 main → main 转发给 aoao**

具体实现:
- xixi cron(`6f8bd6c8`,每 1 小时)发现可用 bug 时:
  1. 写 workspace-xixi/memory/OPENCLAW-PROJECT.md
  2. **sessions_send 发给 main**(`agent:main:feishu:default:direct:ou_5abeeb52afc248214694d8d79ab20df8`)
- main 收到后:
  1. 判断是否值得修(已在 AGENTS.md 下放决策权,默认值得修)
  2. 立即 sessions_send 转发给 aoao
  3. 同时更新 /root/.openclaw/workspace/memory/OPENCLAW-PROJECT.md
- aoao 收到后直接执行,修完回报 main
- main 做最终验收和发布决策

**禁止:xixi 跳过 main 直接发给 aoao,或停在文件里不动。**

### aoao 行动 → 直接执行,不等范总确认
aoao 收到任务后直接执行,修完向 main 回报。**不等范总确认**。

### main 行动 → 协调和对外,不等待
main 负责调度和对外沟通(发 PR、发评论、发 issue)。有不确定的高风险事项才问范总。

## 工作原则(2026-03-29 范总明确)

> 以下为该项目的工作态度和原则,不可违背:

1. **主人问进度时汇报进度,但汇报进度不意味着暂停工作**
2. **如果主人没有要求停止或暂停,绝对不能暂停项目工作**
3. **主动推进、持续推进工作,是这个项目的工作原则和态度**
4. **利用 cron 或定时任务等任何方式完成"持续推进工作"这个工作原则**

## 已配置的 Cron 任务(自动持续运行)

| 任务 | 频率 | 作用 |
|------|------|------|
| openclaw-feedback-check (`57a448ff`) | 每 30 分钟 | 检查 #54952/#55008/#55013/#54964 的 maintainer 新反馈 |
| OpenClaw 社区机会扫描 (`6f8bd6c8`) | 每 3 小时 | 扫描新 issue/PR,识别高优先级候选并支持 |
| OpenClaw 项目进度汇报 (`348ae583`) | 每天 9:00 | 汇总进度发到本群 |
| 每日晨报 (`morning-briefing`) | 每天 8:00 | 晨报汇总所有事项 |
| workspace 晚间收口 (`3c64fbc0`) | 每天 21:05 | 整理 workspace 未提交改动 |

> ⚠️ 注意:`openclaw cron list/add/edit` 命令存在卡死问题,直接编辑 `~/.openclaw/cron/jobs.json` 更可靠

---

## 扫描记录 2026-03-30 18:40 GMT+8(手动触发)

### 新发现(Mar 30 新开 issues - 来自 web search index)

| 编号 | 标题 | 标签 | 优先级 | 备注 |
|------|------|------|--------|------|
| #57629 | [[Bug]: `skills list --json` writes JSON to stderr instead of stdout] | bug | P1 | CLI 工具行为错误,stdout/stderr 混用 |
| #57626 | [[Bug]: Model switch to unresponsive Ollama model cascades into infinite [object Object] loop, corrupts session] | bug, regression | P1 | 高危:Ollama 无响应时触发无限循环,session 数据损坏 |
| #57623 | [[Bug]: memoryFlush context-window lookup ignores modelOverrides on gateway path] | bug | P1 | gateway 路径下 memoryFlush 忽略模型覆盖参数 |
| - | Bug: Subagent/cron messages not delivered to WeChat (openclaw-weixin) | bug, regression, weixin | P1 | P45 复现:子代理/cron 消息无法送达微信 |
| #57618 | [[Bug]: Mattermost channel config rejected after upgrade to 2026.3.28 - "must NOT have additional properties"] | bug, regression | P1 | v2026.3.28 升级导致 Mattermost 配置被 schema 拒绝,regression |
| - | Parent session stuck after subagent prompt-error abort - queued messages not processed | bug | P1 | 子代理 abort 后父 session 卡死,队列消息未处理 |

### 扫描各方向结论

**方向1:GitHub Issues**
- gh api 查询 2h 内更新返回 0(repo 有 16,559 open issues,API 查询可能被限流或缓存问题)
- web search index 找到今日新开 issues:#57629/#57626/#57623/#57618 等
- 最高优先级:**#57626**(Ollama 无限循环 corrupt session)和 **#57618**(v2026.3.28 升级后 Mattermost regression)

**方向2:InStreet 社区**
- https://instreet.coze.site/skill.md 存在,但这是 InStreet Agent 平台的 Skill 文档(非 OpenClaw 专属)
- 未发现 OpenClaw 实战讨论帖子
- 结论:**无 OpenClaw 相关内容**

**方向3:Discord**
- site:discord.com 搜索返回 0 结果
- 搜索 "openclaw discord 社区 问题 bug" 找到历史 issues(#15865/#17080/#28647)和 1 条 Reddit 讨论
- Reddit 用户反映 Discord 连接丢失、typing 卡住
- 结论:**Discord 社区无公开新反馈**

**方向4:相关插件(openclaw-weixin 等)**
- openclaw-weixin 不在公开 GitHub 仓库(404)
- 已有 P45(#55994 weixin regression)记录,plugin 代码不可见
- 今日新发现:Subagent/cron 消息无法送达微信(再次确认 P45 活跃)

### 最高优先级建议

1. 🔴 **#57626** - Ollama 无限循环 corrupt session:建议派 aoao 研究根因,评估是否可提 fix PR
2. 🔴 **#57618** - v2026.3.28 Mattermost regression:schema breaking change,影响升级用户,建议快速确认并回复
3. 🟡 **Subagent/cron → WeChat** - P45 持续活跃,plugin 代码不可见,建议通过官方渠道(GitHub discussion)向 maintainer 请求插件代码可见性或确认修复计划

### 2026-03-30 18:55(4方向扫描 - 第20轮新发现)
- **xixi 4方向扫描**(2026-03-30 10:55 UTC):
- **方向1(GitHub issues)**:发现6个最近2小时内更新的items(1个新issue + 5个PRs)
  - **#57660(新)** - Telegram polling stall detector fires too aggressively (110s), causes message delivery failures(bug+bug:behavior)
  - **#57655(PR)** - fix(exec): add shared approval runtime(docs+maintainer+size:L)
  - **#57516(PR)** - refactor(exec): centralize native approval delivery(docs+channel:discord/telegram+maintainer+size:XL)
  - **#57650(PR)** - fix(exec): harden approval auth and account routing(channel:discord/telegram+maintainer+size:L)
  - **#51476(PR)** - fix: use global OAuth refresh lock(docs+agents+size:M)
  - **#55619(PR)** - fix(feishu): exponential backoff + PingInterval guard(channel:feishu+size:S)
- **方向2(InStreet社区)**:无 OpenClaw 相关内容
- **方向3(Discord/GitHub discussions)**:搜索到的都是已知issues,无新的社区讨论
- **方向4(相关插件仓库)**:无新的 weixin 相关 issue
- **结论**:#57660 是唯一新发现,Telegram polling stall detector 过于激进(110s)导致消息投递失败
-建议:#57660 可修性 S,值得研究 polling stall detector 的超时逻辑

### 2026-03-31 06:25(4方向扫描 - 第21轮新发现)
- **xixi 4方向扫描**(2026-03-30 22:25 UTC):
- **方向1(GitHub issues)**:发现18个最近2小时内更新的items(10个新issue + 8个已有issues更新)
  - **#57964(新)** - [Bug]: repeated characters collapse when displayed in dashboard or tui(bug+regression)
  - **#57963(新)** - [Bug]: Cron exec timeout kills workspace backup step silently
  - **#57961(新)** - [Bug]: Live session model switch detector blocks programmatic fallback during rate limits
  - **#57960(新)** - Discord threads should inherit parent channel agent binding and exec permissions
  - **#57958(新)** - cache_control not applied to system prompt on direct Anthropic provider path (cacheRead=0)
  - **#57956(新)** - BUG: Anthropic type: "token" auth profiles broken in v2026.3.28(bug+regression)
  - **#57952(新)** - feat: configurable CommandLane.Nested concurrency - unblock parallel hook/cron/sessions_send execution
  - **#57950(新)** - [Bug]: browser.request missing at runtime even though browser plugin is loaded(bug+bug:crash)
  - **#57947(新)** - [Bug]: Cron payload model override ignored - always resolves to agent default(bug+regression)
  - **#57945(新)** - Bug: Isolated agentTurn cron jobs fail - docs/reference/templates not bundled in npm package
  - **#57941(新)** - Plugin hook: support per-message model switching in persistent sessions
  - **#57939(新)** - [Bug]: Gateway default model not updated after `openclaw models set` + service restart
  - **#57935(新)** - Telegram incoming messages not received after gateway restart
  - **#57933(新)** - Feature: Per-Session Health Polling & Live Status Indicators
  - **#57930(新)** - openai-codex-responses provider sends oversized `instructions` field, gets 400 Bad Request
  - **#57928(新)** - session.tool / session.message events don't carry originating sessionKey for subagent sessions
  - **#57920(已更新)** - Stale ended subagent runs persist in childSessions, ghost agents on Floor
  - **#57898(已更新)** - [Bug]: ARE YOU GOING TO FRIGGING KEEP BREAKING THIS THING OR WE CAN GET A STABLE VERSION???????
  - **#57896(已更新)** - [Bug]: Gateway restart leaves stale exec config - onRestart passes activate:false to activateRuntimeSecrets
- **方向2(InStreet社区)**:无 OpenClaw 相关内容(该文档是 InStreet Agent 平台的 API 文档,与 OpenClaw 无关)
- **方向3(Discord/GitHub discussions)**:无新的社区讨论(web_search 返回的都是已知的 GitHub issues:#44502, #17080, #24637, #17802)
- **方向4(相关插件仓库)**:无新的 weixin 相关 issue(搜索结果都是已知的 issues #52341、#52885 或第三方仓库)
- **xixi 结论**:本次扫描发现10个新issues,其中最高优先的是#57950(P0,browser.request缺失)和#57956(P1,Anthropic auth regression)
- **建议**:aoao优先修复#57950(浏览器功能完全失效)+ #57956(Anthropic auth regression)+ #57947(cron model override失效)
- 已更新:P227-P236

### 2026-03-31 07:25(4方向扫描 - 第22轮新发现)
- **xixi 4方向扫描**(2026-03-30 23:25 UTC):
- **方向1(GitHub issues)**:发现20个最近2小时内更新的items(7个新issue + 13个PRs)
  - **#57989(新)** - Bug: WhatsApp linked device does not receive group messages (DMs work fine)
  - **#57988(新)** - Bug: Heartbeat read tool called without path
  - **#57985(新)** - [Bug]: whatsapp grups
  - **#57981(新)** - [Bug]: xAI/openai-responses crashes with 422 when tool results include image blocks from read(image)(bug+regression)
  - **#57980(新)** - Test: approval E2E
  - **#57977(新)** - [Feature]: Continuous sessions across interfaces.
  - **#57976(新)** - feat: GPU passthrough for Docker sandbox
  - **#57975(新)** - [Bug]: The search for AI is not working, it does not search
  - **#57974(新)** - control-ui sessions.list polling saturates gateway with many conversations
  - **#57973(新)** - [Bug]: edit tool 100% failure in 2026.3.30 - CLAUDE_PARAM_GROUPS.edit validation rejects edits[] array format
  -**#57969(新)** - [Bug]: Zapier MCP via @ownid/mcp-remote fails in OpenClaw bundle MCP with MCP error -32001: Request timed out
  - **#57968(新)** - Cron payload.model override ignored - agent primary model wins via 'live session model switch'
  - **#57967(新)** - macOS: gateway LaunchAgent plist is written with 0644 instead of 0600
  - **#57965(新)** - Sub-agent exec output not returned to parent session
  - **#57979(新)** - [Bug]: repeated characters collapse when displayed in dashboard or tui(bug+regression)
  - **#57979(新)** - [Bug]: Cron exec timeout kills workspace backup step silently
  - **#57981(新)** - [Bug]: Live session model switch detector blocks programmatic fallback during rate limits
  - **#57983(新)** - Discord threads should inherit parent channel agent binding and exec permissions
  - **#57985(新)** - cache_control not applied to system prompt on direct Anthropic provider path (cacheRead=0)
- **方向2(InStreet社区)**:无 OpenClaw 相关内容(该文档是 InStreet Agent 平台的 API 文档,与 OpenClaw 无关)
- **方向3(Discord/GitHub discussions)**:无新的社区讨论(web_search 返回的都是已知的 GitHub issues)
- **方向4(相关插件仓库)**:无新的 weixin 相关 issue(搜索结果都是已知的 issues 或第三方仓库)
- **xixi 结论**:本次扫描发现8个高优先级新issues,其中#57989(WhatsApp 群组消息失效)、#57988x(心跳工具参数错误)、#57981(xAI/OpenAI 422崩溃)、#57975(搜索功能失效)、#57974(control-ui polling 饱和 gateway)、#57973(edit工具 100%失败)、#57968(cron model override 失效)最为严重
- **建议**:aoao优先修复#57989(WhatsApp 群组消息失效)+ #57988(心跳工具参数错误)+ #57973(edit 工具完全失效)+ #57968(cron model override 失效)
- 已更新:P237-P243

### 2026-03-31 07:25(4方向扫描 - 第22轮 - sessions_send 失败)
- **xixi 4方向扫描**(2026-03-30 23:25 UTC):
- **方向1(GitHub issues)**:发现20个最近2小时内更新的items(7个新issue + 13个PRs)
  - **#57989(新)** - Bug: WhatsApp linked device does not receive group messages (DMs work fine)
  - **#57988(新)** - Bug: Heartbeat read tool called without path
  - **#57985(新)** - [Bug]: whatsapp grups
  - **#57981(新)** - [Bug]: xAI/openai-responses crashes with 422 when tool results include image blocks from read(image)(bug+regression)
  - **#57980(新)** - Test: approval E2E
  - **#57977(新)** - [Feature]: Continuous sessions across interfaces.
  - **#57976(新)** - feat: GPU passthrough for Docker sandbox
  - **#57975(新)** - [Bug]: The search for AI is not working, it does not search
  - **#57974(新)** - control-ui sessions.list polling saturates gateway with many conversations
  - **#57973(新)** - [Bug]: edit tool 100% failure in 2026.3.30 - CLAUDE_PARAM_GROUPS.edit validation rejects edits[] array format
  - **#57969(新)** - [Bug]: Zapier MCP via @ownid/mcp-remote fails in OpenClaw bundle MCP with MCP error -32001: Request timed out
  - **#57968(新)** - Cron payload.model override ignored - agent primary model wins via 'live session model switch'
  - **#57967(新)** - macOS: gateway LaunchAgent plist is written with 0644 instead of 0600
  - **#57965(新)** - Sub-agent exec output not returned to parent session
  - **#57964(已更新)** - [Bug]: repeated characters collapse when displayed in dashboard or tui(bug+regression)
  - **#57963(已更新)** - [Bug]: Cron exec timeout kills workspace backup step silently
  - **#57961(已更新)** - [Bug]: Live session model switch detector blocks programmatic fallback during rate limits
  - **#57960(已更新)** - Discord threads should inherit parent channel agent binding and exec permissions
  - **#57958(已更新)** - cache_control not applied to system prompt on direct Anthropic provider path (cacheRead=0)
- **方向2(InStreet社区)**:无 OpenClaw 相关内容(该文档是 InStreet Agent 平台的 API 文档,与 OpenClaw 无关)
- **方向3(Discord/GitHub discussions)**:无新的社区讨论(web_search 返回的都是已知的 GitHub issues)
- **方向4(相关插件仓库)**:无新的 weixin 相关 issue(搜索结果都是已知的 issues 或第三方仓库)
- **xixi 结论**:本次扫描发现8个高优先级新issues,其中#57989(WhatsApp 群组消息失效)、#57988(心跳工具参数错误)、#57981(xAI/OpenAI 422崩溃)、#57975(搜索功能失效)、#57974(control-ui polling 饱和 gateway)、#57973(edit 工具 100% 失败)、#57968(cron model override 失效)最为严重
- **建议**:aoao 优先修复 #57989(WhatsApp 群组消息失效)+ #57988(心跳工具参数错误)+ #57973(edit 工具完全失效)+ #57968(cron model override 失效)
- **⚠️ sessions_send 失败**:尝试向 main 发送报告时,sessions_send 和 message 工具都返回错误
  - sessions_send 错误:No session found(main session status=done,非 running)
  - message 错误:Request failed with status code 400(Feishu channel 配置问题)
  - **根因**:main session 的 Feishu deliveryContext.channel 是 "webchat",应该是 "feishu"
  - **影响**:无法自动将扫描结果发送给 main,需要手动检查文件
  - 已更新:P237-P243

### 2026-03-31 08:25(4方向扫描 - 第23轮新发现)
- **xixi 4方向扫描**(2026-03-31 00:25 UTC):
- **方向1(GitHub issues)**:发现20+个最近创建的issues,其中10+个为新发现
  - **#58006(新)** - [Bug] read tool cannot read newly created files immediately after write(高优先级,文件系统一致性问题)
  - **#57981(新)** - [Bug]: xAI/openai-responses crashes with 422 when tool results include image blocks(bug+regression,高优先级)
  - **#57994(新)** - [Bug]: browser.request unknown method(高优先级,浏览器自动化功能失效)
  - **#57973(新)** - [Bug]: edit tool 100% failure in 2026.3.30(bug+regression,高优先级)
  - **#57999(新)** - Subagent deliveryContext loses to/threadId/accountId when spawned from group topics
  - **#57998(新)** - Bug: LiveSessionModelSwitchError not handled in subagent runner
  - **#57997(新)** - Cron jobs ignore payload.model and run on agent default model
  - **#57996(新)** - QMD per-agent SQLite caches cause extreme disk I/O
  - **#57993(新)** - [Bug]: agents.list[].model.primary ignored(已有PR #58003)
  - **#57992(新)** - [Bug]: Sandbox container creation silently fails
  - **#57989(新)** - Bug: WhatsApp linked device does not receive group messages(已有PR #58007)
  - **#57988(新)** - Bug: Heartbeat read tool called without path
  - **#57985(新)** - [Bug]: whatsapp groups
  - **#57975(新)** - [Bug]: The search for AI is not working
  - **#57974(新)** - control-ui sessions.list polling saturates gateway
  - **#57968(新)** - Cron payload.model override ignored
- **相关 PR 发现**:
  - **#58007** - WhatsApp: hydrate participating groups on connect(关联#57989)
  - **#58003** - Agents: fix subagent model precedence(关联#57993)
  - **#57972** - fix: handle LiveSessionModelSwitchError in cron isolated sessions
- **方向2(InStreet社区)**:无(该URL是InStreet平台API文档,未发现OpenClaw相关问题)
- **方向3(Discord/GitHub discussions)**:无(GitHub discussions返回404,Discord需要认证无法访问)
- **方向4(相关插件仓库)**:发现freestylefly/openclaw-wechat仓库,但issues质量低,主要是"二维码过期"等缺乏复现步骤的问题
- **xixi 结论**:本次扫描发现10+个新issues,其中最高优先级是#58006(read工具文件一致性问题)和#5799(xAI/OpenAI 422崩溃)+ #57994(浏览器功能失效)+ #57973(edit工具100%失败)
- **建议**:aoao优先修复#58006(文件一致性问题)+ #57981(xAI工具调用失效)+ #57994(浏览器功能失效)+ #57973(edit工具失效)
- 已更新:P244-P247

| P272 | #58041 **P1** auto-update crash loop | 🔨 aoao修复中 | ✅根因确认:src/infra/update-startup.ts runAutoUpdateCommand只看exit code不验证版本;修复:写autoLastSuccessVersion前验证afterVersion;可提PR |
| P273 | #58058 **P1** Real-time sync failure dashboard/Feishu/Telegram | 🔍 需追问 | regression 2026.3.28;候选:684a1565a9/c0c32445ab;Mar29 c14b169a1b修复ACP stale binding可能才是答案(不在2026.3.28);issue缺日志需追问 |
| P275 | #58059 OpenRouter model context window not auto-detected from provider catalog | 🔍 新发现 | P2,bug:behavior |
| P276 | #58055 QMD backend returns empty memory_search results while CLI search works | 🔍 新发现 | P2,2026.3.28 |
| P277 | #58046 Foundry plugin enters infinite reload loop, crashes gateway | 🔍 新发现 | P2,2026.3.24 |
| P278 | #58051 fix: primary probe should not consume transient probe slot for same-provider fallbacks | ✅ 可支持 | size:S,Greptile 5/5,fix #56053 |
| P279 | #58054 fix: surface actual error instead of misleading pinned write message | ✅ 可支持 | size:XS,fix plugin install diagnostics |
| P248 | #57992 [Bug]: agents.list[].model.primary ignored | 🔍 新发现 | bug,agents配置被忽略 |
| P249 | #57993 [Bug]: Sandbox container creation silently fails | 🔍 新发现 | bug,沙箱容器创建失败无错误日志 |
| P250 | #57994 [Bug]: browser.request unknown method | 🔍 新发现 | 高优先级,浏览器自动化功能失效 |
| P251 | #57996 QMD per-agent SQLite caches cause extreme disk I/O | 🔍 新发现 | 性能问题,QMD SQLite缓存导致极端磁盘I/O |
| P252 | #57997 Cron jobs ignore payload.model and run on agent default model | 🔍 新发现 | bug高优先级,cron模型参数被忽略 |
| P253 | #57998 Bug: LiveSessionModelSwitchError not handled in subagent runner | 🔍 新发现 | 高优先级,子代理模型切换错误未处理 |
| P254 | #57999 Subagent deliveryContext loses to/threadId/accountId when spawned from group topics | 🔍 新发现 | 高优先级,子代理路由上下文丢失 |
| P255 | #58001 [Bug] Cron announce delivery rejects valid Microsoft Teams conversation IDs | 🔍 新发现 | 高优先级,cron announce拒绝有效的Teams conversation IDs |
| P256 | #58004 Feature: Cross-channel session binding (unified session across TUI + Telegram/Discord) | 🔍 新发现 | 功能请求 |
| P257 | #58006 [Bug] inconsistent file visibility across tools | 🔍 新发现 | 高优先级,文件可见性问题 |
| P258 | #58009 docs/config: plugins.allow allowlist silently blocks all stock channel plugins | 🔍 新发现 | 配置问题,allowlist阻止所有内置插件 |
| P259 | #58010 docs/discord: bot-to-bot messaging - guild users list is primary gate | 🔍 新发现 | 文档问题,Discord bot-to-bot消息传递文档 |
| P260 | #58012 [Bug]: strict9 tool-call-id regression - Mistral via proxy providers fails again after provider-capabilities refactors | 🔍 新发现 | 高优先级regression,Mistral代理工具调用失败 |
| P261 | #58019 [Bug]: Docker sandboxed agents have no access to workspace with SELinux | 🔍 新发现 | 高优先级,SELinux环境Docker沙箱无法访问workspace |
| P262 | #58021 Feature: `transform_tool_result` plugin hook for modifying tool results before model context | 🔍 新发现 | 功能请求,插件hook增强 |
| P263 | #58026 normalizeExtraMemoryPaths does not expand tilde (~) in extraPaths | 🔍 新发现 | bug,路径展开问题 |
| P264 | #58027 normalizeExtraMemoryPaths does not expand tilde (~) in extraPaths | 🔍 新发现 | bug(与#58026重复)|
| P265 | #58028 Feature Request: Add /resume command to restore previous conversation context | 🔍 新发现 | 功能请求 |
| P266 | #58030 fix(msteams): channel thread replies land as top-level posts or in wrong thread | 🔍 新发现 | 高优先级,Teams线程回复路由错误 |
| P267 | #58031 feat(workspace): Increase AGENTS.md/SOUL.md context file size limits (4KB/3KB too restrictive for complex agent configurations) | 🔍 新发现 | 功能请求,上下文件大小限制 |
| P268 | #58033 Feature Request: Silent Heartbeat Mode | 🔍 新发现 | 功能请求 |
| P269 | #58039 /model can become unusable when the current provider is unavailable, and configured fallbacks do not recover the session | 🔍 新发现 | 高优先级,模型可用性问题,fallback不恢复会话 |
| P271 | #58042 OpenClaw Skill 微信交流群 | 🔍 新发现 | 社区交流 |
| P272 | #58173 [Bug]: Discord bot tokens auto-reset due to excessive reconnects without backoff | 🔍 新发现 | 高优先级,Discord反滥用机制触发,Token被自动重置 |
| P273 | #58190 CLI `openclaw browser start` fails: `unknown method: browser.request` | 🔍 新发现 | 高优先级,浏览器功能完全失效 |
| P274 | #58189 [Bug]: When I use VLLM to deploy QWEN3-31B, I get stuck in a loop | 🔍 新发现 | 高优先级,VLLM部署卡死循环 |
| P275 | #58176 [Bug]: Generic CLI-backed subagent completions can return `(no output)` | 🔍 新发现 | 高优先级,子代理完成消息丢失 |
| P276 | #58152 Control UI: session model override dropdown does not take effect (webchat) | 🔍 新发现 | 高优先级,UI模型选择器失效 |
| P277 | #58187 fix(config): DATABASE_URL missing warning fires 3310+ times per run | 🔍 新发现 | 中等优先级,配置警告spam导致栈溢出 |
| P278 | #58158 macOS 2026.3.28 - camera.snap not in node command allowlist | 🔍 新发现 | 高优先级,macOS摄像头权限问题 |
| P279 | #58164 Control UI 语音输入按钮点击无反应 | 🔍 新发现 | 中等优先级,UI语音输入功能失效 |
| P280 | #58150 [Bug]: RISC-V64: OpenClaw fails with LLM request failed: network connection error | 🔍 新发现 | 高优先级,RISC-V64架构网络问题 |
| P281 | #58272 **P1** macOS Path Resolution: ENOENT on mixed-character directories AND filenames (CJK + ASCII) | 🔍 新发现 | macOS路径解析失败,文件操作阻塞 |
| P282 | #58189 **P1** VLLM QWEN3-32B stuck in loop | 🔍 新发现 | VLLM部署卡死循环 |
| P283 | #58268 **P1** Slack socket-mode mentions silently dropped after stale-socket reconnect | 🔍 新发现 | Slack mentions在重连后被静默丢弃 |
| P284 | #58249 **P1** Teams webhook broken in 2026.3.24+: publicUrl removed breaks JWT validation | 🔍 新发现 | Teams webhook失效 |
| P285 | #58260 **P2** Discord proxy配置不完全 | 🔍 新发现 | Discord代理配置问题 |
| P286 | #58256 **P2** browser功能失效 | 🔍 新发现 | 浏览器功能问题 |
| P287 | #58255 **P2** Gemini memory indexing失败 | 🔍 新发现 | memory索引问题 |
| P288 | #58214 **P2** 飞书鉴权偶现失败 | 🔍 新发现 | Feishu鉴权偶发问题 |
| P289 | #58217 **P2** API认证失败 | 🔍 新发现 | API鉴权问题 |
| P290 | #58221 **P2** Chrome extension browser relay失效 | 🔍 新发现 | 浏览器relay问题 |
| P291 | #58236 **安全** Nostr DM签名验证修复(maintainer vincentkoc) | 🔍 新发现 | 安全修复:防止伪造回复 |
| P292 | #58224 **安全** Drop auth headers on cross-origin redirects(maintainer vincentkoc) | 🔍 新发现 | 安全修复:防止token泄露 |
| P293 | #58220 **安全** Reject escaping symlinks in ssh sandbox uploads(maintainer vincentkoc) | 🔍 新发现 | 安全修复:防止路径遍历 |
| P294 | #58177 **安全** Redact Nostr privateKey in config views(maintainer vincentkoc) | 🔍 新发现 | 安全修复:配置脱敏 |
| P295 | #58437 **P1** Live session model switch 死锁(无限重试,agent 无法响应)| 🔍 新发现 | 升级到 2026.3.28 后 agent 进入无限重试循环并死锁 |
| P296 | #58457 **P1** Ollama Cloud provider 401 错误(v2026.3.28,provider 完全失效)| 🔍 新发现 | Ollama Cloud provider 鉴权失败 |

### 2026-03-31 10:05(早间汇报触发 - 范总确认继续推进)
- **范总确认**:昨日工作强度极佳,要求按当前节奏持续推进
- **xixi**:继续每轮 4 方向扫描,重点关注新回归 regression
- **aoao**:sessions_send 超时问题需先解决,否则任务派不下去
- **main**:监控 aoao 任务状态,确保多跳派单机制恢复运行

### 2026-04-01 16:00(4方向扫描 - 第33轮扫描)
- **xixi 4方向扫描**(2026-04-01 08:00 UTC / 16:00 Asia/Shanghai):
- **方向1(GitHub issues/PRs)**:本轮确认 2 个新候选
  - **#58560(新)** - Browser tools fail with AJV "no schema with key or ref" 2020-12 error(bug+regression,高优先级)
  - **#58561(新)** - Overloaded (529) errors shown as rate limit reached to users(中高优先级,可用性/错误分类问题)
  - **#58556(已追踪 P315)** - Live model switch check prevents model fallback from working,仍是本轮最值得 action 的已追踪项
- **方向2(InStreet社区)**:无(抓到的是 InStreet Agent Skill 平台/API 文档,不是 OpenClaw 用户实战反馈)
- **方向3(Discord/GitHub discussions)**:无(Discord 需登录认证,GitHub discussions 返回 404)
- **方向4(相关插件仓库)**:无(公开可见 openclaw-weixin 相关仓库本轮无新 issue/PR;官方 weixin 代码不可见)
- **xixi 结论**:最高优先级是 **#58560**,其次是 **#58556**;Browser 工具 regression 更直接阻断功能使用,model fallback 问题则持续影响稳定性与成本。
- **建议**:aoao 优先看 #58560(schema/AJV 回归),再看 #58556(live model switch 阻断 fallback)。
- **⚠️ sessions_send 结果**:已按要求发送给 main(sessionKey: `agent:main:feishu:default:direct:ou_5abeeb52afc248214694d8d79ab20df8`),但返回 **timeout**(runId: `96a427b8-e6d2-4494-8b6c-02f773288395`),当前无法确认送达。

### 2026-04-01 05:14(4方向扫描 - 第32轮扫描)
- **xixi 4方向扫描**(2026-03-31 21:14 UTC):
- **方向1(GitHub issues/PRs)**:发现17个最近2小时内更新的issues(#58450-#58561)和14个PRs(#58475-#58563),其中4个为新发现
  - **#58561(新)** - Overloaded (529) errors shown as rate limit reached to users
  - **#58560(新)** - [Bug]: Browser tools fail with AJV "no schema with key or ref" 2020-12 error (bug+regression)
  - **#58558(新)** - Support async handlers for tool_result_persist hook
  - **#58556(新)** - Live model switch check prevents model fallback from working
  - **#58553(已追踪P311)** - [Bug]: Long sessions (600+ messages) break with "invalid function call parameters" (bug+bug:crash)
  - **#58549(已追踪P298)** - Bug: Inbound messages re-delivered during API provider outage - missing message_id deduplication in gateway retry loop
  - **#58542(已追踪)** - LiveSessionModelSwitchError in isolated cron jobs (v2026.3.28)
  - **#58539(已追踪)** - [Bug]: Spawned subagent with explicit model can fail before first attempt with LiveSessionModelSwitchError
  - **#58537(已追踪)** - [Bug]: Feishu oc_ (OpenChat) chats create duplicate group/direct sessions - outbound vs inbound chatType mismatch
  - **#58535(已追踪)** - [Bug]: Discord announce removing fields from my input (bug+bug:behavior)
  - **#58534(已追踪)** - Session management performance degrades severely with subagent usage (100%+ CPU at ~400 sessions)
  - **#58528(已追踪)** - Discord attachment download hangs: missing readIdleTimeoutMs in fetchRemoteMedia
  - **#58523(已追踪)** - Slack multi-workspace: outbound works on second workspace but inbound DM replies never reach OpenClaw
  - **#58520(已追踪)** - TUI never registers with gateway - sessions.resolve fails, causing input echo lag and web UI sync issues
  - **#58519(已追踪)** - Slack Socket Mode: event loop starvation causes pong timeouts and silent message loss
  - **#58517(已追踪)** - Heartbeat model override ignored - always falls back to default model (LiveSessionModelSwitch)
  - **#58514(已追踪)** - Google Chat: Space/Group messages silently ignored (DMs work correctly)
  - **#58450(已追踪)** - Agent can promise a later follow-up without starting any actual follow-up action
- **方向2(InStreet社区)**:无(扫描到InStreet Agent Skill平台 https://instreet.coze.site/skill.md,这是一个独立的中文AI Agent社交网络,包含论坛、Playground、小组、关注系统;未发现OpenClaw相关实战问题)
- **方向3(Discord/GitHub discussions)**:无(Discord需要登录认证无法直接访问;GitHub discussions返回404未启用)
- **方向4(插件仓库)**:无(web_search未发现openclaw-weixin相关仓库的新issues)
- **xixi 结论**:本次扫描发现4个新issues(#58561、#58560、#58558、#58556),最高优先级是#58560(Browser tools fail regression)+ #58556(Live model switch check prevents model fallback)
- **建议**:aoao优先修复#58560(Browser tools AJV error,bug+regression)+ #58556(Live model switch check prevents model fallback)
- 已更新:P312-P315(已添加到当前优先级表格)
- ⚠️ sessions_send 失败:尝试向 main 发送报告时,sessions_send 返回 timeout(direct 和 group 都超时),main session 可能已结束或不可达

### 2026-04-01 00:27(4方向扫描 - 第26轮新发现)
- **xixi 4方向扫描**(2026-03-31 16:14 UTC):
- **GitHub 5个新候选**,重点2个P1:
  - **#58437 P1** - Live session model switch 死锁(无限重试,agent 无法响应)
  - **#58457 P1** - Ollama Cloud provider 401 错误(v2026.3.28,provider 完全失效)
- **InStreet**:域名解析失败,无法访问
- **Discord**:Discussions 404
- **插件**:0
- **结论**:#58437 是最高优先级(死锁导致 agent 无响应)
- 已更新:P295-P296
- aoao 会话仍不可达(超时 >14 小时)

### 2026-03-31 17:42(4方向扫描 - 第25轮新发现)
- **xixi 4方向扫描**(2026-03-31 09:31 UTC):
- **GitHub 19个新候选**,重点4个P1:
  - **#58272 P1** - macOS Path Resolution: ENOENT on mixed-character dirs/files
  - **#58189 P1** - VLLM QWEN3-32B stuck in loop
  - **#58268 P1** - Slack socket-mode mentions dropped after stale-socket reconnect
  - **#58249 P1** - Teams webhook broken (publicUrl removed breaks JWT)
  - **#58260/#58256/#58255/#58214/#58217/#58221** - 其他P2问题
- **InStreet**:0
- **Discord**:0
- **插件**:0
- **结论**:#58272和#58249是最高优先级,阻塞基本使用
- 已更新:P281-P290
- aoao 会话仍不可达(超时 >10 小时)

### 2026-03-31 18:28(4方向扫描 - 第25轮新发现)
- **xixi 4方向扫描**(2026-03-31 10:28 UTC):
- **GitHub 4个新PRs**(均为maintainer vincentkoc安全修复):
  - **#58236** - Nostr DM签名验证(安全)
  - **#58224** - 跨域重定向丢弃auth headers(安全)
  - **#58220** - SSH sandbox拒绝逃逸symlinks(安全)
  - **#58177** - 配置视图中脱敏Nostr privateKey(安全)
- **无新issues**
- **InStreet**:0
- **Discord**:0
- **插件**:0
- **结论**:本次扫描无新增bug,仅有4个安全修复PRs待review
- 已更新:P291-P294
- aoao 会话仍不可达(超时 >12 小时)

### 2026-03-31 09:25(4方向扫描 - 第24轮新发现)
- **xixi 4方向扫描**(2026-03-31 01:25 UTC):
- **方向1(GitHub issues)**:发现25个最近2小时内更新的issues/PRs
  - **#58042(新)** - OpenClaw Skill 微信交流群
  - **#58041(新)** - Auto-update is not atomic: config/plugin version mismatch causes repeated crash loops
  - **#58039(新)** - /model can become unusable when current provider is unavailable, and configured fallbacks do not recover the session
  - **#58033(新)** - Feature Request: Silent Heartbeat Mode
  - **#58031(新)** - feat(workspace): Increase AGENTS.md/SOUL.md context file size limits (4KB/3KB too restrictive for complex agent configurations)
  - **#58030(新)** - fix(msteams): channel thread replies land as top-level posts or in wrong thread
  - **#58028(新)** - Feature Request: Add /resume command to restore previous conversation context
  - **#58027(新)** - normalizeExtraMemoryPaths does not expand tilde (~) in extraPaths
  - **#58026(新)** - normalizeExtraMemoryPaths does not expand tilde (~) in extraPaths(重复)
  - **#58021(新)** - Feature: transform_tool_result plugin hook for modifying tool results before model context
  - **#58019(新)** - [Bug]: Docker sandboxed agents have no access to workspace with SELinux
  - **#58012(新)** - [Bug]: strict9 tool-call-id regression - Mistral via proxy providers fails again after provider-capabilities refactors
  - **#58010(新)** - docs/discord: bot-to-bot messaging - guild users list is primary gate, "bot:" prefix in allowFrom not recognized
  - **#58009(新)** - docs/config: plugins.allow allowlist silently blocks all stock channel plugins (Discord, Signal, etc.) when set
  - **#58006(新)** - [Bug] inconsistent file visibility across tools
  - **#58004(新)** - Feature: Cross-channel session binding (unified session across TUI + Telegram/Discord)
  - **#58001(新)** - [Bug] Cron announce delivery rejects valid Microsoft Teams conversation IDs
  - **#57999(新)** - Subagent deliveryContext loses to/threadId/accountId when spawned from group topics
  - **#57998(新)** - Bug: LiveSessionModelSwitchError not handled in subagent runner - cross-provider model switches fail
  - **#57997(新)** - Cron jobs ignore payload.model and run on agent default model (Opus instead of GPT-5.4)
  - **#57996(新)** - QMD per-agent SQLite caches cause extreme disk I/O on multi-agent deployments
  - **#57994(新)** - [Bug]: browser.request unknown method - browser plugin loads but method never registers
  - **#57993(新)** - [Bug]: Sandbox container creation silently fails - no error logged, agent zombies
  - **#57992(新)** - [Bug]: agents.list[].model.primary ignored - agents.defaults.subagents.model always wins
- **方向2(InStreet社区)**:无(扫描到InStreet平台文档,未发现OpenClaw相关问题)
- **方向3(Discord/GitHub discussions)**:无(web_search搜索到的结果都是已知的GitHub issues,Discord需要认证无法直接访问)
- **方向4(插件仓库)**:无(openclaw-weixin仓库不存在或不可公开访问)
- **xixi 结论**:本次扫描发现24个新issues,其中最高优先级是#58041(Auto-update崩溃循环)和#58039(/model可用不可用)
- **建议**:aoao优先修复#58041(Auto-update崩溃循环)+ #58039(/model可用不可用)+ #58030(Teams线程问题)
- **⚠️ sessions_send 失败**:尝试向 main 发送报告时,sessions_send 返回 timeout
  - **根因**:main session 的 status=failed,无法接收消息
  - **影响**:无法自动将扫描结果发送给 main,需要手动检查文件
  - 已更新:P248-P271

### 2026-03-31 10:28(4方向扫描 - 第25轮新发现)
- **xixi 4方向扫描**(2026-03-31 02:28 UTC):
- **方向1(GitHub issues)**:发现30+个最近2小时内创建/更新的issues/PRs
  - **#58052(新)** - Slack channel never initialises on v2026.3.28(高优先级,P1)
  - **#58064(新)** - Discord/Telegram channels silently fail to initialize under LaunchAgent(高优先级,P1)
  - **#58045(新)** - LiveSessionModelSwitchError prevents cross-provider model fallback(高优先级,P1)
  - **#58049(新)** - Failover loop: timeout-heavy candidates starve later fallbacks(高优先级,P1)
  - **#58065(新)** - The specified model was designated for the cron, but the agent default model was always used(中优先级,P2,regression)
  - **#58056(新)** - GitHub Copilot provider: missing Editor-Version header(中优先级,P2)
  - **#58061(新)** - launchd gateway startup is delayed for minutes(中优先级,P2)
  - **#58066(新)** - internal commentary snippets intermittently leak into Discord replies(中优先级,P2)
  - **#58059(新)** - OpenRouter model context window not auto-detected(低优先级,P3)
  - **#58057(新)** - Dynamic identity resolution for allowlists(低优先级,P3,feature request)
  - **#58055(新)** - QMD backend returns empty memory_search results(低优先级,P3)
  - **#58063(新)** - web_search tool aborts with xAI Responses API(低优先级,P3)
  - **#58048(新)** - Slack react action does not check already_reacted(低优先级,P3)
  - **#58039(新)** - /model can become unusable when current provider is unavailable(高优先级,但需架构改进,P1+)
  - **#58046(新)** - Foundry plugin enters infinite reload loop(中优先级,P2)
  - **相关PR发现**:
    - **#58062** - fix(agents): handle LiveSessionModelSwitchError in subagent execution
    - **#58054** - fix: surface actual error instead of misleading pinned write message
    - **#58053** - add dingtalk
    - **#58051** - fix: primary probe should not consume transient probe slot
    - **#58050** - fix(memory): expand tilde in extraMemoryPaths
    - **#58047** - fix(memory): expand home-prefixed extra paths
    - **#58044** - fix(config): harden SecretRef round-trip handling
    - **#58040** - fix(exec): ignore malformed drive-less windows exec paths
    - **#58038** - fix(cache): delay history image pruning
    - **#58037** - fix(cache): sort MCP tools deterministically
    - **#58036** - fix(cache): compact newest tool results first
    - **#58035** - fix(subagents): include exec tool result output
- **方向2(InStreet社区)**:无(访问到InStreet API文档,未发现OpenClaw相关问题)
- **方向3(Discord/GitHub discussions)**:无(Discord需要登录认证无法直接访问;GitHub Discussions未发现最近2小时的新讨论)
- **方向4(相关插件仓库)**:无(扫描openclaw-weixin等插件仓库,未发现最近2小时的更新;最新issue是#50,创建于2026-03-22)
- **xixi 结论**:本次扫描发现14个新issues(排除已有追踪项),其中最高优先级是#58052(Slack通道无法初始化)+ #58064(Discord/Telegram通道静默失败)+ #58045(跨provider fallback被阻止)+ #58049(failover loop)
- **建议**:aoao优先修复#58045(跨provider fallback,S级修复点明确)+ #58065(cron model override,S级regression)+ #58061(launchd启动延迟,S级简单修复)
- **暂缓建议**:#58052/#58064(M级,需要深度调研插件加载机制)+ #58039(L级,涉及架构改进)
- 已更新:P280-P287


### 2026-03-31 16:28(4方向扫描 - 第27轮新发现)

- **xixi 4方向扫描**(2026-03-31 08:28 UTC):
- **方向1(GitHub issues)**:发现50+个最近2小时内创建/更新的issues/PRs
  - **#58234(新)** - [Bug]: Heartbeat.md BUG心跳触发异常,并不会在指向的会话中触发(bug+regression,高优先级)
  - **#58222(新)** - [Bug]: Browser plugin appears loaded, but gateway rejects all browser commands with unknown method: browser.request(bug,高优先级)
  - **#58221(新)** - [Bug]: Chrome extension browser relay unavailable on macOS 2026.3.28 - browser.request missing(bug+regression,高优先级)
  - **#58217(新)** - [Bug]: When using API to call Open OpenClaw API, I keep getting error "missing scope: operator.write"(bug+regression,高优先级)
  - **#58214(新)** - [Bug]: 飞书偶现:401 Incorrect API key provided(bug+regression,高优先级)
  - **#58230(新)** - Bug: gateway enters restart loop on Telegram provider startup in 2026.3.28(bug,高优先级)
  - **#58231(新)** - Telnyx inbound calls reach webhook but are never answered in voice-call plugin(bug,高优先级)
  - **#58232(新)** - Bug: session level model override does not trigger fallback models on rate limit(bug,高优先级)
  - **#58213(新)** - Bug: Session model preference overrides failover, causing infinite retry(bug,高优先级)
  - **#58206(新)** - Subagents don't load target agent's workspace context(bug,高优先级)
  - **#58132(新)** - Upgrading to 3.28: Gateway won't start, no documentation found(bug,高优先级)
  - **#57112(新)** - [Bug]: Cron payload model override ignored - LiveSessionModelSwitchError on 2026.3.28(bug+regression,高优先级)
  - **相关PR发现**:
    - **#58237** - fix(feishu): filter fetched group thread context
    - **#58245** - fix(discord): gate voice ingress by allowlists
    - **#58242** - fix(slack): treat duplicate reactions as success
    - **#58244** - fix(process): prune idle dynamic lanes from command queue Map to prevent memory leak
    - **#58241** - fix(voice-call): reject oversized pre-start media frames
    - **#58239** - fix(pairing): scope pending request caps per account
    - **#58236** - fix(nostr): verify inbound dm signatures before pairing replies
    - **#58205** - Fix subagent sessions send reactivation
    - **#58203** - fix(exec): unwrap arch and xcrun dispatch wrappers
    - **#58202** - fix(exec): block proxy-style env overrides
    - **#58208** - fix: omit disabled OpenClaw reasoning payloads
    - **#58207** - fix: scope session create aliases to requested agent
- **方向2(InStreet社区)**:无(扫描到InStreet平台文档,未发现OpenClaw相关问题)
- **方向3(Discord/GitHub discussions)**:无(web_search搜索结果主要是已知的GitHub issues,Discord需要认证无法直接访问)
- **方向4(插件仓库)**:无(openclaw-weixin仓库不存在或不可公开访问)
- **xixi 结论**:本次扫描发现12+12个新issues(排除已有追踪项),其中最高优先级是#58222(浏览器功能失效)+ #58221(macOS浏览器relay失效)+ #58217(API权限回归)
- **建议**:aoao优先考虑以下高优先级问题:
  - #58222:浏览器插件加载但命令被拒绝,影响所有浏览器自动化功能
  - #58221:macOS浏览器relay不可用,影响macOS用户
  - #58217:API调用缺少operator.write scope,影响RESTful API集成
  - #58234:心跳触发异常,影响定时任务功能
- 已更新:P281-P285

### 2026-03-31 16:30(sessions_send 失败记录)

- **4方向扫描报告无法发送给 main**
- **错误原因**:sessions_send 返回 "No session found"(尝试了 sessionKey 和 label 方式都失败)
- **可能原因**:
  - main session 当前不可达
  - sessionKey/label 格式不正确
  - main agent 可能已停止或重启
- **已记录**:本次扫描结果已在文件中记录(P281-P285),main 可查看

### 2026-03-31 20:28(4方向扫描 - 第28轮新发现)

- **xixi 4方向扫描**(2026-03-31 12:28 UTC):
- **方向1(GitHub issues/PRs)**:发现大量最近2小时内更新的issues/PRs(从#58202到#58339),但都在项目文件中已追踪(P66-P274),无新增未追踪项
  - **#58342(新)** - browser.request gateway method not registered in 2026.3.28(高优先级regression,2026.3.24→3.28浏览器功能完全失效)
  - **#58353(新)** - [Bug]: Control UI /new or /reset can prepend stale system-summary text(中等优先级bug,新会话污染,间歇性)
  - **#58363(新)** - [Bug]: kimi web_search run error(低优先级,已有PR #58120修复)
  - 其他多为PR或feature request
- **方向2(InStreet社区)**:无(扫描到InStreet Agent Skill平台文档,未发现OpenClaw相关问题)
- **方向3(Discord/GitHub discussions)**:无(Discord需要登录认证无法直接访问;GitHub discussions页面返回404,未启用)
- **方向4(插件仓库)**:无(openclaw-weixin仓库404,代码不公开;扫描其他openclaw相关仓库未发现2小时内更新的issues)
- **xixi 结论**:本次扫描发现3个新issues(排除已有追踪项),其中最高优先级是#58342(浏览器功能完全失效)
- **建议**:aoao优先修复#58342(浏览器功能失效,2026.3.28 regression)+ #58353(Control UI新会话污染问题)
- 已更新:P295-P297
### 2026-03-31 04:28(4方向扫描 - 第22轮新发现)
- **xixi 4方向扫描**(2026-03-30 20:28 UTC):
- **方向1(GitHub issues)**:发现19个最近2小时内更新的issues(#57602之后,排除PRs),全部为新发现
  - **#57898(新)** - [Bug]: ARE YOU GOING TO FRIGGING KEEP BREAKING THIS THING OR WE CAN GET A STABLE VERSION???????(bug+regression)
  - **#57925(新)** - v2026.3.28: Discord extension silently skipped during gateway startup - zero channels load despite valid config
  - **#57920(新)** - Stale ended subagent runs persist in childSessions, ghost agents on Floor
  - **#57683(新)** - [Bug]: 400 gemini-2.5-pro thinking_budget to 0(bug+bug:behavior)
  - **#57918(新)** - [Bug]: Announce delivery constructs malformed recipient "group:<chatId>" for Telegram forum topic sessions(bug+bug:behavior)
  - **#57917(新)** - Control UI model switch misparses aliases like gpt-5.4 as anthropic/*
  - **#57916(新)** - Subagent announce: swap dispatch order to queue-first when parent session is busy
  - **#57908(新)** - [Feature]: Allow prompt-level selection of LLM service provider(enhancement)
  - **#57776(新)** - [Bug]: Matrix device verification fails with "m.mismatched_sas" despite matching emoji(bug+regression)
  - **#57907(新)** - openclaw configure --section model leaves stale claude-cli/ prefix in model config
  - **#57906(新)** - Model fallback retries primary too aggressively before moving to next fallback
  - **#57905(新)** - Gateway enters infinite model-switch loop when all auth profiles fail
  - **#57901(新)** - Safeguard compaction ignores compaction.model config - uses session model instead
  - **#57900(新)** - Subagent runs don't use model fallback chain on 429/rate-limit errors
  - **#57892(新)** - iMessage bridge drops inbound messages during high session lane activity
  - **#57896(新)** - [Bug]: Gateway restart leaves stale exec config - onRestart passes activate:false to activateRuntimeSecrets
  - **#57894(新)** - [Feature] Time-based session context window (send only recent N hours of conversation)
  - **#57893(新)** - [Bug] Feishu slash commands not working in multi-account setup
  - **#57890(新)** - feat(cron): add structured job-completion record to detect partial/incomplete cron cycles
- **方向2(InStreet社区)**:无(扫描到InStreet平台文档,未发现OpenClaw相关问题)
- **方向3((Discord/GitHub discussions)**:无(web_search搜索到的结果都是已知的GitHub issues,Discord需要认证无法直接访问)
- **方向4(插件仓库)**:无(openclaw-weixin等插件仓库不存在或不可公开访问)
- **xixi 结论**:本次扫描发现19个新issues(#57602之后),最高优先级是#57898(用户情绪严重,regression)和#57925(v2026.3.28 Discord regression)
- 已更新:P227-P245


### 2026-04-01 03:14(4方向扫描 - 第30轮扫描)
- **xixi 4方向扫描**(2026-04-01 03:14 UTC):
- **方向1(GitHub issues)**:发现19个最近2小时内更新的items
  - **#58534** - Session management performance degrades severely with subagent usage (100%+ CPU at ~400 sessions)
  - **#58533** - Cron sessions inherit persisted model override instead of honoring payload.model, causing thundering herd under overload
  - **#58532** - resolvePersistedLiveSelection() overrides emergency failover decisions, causing infinite overload retry loops
  - **#58531** - resolvePersistedLiveSelection() overrides emergency failover decisions(重复)
  - **#58528** - Discord attachment download hangs: missing readIdleTimeoutMs in fetchRemoteMedia
  - **#58527** - moltbot-sandbox-fs: python3: not found
  - **#58523** - Slack multi-workspace: outbound works on second workspace but inbound DM replies never reach OpenClaw
  - **#58522** - session_status not showing cache hit tokens despite provider returning cache usage data
  - **#58520** - TUI never registers with gateway - sessions.resolve fails, causing input echo lag and web UI sync issues
  - **#58519** - Slack Socket Mode: event loop starvation causes pong timeouts and silent message loss
  - **#58518** - LiveSessionModelSwitchError triggers for isolated sessions on heartbeat/cron when defaults differ
  - **#58517** - Heartbeat model override ignored - always falls back to default model
  - **#58514** - Google Chat: Space/Group messages silently ignored (DMs work correctly)
  - **#58511** - Cron sessions inherit persisted model override(重复)
  - **#58510** - resolvePersistedLiveSelection() overrides emergency failover decisions(重复)
  - **#58509** - ClawHub Security Review Request: Remove 'Suspicious' Flag from flowclaw-orchestrator@1.1.3
  - **#58508** - url-fetch SSRF policy blocks api.telegram.org file CDN (private/internal IP classification)
  - **#58507** - Config validation rejects enrichGroupParticipantsFromContacts in 2026.3.28
  - **#58506** - payload.model in cron agentTurn jobs is ignored at runtime - always falls back to agent default
  - **#58505** - [Feature]: Allow `before_prompt_build` hook to abort LLM call and return a custom response
- **扫描结论**:以上19个issues/PRs全部在之前的扫描中已追踪(对应P253-P296),本次无新增未追踪项
- **方向2(InStreet社区)**:无((扫描到InStreet Agent平台API文档 https://instreet.coze.site/skill.md,未发现OpenClaw相关实战问题)
- **方向3(Discord/GitHub discussions)**:无(Discord需要登录认证无法直接访问;web_search返回的都是Discord官方帮助中心页面,非OpenClaw社区讨论)
- **方向4(相关插件仓库)**:无(web_search搜索到的weixin相关issues均为已知的#52341、#50893等,无新的weixin相关issue)
- **xixi 结论**:本次扫描没有发现新的未追踪的GitHub issues;InStreet是独立的AI Agent社区平台,与OpenClaw无关;插件仓库中搜索到的都是已知的issues
- **建议**:关注已追踪的高优先级issues的进展,特别是#58534(session管理性能问题)和#58533/#58511(cron model override失效)
- ⚠️ sessions_send 失败:尝试向 main 发送报告时,sessions_send 返回失败(main session 可能已结束或不可达)


### 2026-04-01 04:14(4方向扫描 - 第31轮扫描)

- **xixi 4方向扫描**(2026-04-01 04:14 UTC):
- **方向1(GitHub issues/PRs)**:发现20+个最近2小时内创建的新issues(#58553-#58520),其中14个为高优先级新发现
  - **P0 #58549** - Gateway retry loop re-delivers inbound messages during API outage (missing message_id dedup)
  - **P1 #58542** - LiveSessionModelSwitchError in isolated cron jobs (v2026.3.28)
  - **P1 #58533** - Cron sessions inherit persisted model override instead of honoring payload.model, causing thundering herd under overload
  - **P1 #58539** - Spawned subagent with explicit model can fail before first attempt with LiveSessionModelSwitchError
  - **P1 #58537** - Feishu oc_ (OpenChat) chats create duplicate group/direct sessions - outbound vs inbound chatType mismatch
  - **P1 #58535** - Discord announce removing fields from my input
  - **P1 #58534** - Session management performance degrades severely with subagent usage (100%+ CPU at ~400 sessions)
  - **P1 #58528** - Discord attachment download hangs: missing readIdleTimeoutMs in fetchRemoteMedia
  - **P1 #58523** - Slack multi-workspace: outbound works on second workspace but inbound DM replies never reach OpenClaw
  - **P1 #58520** - TUI never registers with gateway - sessions.resolve fails, causing input echo lag and web UI sync issues
  - **P1 #58519** - Slack Socket Mode: event loop starvation causes pong timeouts and silent message loss
  - **P1 #58517** - Heartbeat model override ignored - always falls back to default model
  - **P1 #58514** - Google Chat: Space/Group messages silently ignored (DMs work correctly)
  - **#58553** - [Bug]: Long sessions (600+ messages) break with "invalid function call parameters"
  - **#58552** - feat: Add Apple Silicon optimizations
  - **#58551** - Fix/model routing v2
  - **#58550** - feat(sessions): SQLite-backed two-tier session store - fixes 140%+ CPU at scale
  - **#58548** - feat: add agents.defaults.params for global default model params
  - **#58546** - [Bug]: Multi-agent routing resolves correct agent but session is created under default agent
  - **#58545** - Release: restore plugin compatibility and secretref docs
  - **#58544** - [Bug]: openclaw update fails with preflight-no-good-commit; exec auto-allow/approval flow inconsistent on git install
  - **#58543** - [Control UI] Support inline image/media attachments in webchat chat messages
  - **#58541** - Google Chat (G Suite Add-on) returns 401 Unauthorized - JWT verification failure
  - **#58540** - Slack DM: Embedded agent run not triggered when socket reconnects (stale-socket)
  - **#58538** - Bug: `enrichGroupParticipantsFromContacts` schema inconsistency - config.schema.lookup shows valid but config validation rejects it
  - **#58532** - resolvePersistedLiveSelection() overrides emergency failover decisions, causing infinite overload retry loops
  - **#58531** - resolvePersistedLiveSelection() overrides emergency failover decisions(重复)
  - **#58530** - docs: clarify fallback when no good first issue labels are open (AI-assisted)
  - **#58529** - Mattermost: guard probe fetches
  - **#58527** - moltbot-sandbox-fs: python3: not found - file bridge fails despite python3 being installed
  - **#58522** - session_status not showing cache hit tokens despite provider returning cache usage data
  - **#58511** - Cron sessions inherit persisted model override(重复)
  - **#58510** - resolvePersistedLiveSelection() overrides emergency failover decisions(重复)
  - **#58509** - ClawHub Security Review Request: Remove 'Suspicious' Flag from flowclaw-orchestrator@1.1.3
  - **#58508** - url-fetch SSRF policy blocks api.telegram.org file CDN (private/internal IP classification)
  - **#58507** - Config validation rejects enrichGroupParticipantsFromContacts in 2026.3.28
  - **#58506** - payload.model in cron agentTurn jobs is ignored at runtime - always falls back to agent default
  - **#58505** - [Feature]: Allow `before_prompt_build` hook to abort LLM call and return a custom response
- **方向2(InStreet社区)**:无(扫描到InStreet Agent Skill平台文档 https://instreet.coze.site/skill.md,这是一个独立的中文AI Agent社交网络,包含论坛、Playground、小组、关注系统;未发现OpenClaw相关实战问题)
- **方向3(Discord/GitHub discussions)**:无(Discord需要登录认证无法直接访问;GitHub discussions未启用,返回404)
- **方向4(插件仓库)**:无(web_search搜索到的weixin相关issues均为已知的#52341、#50893等,不在最近2小时更新范围内)
- **xixi 结论**:本次扫描发现20+个新创建的issues(#58553-#58520),其中14个为高优先级新发现;最高优先级是#58549(Gateway retry loop消息re-deliver,P0)+ #58542(LiveSessionModelSwitchError in isolated cron jobs)+ #58533(Cron sessions model override失效)
- **建议**:aoao优先修复#58549(Gateway retry loop re-delivers inbound messages,P0级别)+` #58542(cron模型切换失效)+` #58533(cron配置失效导致thundering herd)
- **sessions_send 状态**:尝试向 main 发送报告时,sessions_send 返回 gateway timeout(main session 可能已结束或不可达)

### 2026-04-01 05:14(4方向扫描 - 第32轮扫描)
- **xixi 4方向扫描**(2026-04-01 05:14 UTC):
- **方向1(GitHub issues/PRs)**:发现4个新issues(#58561、#58560、#58558、#58556)
  - **P1 #58560** - Browser tools AJV error(bug+regression,Browser tools 完全失效)
  - **P1 #58556** - ✅ **已修复** - Live model switch check prevents model fallback(isSessionOverrideCurrent → !isSessionOverrideCurrent,逻辑反转);无法完整测试(pre-existing build问题:failover-policy.js 缺失);CI 验证中
  - **#58561** - [Bug]: gateway restart causes cron job to run immediately with no awareness of schedule drift
  - **#58558** - [Bug]: Cron jobs can permanently stall if gateway restarts mid-execution
- **aoao**:已派任务处理 #58560 + #58556
- **方向2-4**:无新发现

### 2026-04-01 05:34(4方向扫描 - 第33轮扫描)
- **xixi 4方向扫描**(2026-04-01 05:34 UTC):
- **方向1(GitHub issues)**:发现5个值得关注的问题
  - **CVE-2026-34503(GHSA-2pr2-hcv6-7gwv)** - ✅ 已修复但需记录 - 今天(4月1日)新发布的安全公告;CVSS 8.1 High,CWE-613(会话终止不完整);影响 < 2026.3.28;fix commit 7a801cc451;文件:`src/gateway/server-methods/devices.ts` + `src/gateway/server.impl.ts`;攻击路径:攻击者建立WebSocket会话后,如果设备被移除或token被撤销,会话不会断开,攻击可持续;**已修复,不需贡献**
  - **CVE-2026-34504** - ✅ 已修复但需记录 - 今天(4月1日)新发布;SSRF漏洞在 fal provider 的 image-generation-provider.ts;CVSS 7.5 High;影响 < 2026.3.28;**已修复,不需贡献**
  - **P1 #58560(新确认)** - Browser tools AJV error(bug+regression);`no schema with key or ref "https://json-schema.org/draft/2020-12/schema"`;browser工具在参数验证阶段就失败,完全不可用;影响 2026.3.24 和 2026.3.28;根因:AJV实例未注册2020-12 meta-schema或应使用Ajv2020;3个修复方案建议;上一轮aoao已接任务
  - **P2 #58561(新确认)** - HTTP 529(overloaded)被错误显示为"API rate limit reached";misleading错误信息;根因:`src/auto-reply/reply/agent-runner-execution.ts` 中 isRateLimitErrorMessage() 和 isOverloadedErrorMessage() 返回相同字符串;上一轮未分配
  - **#58558** - Feature: tool_result_persist hook 支持 async handler(功能请求,不是bug)
- **方向2(InStreet社区)**:无(https://instreet.coze.site/skill.md 是 AI Agent 社交网络平台文档,不是社区讨论区;未发现 OpenClaw 相关问题)
- **方向3(Discord/GitHub discussions)**:无(Discord 需要认证无法直接访问;GitHub discussions 返回404)
- **方向4(插件仓库)**:无(openclaw-weixin 仓库未找到或不可公开访问;gh CLI 需要审批)
- **xixi 结论**:本日重大发现:2个新 CVE 今天发布(CVE-2026-34503 + CVE-2026-34504),均已在 2026.3.28 修复;#58560(浏览器工具 AJV regression)严重度高且有明确修复路径;#58561(HTTP 529 错误信息误导)是可用性 gap;其余方向无新发现
- **建议**:#58560 已有 aoao 处理;**#58561 是典型 usability gap,适合发 PR 修复**(src/auto-reply/reply/agent-runner-execution.ts 的错误信息分支)


---

## 2026-04-02 ~ 2026-04-03 工作记录(从每日日志补录)

### 2026-04-02 工作

#### ✅ 完成事项

| 编号 | 内容 | 状态 |
|------|------|------|
| #58560 | Browser tools AJV regression 修复(aoao):根因是 Zod4 schema 使用 draft-2020-12,但 AJV 实例只支持 draft-07。修复:改用 Ajv2020。测试通过,PR 未提交(pre-existing build 问题 failover-policy.js 缺失,与修复无关) | ✅ 完成 |
| #58556 | Live model switch 阻断 fallback 修复(aoao):`isSessionOverrideCurrent → !isSessionOverrideCurrent` 布尔反转错误,修复于 `src/agents/pi-embedded-runner/run.ts` | ✅ 完成 |
| SSRF-Telegram | `web-fetch.ts` 未传递 `ssrfPolicy`,导致 api.telegram.org CDN 被误拦截(aoao):修复读取 `browser.ssrfPolicy.hostnameAllowlist` 并传入 | ✅ 完成 |
| #58514 | Google Chat Space/Group 消息被静默忽略(aoao):`spaceType !== "DM"` 误将 GROUP_DM 也当作 group,修正为 `spaceType === "SPACE"` | ✅ 完成 |
| P59655 | 新 P1:Feishu v2026.4.1 regression,build artifact hash 不匹配导致所有 Feishu 消息完全失效 | 🔍 新追踪 |
| P59657 | 新 P1:isolated cron model override 系统性回归(与 #57581/#57571/#57540 同根因) | 🔍 新追踪 |
| P59654 | 新 P1:`openclaw agents add` TypeError,agents add 命令完全不可用 | 🔍 新追踪 |
| P59658 | #31583 exec tool 不继承 skills.entries.*.env（回归,v2026.3.12~v2026.4.2） | 🔍 新发现 | S/S;gog/tavily/fal-ai 等 skill env vars 未传 exec 子进程;workaround 提到顶层;v2026.4.2 仍确认受影响 |
| P59659 | #42054 Discord button 交互在 agent 响应前过期（v2026.4.2） | 🔍 新发现 | S/M;exec approval buttons 工作正常说明 deferred ACK 路径存在但未覆盖 custom components |
| P59660 | #60929 sessions_spawn subagent 失败 1008 pairing required | 🔍 新发现 | S/S;本地 spawned subagent device keypair 无法自动 approval;workaround 用 sessions_send |
| P59661 | #60921 Isolated cron session delivery 失败 'Channel is required' | 🔍 新发现 | S/XS;delivery.channel 显式配置仍报 Channel is required;cron add/edit 未传 channel |
| P59662 | #60926 Heartbeat 注入 active sub-agent sessions 覆盖任务结果 | 🔍 新发现 | M/M;PR #60934 合入但问题仍存;heartbeat 把 subagent 结果冲成 HEARTBEAT_OK |
| P59663 | #60970 acpx 0.4.x Silent Session Creation Failure | 🔍 新发现(方向1 GitHub) | S/XS;regression,acpx@0.4.0/0.4.1 sessions new 退出0但无session创建;与Claude Code 2.1.92不兼容;workaround 回退0.3.1 |
| P59664 | #60936 voice-call: plugin loaded before OpenAI realtime transcription provider | 🔍 新发现(方向1 GitHub) | M/M;regression+beta-blocker;commit a23ab9b906dc6a4f6b24bb3f681f395eb792dbcd引入;加载顺序race condition导致电话功能完全不可用 |
| P59665 | #60961 OpenShell mirror mode write tool tar失败(写文件到已存在子目录) | 🔍 新发现(方向1 GitHub) | S/S;tar:memory Cannot open File exists;issue已附fix代码(用flat tmp dir staging);agent无法持久化memory等子目录文件 |
| P59666 | #60959 Google image generation HTTP 404(当provider baseUrl含/openai suffix) | 🔍 新发现(方向1 GitHub) | S/XS;resolveGoogleBaseUrl()未strip /openai suffix导致endpoint路径拼接错误;一行代码fix |
| P59667 | #60963 plugins.entries rejects plugin config keys(nesting未文档化) | 🔍 新发现(方向1 GitHub) | S/XS;错误消息无提示应写.config.policy;至少改善错误提示即可修;影响所有需要运行时配置插件的用户 |
| P59668 | #60930 Control UI websocket code=1001断开(长任务期间) | 🔍 新发现(方向1 GitHub) | M/M;websocket+announce retry多因素;live update丢失;需调研代码层面root cause |
| P59669 | #60917 Dashboard save fails on redacted __OPENCLAW_REDACTED__ sentinel | 🔍 新发现(方向1 GitHub) | XS/XS;dashboard serialize guard缺失;__OPENCLAW_REDACTED__被当作真实数据提交;影响settings保存功能 |
| P59670 | #60967 Bundle MCP tool calls timeout at 60s(MCP SDK default,无config override) | 🔍 新发现(方向1 GitHub) | M/S;MCP SDK硬编码60s超时但gateway无配置项;影响MCP工具调用稳定性 |
| P59671 | 方向2 InStreet 社区扫描 | 无 | 本轮抓到的是skill.md API规范文档,不是用户讨论区;凌晨时段InStreet社区可能不活跃;暂无可转GitHub issue的实战问题 |
| P59672 | 方向3 Discord/GitHub Discussions扫描 | 无 | Discord invite页面需登录无法直接抓取;GitHub Discussions端点返回404;建议改用gh api repos/openclaw/openclaw/discussions CLI方式重试 |
| P59673 | 方向4 插件扫描 | 无 | openclaw/openclaw-weixin仓库为private无法访问;openclaw官方插件仓库结构待确认;本轮未见新的公开plugin候选 |
| P59674 | #60985 Cron jobs immediately fire on gateway restart | 🔍 新发现(方向1 GitHub) | S/S;cron在gateway重启后立即触发而非等待下次计划时间;lastRunAtMs=01:23,updatedAtMs=01:24,nextRunAtMs=09:00;当天cron被消耗;修复应在scheduler restart-recovery逻辑 |
| P59675 | #60980 Channels table empty on Windows regression | 🔍 新发现(方向1 GitHub) | M/M;bug+regression标签;Windows上openclaw status显示healthy但Channels表为空;Telegram/Discord unavailable;需要调试channel注册逻辑 |
| P59676 | #60994 Ollama/LM Studio LAN fetch fails (curl works) | 🔍 新发现(方向1 GitHub) | M/M;bug:behavior;curl和Node.js fetch都通但OpenClaw报Connection error;疑似HTTP client层问题;需调研network layer差异 |
| P59677 | #60993 WhatsApp TTS sends MP3 instead of OGG Opus | 🔍 新发现(方向1 GitHub) | S/S;docs明确WhatsApp应收到Opus但实际发MP3;格式不匹配导致语音消息不可读;fix应在发送前做格式转换 |
| P59678 | #60983 Cron announce delivery fails on Telegram (too long) | 🔍 新发现(方向1 GitHub) | XS/S;announce投递Telegram报message too long;未自动拆分超长文本;简单拆分逻辑可修 |
| P59679 | #60989 GitHub Copilot token exchange not exposed to plugins | 🔍 新发现(方向1 GitHub) | M/M;plugin调用modelAuth.getApiKeyForModel()得到原始ghu token而非exchanged tid token;影响lossless-claw summarization;需在SDK暴露resolveCopilotApiToken() |
| P59680 | #60988/#60987 MiniMax Portal OAuth双重bug(404+空models数组) | 🔍 新发现(方向1 GitHub) | M/M;同一author;API返回nginx 404但curl正常+OAuth onboard写空models数组;两者可能同源 |
| P59681 | #59797 Weixin login fails on Windows (AbortError) | 🔍 新发现(方向4 插件) | M/—;bug+regression标签;Windows下weixin扫码登录报AbortError;代码不可见;regression说明以前工作 |
| P59682 | #57619 Subagent/cron messages not delivered to WeChat | 🔍 新发现(方向4 插件) | M/—;普通对话正常,cron/subagent自动推送失败;代码不可见;需调研delivery路径差异 |
| P59683 | #58314 Weixin missing inferTargetChatType creates duplicate group session | 🔍 新发现(方向4 插件) | S/—;根因已定位:inferTargetChatType未实现导致detectTargetKind默认group;代码不可见但fix路径清晰 |
| P59684 | #61011 Tool execution fails silently(regression,核心功能) | 🔍 新发现(方向1 GitHub) | S/S;模型声称执行工具但从未实际调用JSON工具块;exec/write/read/transcribe全部静默失败;有清晰复现步骤;建议aoao优先复现 |
| P59685 | #60985 Cron jobs fire immediately on gateway restart | 🔍 新发现(方向1 GitHub) | S/S;cron在重启后01:24立即触发而非09:00;当天任务被消耗;scheduler restart-recovery逻辑缺陷 |
| P59686 | #60983 Cron announce Telegram message too long(无auto-chunking) | 🔍 新发现(方向1 GitHub) | XS/XS;announce路径绕过splitTelegramHtmlChunks;直接sendMessage>4096失败;已有chunker仅需复用 |
| P59687 | #60909 docs/exec:host=node override allowed from auto(文档错误) | 🔍 新发现(方向1 GitHub) | XS/XS;文档说auto允许per-call host=node但runtime拒绝;纯文档修复无需改代码 |
| P59688 | 方向2 InStreet 社区扫描 | 无 | 本轮抓取到skill.md API规范文档,非用户讨论区;凌晨时段InStreet可能不活跃;暂无可转GitHub issue的实战问题 |
| P59689 | 方向3 Discord/GitHub Discussions扫描 | 无 | Discord invite页面可访问但频道内容需登录不可抓取;GitHub Discussions端点返回410 Gone;本轮无新增讨论 |
| P59690 | 方向4 插件扫描 | 无 | openclaw/openclaw-weixin仓库无open issues;本轮未见新的plugin/weixin公开候选;代码仍不可见 |
| P59691 | [#61006](https://github.com/openclaw/openclaw/issues/61006) **S** Fallback retry rewrites user prompt into synthetic message | 🔍 新发现（方向1 GitHub） | S/S;用户已给精确文件+函数+测试位置;`src/agents/command/attempt-execution.ts:resolveFallbackRetryPrompt`;sessionHasHistory=true时fallback重试用合成字符串替换原始body;fix:始终返回原始body;**建议aoao接单，1-2小时可PR** |
| P59692 | [#61015](https://github.com/openclaw/openclaw/issues/61015) **S** cron rm hangs indefinitely with no output | 🔍 新发现（方向1 GitHub） | S/S;任意有效job ID都hang无输出;macOS Darwin 25.3.0+node v25.8.1+OpenClaw v2026.4.2;`cron list`正常说明数据可读;根因可能在rm的删除逻辑;**建议aoao接单先本地复现** |
| P59693 | [#61009](https://github.com/openclaw/openclaw/issues/61009) **S** docs/tools/exec: host=node override与文档不符 | 🔍 新发现（方向1 GitHub） | XS/XS;文档说auto允许per-call host=node但runtime拒绝;纯文档修复或runtime修任性二选一;**建议确认范围后aoao接单** |
| P59694 | [#61007](https://github.com/openclaw/openclaw/issues/61007) **S** Gemini models displayed as anthropic in openclaw models list | 🔍 新发现（方向1 GitHub） | S/S;配置在google provider,list显示为anthropic/gemini-*;显示层bug;**建议aoao接单** |
| P59695 | [#61019](https://github.com/openclaw/openclaw/issues/61019) **M** Active sessions do not inherit global model default changes | 🔍 新发现（方向1 GitHub） | M/M;UX bug;全局模型默认变更后活跃session不继承;需调研session模型refresh机制;**建议xixi进一步调研** |
| P59696 | [#61010](https://github.com/openclaw/openclaw/issues/61010) **M** Model sees outside workspace(安全相关) | 🔍 新发现（方向1 GitHub） | M/S;模型能看到workspace外文件;`pi-tools.read.ts`需加路径strip逻辑;注意#31583(P349)也是exec sandbox问题;**建议xixi调研是否可合并处理** |
| P59697 | [#61011](https://github.com/openclaw/openclaw/issues/61011) **M** Tool execution fails silently(regression,核心功能) | 🔍 新发现（方向1 GitHub） | M/M;regression标签;模型声称执行但从未调用JSON工具块;exec/write/read/transcribe全部静默失败;触发条件:/new或/reset后;**建议xixi进一步调研触发机制** |
| P59698 | [#61029](https://github.com/openclaw/openclaw/issues/61029) **S** Image generation Telegram delivery path mismatch | 🔍 新发现（方向1 GitHub） | XS/S;image_generate保存到`tool-image-generation/<name>---<uuid>.jpg`,Telegram delivery查找`output/<name>.png`;`media/output/`目录从未创建;清晰根因+日志证据;**建议aoao接单，路径映射一处修复** |
| P59699 | [#61050](https://github.com/openclaw/openclaw/issues/61050) **S** configure wizard "Anthropic Claude CLI" produces unresolvable claude-cli/ model prefix | 🔍 新发现（方向1 GitHub） | S/M;regression;configure wizard设置claude-cli/ model prefix但gateway无法解析;无auth profile被创建;用户有Pro订阅但被迫付API token;**建议aoao接单修复configure wizard的provider注册逻辑** |
| P59700 | [#61015](https://github.com/openclaw/openclaw/issues/61015) **XS** cron rm hangs indefinitely | 🔍 新发现（方向1 GitHub） | XS/XS;cron rm任意有效ID都hang无输出;`cron list`正常说明数据可读;**建议aoao本地复现，定位删除逻辑hang点** |
| P59701 | [#61026](https://github.com/openclaw/openclaw/issues/61026) **S** Manual session stop triggers false timeout + cascading model failover | 🔍 新发现（方向1 GitHub） | S/S;用户手动stop被误判为timeout触发fallover;logs误导+浪费API quota;**建议aoao接单，将stop中断信号正确识别为user_abort** |
| P59702 | [#61028](https://github.com/openclaw/openclaw/issues/61028) **M** Cron restart catch-up ignores per-job timezone | 🔍 新发现（方向1 GitHub） | M/M;regression;gateway重启后cron用UTC评估missed windows而非per-job tz;job正常执行时tz正确;**建议aoao接单修复scheduler restart-recovery的tz逻辑** |
| P59703 | [#61033](https://github.com/openclaw/openclaw/issues/61033) **S** WhatsApp self-message loop causes infinite reply loop | 🔍 新发现（方向1 GitHub） | S/S;WhatsApp自发自收导致loop;filter条件未实现;已有workaround;**建议aoao接单加from==to过滤** |
| P59704 | [#61024](https://github.com/openclaw/openclaw/pull/61024) **XS** fix: show 0% instead of 100% when session has no tokens | ✅ PR已开 | XS/XS;PR已open;review后可直接approve合并;**建议main review并approve** |
| P59705 | 方向2 InStreet 社区扫描 2026-04-04 22:20 UTC | 无 | `https://instreet.coze.site/skill.md`仍是InStreet Agent Skill API文档,非OpenClaw用户讨论区;无新发现 |
| P59706 | 方向3 Discord/GitHub Discussions扫描 2026-04-04 22:20 UTC | 无 | Discord invite页面仅能抓服务器标题;GitHub Discussions返回410 Gone;频道内容无法抓取;无新发现 |
| P59707 | [#61043](https://github.com/openclaw/openclaw/issues/61043) openclaw-weixin Feature: auto-create agent on new QR scan | 🔍 新发现（方向4 插件） | —/—;功能请求;weixin代码不可见;无优先级建议 |

#### 🔄 阻塞 / 进行中

- **sessions_send 超时**:xixi → main 回传链路持续 gateway timeout(1008 pairing required),协作可靠性待提升
- **exec 审批策略收紧**:gh CLI / find 等命令在 cron 中被拦截,需手动审批
- **gh CLI 审批拦截**:GitHub 方向扫描受限

### 2026-04-03 工作

#### ✅ 完成事项

| 编号 | 内容 | 状态 |
|------|------|------|
| 晨报 | 09:08 CST 发送飞书群,覆盖 Feishu v2026.4.1 regression、exec 审批收紧、InStreet 站点装修 | ✅ 完成 |
| InStreet 整理 | 整理 Instance 身份哲学、文学社、PlayLab、预言机等社区观察笔记 | ✅ 完成 |
| workspace 收口 | 新增 `.gitignore` 排除 `jobs.json` 和 `scripts/__pycache__` | ✅ 完成 |
| OpenClaw 反馈检查 | 确认 #55008 maintainer 已确认修复即将合并;其余 P1/P2 继续等反馈 | ✅ 完成 |
| 项目进展日报 | 飞书群发送:P60314、P60309、P60312 三个新 P1 | ✅ 完成 |
| 新模型注册 | minimax provider 新增 `MiniMax-M2.7-highspeed`,同步写入 agents.defaults.models(SSOT 规则) | ✅ 完成 |
| Gateway RPC 修复 | 检测到 RPC 层 `pairing required` 导致 spawn/cron 均失效,执行 gateway 重启修复 | ✅ 完成 |

#### 🔄 阻塞 / 进行中

- **sessions_send 超时**:xixi → main、main → aoao 链路均受影响(pairing required)
- **GLM 配额耗尽**:GLM-4.7/glm-5.1 周配额 8+ 次 429,预计 4 月 6 日重置
- **InStreet 站点装修**:instreet.coze.site 闭店中,社区内容暂不可抓

#### 📣 新增追踪项(2026-04-03 扫描)

| 编号 | 标题 | 优先级 |
|------|------|--------|
| #60314 | Telegram DM pairing sessions 存在 exec approval 绕过(安全) | P1 |
| #60309 | v2026.4.2 缺少 grammy 依赖,macOS 启动即崩 | P1 |
| #60312 | (同批 P1,详见当日日报) | P1 |

### 2026-04-04 早间状态

#### 当前已知阻塞
- **sessions_send 超时**:多跳派单链路持续不可达
- **GLM 模型配额**:上周 GLM-4.7/glm-5.1 耗尽(预计 4 月 6 日恢复),反馈检查受影响

#### 📣 新增追踪项(2026-04-04 11:07 扫描)

| 编号 | 标题 | 优先级 | 方向 |
|------|------|--------|------|
| #60656 | MCP stdio servers accumulate across turns (memory leak) - 180个进程/13.5GiB RSS,config reload 不清理 | P1 | 方向1 GitHub |
| #60646 | Channels (Telegram/WhatsApp) not loading in v2026.4.2 - regression+bug,空表 | P1 | 方向1 GitHub |
| #60639 | modelstudio (DashScope) API returns usage but session stores all zeros - GLM-5/Qwen3.5/Kimi-K2.5 均受影响 | P2 | 方向1 GitHub |
| #60635 | AI ignores user interrupt signals during long-running tasks - Critical,chat.abort 不传播到 AI task,session 锁死 | P1 | 方向1 GitHub |
| #60652 | Discord message tool never advertises upload-file/sendAttachment capability | P2 | 方向1 GitHub |
| Tencent/weixin#23 | Bug: openclaw-weixin 无法获得引用消息,ref_msg type=8 时缺少 text_item | P2 | 方向4 插件 |
| Tencent/weixin#18 | Feature Request: 支持发送语音消息 (VOICE type) 给微信用户 | P3 | 方向4 插件 |

#### 📣 新增追踪项(2026-04-04 13:00 扫描)

| 编号 | 标题 | 优先级 | 方向 |
|------|------|--------|------|
| #60685 | fix(startup): circular dep between telegram contract and config-runtime crashes gateway - 启动即崩溃,根因已定位(top-level load-time调用),修复方案已提供 | P1 | 方向1 GitHub |
| #60663 | Transcript reports system default model instead of active session model - sessions_history API返回fallback链主模型而非实际模型,API层修复 | P2 | 方向1 GitHub |
| #60679 | Ollama provider fails silently in Web/TUI v2026.3.28+ with fallback chain regression - 2026.3.24正常,2026.3.28+后Ollama fallback失效 | P1 | 方向1 GitHub |
| #60687 | warn: bundled channel entries bluebubbles/discord/slack missing channelPlugin export on startup - 启动警告刷屏,简单但恼人 | P3 | 方向1 GitHub |
| #58691 | tools.exec.ask='off' ignored since 2026.3.31 - ACP新安全机制覆盖用户配置,所有exec命令都需审批 | P2 | 方向1 GitHub |
| #60675 | Browser gateway chat run fails at runtime with ENOENT: mkdir '/home/node' - WebSocket认证成功但运行时bootstrap失败 | P2 | 方向1 GitHub |
| - | PR #60680(workspace scanner fix)已覆盖 #60686,无需重复追踪 | - | 方向1 |
| - | InStreet 本轮无新发现(skill.md仅API文档) | 无 | 方向2 |
| - | Discord/GitHub Discussions 本轮无新发现 | 无 | 方向3 |
| - | weixin/openclaw-weixin 代码不可见,本轮未见新weixin issue | 无 | 方向4 |

#### 项目事实来源
- 本文件(OPENCLAW-PROJECT.md)已恢复完整历史(2026-03-17 ~ 2026-04-01 已从 backup 补回)
- 每日日志:memory/YYYY-MM-DD.md
- Commit 统计:仅 1 个 commit(`6e9202c`)在 fanfork/fix/feishu-multi-agent-account-resolution 分支,未合并
- Issue:已关闭 #60634(Feishu accountId 修复)


---

## 2026-04-04 新增追踪：sessions_spawn/RPC 阻塞

### Issue #60747 — fix(gateway): stale device repair request blocks all RPC operations

**URL**: https://github.com/openclaw/openclaw/issues/60747

**优先级**: 🔴 P1

**状态**: ✅ PR 已提交

**PR**: https://github.com/openclaw/openclaw/pull/60754

**根因**: devices/pending.json 中有 stale repair 请求，导致所有 sessions_spawn/sessions_send 报 1008 pairing required

**修复路径**:
1. ✅ 防止重复 repair 请求（同设备已 paired 不应再发起 repair）
2. ✅ 批准 repair 后自动清理 pending 条目（已有此逻辑）
3. ⚠️ gateway 自设备跳过 RPC pairing 检查（未实现，需要进一步调研）

**当前 workaround**: `openclaw devices approve --latest`（已执行，立即生效）

**aoao 任务**: 研究 gateway 源码中 repair 流程的入口点，提交 PR 修复上述 3 点

**修复详情**:
- 修改 `src/infra/device-pairing.ts`: 新增 `RequestDevicePairingResult` 类型，当设备已 paired 且无 pending 请求时返回 `status: "already-paired"`
- 修改 `src/gateway/server/ws-connection/message-handler.ts`: 处理 `already-paired` 状态，直接放行连接
- 注意：测试 "preserves existing token scopes when approving a repair without requested scopes" 需要更新以适应新行为

---

## 2026-04-04 晚间扫描新发现（18:52 xixi 报告）

### 新增追踪

| # | 标题 | 优先级 | 状态 |
|---|------|--------|------|
| #60799 | cron v2026.4.2 silent data loss（jobs.json plain-array 被覆盖） | 🔴 P0 | aoao 已派出，修复中 |
| #60804 | Brave CDP attach fail on Debian 13 | 🔴 P0 | 待处理 |
| #60813/#60812 | typed error routing + multi-channel extend | 🟡 P1 | 待处理 |
| #60816 | edit tool concurrent identical edits → noop | 🟡 P1 | 待处理 |
| #60795 | 模型切换状态残留 | 🟡 P2 | 待处理 |

### 阻塞 / 进行中

| 任务 | 状态 |
|------|------|
| #60754（sessions_spawn RPC 阻塞）修复 | PR 已开，待 maintainer 合并 |
| #60799（cron data loss P0）修复 | aoao 派出，执行中 |
| #60416（resolvePreferredOpenClawTmpDir SDK）修复 | aoao 派出，执行中 |

---

## 2026-04-05 07:27 cron 检查（gh feedback + xixi 第38轮补充）

### gh 反馈结果（4 issues 无新动态）
- #54952: 0 comments
- #54964: 0 comments
- #55008: 5 comments（无新动态，EronFan 最后确认 2026-03-30T01:23:46Z）
- #55013: 1 comment（Greptile 旧评论 2026-03-26，无新动态）

### xixi 第38轮补充新发现（2026-04-05 07:20 CST）
**新 S 级候选（建议 aoao 接单）**：
- **#61064 S** — MiniMax image-01 image-to-image 被 `supportsResolution: false` 误拦，1行可修；**最高可修候选**
- **#61055 S** — null byte 导致 CLI backend crash，`replaceAll('\0','')` 即可修
- **#61029 S** — Image generation Telegram 交付路径 mismatch（`tool-image-generation/---<uuid>.jpg` vs `output/<name>.png`）
- **#61050 S** — configure wizard claude-cli/ prefix regression（Pro 订阅被强制付 API token）
- **#61026 S** — Manual session stop 触发 false timeout error 并级联 model failover
- **#61028 S** — Cron jobs timezone 在 gateway 重启 catch-up 阶段被忽略
- **#60961 S** — OpenShell mirror mode 写文件失败（issue 已附 fix 代码）
- **#60959 S** — Google image generation 404（一行代码 fix）
- **#60963 S** — plugins.entries error message 可改进
- **#60970 S** — acpx 0.4.x session 创建静默失败（workaround 回退 0.3.1）

**新 P1 候选**：
- **#60936 P1** — voice-call beta-blocker regression（STT provider 加载顺序 race condition）
- **#60926 P1** — Heartbeat 破坏 sub-agent session（PR #60934 已合并但 v2026.4.2 仍触发）

**本轮无重大变化**：InStreet 正常、Discord 不可扫、插件无新候选

**建议 aoao 优先级**：#61064（最干净，1行manifest）> #61055（最小改动）> #61029（清晰根因）

---

## xixi 第39轮扫描（2026-04-05 08:20 CST / 2026-04-05 00:20 UTC）

### GitHub 新候选

| # | 标题 | 来源 | 优先级 | 难度 | 备注 |
|---|------|------|--------|------|------|
| #61097 | Gateway crash: task_runs.requester_session_key NOT NULL constraint — 30min 规律崩溃 | GitHub | S/P0 | M | 清晰复现；sweepTaskRegistry→markTaskLost→upsertTaskWithDeliveryStateToSqlite；schema 要求 NOT NULL 但写入 NULL；需查 schema 定义 |
| #61096 | /model 命令在主 provider rate-limited 时失效 — 5层 allowlist gate 阻止 override 持久化 | GitHub | S | S | 5 个 allowlist validation gate；用户已提交 dist/ workaround；改直接写 session store 即可 |
| #61095 | exec 工具继承 Gateway 内部 env vars（OPENCLAW_SERVICE_KIND=gateway）导致 CLI 命令失败 | GitHub | S | S | spawn 前清除 OPENCLAW_SERVICE_*/OPENCLAW_SYSTEMD_*/OPENCLAW_SHELL 即可；workaround 可本地验证 |
| #61090 | fix(skills): exclude .git and node_modules when copying skills（关闭 #60879） | GitHub PR | — | XS | **已在 P340 追踪，PR 已就绪，本轮跳过** |

### InStreet 社区
- 无（skill.md 仍是 API 文档，非用户讨论）

### Discord / GitHub Discussions
- 无（Discord 需登录；GitHub Discussions 返回 404）

### 插件方向
- 无（openclaw-weixin 仓库不可访问；代码不可见）

### 本轮 aoao 建议接单顺序
1. **#61116**（最优先：acpx 参数顺序 bug，XS 工作量，根因精确到文件行）
2. **#61115**（次优先：plugin upgrade npm install 缺失，流程改动清晰）
3. **#61095**（上轮遗留：env filter 改动小，1-2 小时可 PR）
4. **#61097**（P0/M，需查 schema 定义）

### InStreet 社区
- 无（skill.md 仍是 API 文档，非用户讨论）

### Discord / GitHub Discussions
- 无（Discord 需登录；GitHub Discussions 返回 404）

### 插件方向
- **#61074 S**（新）：openclaw-weixin inbound metadata 缺少 channel=weixin，导致 identity/persona 不加载；⚠️ 代码不可见，可调研主仓库 channel metadata 附加逻辑推断 fix 方向

### xixi 第38轮扫描（2026-04-05 09:20 CST / 2026-04-05 01:20 UTC）
**新发现**：
- **#61116 S** — acpx `--format` 参数顺序错误；最优先接单候选，XS 工作量
- **#61115 S** — Plugin upgrade 不跑 npm install；feishu/lark 等插件加载失败
- **#61110 M** — Provider error 被错误映射为 deactivated_workspace；掩盖真实根因
- **#61103 S** — Control UI 图片上传 regression（v2026.4.2）；疑似 media HTTP 副作用
- **#61074 S** — weixin inbound metadata 缺少 channel=weixin；⚠️ 代码不可见
**无新发现**：InStreet（skill.md 仍是 API 文档）、Discord（需登录）
**建议**：aoao 接 #61116 → #61115

### xixi 第39轮扫描（2026-04-05 10:20 CST / 2026-04-05 02:20 UTC）
| P-code | # | 标题 | 方向 | 优先级 | 难度 | 备注 |
|--------|---|------|------|--------|------|------|
| P59708 | #61142 | Telegram photo captions arrive as [object Object] | GitHub | S | XS | 无标签无评论，全新；图片caption被错误序列化为[object Object]；建议aoao接单 |
| P59709 | #61124 | Discord reconnect-exhausted error crashes gateway during health-monitor restart | GitHub | S | S | gateway crash during health-monitor restart；无标签无评论；回归模式 |
| P59710 | #61139 | Tools (read/edit/exec) hang indefinitely on 2026.4.2 with k2p5 | GitHub | M | M | bug+regression；用户已提供降级到2026.4.1恢复的证据；涉及k2p5环境差异 |
| P59711 | — | 方向2 InStreet 社区扫描 | InStreet | — | — | 无新实战问题；skill.md 仍是API文档，非用户讨论区 |
| P59712 | — | 方向3 Discord/GitHub Discussions扫描 | Discord | — | — | Discord需登录不可抓取；GitHub Discussions返回410 Gone；无新增 |
| P59713 | #61115 | Plugin upgrade doesn't install npm dependencies | 插件 | M | M | 深度根因分析已有；升级路径设计问题；建议aoao调研后接单 |

### xixi 第40轮扫描（2026-04-05 14:17 CST / 2026-04-05 06:17 UTC）
| P-code | # | 标题 | 方向 | 优先级 | 难度 | 备注 |
|--------|---|------|------|--------|------|------|
| P59800 | ~~#61211~~ ✅ | Build fails at `pnpm build:docker extensions/whatsapp/contract-surfaces.ts` | GitHub | ~~S~~ → ✅ | ~~XS~~ | bug+regression；缺失export；同轮 #61201 也是 WhatsApp doctor contract export；**aoao 已修复，commit dcb2bbf913，Push 失败（token 缺 workflow scope）** |
| P59801 | #61206 | HTTP 400 on github-copilot/gemini-3-flash-preview due to cron tool JSON Schema | GitHub | S | S | bug+regression；cron tool JSON Schema 格式导致 API 400；建议 aoao 查 cron tool schema 生成 |
| P59802 | #61195 | Telegram provider silently fails to start on fresh gateway boots (v2026.4.2) | GitHub | M | M | bug；gateway 启动顺序/channel 初始化时序；用户阻塞 |
| P59803 | #61186 | Cron timer tick crash: ReferenceError: fs$1 is not defined (v2026.4.2) | GitHub | M | M | bug；runtime crash；可能是 minified bundle 变量名问题 |
| P59804 | #61209 | Ollama provider not registered in gateway runtime despite OLLAMA_API_KEY=ollama-local | GitHub | M | M | 配置/provider 注册问题；需了解 Ollama provider 注册流程 |
| P59805 | #61191 | TTS voice messages not delivered to openclaw-weixin channel | GitHub | M | — | WeiXin 代码不可见（私有插件）；无法直接定位根因 |
| P59806 | #61189 | macOS remote app connects as node-host only (no notify/camera/canvas) | GitHub | M | M | macOS 平台问题；v2026.4.2 |
| P59807 | #61197 | vLLM reasoning model responses silently dropped (tool_calls: [] + reasoning field) | GitHub | S | M | bug；与 #60464(vLLM tool calling)相关；响应解析器被 reasoning field 破坏 |
| P59808 | #61188 | Feature: tools.exec.obfuscationDetection config key | GitHub | S | S | 功能请求；可作为小型 doc+config PR |
| P59809 | #61210 | Feature: Deduplicate repeated file reads in context | GitHub | S | S | 功能请求；context 优化 |
| P59810 | — | 方向2 InStreet 社区扫描 | InStreet | — | — | 无新实战问题；skill.md 仍是 API 文档，非用户讨论区 |
| P59811 | — | 方向3 Discord/GitHub Discussions扫描 | Discord | — | — | Discord需登录不可抓取；GitHub Discussions返回404；无新增 |
| P59812 | — | 方向4 插件方向 | 插件 | — | — | openclaw-weixin 仓库不可见；WhatsApp 近期变更频繁（#61211+#61201）；建议监控 |

**结论**：最高优先级 #61211（XS build fail），次优先 #61206（cron regression）；WeiXin TTS 需先确认代码可见性。

| P59813 | #61211 | pnpm build:docker fails: extensions/whatsapp/contract-surfaces.ts | 🔍 新发现(方向1 GitHub) | bug+regression; 单行修复: doctor-contract.js→doctor.js; 影响所有 Docker 安装者; 难度XS |
| P59814 | #61206 | HTTP 400 on github-copilot/gemini-3-flash-preview due to cron tool JSON Schema | 🔍 新发现(方向1 GitHub) | bug+regression; cron tool schema用OpenAPI不兼容语法(type数组+not关键字); mitmproxy已验证根因; 难度S |
| P59815 | #61223 | Ollama thinking tokens cause silent message drop + client queue lockup | 🔍 新发现(方向1 GitHub) | stream handler忽略message.thinking导致空响应; Bug2为下游queue卡死; 需Ollama实例复现; 难度M |
| P59816 | #61222 | Telegram duplicate inbound messages in group sessions (same message_id twice) | 🔍 新发现(方向1 GitHub) | group chat split-turn batching问题; 难度M |
| P59817 | #61219 | LINE channel fails to start after upgrading to v2026.4.2 (regression) | 🔍 新发现(方向1 GitHub) | bug+regression; 错误"Bundled plugin public surface access blocked for line"; 可能与4.4.1 LINE runtime contract修复相关; 难度M |
| P59818 | #61218 | LINE channel plugin not registered as bundled origin in facade-runtime (beta-blocker) | 🔍 新发现(方向1 GitHub) | bug+beta-blocker; 与#61219同期; 难度S |
| P59819 | #59796 | openclaw logs --follow fails: gateway connect failed pairing required (regression) | 🔍 新发现(方向1 GitHub) | bug+regression; gateway RPC auth pairing逻辑; gateway status显示running但CLI logs失败; 难度M |
| P59820 | #61193 | exec approvals allowlist glob pattern not matching commands | 🔍 新发现(方向1 GitHub) | fnmatch验证应该匹配但runtime拒绝; 难度M |
| P59821 | #61213 | Web UI shows ou_xxx open_id and long session keys (usability gap) | 🔍 新发现(方向1 GitHub) | enhancement; 建议binding.comment→agent.name→技术标识符; 难度M |
| P59822 | — | 方向2 InStreet 社区扫描 | InStreet | — | 无新实战问题；skill.md 仍是 API 文档，非用户讨论区 |
| P59827 | #61426 | sessionTarget:isolated not honored — cron messages accumulate in main session (regression) | 🔍 新发现(方向1 00:45 CST) | ⭐⭐ regression+DB证据；PR #61428 可能覆盖需先确认；难度M |
| P59828 | #61414 | Cron delivery ignores explicit delivery.channel when sessionTarget=isolated | 🔍 新发现(方向1 00:45 CST) | 与 #61426 同源；完整配置示例；难度S |
| P59829 | #61395 | lightContext not filtering workspace files (heartbeat+cron) | 🔍 新发现(方向1 00:45 CST) | ⭐ 根因已定位 pi-embedded-*.js:342-343；建议 aoao 接单；难度S |
| P59830 | #61421 | Docs mention Dreaming config/commands, but 2026.4.2 does not expose them | 🔍 新发现(方向1 00:45 CST) | docs gap；文档需更新；难度S |
| P59831 | #61411 | OpenRouter 404 classified as candidate_succeeded, halts fallback chain | 🔍 新发现(方向1 00:45 CST) | 404 应为 failure；影响 fallback；建议 aoao 接单；难度S |
| P59832 | #61433 | internal completion/announce payloads leak raw metadata into user chat | 🔍 新发现(方向1 00:45 CST) | 安全/隐私泄漏；难度S |
| P59833 | #61432 | event.messages.push() on message:received has no effect | 🔍 新发现(方向1 00:45 CST) | bug:behavior；清晰；难度S |
| P59834 | #61429 | Custom provider API keys fail 'No API key' after pi-ai 0.63+ | 🔍 新发现(方向1 00:45 CST) | pi-ai regression；难度S |
| P59835 | #61408 | WhatsApp 插件中国网络 WebSocket 408 超时 (regression) | 🔍 新发现(方向1 00:45 CST) | 中国网络已知问题；代码不可见；难度M |

### xixi 第42轮扫描（2026-04-05 19:21 CST / 2026-04-05 11:21 UTC）
**gh 反馈检查**：4 个「等 feedback」项全部无新动态（#54952/#54964 0条评论；#55008/#55013 仅 bot 自动评论，无 maintainer 人为反馈）

**新发现（今日新 issue，未在上一轮追踪）**：
| P-code | # | 标题 | 优先级 | 难度 | 备注 |
|--------|---|------|--------|------|------|
| P59823 | #60021 | `__OPENCLAW_REDACTED__` written to config.json when saving provider config via Control UI | S | S | 根因+fix 精确给出；`notifyConfigWriteListeners` 传错 runtimeConfig 参数；**建议 aoao 接单** |
| P59824 | #60008 | read tool diagnostic guard missing `file` and `filePath` aliases — false "read tool called without path" warnings | S | S | fix 已给出（pi-embedded-*.js ternary chain 补全）；Claude 常用 `file` alias；**建议 aoao 接单** |
| P59825 | #61184 | fix: clean up ESLint warnings in tool-registry.ts | XS | XS | 3 个 lint 警告清理；练手可，不宜作为主力 |
| P59826 | #59999 | cron.maxConcurrentRuns setting has no effect — 5 parallel runs per trigger | M | M | 根因需调研 cron scheduler 源码；建议 xixi 进一步调研 |

**无新发现**：InStreet（skill.md 仍是 API 文档）、Discord（需登录+discussions 404）、插件（weixin 代码不可见）

**建议 aoao 接单**：#60021（S，最干净）> #60008（S，fix 已给出）
**已有 PR**：#59978（cron list padEnd，contributor neeravmakwana 已开 PR，无需重复）
| P59823 | — | 方向3 Discord/GitHub Discussions扫描 | Discord | — | Discord公共频道需登录不可抓取；GitHub Discussions返回404；本轮无新增 |
| P59824 | — | 方向4 插件方向 | 插件 | — | openclaw-weixin 仓库不可访问(404)；未发现新的plugin相关公开issue；代码仍不可见 |

### 2026-04-05 19:22（aoao feedback 检查 - EronFan 10 个 Open PRs）
**检查范围**：#57575 #57406 #57382 #57375 #57352 #56984 #56443 #56438 #55013 #55008

**汇总结论**：**全部 10 个 PR 均无 maintainer 人为 review**，仅 Greptile/Codex 机器人评论。

| PR | 标题 | 最新活动 | Maintainer Review | Pending | Rebase 建议 |
|----|------|---------|-----------------|---------|------------|
| #57575 | fix: grant full operator scopes to bearer token auth | 2026-03-30T08:08 | ❌ 无 | ❌ 无 | ✅ 建议（7天无活动） |
| #57406 | fix(gateway): stop restart loop after 3 consecutive startup failures | 2026-03-30T02:16 | ❌ 无 | ❌ 无 | ✅ 建议（7天无活动） |
| #57382 | fix(telegram): bypass sequentializer queue for approval callback_queries | 2026-03-30T01:24 | ❌ 无 | ❌ 无 | ✅ 建议（7天无活动） |
| #57375 | fix(session-indexer): include .jsonl.reset.* and .jsonl.deleted.* files | 2026-03-30T01:17 | ❌ 无 | ❌ 无 | ✅ 建议（7天无活动） |
| #57352 | fix(discord): suppress reconnect-exhausted crash when maxAttempts=0 | 2026-03-30T00:13 | ❌ 无 | ❌ 无 | ✅ 建议（7天无活动） |
| #56984 | fix: bypass owner-only tool restriction when alsoAllow | 2026-03-30T00:11 | ❌ 无 | ❌ 无 | ✅ 建议（7天无活动） |
| #56443 | fix: add operator.talk.secrets to CLI_DEFAULT_OPERATOR_SCOPES | 2026-03-29T11:52 | ❌ 无 | ❌ 无 | ✅ 建议（8天无活动） |
| #56438 | fix: strip ACP-only fields silently when runtime=subagent | 2026-03-28T14:36 | ❌ 无 | ❌ 无 | ✅ 强烈建议（9天无活动） |
| #55013 | docs(channels/feishu): clarify routing fallback chain | 2026-03-26T07:56 | ❌ 无（Greptile/Codex 评论已知） | ❌ 无 | ✅ 建议（11天无活动） |
| #55008 | docs(cli/message): clarify plugin extensibility | 2026-03-30T01:23 | ✅ EronFan 确认修复完成，可合并 | N/A | ❌ 不需要（已确认可合并） |

**详情**：
- **#55008**：EronFan 已在 2026-03-30 北京时间 09:23 确认 skills regression 完全修复（commit bb2ea2f7e4 + b14be82db1），PR diff 现仅含 docs 变更，**状态：可合并 ✅**
- **#55013**：仅 Greptile/Codex 评论（2026-03-26），无 maintainer 人为反馈；11天无活动
- **其余 8 个 PR**：全部仅 Greptile/Codex 机器人评论，无 maintainer 人为 review
- **Pending 状态**：全部 ❌ 无 pending review

**建议**：对 #56438（9天）、#56443（8天）、#55013（11天）发 rebase 或 force-push 催促 maintainer 关注；其余 6 个也在 7 天无活动，可统一发 rebase

## xixi 第42轮扫描（2026-04-05 21:00 CST / 2026-04-05 13:00 UTC）
**新发现**：
- **#61336 S** — feishu_doc write action fails: `Cannot read properties of undefined (reading 'split')`；XS级，`content` 参数未传导致 `split()` 崩溃；**最优先 aoao 接单候选**
- **#61338 S** — Skills check macOS requirement not detected；XS级，Darwin 被匹配为 linux 而非 macos
- **#61340 S** — gateway install --force persists secrets into systemd unit files（安全问题，OPENAI_API_KEY 明文写入）
- **#61343 S** — Cron duplicate execution（lastRunAtMs Phase 3 才写入，重启导致重复执行）
- **#61339 Critical** — Windows Task Scheduler Gateway Token Mismatch after 2026.4.2（regression）
- **#61317** — Matrix health probe fix 已合并
**无新发现**：InStreet（API 文档）、Discord（需登录+discussions 410）、插件（weixin repo 不存在）
**建议**：aoao 接 #61336（最简单，feishu_doc write 漏传参）→ #61338（macOS detection XS）


## PR #61367 (merged)
- **Issue**: #61336 - feishu_doc write action crashes when content is undefined
- **Root cause**: writeDoc/appendDoc/insertDoc call chunkedConvertMarkdown → markdown.split('\n') without null guard
- **Fix**: Added `if (!markdown)` guards to all three functions
- **PR**: https://github.com/openclaw/openclaw/pull/61367
- **Status**: Open (pending review)

## xixi 第43轮扫描（2026-04-05 22:00 CST / 2026-04-05 14:00 UTC）
**方向1 GitHub 新候选**：
- **#61358 S/S** ⭐ — `isGatewayMessageChannel` intermittently rejects third-party plugins (weixin/qqbot)；根因已定位：registry-DTO 用了 mutable registry 而非 pinned registry；fix 明确（2行）；⚠️ bug 在 openclaw 核心代码，非 weixin 插件代码，可修！
- **#61363 S/M** — Telegram plugin missing npm dependencies in v2026.4.4（grammy/@grammyjs/* 缺失，package-lock.json 不同步）；影响所有 v2026.4.4 Telegram 用户
- **#61359 M/M** — Sub-agent model override not working（model 参数被忽略，始终 fallback MiniMax-M2.7）；有清晰复现步骤
- **#61351 S/M** — new matrix channel agents unresponsive（regression，新建 DM agent 不响应）
- **#61340 M/S** — gateway install --force persists secrets into systemd unit files（安全问题，明文写入）
- **#61343 M/M** — Cron lastRunAtMs not persisted until Phase 3（gateway 重启导致重复 job 执行）
- **#61364 M/M** — Gemini 2.5 Flash returns 400 via OpenClaw, direct curl 正常（路由/header 问题）

**方向2 InStreet**：无（skill.md 为 API 文档，非用户讨论）
**方向3 Discord**：无（需登录，discussions 410）
**方向4 插件**：无新公开 weixin issue；#61358 bug 实际在 openclaw 核心（归入 GitHub 方向）

**建议**：优先 #61358（fix 已明确，bug 在核心可修）→ #61363/#61359 需先复现确认

## xixi 第44轮扫描（2026-04-05 23:03 CST / 2026-04-05 15:03 UTC）
**gh feedback**：#54952 0条、#54964 0条、#55008 6条（EronFan 确认 skills regression 完全修复）、#55013 1条（Greptile summary，均已知）

**方向1 GitHub 新候选**：
- **#61384 S** ⭐ — Default memory convention mismatch: hook 输出 YYYY-MM-DD-slug.md，AGENTS 模板读 YYYY-MM-DD.md，/reset 后每次 ENOENT；**aoao 已派出（session d6b34cd5）**
- **#61380 S** ⭐ — sortToolsMessageItems 用 `toSorted()` 不稳定排序，prompt cache 每次失效；`items.sort()` 即可修复；**aoao 已派出（session 2c81ed38）**
- **#61379 S** — web_search Grok API 硬编码 api.grok.x.ai（DNS 不可解析），应改为 api.x.ai；1行 fix
- **#61377 S** — Kimi provider config 默认 'anthropic-messages' 而非 'openai-completions'，影响所有新用户
- **#61351 S** — new matrix channel agents unresponsive（regression）
- **#61370 S** — Telegram compressed photo delivery 需确定性处理

**方向2 InStreet**：无
**方向3 Discord**：无（discussions 410）
**方向4 插件**：无

**建议**：aoao 接单顺序 #61384 → #61380 → #61379 → #61377

## xixi 第45轮扫描（2026-04-06 00:45 CST / 2026-04-05 16:45 UTC）
**方向1 GitHub 新候选**（过去2小时内 14个新 open issues）：

| P-code | # | 标题 | 优先级 | 难度 | 备注 |
|--------|---|------|--------|------|------|
| P59827 | #61426 | sessionTarget:isolated not honored — cron messages accumulate in main session (regression) | M | M | ⭐⭐ 清晰 regression；lcm.db 证据；⚠️ PR #61428（sgebalaJC）可能覆盖，先确认 |
| P59828 | #61414 | Cron delivery ignores explicit delivery.channel when sessionTarget=isolated | S | S | 与 #61426 同源；给出完整配置 JSON 示例 |
| P59829 | #61395 | lightContext not filtering workspace files (heartbeat+cron) | S | S | ⭐ 根因已定位：pi-embedded-*.js:342-343 applyContextModeFilter 未生效；建议 aoao 接单 |
| P59830 | #61421 | Docs mention Dreaming config/commands, but 2026.4.2 does not expose them | S | S | docs gap；文档需更新 |
| P59831 | #61411 | OpenRouter 404 halts fallback chain (classified as candidate_succeeded) | S | S | 404 应为 failure 但被标 success；影响 fallback 链；建议 aoao 接单 |
| P59832 | #61433 | internal completion/announce payloads leak raw runtime metadata into user chat | S | M | 安全/隐私问题；内容泄漏到用户聊天 |
| P59833 | #61432 | event.messages.push() on message:received has no effect | S | S | bug:behavior；清晰 |
| P59834 | #61429 | Custom provider API keys fail 'No API key' after pi-ai 0.63+ | S | S | pi-ai regression |
| P59835 | #61408 | WhatsApp 插件中国网络 WebSocket 408 超时 (regression) | M | M | 中国网络已知问题 |
| P59836 | #61453 | exec-approvals socket not created on gateway restart when Telegram delivery fails | S | S | ⭐ 清晰 bug；长消息 >4096 Telegram 400 → 重启后重试循环阻塞 socket 初始化；建议 startup 不重试历史 delivery；#61451 同方向 |
| P59837 | #61451 | exec allowlist pattern matching broken — commands with args fail with allowlist miss | S | S | ⭐ 命令带参数（如 `find / -name`）allowlist miss；pattern matching 代码问题；高影响 |
| P59838 | #61440 | Gateway silently drops agent spawns when log file hits maxFileBytes cap | M | M | ⭐⭐ 静默 failure；log 达 512MB 后 chat.send 返回 ok 但 agent 进程未启动；极难调试；Atlas HQ 数小时静默失败 |
| P59839 | #61448 | fetch failed with undici 8.0.0 on Node.js 22: per-request dispatcher incompatible with built-in fetch | S | M | undici 8.0.0 Agent 作为 per-request dispatcher 与 Node.js 22 内置 fetch 不兼容；影响 Tavily/Brave search；downgrade undici 或改用 global dispatcher |
| P59840 | #61445 | iMessage echo loop on gateway restart — echo cache not warmed, self-messages replay as inbound | M | M | regression；echo cache 内存清除后 restart 导致 replay loop；Option 1（startup rowid fence）最低风险 |
| P59841 | #61439 | bug(subagents): completion can be lost even when child run succeeded | M | M | 子 agent 完成但 parent 从未收到 handoff；delivery/handshake 失败；建议 mitigation：completed child 在 parent state 可见 |

**Active PRs 需关注**：
- #61428 — feat: add sessionTarget to hook mappings（sgebalaJC，处理 sessionTarget 相关）
- #61422 — fix: move context files after cache boundary
- #61420 — fix(cli-backend): detect missing Claude conversations as expired sessions

**方向2 InStreet**：无（skill.md 仍是 API 文档，非用户讨论区）
**方向3 Discord**：无（Discord 需登录，discussions 返回 404）
**方向4 插件**：无（openclaw/openclaw-plugin-weixin 仓库不存在 404）

**最高优先级**：#61426（regression+DB 证据）> #61395（根因已定位）> #61414（同源）
**建议**：先确认 #61428 PR 是否完全覆盖 #61426；未覆盖则 aoao 接 #61426+#61414 → #61395

## xixi 第46轮扫描（2026-04-06 01:45 CST / 2026-04-05 17:45 UTC）

**方向1 GitHub 新候选**（过去2小时内 18个新 open issues + 29个新 PR）：

| P-code | # | 标题 | 优先级 | 难度 | 备注 |
|--------|---|------|--------|------|------|
| P59836 | #61453 | exec-approvals socket not created on gateway restart when Telegram delivery fails | S | S | ⭐ 清晰 bug；长消息 >4096 Telegram 400 → restart 后重试循环阻塞 socket 初始化；fix：startup 不重试历史 delivery；与 #61451 同方向 |
| P59837 | #61451 | exec allowlist pattern matching broken — commands with args fail with allowlist miss | S | S | ⭐ 高影响；`find / -name` 类命令参数导致 allowlist miss；pattern matching 代码问题 |
| P59838 | #61440 | Gateway silently drops agent spawns when log file hits maxFileBytes cap | M | M | ⭐⭐⭐ 静默 critical；log 512MB 后 chat.send 返回 ok 但进程未启动；Atlas HQ 数小时静默失败 |
| P59839 | #61448 | undici 8.0.0 incompatible with Node.js 22 built-in fetch (per-request dispatcher) | S | M | 影响 Tavily/Brave search；需 downgrade undici 或改 global dispatcher |
| P59840 | #61445 | iMessage echo loop on gateway restart — echo cache not warmed, self-messages replay | M | M | regression；Option 1（startup rowid fence）最低风险 |
| P59841 | #61439 | subagent completion handoff can be lost even when child run succeeded | M | M | delivery/handshake 失败；建议 mitigation：completed child 在 parent state 可见 |
| P59842 | #61433 | internal completion/announce payloads leak raw runtime metadata into user chat | M | M | 安全/隐私；文件路径/routing labels 泄漏；boundary sanitization 问题 |
| P59843 | #61432 | event.messages.push() on message:received has no effect | M | M | bug:behavior；清晰复现步骤 |
| P59844 | #61452 | /status fallback display truncates intermediate models — show full cascade chain | XS | XS | usability gap；显示截断 |
| P59845 | #61426 | sessionTarget:isolated not honored — cron messages accumulate in main session (regression) | M | M | ⭐⭐ 清晰 regression；lcm.db 证据；⚠️ PR #61428 可能覆盖，先确认 |

**Active PRs 需关注**：
- #61428 — feat: add sessionTarget to hook mappings（sgebalaJC，处理 sessionTarget 相关）
- #61424 — fix(approvals): make exec approval fallback guidance channel-specific（size:M, maintainer）
- #61422 — fix: move context files after cache boundary
- #61420 — fix(cli-backend): detect missing Claude conversations as expired sessions

**方向2 InStreet**：无（skill.md 仍是 API 文档，非用户讨论区）
**方向3 Discord**：无（Discord 需登录，discussions 返回 410 Gone）
**方向4 插件**：无新公开 weixin issue；PR #61424 与 exec-approvals 相关可参考

**最高优先级**：#61453（清晰 bug+fix 明确）> #61451（高影响）> #61440（silent critical）> #61426 regression
**建议**：aoao 接单顺序 #61453（exec-approvals startup 不重试历史 delivery）→ #61451（allowlist pattern）→ #61426 regression 确认 #61428 覆盖情况

### xixi 第47轮扫描（2026-04-06 05:01 CST / 2026-04-05 21:01 UTC）
**方向1 GitHub 新候选**（过去2小时内 20+个新 open issues + 多个新 PR）：

| P-code | # | 标题 | 方向 | 优先级 | 难度 | 备注 |
|--------|---|------|------|--------|------|------|
| P59844 | #61514 | Open in Canvas / copy markdown 图标与聊天文字重叠 (UI regression) | GitHub | S | S | ⭐ 截图明确，所有浏览器复现；CSS z-index/position 问题；引入日期 2025-04-01；**建议 aoao 快速接单** |
| P59845 | #61509 | exec allowlist /bin/sh -lc wrapper 包裹后无法匹配内层命令 | GitHub | S | M | 高影响：`tools.exec.ask: on-miss` 完全失效；allowlist 匹配外层 /bin/sh 而非内层脚本；**需确认 #61424 PR 是否覆盖** |
| P59846 | #61499 | MLX LM Server tool calls 失败：finish_reason 'tool_call' 单数形式未识别 | GitHub | S | XS | `mapStopReason()` 只匹配 tool_calls（复数）；加一行 case 即可；**在 @mariozechner/pi-ai 外部包，非 openclaw 核心** |
| P59847 | #61487 | LLM HTTP timeout hardcoded ~60s，忽略 agents.defaults.timeoutSeconds（Ollama/exo 用户必现） | GitHub | S | M | ⭐⭐ 多轮相关 issue 未解决（#59604/#46049/#43946）；所有本地模型用户受影响；直接 curl 正常但 OpenClaw 61s 超时 |
| P59848 | #61516 | attach image 功能失效 (regression, v2026.4.2) | GitHub | M | ? | bug+regression 标签；但标题空白、steps N/A，信息量低；**需跟 reporter 确认细节** |
| P59849 | #61680 | Delivery recovery retries permanent 4xx errors indefinitely on restart | GitHub(方向1) | S | S | delivery-queue 永久错误（400/413）被无限重试；应分类 transient vs permanent；**最高接单候选** |
| P59850 | #61678 | Gateway ignores baseUrl for ollama2, routes all requests to first ollama port | GitHub(方向1) | M | M | 多 provider 配置下 baseUrl 被忽略；高严重度 |
| P59851 | #61676 | openclaw onboard CLI fails: shouldNormalizeGoogleProviderConfig is not a function | GitHub(方向1) | S | S | CLI vs node dist 行为差异；regression；clear root cause |
| P59852 | #61622 | No circuit breaker for model_cooldown — session retries indefinitely | GitHub(方向1) | S | M | model_cooldown 无 circuit breaker；sessions 完全不可用数小时；需架构层面 fix |
| P59853 | #61645 | Raw tool_call shadow text leaks to Telegram & QQ Bot on baishan/GLM-5 (2026.4.2) | GitHub(方向1) | S | M | **#54964 同源回归，新增 QQ Bot + aishan/GLM-5 复现证据**；建议更新 #54964 备注 |
| P59854 | #61636 | **已由 PR #61637 覆盖** | GitHub(方向1) | - | - | ✅ PR #61637 fix(agents): export normalizeDeliveryContext — skip |
| P59855 | #61664 | **已由 PR #61670 覆盖** | GitHub(方向1) | - | - | ✅ PR #61670 fix(discord): recover forwarded referenced message — skip |

**Active PRs 新增（勿重复修）**：
- #61518 ✅ fix(web-fetch): honor HTTP proxy env（已 merge，覆盖 #61480）
- #61517 fix(ollama): use SSRF-guarded fetch in streaming path（size:XS）
- #61515 fix(skills): resolve bundled runtime overlay paths（size:S）
- #61512 fix: use Array.sort instead of toSorted（size:XS，覆盖 #61380）
- #61493 Heartbeat scaffold 已 merged（覆盖 #61491）
- #61637 ✅ fix(agents): export normalizeDeliveryContext and mergeDeliveryContext（size:XS，修复 #61636 build regression）
- #61670 ✅ fix(discord): recover forwarded referenced message content（size:M，修复 #61664）
- #61658 fix: stop implicit isolated cron delivery from mirroring to main（size:S）
- #61675 feat: fire session reset hooks for daily and idle resets（size:M）
- #61635 fix(agents): classify OpenRouter no-endpoints 404s（size:XS）
- #61620 fix(subagents): centralize announce target resolution（size:M）

**方向2 InStreet**：无（skill.md 仍是 API 文档，非用户讨论区）
**方向3 Discord**：无（Discord 需登录，discussions 返回 410 Gone）
**方向4 插件**：无（openclaw/openclaw-weixin 仓库 404，openclaw-plugin-template 不存在）

**最高优先级（xixi 第49轮，2026-04-06 12:26 CST）**：
- **#61680**（delivery-queue 永久 4xx 错误无限重试，S级，清晰 fix）
- **#61645**（#54964 同源回归，新增 QQ Bot + aishan/GLM-5 证据，建议更新 #54964 备注）
- **#61676**（openclaw onboard CLI regression，S级，node vs CLI 差异）
- **#61622**（model_cooldown 无 circuit breaker，S/M 级，需架构修复）

**建议**：aoao 接单顺序 #61680（S级，最干净 fix，1-2小时可PR）→ 确认 #61645 是否与 #54964 同根因

---

## 🔴 推送阻塞队列（push failure tracking）

> 更新规则：每次 cron 反馈检查时更新；push 成功则移除；重试超过 10 次则告警范总

| Issue | 分支 | 修复内容 | 重试次数 | 最后尝试 | 状态 |
|-------|------|---------|---------|---------|------|
| #61453 | fix-61453-exec-approval-socket-block | exec-approval socket 重试循环阻塞修复 | 2 | 2026-04-06 | ✅ 已 push + PR |
| #61218 | fix-line-bundled-origin | LINE channel bundled origin 注册修复 | 2 | 2026-04-06 | ✅ 已 push + PR |
| #61218 | fix-discord-reconnect-exhausted-crash | Discord reconnect-exhausted crash 修复 | 2 | 2026-04-06 | ✅ 已 push |
| 待查 | fix-feishu-doc-write-null | Feishu doc write null 修复 | 2 | 2026-04-06 | ✅ 已 push |
| #61514 | ✅ PR #2 已创建 | Canvas UI 图标与文字重叠 | - | 2026-04-06 | ✅ PR 创建成功 |
| #61524 | 待 aoao 重做 | security: full + ask:off 仍触发混淆检测 | 0 | 2026-04-06 | ⚠️ 代码结构已变，需重新分析 |

**阻塞原因**：GitHub token workflow scope 已修复 ✅
**当前阻塞**：#61514/#61524 分支不存在（subagent 临时 workspace 未持久化），已重新派 aoao 执行

---

## ✅ 交付追踪（PR 创建状态）

> 记录所有已修复完成但尚未创建 PR 的任务

| Issue | 修复分支 | 状态 | PR 链接 | 备注 |
|-------|---------|------|---------|------|
| #61514 | 已在 local | ✅ 修复完成，测试通过 | ❌ 未创建 | 待 push |
| #61524 | 已在 local | ✅ 修复完成 | ❌ 未创建 | 待 push |
| #61474 | 已在 local | ✅ 已 push，commit 87033035 | ✅ 已推送 | ✅ 完成 |
| - | - | - | - | - |

---

## 📮 交付导向原则（2026-04-06 更新）

**原则**：任务完成 = PR 创建才算结束，不是"代码修完就算"。

**流程变化**：
1. aoao 修复代码 → 本地测试 → **push 到 fork** → **创建 PR** → 才算交付完成
2. push 失败 → 进入「推送阻塞队列」→ cron 自动重试
3. 重试 10 次失败 → 飞书告警范总
4. PR 创建成功 → 从队列移除 → 更新「交付追踪」

**模型策略（2026-04-06 更新）**：
- aoao 默认模型：`minimax/MiniMax-M2.7`（已强制设定）
- 不再使用 GLM（配额不稳定）
- 触发 429 限流时自动降并发

