# Security Policy

## Supported Versions

We actively support the latest version of Sentinel AI. Security updates are provided for:

| Version | Supported          |
| ------- | ------------------ |
| 1.0.4   | :white_check_mark: |
| 1.0.3   | :x:                |
| < 1.0.3 | :x:                |

## Reporting a Vulnerability

If you discover a security vulnerability in Sentinel AI, please report it responsibly:

### How to Report

1. **DO NOT** create a public GitHub issue for security vulnerabilities
2. Send an email to: **security@abdul-baquee.dev** (if available)
3. Or create a private security advisory on GitHub

### What to Include

Please include the following information in your report:

- **Description** of the vulnerability
- **Steps to reproduce** the issue
- **Impact assessment** (what could an attacker do?)
- **Suggested fix** (if you have one)
- **Your contact information** for follow-up

### Response Timeline

- **Initial Response**: Within 48 hours
- **Assessment**: Within 1 week
- **Fix Development**: Depends on severity
- **Public Disclosure**: After fix is released (coordinated disclosure)

### Security Best Practices

When using Sentinel AI:

1. **Download from official sources only**
   - GitHub releases: https://github.com/abdulbaquee/sentinel-ai-releases/releases
   - Verify checksums when available

2. **Keep updated**
   - Always use the latest version
   - Subscribe to release notifications

3. **Secure environment**
   - Run with minimum necessary privileges
   - Isolate in CI/CD environments when possible

4. **Code analysis security**
   - Review generated reports before sharing
   - Be cautious with sensitive code paths in reports

## Security Features

Sentinel AI includes several security considerations:

- **PHAR integrity**: Self-contained execution
- **No network calls**: Offline analysis (except for tool downloads)
- **Read-only analysis**: Does not modify source code without explicit permission
- **Configurable scope**: Analyze only specified directories

## Vulnerability Disclosure

We follow responsible disclosure practices:

1. Security issues are fixed privately
2. Affected users are notified through release notes
3. CVE numbers are assigned for significant vulnerabilities
4. Security advisories are published on GitHub

## Bug Bounty

Currently, we do not offer a formal bug bounty program, but we appreciate and acknowledge security researchers who help improve Sentinel AI's security.

---

Thank you for helping keep Sentinel AI secure! 🔒
