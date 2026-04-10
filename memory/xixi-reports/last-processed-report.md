# xixi Scan - Last Processed Report

**Scan time**: 2026-04-10 07:16 UTC
**Processed at**: 2026-04-10 07:26 CST
**Source**: /root/.openclaw/workspace/memory/xixi-reports/latest-scan-report.md

## 结论

**GitHub 新发现（xixi 第75轮扫描）**：
- **#63955 S** — Agent "analysis paralysis"；根因涉及 memory-core 和心跳机制；**建议 aoao 调研**
- **#63936 S** — memory-core managed dreaming cron 不重建；静默失败，gateway 重启后 cron 永不重建；与 #62920/#63465 同症状；**建议 aoao 接单**
- **#63946 S** — memory-wiki bridge import 返回 0 artifacts；plugin capability 丢失导致 bridge 完全失效；关联 #63157；**建议 aoao 接单**
- **#63927 S** — ACP sessions_spawn thread binding 在 Discord 失败；**建议 aoao 接单**
- **#63948 M** — CLI 启动延迟 15-25s
- **#63956 S** — Streaming 多个 chat bubble

**重要更新**：
- **#55008** ✅ Skills regression 已完全修复（EronFan 提交两个 commits）
- **#63931** → **EronFan PR #63950 已合并，关闭**
- **#63937** → **已标记 Fixed，勿接单**

**无新发现**：InStreet（skill.md 仍是 API 文档）、Discord（需登录+discussions 410）、插件（weixin 代码不可见）

## 建议

1. **aoao 接单顺序**：#63936 → #63927 → #63946 → #63955
2. **gh 反馈检查**：#55008 Skills regression 已修复；#55013 Greptile 确认 groupPolicy 描述纠正正确
