# HEARTBEAT.md

## 目标
只做低打扰、高价值的周期检查；没新情况就返回 `HEARTBEAT_OK`。

## 检查顺序
每次 heartbeat 最多做 1-2 项，避免无意义刷屏：

1. 看 `memory/heartbeat-state.json`
2. 优先检查距离上次最久、且最有价值的项目：
   - calendar
   - email
   - mentions
   - weather
3. 如果没有可检查项、或不适合打扰，就直接 `HEARTBEAT_OK`

## 主动提醒条件
只在下面情况主动发消息：
- 未来 2 小时内有日程
- 收到明显重要/紧急的新消息
- 距离上次主动汇报已超过 8 小时，且确实有新信息
- 发现需要尽快处理的异常

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
5. 写入文件（**直接执行，不询问**）

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
