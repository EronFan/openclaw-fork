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

## 记账规则
每次 heartbeat 完成后，更新 `memory/heartbeat-state.json`：
- 对应检查项的时间戳
- `updatedAt`
- 如果有主动提醒，再更新 `lastProactiveReachoutAt`

## 顺手可做的事
如果不需要主动提醒，可以低成本做这些：
- 整理当天 `memory/YYYY-MM-DD.md`
- 从最近 daily notes 提炼长期记忆到 `MEMORY.md`
- 检查 workspace 是否有未提交改动

## 输出规则
- 无事：`HEARTBEAT_OK`
- 有事：直接输出结论和建议动作，不写内部思考过程
