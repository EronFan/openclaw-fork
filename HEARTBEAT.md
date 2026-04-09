# HEARTBEAT.md

## 目标
只做低打扰、高价值的周期检查；没新情况就返回 `HEARTBEAT_OK`。

## 检查顺序
每次 heartbeat 最多做 1-2 项，避免无意义刷屏：

1. 看 `memory/heartbeat-state.json`
2. **【必须】检查 subagent 失败状态**（见下方规则）
3. **【必须】检查 xixi 扫描状态**（见下方规则）
4. 优先检查距离上次最久、且最有价值的项目：
   - calendar
   - email
   - mentions
   - weather
5. 如果没有可检查项、或不适合打扰，就直接 `HEARTBEAT_OK`

## 主动提醒条件
只在下面情况主动发消息：
- 未来 2 小时内有日程
- 收到明显重要/紧急的新消息
- 距离上次主动汇报已超过 8 小时，且确实有新信息
- 发现需要尽快处理的异常

## Subagent 失败监控规则（必须执行）

**每次 heartbeat 必须检查 subagent 状态，有失败必须处理：**

1. 调用 `subagents(action=list, recentMinutes=120)` 检查最近2小时 subagent 状态
2. 如果有 `status=failed` 的 subagent：
   - 立即分析失败原因（查看 `sessions_history` 获取输出摘要）
   - 如果是可修复的失败（代码可找、环境可配）：立即 `sessions_spawn` 重试
   - 如果是复杂失败（根因不清、需要更多上下文）：立即通知范总并说明原因
   - **禁止**：忽略失败、延迟重试、不了了之
3. 记录到 `memory/heartbeat-state.json` 的 `subagentFailures[]` 数组（记录 issue 号、失败次数、首次失败时间）
4. 如果同一 issue 失败≥3次：标记为"需人工介入"，通知范总决定是否继续
5. 正常结束（done）的 subagent 也要记录到 `subagentSuccesses[]`

**硬规则**：subagent 失败 = 必须立即处理，不等、不拖、不忽略。

## Xixi 扫描监控规则（必须执行）

**每次 heartbeat 必须检查 xixi 扫描工作是否正常：**

1. 读取 `xixi-reports/latest-scan-report.md` 的时间戳（文件头部或第一行时间）
2. 读取 `memory/OPENCLAW-PROJECT.md` 中最近一轮 xixi 扫描记录的时间
3. 检查 xixi 扫描是否超过以下阈值：
   - 超过 **3小时** 无新扫描报告 → 立即通知范总（xixi 可能掉线）
   - 超过 **6小时** 无新扫描 → 立即手动触发 xixi 重新扫描
4. 检查 `OPENCLAW-PROJECT.md` 中是否有未处理的 xixi 建议（建议 aoao 接单的项）
   - 有未处理的高优先级建议 → 立即派出 aoao 接单
   - 有未处理的低优先级建议 → 记录在 heartbeat-state.json 待处理队列
5. 如果 xixi 超过 **12小时** 无任何扫描活动：派 xixi 立即执行一轮扫描

**与 subagent 失败监控的关系**：
- xixi sessions_spawn 任务走 subagent 失败规则
- xixi cron 任务走本规则（检查扫描报告文件时间戳）
- 两者独立，都必须检查

## 不打扰条件
出现任一情况，优先 `HEARTBEAT_OK`：
- 23:00-08:00，且无紧急事项
- 30 分钟内刚检查过同类项目
- 没有任何新增信息
- 只是重复旧提醒

## 记账规则（必须执行）
每次 heartbeat 完成后，**必须**更新 `memory/heartbeat-state.json`：
1. 读取当前 `memory/heartbeat-state.json`
2. 更新 `updatedAt` 为当前 UTC 时间（格式：`2026-04-08T12:30:00Z`）
3. 如果有检查 calendar/email/mentions/weather，更新对应时间戳
4. 如果有主动提醒，更新 `lastProactiveReachoutAt`
5. 记录 subagent 失败/成功状态（见上方规则）
6. 写入文件（**直接执行，不询问**）

## 自动收口规则（必须执行）
每次 heartbeat 完成后，**必须**检查 workspace 是否有未提交文件：
- 执行 `git status --porcelain` 检查是否有未提交文件
- 如果有，**立即执行 `git add . && git commit -m "auto: heartbeat $(date +%Y-%m-%dT%H%M%SZ)"`**（不询问）
- 禁止回复"是否需要我执行 git commit"这类询问

## 输出规则
- 无事：`HEARTBEAT_OK`
- 有事：直接输出结论和建议动作，不写内部思考过程，不询问

## 禁止行为
- 禁止在 heartbeat 会话中询问用户是否执行操作
- 禁止在 heartbeat 会话中执行高风险操作（删除、外部发送、资金相关）
- 禁止长篇输出，最多 3 句话
