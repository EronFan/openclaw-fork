# 全量扫描报告 2026-04-13 16:38 CST / 08:38 UTC

## GitHub Issues（方向1）

**扫描范围**: 2026-04-13 06:38 UTC 后更新的 open issues/PRs
**本轮新发现**: 14 个 open issues，20 个 open PRs（大部分为已追踪 issue 的配套 PR）

### 最高优先级新候选

1. **#65810 🔥 S** — Fallbacks does not work. Connection errors (ECONNREFUSED, network offline) should trigger model fallback
   - bug+bug:behavior 双标签；网络错误（ECONNREFUSED）应触发 fallback 但未触发
   - 0评论，未认领；根因涉及 fallback chain 对网络错误的处理
   - **建议：aoao 接单**

2. **#65786 regression** — Feishu config invalid after upgrade to 4.11 (channels.feishu: invalid config)
   - bug+regression 双标签；与 #65177(feishu botName→name migration)同簇
   - `openclaw doctor --fix` 在 4.11 版本无法修复；centOS Stream 8 用户受影响
   - 0评论，未认领；**建议 aoao 接单**

3. **#65763 S** — Plugin-registered provider models return 'model not allowed'
   - 根因已给出：plugin-registered providers 在 `buildAllowedModelSet` 中不被识别
   - 与历史 issue #30152 同根；workaround 是用 alias
   - **建议：review #30152 相关修复后接单**

4. **#65782 M** — Memory indexing stalls when chunker splits emoji at surrogate-pair boundary
   - bug；根因+完整修复方案+live verification 数据齐全；与 #27753 同簇
   - 0评论，未认领；**建议 aoao 接单**（已给出精确修复路径）

5. **#65799 S** — Feishu WebSocket should not inherit ambient proxy env by default
   - bug+usability；给出精确代码位置（extensions/feishu/src/client.ts）
   - PR #65802 已同步 open（fix: disable ambient proxy inheritance for websocket by default）
   - **建议：review #65802 确认是否覆盖**

### 已确认有 PR 在修（可快速确认）
- #65782 → PR #65796 (fix(memory): prevent indexing stalls from emoji surrogate pair splits)
- #65799 → PR #65802 (fix(feishu): disable ambient proxy inheritance for websocket by default)
- #65760 → PR #65805 (fix(fallback): preserve original prompt in resolveFallbackRetryPrompt)
- #65768 → PR #65785 (fix(minimax): allow web_search to use MINIMAX_OAUTH_TOKEN)

### 方向1结论
本轮新 issue 质量较高，#65810/#65786/#65782 明确可修；#65799 已有配套 PR。最高优先级 **#65810**（网络错误 fallback 失效）和 **#65786**（feishu upgrade regression）。

---

## 插件仓库（方向2）

### Tencent/openclaw-weixin
- 仓库 issue/PR 无法抓取（exit code 1 或空）
- 继续追踪：#55994/#58738（weixin 代码不可见）

### 其他相关插件
- 无新增可公开访问的插件 issue

**结论：无新发现（方向2）**

---

## 贡献者文件区域（方向3）

### 扫描范围
最低贡献量 10 位 contributors（各 2 次贡献）：aaronveklabs, Aftabbs, AI-Reviewer-QS, AkashKobal, akoscz, al3mart, Alex-Alaniz, alexfilatov, Anandesh-Sharma, andreabadesso

### 发现
- 最低段 contributors 的最近 commit 无法通过 `gh api` 抓取（可能是 CONTRIBUTING 分支或已删除 fork）
- 无可关联的新 open bug

**结论：无新发现（方向3）**

---

## 追踪 PR 反馈（方向4）

### PR #65772（fix(cli): keep nodes list aligned with nodes status）
- 3 个新 review comments：
  - **greptile-apps**: 2 个 P2 问题（unauthorized fallback 范围过宽 + if/else 重复调用 node.list）
  - **chatgpt-codex-connector**: P2 无 major issues
  - **skainguyen1412**: 3 个 COMMENTED review
- **建议：关注 author 是否响应 greptile P2 feedback，接近可 merge 状态**

### 其他追踪 PR 状态
- PR #65805（preserve original prompt in fallback retry）刚 open，greptile 已 COMMENTED
- PR #65796（emoji surrogate pair split）刚 open，skeinguyen1412 已 COMMENTED
- PR #65778（preserve original prompt in fallback retry, same as #65805）刚 open

### 方向4结论
PR #65772 有实质性的 maintainer/copilot review feedback，接近 merge 窗口；其余新 PR 均处于早期 review 阶段。

---

## 结论

**最高优先级：**
1. **#65810** — 网络错误 fallback 失效（S 级，0评论未认领，建议 aoao 接单）
2. **#65786** — Feishu config upgrade regression（regression，与 #65177 同簇，建议 aoao 接单）
3. **#65782** — Memory indexing emoji surrogate stall（有完整根因分析+修复方案，建议 aoao 接单）

**建议：**
- aoao 优先处理 #65810（网络 fallback）和 #65786（feishu upgrade）
- #65782 有 PR #65796 在修，可 review 确认
- 方向2/方向3 本轮无新发现
- PR #65772 接近可 merge，关注 author 是否响应 greptile P2 feedback
