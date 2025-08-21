# 🪙 LiLGcoin — Security Policy

Security and transparency are core to the mission of **LiLGcoin (LGX / ₲)**.  
This document defines verification, audit, and responsible disclosure practices for the project.

---

## 🔹 Contract Verification
- All deployed contracts are verified on **BscScan** for public transparency.  
- Verified source code must exactly match the bytecode deployed on-chain.  
- Historical deployments (including the **May 25, 2021 Ethereum misdeployment**) are preserved in this repo under `contracts/eth_misdeploy/` for historical accuracy.  

---

## 🔹 Code Audits
- Internal reviews are performed by core developers prior to release.  
- External audits may be commissioned as resources allow.  
- Security notes and fixes are logged in `docs/AUDIT_NOTES.md`.  

---

## 🔹 Responsible Disclosure
If you discover a vulnerability in LiLGcoin contracts or infrastructure:

1. **Do not exploit** the issue or disclose it publicly.  
2. Email the security contact: **security@lilgcoin.org**  
3. Provide a detailed description, including steps to reproduce.  
4. Allow the development team reasonable time to investigate and patch.  

Contributors who responsibly disclose vulnerabilities will be acknowledged in release notes.  

---

## 🔹 Policy Principles
- **Transparency:** All fixes and audit notes are published.  
- **Minimalism:** Keep the code surface area small to reduce risk.  
- **Resilience:** Encourage redundancy, backups, and safe liquidity custody.  
- **Community Safety:** Protecting LGX holders and LP participants is priority #1.  

---

## 🔹 Emergency Actions
In case of critical vulnerabilities:
- The **Founder Vault (LGXatoshi)** may pause or migrate liquidity if needed.  
- Patches are deployed via transparent commits to this repo.  
- Public advisories are issued immediately after a fix is live.  

---

## 🔹 Reporting Channels
- **Email:** security@lilgcoin.org  
- **GitHub Issues:** For non-sensitive bugs and suggestions.  
- **Telegram / Facebook group:** Community notices (not for vulnerability details).  

---
