const fs=require('fs');
const {execSync}=require('child_process');
function get(url){return JSON.parse(execSync(`curl -sL ${JSON.stringify(url)}`,{encoding:'utf8',maxBuffer:20*1024*1024}));}
const issues=get('https://api.github.com/repos/openclaw/openclaw/issues?state=open&sort=updated&direction=desc&per_page=40').filter(x=>!x.pull_request);
const prs=get('https://api.github.com/repos/openclaw/openclaw/pulls?state=open&sort=updated&direction=desc&per_page=15');
const closed=get('https://api.github.com/repos/openclaw/openclaw/pulls?state=closed&sort=updated&direction=desc&per_page=20');
const issueOut=[];
for(const it of issues.slice(0,15)){
  let comments=[];
  if(it.comments>0){ try{ comments=get(it.comments_url+'?per_page=10&sort=created&direction=desc'); }catch(e){} }
  issueOut.push({
    number: it.number, title: it.title, html_url: it.html_url, updated_at: it.updated_at, created_at: it.created_at,
    comments: it.comments, labels: it.labels.map(l=>l.name), author: it.user.login,
    body: (it.body||'').slice(0,500),
    recent_comments: comments.slice(0,5).map(c=>({user:c.user.login, association:c.author_association, created_at:c.created_at, body:(c.body||'').replace(/\s+/g,' ').slice(0,300)}))
  });
}
const prOut=[];
for(const pr of prs.slice(0,10)){
  let reviews=[], icomments=[], comments=[], full=pr;
  try{reviews=get(`https://api.github.com/repos/openclaw/openclaw/pulls/${pr.number}/reviews?per_page=10`);}catch(e){}
  try{icomments=get(`https://api.github.com/repos/openclaw/openclaw/pulls/${pr.number}/comments?per_page=10`);}catch(e){}
  try{comments=get(`https://api.github.com/repos/openclaw/openclaw/issues/${pr.number}/comments?per_page=10`);}catch(e){}
  try{full=get(`https://api.github.com/repos/openclaw/openclaw/pulls/${pr.number}`);}catch(e){}
  prOut.push({
    number: pr.number, title: pr.title, html_url: pr.html_url, updated_at: pr.updated_at, created_at: pr.created_at,
    user: pr.user.login, draft: pr.draft, state: pr.state, mergeable_state: full.mergeable_state,
    head: pr.head.ref, base: pr.base.ref, body:(pr.body||'').slice(0,500),
    reviews: reviews.slice(-6).map(r=>({user:r.user.login, association:r.author_association, state:r.state, submitted_at:r.submitted_at, body:(r.body||'').replace(/\s+/g,' ').slice(0,220)})),
    inline_comments: icomments.slice(-6).map(c=>({user:c.user.login, association:c.author_association, path:c.path, line:c.line, created_at:c.created_at, body:(c.body||'').replace(/\s+/g,' ').slice(0,220)})),
    issue_comments: comments.slice(-6).map(c=>({user:c.user.login, association:c.author_association, created_at:c.created_at, body:(c.body||'').replace(/\s+/g,' ').slice(0,220)}))
  });
}
const closedOut=closed.slice(0,12).map(pr=>({number:pr.number,title:pr.title,html_url:pr.html_url,updated_at:pr.updated_at,merged_at:pr.merged_at,closed_at:pr.closed_at,user:pr.user.login,head:pr.head.ref}));
fs.writeFileSync('/tmp/openclaw-scan.json', JSON.stringify({issues:issueOut, prs:prOut, closed:closedOut},null,2));
console.log('wrote /tmp/openclaw-scan.json');
