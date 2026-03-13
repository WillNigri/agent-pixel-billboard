# Chain & Payment Research: Agent Pixel Billboard

**Last Updated:** March 2026  
**Purpose:** Determine optimal blockchain and payment token for AI agent advertising platform

---

## 1. How AI Agents Pay On-Chain Today

### Agent Frameworks & Their Tokens

| Framework | Chain(s) | Payment Token | Notes |
|-----------|----------|----------------|-------|
| **Coinbase AgentKit** | Base, Ethereum, Polygon | USDC | Wallet-agnostic, framework-agnostic SDK |
| **Virtuals Protocol** | Base | VIRTUAL | Agent tokenization, per-inference payments |
| **Fetch.ai** | Cosmos | FET | Native token for staking, payments, gas; launched Visa payments for agents (Jan 2026) |
| **Autonolas (Olas)** | Multi-chain | OLAS | Marketplace with fees, agent services |
| **Solana Agent Kit** | Solana | SOL, USDC | Via Jupiter swaps |
| **Crossmint** | Solana + EVMs | USDC | Agent wallets, virtual cards |
| **Privy** | Multiple | Flexible | Agent wallet infrastructure with TEEs |

### Key Agent Wallet SDKs

- **Coinbase AgentKit** — https://github.com/coinbase/agentkit
  - Integrates with Privy and viem
  - Supports OpenAI Agents SDK, LangChain, Vercel AI SDK
  - USDC payments via CDP

- **Privy Agentic Wallets** — https://docs.privy.io/recipes/agent-integrations/agentic-wallets
  - TEEs + key sharding for security
  - Policy controls for autonomous transactions

- **Crossmint Agentic Payments** — https://www.crossmint.com/solutions/ai-agents
  - Agent wallets, virtual cards, stablecoin infrastructure

- **Circle x402** — https://www.circle.com/blog/autonomous-payments-using-circle-wallets-usdc-and-x402
  - Developer-controlled wallets + USDC
  - x402 protocol for autonomous HTTP payments

- **Solana agentwallet-sdk** — https://dev.to/up2itnow0822/agentwallet-sdk-v300-solana-wallets-jupiter-swaps-and-a-17-chain-cctp-v2-bridge-46np
  - Daily spend caps for security
  - Jupiter swaps built-in

---

## 2. Blockchain Comparison for Agent Payments

| Chain | Agent SDKs | USDC Support | Tx Cost | Speed | Dev Tools |
|-------|------------|--------------|---------|-------|-----------|
| **Base** | AgentKit, x402 (Stripe), Circle | Native | ~$0.01-0.05 | ~2 sec | Excellent (Coinbase-backed) |
| **Solana** | Solana Agent Kit, agentwallet-sdk | Via Jupiter | ~$0.001-0.01 | ~0.4-1 sec | Strong |
| **NEAR** | Native AI agents | Limited | ~$0.01 | ~1 sec | Good |
| **Polygon** | AgentKit | Yes | ~$0.01-0.05 | ~2 sec | Good |
| **Arbitrum** | AgentKit | Yes | ~$0.1-0.3 | ~1 min | Excellent |
| **Avalanche** | Emerging | Yes | ~$0.02-0.1 | ~1 sec | Good |

### Detailed Analysis

**Base (Coinbase L2) — RECOMMENDED**
- Native USDC support with Stripe x402 payments (Feb 2025)
- AgentKit directly supported by Coinbase
- Circle + x402 = autonomous payments infrastructure
- Alchemy USDC payment system for AI agents (Feb 2026)
- Low fees, fast finality
- Largest agent ecosystem momentum in 2025-2026

**Solana**
- Very fast, very cheap
- Multiple agent SDKs emerging
- Strong DeFi with Jupiter aggregator
- USDC available but requires swap
- Growing but less agent-specific infrastructure than Base

**NEAR**
- AI-native narrative
- Sub-second finality
- Less USDC liquidity than Base
- Developer-focused but smaller ecosystem

---

## 3. Payment Standard Recommendation

### Recommended: **USDC on Base**

**Rationale:**
1. **Widest Agent Compatibility** — Coinbase AgentKit, Circle, Stripe, and most emerging agent frameworks natively support USDC on Base
2. **x402 Protocol** — The emerging standard (Coinbase + Cloudflare) for autonomous HTTP payments works natively on Base
3. **Institutional Trust** — USDC = stable, regulated stablecoin
4. **No Token Volatility** — Both payer and payee avoid crypto price fluctuation
5. **Base Ecosystem Momentum** — All major agent players (Virtuals, AgentKit, Stripe) are betting on Base

### ERC-8004 + x402 Stack

- **ERC-8004** — Ethereum standard for AI agent identity/reputation (https://eips.ethereum.org/EIPS/eip-8004)
- **x402** — HTTP 402 "Payment Required" protocol for autonomous payments

When combined: agents can verify counterparty reputation (ERC-8004) and execute payments (x402) without central platform dependency.

### Alternative Options

| Token | Pros | Cons |
|-------|------|------|
| **USDC** | Stable, widely supported, institutional | Requires on/off ramp |
| **VIRTUAL** | Virtuals Protocol native | Only for Virtuals ecosystem |
| **FET** | Fetch.ai native | Less agent wallet infra |
| **Native (ETH/SOL)** | No stablecoin needed | Price volatility |

---

## 4. Competitor Analysis

### Existing "Agent Marketplace" Platforms

**No direct competitors found** for AI agent advertising/marketplace in 2025-2026.

### Related Platforms

| Platform | Type | Payment |
|----------|------|---------|
| **Virtuals Protocol** | Agent tokenization marketplace | VIRTUAL token |
| **Olas (Autonolas)** | Agent services marketplace | OLAS |
| **Blockchain-Ads** | Crypto ad network | BTC, PayPal |
| **Adshares** | Decentralized ad network | Native token |

### Key Insight

**Blue ocean opportunity** — There is no existing "agent advertising" or "agent services marketplace" with on-chain payments. The Agent Pixel Billboard concept is novel.

---

## 5. Implementation Recommendations

### For Agent Pixel Billboard

1. **Accept payments in USDC on Base**
   - Use Circle's developer-controlled wallets or Coinbase AgentKit
   - Implement x402 for automated micropayments (pay-per-pixel-view)

2. **Secondary options:**
   - USDC on Polygon (if Base proves difficult)
   - Accept VIRTUAL if partnering with Virtuals Protocol agents

3. **Avoid:**
   - Native tokens (volatility hurts both parties)
   - USDT (regulatory uncertainty, less agent support)
   - Niche chains with poor agent SDK coverage

### Technical Stack

```
Payments:     USDC via Circle Wallet SDK / AgentKit
Chain:        Base (primary), Polygon (fallback)
Protocol:     x402 for autonomous payments
Identity:     ERC-8004 for agent verification (optional future)
```

---

## Sources

- https://github.com/coinbase/agentkit
- https://www.circle.com/blog/autonomous-payments-using-circle-wallets-usdc-and-x402
- https://www.virtuals.io/
- https://www.fetch.ai/blog/agent-based-trading-tools-for-decentralized-exchanges
- https://olas.network/
- https://eips.ethereum.org/EIPS/eip-8004
- https://www.coingecko.com/learn/ai-agent-payment-infrastructure-crypto-and-big-tech
- https://cointelegraph.com/news/alchemy-ai-agents-pay-access-blockchain-data-usdc
- https://solana.com/ai
- https://docs.privy.io/recipes/agent-integrations/agentic-wallets
