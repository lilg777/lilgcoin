# LGX Daily Faucet — deploy guide

Old-school daily faucet for LiLGcoin (LGX) on BNB Smart Chain. The contract
holds donated LGX and pays a fixed amount to any wallet once a day, until the
pool runs out. Fully automatic once deployed — nobody gets forgotten.

## Why a fixed daily amount (not game scores)

The Earn LGX game runs in the browser, so its scores live in the player's own
phone storage. A contract cannot trust that — anyone could edit their balance
and drain the pool. The faucet pays a fixed daily amount instead, capped at
one claim per wallet per day.

## Numbers (verified on-chain)

- LGX token: `0xbec041bc90cae81596df063c3eee4e858fc3903d`
- **LGX has 16 decimals** (not 18 — verified via `decimals()` and
  `totalSupply()` on BSC). 1 LGX = 10^16 base units.
- Suggested starting numbers (owner can change both later):
  - **Seed the pool: 100,000 LGX** (~$43.60 at $0.000436/LGX)
  - **Daily claim: 500 LGX** (~$0.22) — set high enough to beat BSC gas.
    A claim costs a few cents of gas, so a 25 LGX claim (~$0.01) would cost
    more to claim than it is worth. 100,000 LGX funds 200 daily claims.
- Cooldown: 86400 seconds (1 day).

## Deploy (Remix, ~10 minutes)

1. Go to https://remix.ethereum.org — no install needed.
2. Create a new file, paste in `LGXDailyFaucet.sol`.
3. Compile: Solidity compiler tab, version **0.8.20** (or any 0.8.x).
4. Deploy: "Deploy & run transactions" tab.
   - Environment: **Injected Provider — MetaMask** (connect the wallet that
     will own the faucet; switch MetaMask to **BNB Smart Chain**, chain 56).
   - Constructor arguments:
     - `_lgx`: `0xbec041bc90cae81596df063c3eee4e858fc3903d`
     - `_claimAmount`: `5000000000000000000` (500 LGX in base units)
     - `_cooldown`: `86400`
   - Click Deploy and confirm in MetaMask (costs a little BNB in gas).
5. **Fund it:** in MetaMask (or Trust Wallet), send LGX to the new contract
   address — e.g. 100,000 LGX. The contract can only pay out what it holds.
6. **Verify (recommended):** on BscScan, open the contract address →
   Contract → Verify and Publish, using the same compiler version and the
   flattened source. Lets everyone read the code.
7. **Tell Muse the contract address** — the Earn LGX page (`earn-lgx.html`)
   has a `FAUCET_ADDRESS` placeholder at the top of its script. Once it is
   filled in, the Claim button goes live.

## Owner controls (all on BscScan → Contract → Write, or in Remix)

- `setClaimAmount` — change the daily payout (base units, 16 decimals).
- `setCooldown` — change the wait between claims, in seconds.
- `setPaused` — pause/unpause claims.
- `withdraw` — take LGX back out of the faucet.
- `transferOwnership` — hand control to another wallet.

## Read-only checks (anyone, no wallet needed)

- `poolBalance()` — LGX left in the faucet.
- `nextClaimAt(address)` — when a wallet can claim again.
- `totalClaimed()` / `totalClaims()` — lifetime payouts.
