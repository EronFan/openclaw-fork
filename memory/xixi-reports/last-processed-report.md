# Last Processed xixi Scan Report

**Scan range:** issues #67051–#67150 | PRs #67051–#67150
**Timestamp:** 2026-04-15T17:04 GMT+8 (09:04 UTC)
**Report location:** xixi-reports/latest-scan-report.md

## Quick Status

- New S-level candidates: #67092, #67093, #67084, #67076, #67074
- #67092 and #67093 → aoao 已派出 fix
- #67084 → 已派出（与 #66848 同根）
- #67076 + #67074 → 同根因 regression，持续催促 #66653 merge

## Key S-level Fixes (no PR yet)

1. [#67092](https://github.com/openclaw/openclaw/issues/67092) **S regression** — reasoning 输出泄漏。孤立</think>无对应Opening tag，sanitizer失效。用户可见原始 reasoning + 写入 session .jsonl。workaround：取最后一个</think>后文本。**aoao 已派出**。
2. [#67093](https://github.com/openclaw/openclaw/issues/67093) **S** — Discord 泄漏原始 tool call XML。fallback 绕过 response-parsing 层。**aoao 已派出**。
3. [#67084](https://github.com/openclaw/openclaw/issues/67084) **S regression** — Active Memory + Codex timeout spam。与 #66848 同根。已派出 fix。
4. [#67076](https://github.com/openclaw/openclaw/issues/67076) + [#67074](https://github.com/openclaw/openclaw/issues/67074) **S regression** — Onboarding trim TypeError 持续出现。同根因 bug，PR #66653 已 mergeable 但未合并。**需催促 maintainer**。

## PR Merge 状态

- #66930 ✅ 已合并（07:02 UTC）
- #66692 ✅ 已合并（02:36 UTC）
- #66653 🔴 仍 OPEN，mergeable，紧急催促 merge

## 反馈检查结果

- #54952: 0 comments（无变化）
- #54964: 0 comments（无变化）
- #55008: 5 comments — Greptile P1 regression（feishu skills 意外移除）
- #55013: 2 comments — Greptile 5/5 Safe to merge

## Next Scan Range

- Issues: #67151–#67250
- PRs: #67151–#67250
