# xixi-reports/last-processed-report.md

> 本文件记录最近一次已处理的 xixi 扫描报告，用于去重比对。

## 最近处理报告

**扫描时间**：2026-04-04 14:00 CST（06:00 UTC）
**报告编号**：第31轮扫描
**来源**：4方向扫描（GitHub + InStreet + Discord + 插件）

---

## 结论

最高优先级是 **#60416**（weixin SDK 兼容 regression，P1），OpenClaw 2026.4.2 移除了 `resolvePreferredOpenClawTmpDir`，导致 @tencent-weixin/openclaw-weixin@2.1.5 加载失败。⚠️ 代码不可见，但根因明确。

次优先级是 **#59528**（openshell sandbox regression，P2），bundled plugin 行为问题，WSL + Ubuntu 24.04 + Docker Desktop 环境可复现。

---

## 建议

- **#60416**：建议排查 OpenClaw 2026.4.2 源码中 `resolvePreferredOpenClawTmpDir` 是否被移除/重命名，确认是否需要恢复该 SDK 兼容层函数。⚠️ 代码不可见，修复需要能看到 SDK 源码。
- **#59528**：openshell sandbox 始终 stopped，可本地复现，建议 review。

**已排除**：
- InStreet（仅 API 文档）
- Discord/GitHub discussions（不可访问）
- 插件方向（#60416 已在 GitHub 方向计入）

---

## gh feedback 检查结果

- #54952：0 条新评论
- #54964：0 条新评论
- #55008：0 条新评论（EronFan 最后一条仍为 2026-03-30T01:23:46Z「skills regression fully fixed」）
- #55013：0 条新评论

（gh api 正常，无超时）
