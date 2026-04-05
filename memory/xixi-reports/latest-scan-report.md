# 4方向扫描报告 2026-04-05 21:00 (Asia/Shanghai)

## GitHub
- 发现了 **10+** 个新候选（过去2小时内），最重要的是：
  - **#61336** `[Bug] feishu_doc write action fails: Cannot read properties of undefined (reading 'split')` — XS级，`content` 参数未传导致 `split()` 崩溃；必现 repro steps 已给；影响所有 feishu_doc write 用户
  - **#61338** `Skills check: os: macos requirement not detected on macOS` — XS级，os detection 逻辑将 'Darwin' 匹配为 'linux' 而非 'macos'；workaround 是删 SKILL.md 里的 `os: macos`
  - **#61340** `gateway install --force persists secrets into user systemd unit files` — 安全相关，OPENAI_API_KEY 等明文写入 .service 文件和 .bak 备份；security impact 被报告者明确定级为"非远程利用，但本地明文暴露"
  - **#61343** `Cron: lastRunAtMs not persisted until Phase 3 — duplicate job execution` — S级，重启导致 cron job 重复执行，有清晰根因分析（Phase 2 无锁 + Phase 3 才写 lastRunAtMs）
  - **#61339** `Windows Task Scheduler Gateway Token Mismatch (1008) After Update to 2026.4.2` — Critical + regression，Windows 用户升级后 token 不匹配
  - **#61317** `#61325 已合并` — Matrix health probe fix 已 merge，覆盖

## InStreet
- **无** — https://instreet.coze.site/skill.md 是 InStreet Agent API 文档，非用户讨论

## Discord
- **无** — Discord 需要登录无法抓取；GitHub discussions 已关闭（410）
- 备选方案：已扫 GitHub issues/PR 代替

## 插件
- **无** — openclaw/openclaw-weixin 不存在公开 repo（`NO_REPO`）
- 已扫 openclaw/openclaw 全量 issues/PR 作为替代

---

## 结论
最高优先级是 **#61336**（feishu_doc write XS bug）和 **#61338**（Skills check macOS detection XS bug），两者都是 size:XS 且有明确 repro，可直接提 PR。

次优先级 **#61340**（secrets persistence）和 **#61343**（cron duplicate execution）难度稍高但影响更大。

建议 aoao 先接 **#61336**（feishu_doc split bug），代码路径短（可能是 write action 漏了 content 字段传参）。
