import json, subprocess, os
SINCE = subprocess.check_output(["date","-u","-d","2 hours ago","+%Y-%m-%dT%H:%M:%SZ"], text=True).strip()
out='/tmp/xixi-scan'
os.makedirs(out, exist_ok=True)
query='''query($q:String!,$after:String){search(query:$q,type:ISSUE,first:50,after:$after){pageInfo{hasNextPage endCursor} nodes{__typename ... on Issue {number title updatedAt url state author{login} labels(first:10){nodes{name}} comments{totalCount}} ... on PullRequest {number title updatedAt url state author{login} labels(first:10){nodes{name}} comments{totalCount}}}}}'''

def fetch(q):
    items=[]
    after=None
    while True:
        cmd=["gh","api","graphql","-f",f"query={query}","-F",f"q={q}"]
        if after:
            cmd += ["-F",f"after={after}"]
        data=json.loads(subprocess.check_output(cmd,text=True))["data"]["search"]
        items.extend(data["nodes"])
        if not data["pageInfo"]["hasNextPage"] or len(items)>=100:
            break
        after=data["pageInfo"]["endCursor"]
    return items
queries={
  'issues': f'repo:openclaw/openclaw is:issue is:open updated:>={SINCE} sort:updated-desc',
  'prs': f'repo:openclaw/openclaw is:pr is:open updated:>={SINCE} sort:updated-desc',
  'tencent_weixin': f'repo:Tencent/openclaw-weixin is:open updated:>={SINCE} sort:updated-desc',
  'openclaw_weixin': f'repo:openclaw/openclaw-weixin is:open updated:>={SINCE} sort:updated-desc',
}
for name,q in queries.items():
    try:
        items=fetch(q)
    except subprocess.CalledProcessError:
        items=[]
    with open(f'{out}/{name}.json','w') as f:
        json.dump(items, f)
print(SINCE)
