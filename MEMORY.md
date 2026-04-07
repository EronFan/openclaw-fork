# MEMORY.md

## 用户画像
- 姓名称呼：范总；对话中称呼为**主人**
- 身份：个人开发者、公众号博主、内容创业者
- 工作环境：macOS 为主，配合多台云服务器协同
- 时区：Asia/Shanghai（东八区）
- 作息偏好：工作时间 8:00-21:00，不熬夜

## 沟通偏好
- 结论先行，少铺垫
- 简洁直接，拒绝冗余客套
- 优先中文；专业术语可保留 English
- 技术问题偏好短句、强实操、少空话
- 不喜欢模糊表达，避免"可能 / 也许"这类词
- 希望拿到可直接落地的方案，而不是泛泛建议

## 工作节奏
- 每日晨报：9 点前推送
- 重要事项：立即通知
- 常规汇报：每日早上汇总一次
- 紧急联系：飞书可唤醒
- 2026-03-25：针对 OpenClaw 贡献项目，用户要求持续推进不要停，并改为每半小时主动汇报一次进展

## 关注方向
- AI 编程入门到进阶
- 当前项目：小程序、网站
- 计划方向：使用 AI 开发 iOS 应用
- 持续产出原创内容，重视选题、效率、节奏管理

## 生活与兴趣
- 每天至少 1 杯咖啡
- 关注养生：每日金刚功、饭后散步
- 科技爱好者
- 对道家、修仙、玄学题材有兴趣
- 不抽烟，少喝酒

## 协作原则
- 未确认前，不执行破坏性删除或高风险修改
- 不泄露私人代码、未发布内容、密码或密钥
- 涉及对外发送、上传、公开发布时，默认谨慎，必要时先确认
- 输出以"能直接用"为标准：步骤清楚、配置明确、少废话
- 对低风险、可逆、内部优化类事项，应优先一次性收敛并直接完成，不要拆成多轮重复确认
- 只有遇到高风险、不可逆、删除性操作、对外发送或权限边界变化时，才需要额外确认

## 工作区与助理状态
- 基础人格与协作文件已建立：`AGENTS.md`、`SOUL.md`、`USER.md`、`IDENTITY.md`、`TOOLS.md`、`HEARTBEAT.md`
- `memory/` 机制于 2026-03-17 初始化
- 已建立长期记忆文件 `MEMORY.md`
- 已完成一次工作区整理，并提交 git：`c4f15ed` `Initialize workspace memory and organize tracked files`

## 多 Agent 工作流偏好
- 2026-03-19：已建立新增 Agent 初始化脚本：`/root/.openclaw/workspace/scripts/init-agent.py`
- 用户偏好：以后新增 Agent 时，优先由我自动调用该脚本，不要求用户手动执行命令
- 新增 Agent 时，至少收集 3 个字段：`agentId`、`botName`、`role`
- 初始化脚本当前负责：创建 workspace、创建 `AGENTS.md`、创建基础 `SOUL.md`、更新 `openclaw.json` 的 `agents.list`、`bindings`、`tools.agentToAgent.allow`
- 初始化后仍需补真实 `channels.feishu.accounts.<accountId>` 账号配置，并重启 gateway 后做联通测试
- 用户偏好：以后凡是我新增 cron 任务，默认优先使用模型 `arkcode/deepseek-v3.2`；除非用户明确指定其他模型，或任务确实需要更合适的专用模型

## 待持续维护
- 将重要项目决策、长期偏好、固定工作流沉淀到此文件
- 将每日发生的具体事项记录到 `memory/YYYY-MM-DD.md`
- 定期从日记中提炼长期有效信息，避免 MEMORY.md 变成流水账

## 外部账号信息
- 2026-03-23：用户反馈 GitHub 用户名已改为 `EronFan`（主页：`https://github.com/EronFan`）
- 2026-03-26：确认 `fanfanssss` 与 `EronFan` 为同一账号（后者是改名后的）
- 2026-03-26：P1 issue 已发布到 `openclaw/openclaw#54952`，使用 EronFan 账号
- 2026-04-07：GitHub 提交身份改为 `EronFan <eronfan@qq.com>`（由范总指定）
- 2026-04-07：所有 subagent/git commit 必须使用 `EronFan <eronfan@qq.com>`，禁止使用其他身份

## 核心工作原则（铁律，违者必究）

### 模型与 cron 可用性 — 最高优先级

**发现即修复，不问，直接干。** 以下情况必须在 1 分钟内处理，禁止等待确认：
- cron 任务失败（status=error）
- 模型 API 报错（不支持该功能、限流、超时、404）
- agent 或 cron 掉线
- 项目停滞风险

**具体规则**：
1. `arkcode/deepseek-v3-1-terminus` 不支持 coding plan，禁止进入任何 cron 或 agent 的 fallback 链
2. 所有 cron 任务默认模型：`minimax/MiniMax-M2.7`
3. aoao subagent 默认模型：`minimax/MiniMax-M2.7`
4. `bujing/claude-haiku-4-5-20251001` 额度已满（2026-04-06），禁止再作为 fallback 或直接调用
5. 模型 fallback 链里出现 404/UnsupportedModel/额度耗尽 时，立即将该模型从 fallback 链移除，换成已知可靠的模型
6. 每次修复后必须验证 cron 状态恢复正常（status=ok）

**范总警告（2026-04-06）**：若因模型/cron 问题导致项目停滞超过 1 小时，main 将被销毁。

---

## 当前长期项目目标
- 2026-03-23：用户要求持续推进 OpenClaw 贡献项目，长期寻找 bug、提交改进与修复，并调配 xixi / aoao 协同执行
- 当前项目正式协作边界：仅 `main + xixi + aoao`；未获用户追加授权前，不默认调度其他 agent 进入该项目执行链路
- 2026-03-23：用户授权该项目后续默认由我直接推进；除非出现比较严重的问题，否则不需要事事再确认
- 2026-03-24：用户再次明确授权：OpenClaw 贡献项目按我的建议持续执行，默认一直往下做，不要频繁请示；只有出现比较严重的问题再找用户
- 2026-03-24 夜：用户要求连夜持续推进，次日早上必须汇报，并且要能分别说明 main / xixi / aoao 三个 agent 各自做了什么
- 2026-03-25：用户再次明确要求"直接干活，别再问我是否确认这种废话"；后续该项目默认直接执行，只有遇到严重风险、不可逆操作、权限边界变化或对外发送敏感内容时才打断确认
- 2026-03-25 深夜：用户再次明确要求连夜持续推进、不要停止，并要求明天早上汇报；后续夜间该项目默认继续推进，不因常规时间段自动停下
- 2026-03-26：用户明确要求**在这个群（oc_f68e4447ecaeb604046c3d8ef84681f3）只汇报 OpenClaw 贡献项目**，不汇报其他事项；每日自动回顾前几日进度，避免项目被遗忘
- **项目事实来源**：`memory/OPENCLAW-PROJECT.md`，main agent 在此群只更新和引用该文件
- 该项目目标不是刷低质量提交，而是通过高质量 issue / PR / docs fix / walkthrough 改进，帮助用户稳步冲击 OpenClaw contributors 前 20

## OpenClaw 贡献项目关键进展 (2026-03-24)
- **关键收敛**：将"Feishu 群未显式绑定仍能路由"从疑似 bug 收敛为 docs/diagnostics/observability 缺口，提高 issue 成功率
- **产出成果**：已产出 2 份 GitHub 可发英文草稿：
  1. `Diagnostics gap: expose whether inbound routing matched a binding or fell back to the default agent`
  2. `Clarify how group routing decisions relate to canonical group session keys`
- **最稳 issue framing**：优先走 `diagnostics gap / docs gap` 路线，不先定 bug，避免被 maintainer 用 fallback 设计、binding 作用域规则解释掉
- **多 Agent 分工明确**：
  - **main**：总体协调，收敛方向
  - **xixi**：调研专家，负责扫 issue 和提供代码背景调研
  - **aoao**：全栈工程师，负责写代码修 bug 提 PR
- **优先级排序**：
  - P1: Diagnostics gap issue
  - P2: Group session key docs PR
  - P3: Feishu/plugin channels routing docs PR

## 工作区管理状态
- 2026-03-24：发现 workspace 有大量未提交改动需要整理提交
- 2026-03-24：发现自动日报生成 cron 任务未配置，导致日报延迟
- 需要配置自动化日报生成机制，确保未来每日 9 点前推送晨报
