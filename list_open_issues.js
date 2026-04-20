const {execSync}=require('child_process');
const issues=JSON.parse(execSync("curl -sL 'https://api.github.com/repos/openclaw/openclaw/issues?state=open&sort=updated&direction=desc&per_page=100'",{encoding:'utf8',maxBuffer:20*1024*1024})).filter(x=>!x.pull_request);
for (const it of issues.slice(0,30)) {
  console.log(`${it.number}\t${it.updated_at}\tcomments=${it.comments}\t${it.title}`);
}
