# 全量扫描报告 2026-04-15 02:20 CST (2026-04-14 18:20 UTC)

---

## GitHub Issues（方向1）

**发现 1 个新候选**：`#66695` — pre-commit hook assumes bare `pnpm` instead of Corepack-managed pnpm

**关键发现**：
- **#66695** (`pfrederiksen` 报告)：pre-commit hook 在 line 76 调用 bare `pnpm check`，Corepack 环境下失败（command not found）。repo 已声明 `packageManager: pnpm@10.32.1`，Corepack 激活可用，但 hook 硬编码了 `pnpm` 二进制名
- **PR #66696 已开**：`pfrederiksen` 自提交 fix，size XS，修改 `git-hooks/pre-commit` 和 `scripts/pre-commit/run-node-tool.sh`，支持 Corepack 激活场景；`scripts` + `size: XS` 标签；2 条评论待 review
- 根因极清晰（pre-commit 脚本 1-2 行即可修），**建议 review PR #66696**
- **已有覆盖项无重复**：#66669/#66668/#66657 的 EronFan PRs (#66703/#66704/#66725) 本轮 API 显示 state=closed (merged_at=null)，疑似被 repo 的 `r: too-many-prs` 自动关闭策略触发，需重新提 PR

---

## 插件仓库（方向2）

**无更新**。`Tencent/openclaw-weixin` 仓库不可公开访问（gh api 返回 404），`openclaw/openclaw-plugin/weixin` 同样返回 404。无新的公开插件 issue/PR 可追踪。

---

## 贡献者文件区域（方向3）

**扫描了排名最末 10 个 contributors（byungsker / pashpashpash / xinhuagu / MoerAI / aether-ai-agent / chinar-amrutkar / Whoaa512 / darkamenosa / BruceMacD / sliverp）**，每个取最近 5 条 commit 并过滤 `.ts/.tsx` 文件。

**结果**：所有 10 个末段贡献者近 5 条 commit 均无 `.ts/.tsx` 文件改动记录——这些人可能是早期一次性贡献者（贡献量 9-12 次），长期无活跃新 commit，或活动在文档/配置文件而非源码区。

**结论**：无相关 open bug 发现；文件区扫描无新候选。

---

## 追踪 PR 反馈（方向4）

**已追踪 PR 状态变化**：

| PR | 标题 | 状态 | 备注 |
|----|------|------|------|
| **#66696** | Support Corepack-managed pnpm in pre-commit tooling | **open, 2 comments** | size XS by pfrederiksen；maintainer 2 评论讨论；**review 机会** |
| **#66692** | fix(audio): restore allowPrivateNetwork for self-hosted STT (v2026.4.14 regression) | **open, 0 comments** | by jhsmith409；修复 #66691 regression；待 maintainer review |
| **#66689** | fix: allow workspace-rooted absolute media paths in auto-reply | **open, 1 assignee (gumadeiras)** | by joelnishanth；修复 #66635；size M；已 assign maintainer |
| **#66697/#66703/#66704/#66725** | EronFan 安全+Feishu+UI+uninstall fix PRs | **全部 state=closed, merged_at=null** | 本轮 API 确认全部 closed 而非 merged；疑似 `r: too-many-prs` 策略触发；需重新提 PR |

**EronFan PRs 重新提 PR 建议**：
- `#66703`（webchat 用户图片附件 — P60130）：需重新提 PR，maintainer 已 review (5 review_comments) 但被关闭
- `#66704`（plugins uninstall — P60131）：需重新提 PR，1 review_comment 但被关闭  
- `#66725`（feishu @mention trim — P60125）：需重新提 PR，1 review_comment 但被关闭

---

## 结论

**最高优先级**：
1. 🔴 **EronFan 3 个 PR 被关闭**（#66703/#66704/#66725），安全 bug（#66626）和 Feishu bug（#66657）修复丢失，需在低活跃期重新提 PR 推 merge
2. 🔴 **PR #66696 review**：size XS，根因清晰，maintainer 已参与讨论，快速 Approve 可立即 merge
3. 🟡 **PR #66692**（allowPrivateNetwork regression）：jhsmith409 修的 regression，可 review 确认
4. 🟡 **PR #66689**（WhatsApp media path）：已有 maintainer assign，继续追踪 merge 窗口

**建议**：
- aoao 接单方向：重新提 EronFan 的 3 个 PR（优先 #66626 config secret leak 安全修复）
- xixi 调研方向：无新发现，方向3末段贡献者无活跃源码文件

**inProgressFixes 更新**：
- P60130(#66669) PR #66703 closed → 需重新提
- P60131(#66668) PR #66704 closed → 需重新提
- P60125(#66657) PR #66725 closed → 需重新提
- P60120(#66626) PR #66697 closed → 安全修复，需重新提