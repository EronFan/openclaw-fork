const d=require('/tmp/openclaw-scan.json');
for (const pr of d.prs) {
  const human = [];
  for (const r of pr.reviews||[]) if (!r.user.includes('[bot]')) human.push({kind:'review',...r});
  for (const c of pr.inline_comments||[]) if (!c.user.includes('[bot]')) human.push({kind:'inline',...c});
  for (const c of pr.issue_comments||[]) if (!c.user.includes('[bot]')) human.push({kind:'issue',...c});
  if (human.length) {
    console.log(`\nPR #${pr.number} ${pr.title}`);
    console.log(`updated ${pr.updated_at} mergeable=${pr.mergeable_state} draft=${pr.draft}`);
    for (const h of human) console.log(`- ${h.kind} ${h.user} ${h.association||''} ${h.state||''} ${h.submitted_at||h.created_at||''} ${(h.body||'').replace(/\s+/g,' ').slice(0,260)}`);
  }
}
