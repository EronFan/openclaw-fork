# 全量扫描报告 2026-04-15 06:20 CST (22:20 UTC)

## GitHub Issues（方向1）

**本轮发现 8 个新候选 issue，全部未认领（0 评论）：**

### 🔴 最高优先级（建议立即派出 fix）

1. **#66849** — `2026.4.14 upgrade makes existing conversations fail broadly after repeated active-memory pre-reply timeouts`
   - 标签：无（未被确认）
   - 严重性：S regression
   - 影响：升级后所有渠道（Feishu/Weixin）的多模型、多 surface 现有会话全面失败；回滚到 2026.4.12 恢复
   - 根因：active-memory pre-reply 路径反复超时；broad failure 影响所有现有用户
   - 行动：**派出 fix，根因在 active-memory pre-reply timeout path**

2. **#66822** — `memorySearch.remote.batch.concurrency = 1 has no effect — indexing floods Ollama with concurrent requests`
   - 标签：bug, bug:crash
   - 严重性：S（crash）
   - 影响：设 concurrency=1 后 OpenClaw 仍发 30+ 并发 embedding 请求 → SIGKILL 终止进程，0 chunks indexed
   - 根因：concurrency 配置被忽略；Ollama 被灌爆
   - 行动：**派出 fix**

3. **#66830** — `Compaction dead zone: reserveTokens vs reserveTokensFloor asymmetry`
   - 标签：bug, bug:behavior
   - 严重性：S
   - 影响：提升 reserveTokens 以提前触发 compaction 无效；长运行会话卡在 fallback 模型上
   - 根因：memoryFlush threshold 对 floor 而非实际 reserveTokens 计算
   - PR：同根因在 #66845？待确认
   - 行动：**派出 fix**

### 🟠 高优先级

4. **#66848** — `TypeError: Cannot read properties of undefined (reading 'trim')`
   - 标签：bug, bug:crash
   - 严重性：S（crash）
   - 影响：崩溃；同根因已在多个 PR 修过（#66653 等）
   - 行动：**派出 fix，参照 #66653 的 trim guard pattern**

5. **#66832** — `logs.tail likely fails to redact several credential formats`
   - 标签：bug, bug:behavior
   - 严重性：S（安全）
   - 影响：JWT、X-OpenClaw-Token、x-pomerium-jwt-assertion、Basic auth 等格式可能通过 logs.tail 泄漏给 operator.read 客户端
   - 根因：正则 redaction 只覆盖部分格式
   - 行动：**派出 fix**

6. **#66839** — `macOS node does not advertise system.run.prepare, breaking exec host=node`
   - 标签：bug, bug:behavior
   - 严重性：S regression（2026.4.11）
   - 影响：macOS 节点 exec host=node 完全不可用
   - 根因：macOS node capability advertisement 缺少 system.run.prepare
   - 行动：**派出 fix**

7. **#66828** — `Cron lane remapped to Nested and subagent cleanup packaging regression in v2026.4.12`
   - 标签：无
   - 严重性：S regression
   - 影响：cron.maxConcurrentRuns 配置失效（lane 变成 concurrency 1）；subagent cleanup 失败
   - 行动：**派出 fix**

8. **#66813** — `webchat heartbeat with target "last" skips with no-target and blocks background execution`
   - 标签：bug, bug:behavior
   - 严重性：S
   - 影响：webchat 直接会话的 background execution 被心跳 skip 阻塞
   - 行动：**派出 fix**

### 已有 PR 覆盖无需重复追踪
- **#66833** (OpenRouter/Qwen3 reasoning_details) — **PR #66842 已开（bde1）**，同 issue
- **#66844** (ollama embedding provider) — PR 已开，方向1 GitHub
- **#66845** (memory flush dedup) — PR 已开

## 插件仓库（方向2）

**无 weixin 公开 issue。** openclaw org 下公开 repo 扫描结果：
- `openclaw/caclawphony`, `openclaw/casa`, `openclaw/clawdinators`, `openclaw/clawhub`, `openclaw/docs`, `openclaw/flawd-bot`, `openclaw/hermit`, `openclaw/homebrew-tap`, `openclaw/lobster`, `openclaw/openclaw-windows-node`, `openclaw/skills`, `openclaw/trust` 等
- 无相关 channel plugin issue 发现；大部分是工具/配置类 repo
- **结论：无**

## 贡献者文件区域（方向3）

末段 10 位 contributors（huntharo/mcaxtr/bmendonca3/onutc/jalehman/eleqtrizit/osolmaz/Glucksberg/altaywtf/quotentiroler）commit 文件 API 未返回数据（可能为 0 commit 或权限限制）。

**结论：无新文件区发现问题**（可能是 API 限速或空 contributor）

## 追踪 PR 反馈（方向4）

### 有 maintainer 新评论/PR 的活跃项

| PR | 作者 | 最新状态 |
|----|------|---------|
| #66847 | wkeything | fix(security): guard instruction file writes — **安全修复** |
| #66842 | bde1 | fix(agents): handle OpenRouter reasoning_details — **覆盖 #66833 同根因** |
| #66844 | wkeything | fix(memory): recognize ollama as valid embedding provider — 覆盖 #66841 |
| #66845 | wkeything | fix(memory): handle zero-initialization in flush compaction dedup |
| #66846 | wkeything | feat(memory): add model override for memoryFlush |
| #66788 | RLTree | memory-wiki: fix native relative report links |
| #66838 | rmfalco89 | fix(heartbeat): cron event wrapper neutral |
| #66780 | xudaiyanzi | fix(ui): retry chat.history during gateway startup |
| #66562 | oraculoos | fix(reply): keep implicit threading |

### 维持追踪的已有 PR
- **#66626** (#66697) config.get 密钥泄漏 — 待 merge
- **#66657** (#66698) Feishu TypeError — 待 merge
- **#66601** (#66680) lossless-claw context engine — 待 merge
- **#66669** (#66703) Control UI 图片附件不渲染 — 待 merge
- **#66668** (#66704) plugins uninstall 文件残留 — 待 merge

## 结论

**最高优先级：**
1. **#66849** active-memory pre-reply timeout → broad conversation failure（影响最广，回滚率最高）
2. **#66822** memorySearch concurrency=1 配置失效导致 SIGKILL（crash，清晰可复现）
3. **#66847** security guard instruction file writes（安全修复，PR 已开，需 maintainer review）
4. **#66830** compaction dead zone（长运行会话稳定性，影响大）
5. **#66832** logs.tail credential redaction（安全，5 类格式未覆盖）

**建议：**
- 派出 5 个 subagent 分别接 #66849/#66822/#66830/#66832/#66848
- PR #66847（security guard）和 #66842（OpenRouter/Qwen3）已开，需跟进 review 状态
