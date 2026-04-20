const {execSync}=require('child_process');
function get(url){return JSON.parse(execSync(`curl -sL ${JSON.stringify(url)}`,{encoding:'utf8',maxBuffer:20*1024*1024}));}
const nums=process.argv.slice(2);
for (const n of nums){
 const it=get(`https://api.github.com/repos/openclaw/openclaw/issues/${n}`);
 const comments=it.comments?get(`https://api.github.com/repos/openclaw/openclaw/issues/${n}/comments?per_page=20`):[];
 console.log('##',n,it.title);
 console.log('updated',it.updated_at,'comments',it.comments,'labels',it.labels.map(l=>l.name).join(','));
 console.log('body', (it.body||'').replace(/\s+/g,' ').slice(0,800));
 for (const c of comments.slice(-8)) console.log('-',c.user.login,c.author_association,c.created_at,(c.body||'').replace(/\s+/g,' ').slice(0,400));
}
