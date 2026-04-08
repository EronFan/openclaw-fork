# 4方向扫描报告 [2026-04-08 14:36 CST / 06:36 UTC]

## GitHub
发现了 **40+ 个新候选**（近2小时更新），全部来自 v2026.4.7/v2026.4.7-1 发布后的持续 regression 爆发，以及 v2026.4.5 的遗留 regression。

### 最高优先（不在已有PR覆盖范围内）

**#62980 S** — Node.js ESM loader on Windows receives 'c:' as protocol instead of 'file:'（bug:crash）
- 清晰可本地复现，Windows 用户直接崩溃
- 根因：ESM loader 路径解析问题
- **建议 aoao 接单（S，可本地验证）**

**#62967 S** — gpt-5-mini returns 400: reasoning_effort 'none' not supported (since v2026.4.5)
- GPT-5-mini reasoning_effort 参数 v2026.4.5 后报错 400
- 所有 GPT-5-mini 用户完全失效
- **建议 aoao 接单（S，参考 GPT-5.x max_tokens 处理模式）**

**#62976 S** — Doctor cannot recover from invalid third-party plugin config; gateway hard-fails to start
- Doctor 发现 invalid config 后无法恢复，直接 hard-fail
- 所有使用第三方插件的用户都会 gateway 无法启动
- **建议 aoao 调研 Doctor recovery 逻辑（S）**

**#62978 S** — Global install 2026.4.7-1 breaks Telegram plugin loading and leaves gateway in restart loop
- v2026.4.7-1 global install 触发 Telegram 插件加载失败
- gateway 进入 restart loop，生产环境严重影响
- **建议 aoao 调研 npm global install 插件加载路径（M）**

**#62981 S** — Session file locked when gateway times out and falls back to embedded runner
- 全新 issue（06:31 UTC），无 PR
- session file 锁导致 embedded runner 回退失败，超时恢复场景完全破坏
- **建议 aoao 调研 session file locking 机制（M）**

### 已有 PR 覆盖（勿重复接单）
- #62972（fix endless loop，PR #62972 已开）
- #62944（image timeout，PR #62979 已开）
- #62909（Control UI `process is not defined`，PR #62975 maintainer 已开）
- #62941/#62869（heartbeat session nesting，PR #62941 + #62885 已开）
- #62931（Matrix dm.policy migration，PR #62942 maintainer 已开）
- #62888/#62887（tools.deny 安全漏洞，已在追踪）

## InStreet
**无** — `instreet.coze.site/skill.md` 仍为 InStreet Agent Skill API 文档，非 OpenClaw 用户讨论区。

## Discord / GitHub Discussions
**无** — Discord invite 页面仅显示"Discord"标题，无法抓取频道内容；GitHub discussions 返回 404。

## 插件
**Tencent/openclaw-weixin #8（2026-04-08 06:19 UTC）**：微信机器人长时间无消息后 session 过期，无法自动恢复，需要手动重新扫码登录。
- ⚠️ 代码不可见，无法定位根因
- 建议关注但无法直接修

## 结论
**最高优先级：#62980**，原因：
1. bug:crash + bug:regression 双重标签，直接崩溃
2. Windows 可本地复现，无需特定环境
3. 根因明确（ESM loader 路径协议）
4. size S，1-2小时可定位修复

**次高：#62967**（GPT-5-mini reasoning_effort 400）和 **#62976**（Doctor recovery gap）

**建议 aoao 接单顺序：**
1. #62980（XS-S，Windows ESM crash）
2. #62967（S，GPT-5-mini regression）
3. #62976（S，Doctor recovery gap）
4. #62978（M，2026.4.7-1 Telegram restart loop）
