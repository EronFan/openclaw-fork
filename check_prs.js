const {execSync}=require('child_process');
function get(n){return JSON.parse(execSync(`curl -sL -H 'Accept: application/vnd.github+json' https://api.github.com/repos/openclaw/openclaw/pulls/${n}`,{encoding:'utf8',maxBuffer:5*1024*1024}));}
for (const n of [67978,68334,68041,68848,68834,68846,68832,68829]) {
  const pr=get(n);
  console.log(JSON.stringify({n, state:pr.state, merged_at:pr.merged_at, title:pr.title, draft:pr.draft, html_url:pr.html_url}));
}
