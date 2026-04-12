# 全量扫描报告 [2026-04-12 13:45 CST]

## GitHub Issues（方向1）
- 发现了 9 个近 2 小时内更新的候选，最重要的是 #65193。
- 重点新候选：
  - [#65193](https://github.com/openclaw/openclaw/issues/65193) Cron 持久化状态缺字段，运行时直接因为 `runningAtMs` 崩溃，属于直接打断任务执行的 regression。
  - [#65191](https://github.com/openclaw/openclaw/issues/65191) 插件初始化先于 config 加载，导致 weixin / memory-lancedb-pro 启动期误报和配置未生效。
  - [#65184](https://github.com/openclaw/openclaw/issues/65184) `openclaw gateway install` 在 migrated root + `systemd --user` 场景下误报 unit file 不存在，升级恢复链路有 race。
  - 次级但值得盯：[#65182](https://github.com/openclaw/openclaw/issues/65182) Control UI 泄露 `<final>` 标签，[#65183](https://github.com/openclaw/openclaw/issues/65183) bundled webhooks async register 契约不一致。

## 插件仓库（方向2）
- 无。
- `Tencent/openclaw-weixin` 近 2 小时公开 issue / PR 未出现新候选；代码仍不可见。

## 贡献者文件区域（方向3）
- 扫描了排名最末的 10 个 contributors，覆盖约 119 个最近活跃文件区域。
- 发现 1 个值得继续 action 的高相关 open bug：
  - contributor-area: `src/auto-reply/reply/agent-runner-memory*` / `src/agents/pi-embedded-runner/compact*` ↔ [#55679](https://github.com/openclaw/openclaw/issues/55679) `memoryFlush` 永不触发。
- 本轮最相关的文件区：
  - `lml2468`: `src/gateway/control-plane-rate-limit*`, `src/gateway/server-maintenance.ts`, `src/gateway/server-methods/nodes.ts`
  - `davidrudduck`: `src/agents/pi-embedded-runner/compact*`, `src/auto-reply/reply/agent-runner-memory.ts`
  - `BruceMacD`: `extensions/ollama/*`
  - `Whoaa512`: `src/security/external-content.ts`, `src/gateway/session-utils*`

## 追踪 PR 反馈（方向4）
- 已追踪 PR 本轮无 maintainer 新评论。
- 状态变化：
  - [#64657](https://github.com/openclaw/openclaw/pull/64657) 作者新增说明，明确该 PR 与 #54840 是互补关系，不是重复修复。
  - [#65021](https://github.com/openclaw/openclaw/pull/65021) 继续有自动 review / author push，仍活跃。
  - [#65016](https://github.com/openclaw/openclaw/pull/65016) 仍 open。
  - [#64681](https://github.com/openclaw/openclaw/pull/64681) 仍 open，更新时间未进入本轮关键变化。
  - [#65144](https://github.com/openclaw/openclaw/pull/65144) / [#65146](https://github.com/openclaw/openclaw/pull/65146) 仍为 closed。

## 结论
最高优先级是 [#65193](https://github.com/openclaw/openclaw/issues/65193)，因为它会直接把 cron 任务打崩，影响持续执行链路。
建议顺序：先看 #65193，其次 #65191，再看 #65184。