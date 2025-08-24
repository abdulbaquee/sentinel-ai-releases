# 🚀 Sentinel AI v1.0.6 - Quick Start Guide

## ⚡ One-Command Installation

### **Linux & macOS:**
```bash
curl -sSL https://raw.githubusercontent.com/abdulbaquee/sentinel-ai-releases/main/releases/v1.0.6/install.sh | bash
```

### **Windows (PowerShell as Administrator):**
```powershell
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/abdulbaquee/sentinel-ai-releases/main/releases/v1.0.6/install.ps1" -OutFile "install.ps1"
.\install.ps1
```

## 🎯 Quick Test

After installation, test Sentinel AI:

```bash
# Check version
sentinel --version

# Analyze your PHP code
sentinel analyze src/

# Interactive auto-fix
sentinel autofix src/ --interactive
```

## 📋 Requirements

- **PHP:** 8.2 or higher
- **Extensions:** mbstring, json, phar, sodium, intl
- **OS:** Linux, macOS, Windows (x86_64)

## 🔧 What Sentinel AI Does

Sentinel AI is a comprehensive PHP code analysis and auto-fix tool that:

- ✅ **Analyzes** your PHP code for quality issues
- ✅ **Auto-fixes** common problems automatically
- ✅ **Detects** security vulnerabilities
- ✅ **Supports** Laravel, Symfony, CodeIgniter, and other frameworks
- ✅ **Generates** detailed HTML reports
- ✅ **Integrates** with CI/CD pipelines

## 🎮 Basic Commands

```bash
# Analyze code
sentinel analyze src/

# Auto-fix issues
sentinel autofix src/

# Interactive mode
sentinel autofix src/ --interactive

# Generate HTML report
sentinel analyze src/ --html-report report.html

# Check cache status
sentinel cache --stats

# Clear cache
sentinel cache --clear
```

## 🏗️ Framework Support

Sentinel AI automatically detects and optimizes for:
- **Laravel** - Laravel-specific rules and best practices
- **Symfony** - Symfony-specific analysis and recommendations
- **CodeIgniter** - CodeIgniter framework optimizations
- **CakePHP** - CakePHP-specific code quality rules
- **Laminas** - Laminas framework support
- **Yii** - Yii framework integration

## 🚀 Advanced Usage

```bash
# Custom rules
sentinel custom-rules --list

# Security analysis
sentinel analyze src/ --security

# Architecture analysis
sentinel analyze src/ --architecture

# Specific PHP standard
sentinel analyze src/ --standard PSR12

# Timeout for large projects
sentinel analyze src/ --timeout 300
```

## 📊 Example Output

```
Sentinel AI 1.0.6
================

Analyzing: /path/to/your/project
--------------------------------

✅ PHP_CodeSniffer Results: 0 violations found
✅ PHPStan Results: 0 errors found
✅ PhpMetrics Results: Average complexity 2.1 across 45 functions
✅ PHPCpd Results: No duplicates found

🎉 Analysis complete! Your code looks great!
```

## 🆘 Need Help?

- **Documentation:** [User Guide](https://github.com/abdulbaquee/sentinel-ai/blob/main/docs/user-guides/USER_GUIDE.md)
- **Issues:** [GitHub Issues](https://github.com/abdulbaquee/sentinel-ai/issues)
- **Discussions:** [GitHub Discussions](https://github.com/abdulbaquee/sentinel-ai/discussions)

## 🎉 Ready to Go!

Your Sentinel AI installation is complete! Start analyzing your PHP code and improving code quality today.

---

**Happy coding! 🚀**
