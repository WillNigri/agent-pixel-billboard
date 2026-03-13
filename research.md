# Million Dollar Homepage Style Projects: Research Findings

This document compiles research on pixel-advertising and collaborative canvas projects for building an "agents-only" version.

---

## 1. The Original: MillionDollarHomepage.com (2005)

**What it was:**
- 1000×1000 pixel grid (1 million pixels)
- Sold in 10×10 blocks (100 pixels) for $1/pixel
- Minimum purchase: $100

**What made it work:**
- **Timing:** First-mover advantage in 2005 during Web 2.0 boom
- **Viral hooks:** $1M goal, media-friendly story (student paying for college)
- **Simplicity:** No account needed, instant purchase
- **Scarcity:** Limited inventory, countdown urgency
- **Word-of-mouth + press:** BBC, The Register, Digg coverage

**Final stats:**
- **Revenue:** $1,037,100 (gross)
- **Time:** ~5 months (Aug 2005 - Jan 2006)
- **Pixels sold:** ~999,000 (last 1,000 auctioned on eBay for $38,100)
- **Alexa rank:** Peaked at #127
- **Setup cost:** ~€50 (domain + hosting)

**Why it succeeded:**
- Novelty of pixel advertising
- Clear value proposition: own a piece of internet history
- Strong viral loop from press coverage

**Tech stack (estimated):** PHP, MySQL, basic HTML/images

---

## 2. Crypto/NFT Versions

### Million Dollar Homepage on Ethereum (2020)
- Rebuilt as ETH smart contract + DApp
- Pixels sold for ETH instead of dollars
- Claim: "ads on blockchain forever"
- **Outcome:** Curiosity project, not mainstream success

### NFT Pixel Project
- Community-designed NFT inspired by Million Dollar Homepage
- Goal: snapshot of blockchain/crypto adoption era
- **Outcome:** Niche, limited traction

### Million Dollar Billboard (Polygon)
- 1000×1000 grid on Polygon blockchain
- Purchases become Polygon NFTs
- Renting model (pixels are "rentable")
- **Outcome:** Developer demo, limited adoption

**Why crypto versions didn't take off:**
- Added complexity (wallet setup, gas fees)
- Lost the simplicity of the original
- 2005 novelty doesn't work in 2020+ saturated crypto space
- No clear advantage to being "on blockchain" for this use case

---

## 3. Modern Clones & Spiritual Successors

Most clones failed. Key insights:

- **First-mover matters:** Everyone who tried after 2005 was seen as a copycat
- **Timing is everything:** The original caught a cultural moment
- **No clone achieved significant traction** after 2005

**Exception:** Some small-scale versions exist as niche projects, but none reached viral status.

---

## 4. Reddit's r/place (2017, 2022, 2023)

**What it is:**
- Collaborative pixel canvas
- Users place 1 pixel at a time (cooldown: 5-20 min)
- 16-color palette (expanded to 32 in later versions)
- Canvas expanded from 1000×1000 (2017) to 3000×2000 (2023)

**What made it work:**
- **Community-driven:** Each subreddit claimed territory
- **Competition + cooperation:** Thousands of communities collaborating/competing
- **Time-limited:** Creates urgency and event-like engagement
- **Built-in audience:** Reddit's existing user base
- **April Fools' timing:** Leveraged Reddit's tradition of April Fools experiments

**Engagement stats:**
- **2017:** 1M+ users, 16M pixels placed, 90K+ concurrent viewers
- **2022:** Even larger, canvas expanded mid-event
- **2023:** 6M pixel canvas, 32 colors

**Key insight:** The value isn't the pixels—it's the community coordination and social dynamic.

**Tech stack:** Reddit custom-built (likely Node.js, Redis, real-time updates)

---

## 5. AI/Agent Pixel Projects

### Pixel Agents (pixelagents.net)
- **Concept:** Collaborative canvas where AI agents create art
- **Canvas:** 64×64 (4,096 pixels)
- **Rules:** 200 pixels/day per agent, no overwriting, daily reset
- **Built by:** Christoph Rumpel + AI assistant
- **API:** Agents can register and paint via API

**What makes it interesting:**
- First "agents-only" pixel canvas
- Simple API for bot registration
- Daily reset creates recurring engagement
- 64×64 is small enough for rapid experimentation

### Moltpixel (offline)
- Similar concept: AI agent collaborative canvas
- Had API for agent registration
- Currently offline

**Other related:**
- tldraw's "makereal" (2023) — vibe coding tool, not pixel-focused
- Various LLM collaboration experiments (academic papers)

---

## Key Takeaways for Building an "Agents-Only" Version

### What Worked:
1. **First-mover advantage** (original) or **unique twist** (r/place)
2. **Community/social dynamics** — it's not just about pixels, it's about coordination
3. **Simplicity** — easy to understand, easy to participate
4. **Scarcity/urgency** — limited space or time-limited events
5. **Built-in audience** — leverage existing platforms or communities

### What Failed:
1. **Clones without differentiation** — no one cares about copycats
2. **Adding unnecessary complexity** — crypto versions added friction, no benefit
3. **No community** — individual pixel buyers vs. coordinated groups

### Opportunities for Agents-Only:
1. **API-first design** — make it easy for agents to participate programmatically
2. **Agent coordination as feature** — bots collaborating/competing is the hook
3. **Theme/daily challenges** — like Pixel Agents' daily reset
4. **Observable behavior** — people will watch agents fight for territory
5. **Leaderboards/stats** — which model/team wins? who paints fastest?

### Potential Challenges:
1. **Bot detection** — need to verify participants are actually agents
2. **Spam/abuse** — automated systems can game anything
3. **Engagement** — need humans to watch (Twitch/YouTube potential?)
4. **Novelty decay** — what made r/place work was human emotion, not just pixels

---

## Summary Table

| Project | Year | Revenue/Traction | Key Innovation |
|---------|------|------------------|-----------------|
| MillionDollarHomepage.com | 2005 | $1.03M | First pixel ad marketplace |
| r/place | 2017-2023 | 1M+ users | Community collaboration |
| NFT Pixel Project | 2021 | Minimal | Blockchain immutability |
| Pixel Agents | 2024 | Small | Agents-only, API-first |
| Crypto ETH versions | 2020 | Minimal | Smart contracts |

---

*Research completed: March 2026*
