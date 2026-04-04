#!/bin/bash
# OpenClaw 社区机会扫描脚本
# 每 3 小时扫描过去 6 小时的新 PR/issue，识别高优先级候选并支持
# 由 main agent 调用，写入 memory 日志

cd /root/.openclaw/workspace

TIMESTAMP=$(date +"%Y-%m-%d %H:%M")
TOKEN=$(gh auth token 2>/dev/null)
REPO="openclaw/openclaw"

# 计算 6 小时前的时间戳（GitHub ISO8601 格式）
SIX_HOURS_AGO=$(date -d '6 hours ago' -u +"%Y-%m-%dT%H:%M:%SZ")

# --- 扫描新 PR（过去 6 小时内更新，open 状态） ---
PRS=$(curl -s -H "Authorization: Bearer $TOKEN" \
  "https://api.github.com/repos/$REPO/pulls?state=open&sort=updated&direction=desc&per_page=30" | \
  python3 -c "
import json,sys
from datetime import datetime
cutoff = datetime.fromisoformat('$SIX_HOURS_AGO'.replace('Z','+00:00'))
data = json.load(sys.stdin)
results = []
for p in data:
    updated = datetime.fromisoformat(p['updated_at'].replace('Z','+00:00'))
    if updated > cutoff:
        labels = [l['name'] for l in p.get('labels',[])]
        comments = p.get('comments', 0)
        reviews = p.get('review_comments', 0)
        results.append({
            'number': p['number'],
            'title': p['title'][:70],
            'user': p['user']['login'],
            'labels': labels,
            'comments': comments,
            'reviews': reviews,
            'size': next((l for l in labels if l.startswith('size:')), 'size:?')
        })
print(json.dumps(results))
")

# --- 扫描新 issue（过去 6 小时内创建，open 状态，无 PR） ---
ISSUES=$(curl -s -H "Authorization: Bearer $TOKEN" \
  "https://api.github.com/repos/$REPO/issues?state=open&sort=updated&direction=desc&per_page=30" | \
  python3 -c "
import json,sys
from datetime import datetime
cutoff = datetime.fromisoformat('$SIX_HOURS_AGO'.replace('Z','+00:00'))
data = json.load(sys.stdin)
results = []
for i in data:
    if i.get('pull_request'): continue  # 跳过 PR
    updated = datetime.fromisoformat(i['updated_at'].replace('Z','+00:00'))
    if updated > cutoff:
        labels = [l['name'] for l in i.get('labels',[])]
        comments = i.get('comments', 0)
        results.append({
            'number': i['number'],
            'title': i['title'][:70],
            'user': i['user']['login'],
            'labels': labels,
            'comments': comments,
            'has_bug': any('bug' in l for l in labels),
            'has_regression': any('regression' in l for l in labels),
            'has_security': any('security' in l for l in labels)
        })
print(json.dumps(results))
")

# --- 解析结果 ---
echo "[$TIMESTAMP] 社区扫描开始" >> memory/openclaw-scan-log.txt
echo "  新 PR 数: $(echo $PRS | python3 -c 'import json,sys; print(len(json.load(sys.stdin)) if sys.stdin.read().strip() else 0)' 2>/dev/null || echo 0)" >> memory/openclaw-scan-log.txt
echo "  新 Issue 数: $(echo $ISSUES | python3 -c 'import json,sys; print(len(json.load(sys.stdin)) if sys.stdin.read().strip() else 0)' 2>/dev/null || echo 0)" >> memory/openclaw-scan-log.txt

# --- 输出结构化结果供 main agent 使用 ---
python3 -c "
import json, sys

prs = json.loads('$PRS') if '$PRS'.strip() else []
issues = json.loads('$ISSUES') if '$ISSUES'.strip() else []

# 优先看：XS/S size + 无 review + bug/regression/security 标签
high_priority_prs = [p for p in prs if p['comments'] == 0 and p['reviews'] == 0 and 
                     any(l in ['bug','regression','security'] for l in p['labels'])]

print(f'SCAN_RESULTS:{len(prs)}|{len(issues)}|{len(high_priority_prs)}')
" 2>/dev/null

exit 0
