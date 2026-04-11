#!/bin/bash
# OpenClaw 贡献者区域扫描脚本
# 每小时扫描 top contributors 活跃的文件区域，寻找遗漏的 bug
# 策略：找出高贡献者最近改过的文件，扫这些文件中是否有未修复的问题

cd /root/.openclaw/workspace

TIMESTAMP=$(date +"%Y-%m-%d %H:%M")
TOKEN=$(gh auth token 2>/dev/null)
REPO="openclaw/openclaw"

# 获取 top 10 contributors（排除 EronFan 自己）
TOP_CONTRIBUTORS=$(gh api repos/openclaw/openclaw/contributors --paginate --jq '
  .[0:10] | .[] | select(.login != "EronFan") | .login
' 2>/dev/null)

echo "[$TIMESTAMP] 贡献者区域扫描开始" >> memory/contributor-scan-log.txt
echo "  扫描贡献者: $TOP_CONTRIBUTORS" >> memory/contributor-scan-log.txt

# 对每个 top contributor，取最近 20 条 commit，收集改过的文件
echo "$TOP_CONTRIBUTORS" | while read contributor; do
    if [ -z "$contributor" ]; then continue; fi
    
    FILES=$(gh api "repos/$REPO/commits?author=$contributor&per_page=20" --jq '
      [.[] | .files[]? | .filename] | unique[] | select(. != null)
    ' 2>/dev/null)
    
    echo "  $contributor 活跃文件数: $(echo "$FILES" | grep -c '/' || echo 0)" >> memory/contributor-scan-log.txt
    
    # 对每个文件，搜相关 open bug
    echo "$FILES" | while read file; do
        if [ -z "$file" ]; then continue; fi
        
        # 搜这个文件相关的未关闭 bug
        BUGS=$(gh issue list --repo openclaw/openclaw --state open --label bug --limit 5 --json number,title --jq "
          .[] | select(.title | contains(\"$file\") or contains(\"$(basename $file)\")) | {number, title}
        " 2>/dev/null)
        
        if [ -n "$BUGS" ]; then
            echo "  === 文件 $file 相关未关闭 Bug ===" >> memory/contributor-scan-log.txt
            echo "$BUGS" >> memory/contributor-scan-log.txt
        fi
    done
done

# 输出结构化摘要
python3 -c "
import subprocess, json

# 统计这次扫描发现了多少文件区域和候选 bug
log = open('/root/.openclaw/workspace/memory/contributor-scan-log.txt').readlines()
scan_start = [i for i,l in enumerate(log) if '$TIMESTAMP' in l]
if scan_start:
    recent = log[scan_start[0]:]
    file_areas = sum(1 for l in recent if '活跃文件数' in l)
    bug_references = sum(1 for l in recent if '相关未关闭 Bug' in l)
    print(f'CONTRIBUTOR_SCAN:{file_areas} areas|{bug_references} bug refs')
" 2>/dev/null

exit 0
