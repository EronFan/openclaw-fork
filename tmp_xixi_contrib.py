import json, subprocess, os, time
out='/tmp/xixi-scan'
with open(f'{out}/contributors.json') as f:
    contributors=json.load(f)
contributors=[c for c in contributors if c.get('login')!='EronFan']
bottom=sorted(contributors, key=lambda c:c.get('contributions',0))[:10]
result=[]
for c in bottom:
    login=c['login']
    try:
        commits=json.loads(subprocess.check_output(['gh','api',f'repos/openclaw/openclaw/commits?author={login}&per_page=20'],text=True))
    except subprocess.CalledProcessError:
        commits=[]
    files=[]
    seen=set()
    for commit in commits[:20]:
        sha=commit['sha']
        try:
            detail=json.loads(subprocess.check_output(['gh','api',f'repos/openclaw/openclaw/commits/{sha}'],text=True))
        except subprocess.CalledProcessError:
            continue
        for fobj in detail.get('files',[]):
            name=fobj.get('filename')
            if name and name not in seen:
                seen.add(name)
                files.append(name)
    result.append({'login':login,'contributions':c.get('contributions',0),'files':files[:100],'commitCount':len(commits)})
with open(f'{out}/bottom_contributors_files.json','w') as f:
    json.dump(result,f)
print(json.dumps(result, indent=2))
