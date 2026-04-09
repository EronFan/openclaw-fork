# 4方向扫描报告 2026-04-09 21:18 CST (13:18 UTC)

## GitHub
发现了 **11个新候选**（过去1小时更新），最重要：

### 🔴 #63742 exec工具`~`路径解析缺失 — **S级，最清晰候选**
- **与 read 工具行为不一致**：read 支持 `~`，exec 不支持
- **危险隐式回退**：无效 workdir 静默回退到 `~`，而非报错
- 有完整日志、对比数据、修复代码示例
- **难度 XS，核心是加 `os.expanduser(workdir)` + 改 warning 为 error**
- **建议 aoao 立即接单**

### 🔴 #63751 Bedrock auto-discovery 不受 `models.mode: replace` 抑制 — **S级**
- `models.mode: "replace"` 应该只显示配置的 provider，但 Bedrock auto-discovered models 仍出现
- regression（有 bug+regression 标签）
- 症状清晰：30+ Bedrock models 出现在 selector 中
- 根因：`models.mode: replace` 不覆盖 Bedrock auto-discovery 逻辑
- **难度 S，需找到 Bedrock auto-discovery 代码路径并尊重 mode=replace**

### 🟡 #63750 Orphan cleanup 误删 status=done 的正常 subagent session — **S级**
- 有完整根因分析+修复代码
- orphan cleanup 用 `status=done` 判断 orphan，但 done 也是正常终止状态
- 导致 runs.json 被清空、session 历史永久丢失
- **难度 S，逻辑修复很清晰**

### 🟡 #63740 dist/run-main-*.js 源代码损坏 — **S级 regression**
- shell 命令（tail）错误地拼接进了 JS 源文件
- **Critical**：CLI 完全无法启动，需手动修复 node_modules
- 根因疑似 crash recovery 或 log rotation 阶段的路径重定向 bug
- **难度 M，根因难定位但修复模式清晰**

### 🟡 #63736 Hang time — **需详情**
- 标题太简略，需要读详情判断

### 已在上一轮覆盖（12:18 UTC）本次仍活跃
- **#63732** — daily atHour reset 失效（regression，高优先级，contributor 已给根因）
- **#63727** — qa/scenarios scaffold 缺失（Critical，size XS，maintainer 已给修复方案）
- **#63729** — echoTranscript Telegram 静默失败（S）
- **#63730** — Crontab trigger 安全漏洞（S+Security）

## InStreet
- **无**：`https://instreet.coze.site/skill.md` 仍是 InStreet Agent API 文档，非用户讨论

## Discord
- **无法访问**：Discord invite 页面只显示 "Friends of the Crustacean 🦞🤝"，频道内容需登录
- GitHub discussions 仍返回 404

## 插件
### openclaw/openclaw-weixin（公共 issues）
- 本轮未抓到新的 weixin issues（repo 无 public issues 或需认证）
- 已有追踪项：#55994/#58738（代码不可见）
- **建议**：如果 main 需要，可以考虑在 openclaw 主仓库搜索 weixin 相关 open issue 作为代理

## 结论
**最高优先级：**
1. **#63742**（XS难度，清晰可本地复现，exec ~路径问题）
2. **#63751**（S级，Bedrock mode=replace regression，逻辑清晰）
3. **#63750**（S级，orphan cleanup 误删 session，修复明确）

**建议 main 派单给 aoao：**
- #63742 最适合作为第一个 XS 单，修复范围小、复现容易
- #63751 和 #63750 难度 S，可以并行调研代码位置后接单
