# 🪙 LiLGcoin — Audit Notes & Security Reviews

This document records all known audits, reviews, and notable fixes for **LiLGcoin (LGX / ₲)**.  
Transparency and accountability are central to the project’s culture.

---

## 🔹 Format
Each entry should follow this structure:

- **Date:** YYYY-MM-DD  
- **Reviewer(s):** Name / Handle / Organization  
- **Scope:** What was tested or reviewed  
- **Findings:** Summary of vulnerabilities, risks, or concerns  
- **Resolution:** Actions taken, commits linked  
- **Status:** Fixed | Pending | Mitigated | Accepted Risk  

---

## 🔹 Audit Log

### 2021-05-25 — Ethereum Misdeployment
- **Reviewer(s):** LGXatoshi, Victor Bermudez  
- **Scope:** Initial ERC-20 deployment on Ethereum (accidental).  
- **Findings:** Incorrect chain deployment due to tutorial-follow error.  
- **Resolution:** Preserved as `contracts/eth_misdeploy/` for history. Transitioned to Testnet-first strategy.  
- **Status:** Closed (historical only).  

---

### 2021-06-10 — Testnet Alpha Review
- **Reviewer(s):** LGXatoshi, Victor Bermudez  
- **Scope:** Testnet deployment prior to BSC launch.  
- **Findings:** Minor allowance logic bugs; corrected in subsequent commits.  
- **Resolution:** Fixed prior to mainnet launch.  
- **Status:** Fixed.  

---

### 2021-10-30 — BSC Mainnet Launch Validation
- **Reviewer(s):** Core Dev Team  
- **Scope:** Production LGX contracts deployed on BSC.  
- **Findings:** No critical issues identified at launch.  
- **Resolution:** Contracts verified on BscScan. Liquidity added transparently.  
- **Status:** Verified & Active.  

---

### [Future Entry Placeholder]
- **Date:**  
- **Reviewer(s):**  
- **Scope:**  
- **Findings:**  
- **Resolution:**  
- **Status:**  

---

## 🔹 Notes
- This log is **not** a substitute for external audits.  
- Community is encouraged to review contracts and report responsibly.  
- All critical fixes will be cross-referenced in [SECURITY.md](SECURITY.md).  

---
