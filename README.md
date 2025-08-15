# 📦 Sentinel AI - Official Release Binaries

> **Cross-platform PHP code quality analysis tool - Official distribution repository**

[![Latest Release](https://img.shields.io/github/v/release/abdulbaquee/sentinel-ai-releases?style=for-the-badge&logo=github)](https://github.com/abdulbaquee/sentinel-ai-releases/releases/latest)
[![Downloads](https://img.shields.io/github/downloads/abdulbaquee/sentinel-ai-releases/total?style=for-the-badge&logo=download)](https://github.com/abdulbaquee/sentinel-ai-releases/releases)
[![Platform Support](https://img.shields.io/badge/Platform-Linux%20%7C%20macOS%20%7C%20Windows-blue?style=for-the-badge&logo=matrix)](https://github.com/abdulbaquee/sentinel-ai-releases/releases)

## 🚀 **Quick Installation**

### **Automated Installation (Recommended)**

```bash
curl -sSL https://raw.githubusercontent.com/abdulbaquee/sentinel-ai-releases/main/install.sh | bash
```

### **Manual Download**

```bash
# Download latest PHAR
curl -L https://github.com/abdulbaquee/sentinel-ai-releases/releases/latest/download/sentinel.phar -o sentinel
chmod +x sentinel && ./sentinel --version
```

## 📋 **What is Sentinel AI?**

Sentinel AI is a **comprehensive PHP code quality analysis tool** that combines multiple static analysis tools into a single, easy-to-use interface. It provides:

- 🔍 **Static Code Analysis** - Detect bugs, type errors, and code smells
- 🛠️ **Automated Code Fixes** - Auto-fix common issues with interactive mode
- 📊 **Detailed Reports** - HTML reports with actionable insights
- 🚀 **Cross-Platform** - Native binaries for Linux, macOS, and Windows
- ⚡ **Fast Performance** - Optimized for large codebases with intelligent caching

## 📦 **Available Downloads**

Each release includes:

| File                          | Platform   | Description                    |
| ----------------------------- | ---------- | ------------------------------ |
| `sentinel.phar`               | Universal  | Cross-platform PHAR executable |
| `sentinel-linux-x86_64`       | Linux      | Native Linux binary            |
| `sentinel-macos-x86_64`       | macOS      | Native macOS binary            |
| `sentinel-windows-x86_64.bat` | Windows    | Windows batch wrapper          |
| `install.sh`                  | Unix/Linux | Automated installation script  |
| `uninstall.sh`                | Unix/Linux | Uninstallation script          |

## 🔧 **Usage Examples**

```bash
# Analyze a PHP project
sentinel analyze src/

# Auto-fix issues interactively
sentinel autofix src/ --interactive

# Generate HTML report
sentinel analyze src/ --format=html --output=report.html

# Check specific file
sentinel analyze app/Models/User.php

# Show help
sentinel --help
```

## 📖 **Documentation**

- 📚 **[User Guide](https://github.com/abdulbaquee/sentinel-ai/blob/main/docs/user-guides/USER_GUIDE.md)** - Complete usage documentation
- 🚀 **[Quick Reference](https://github.com/abdulbaquee/sentinel-ai/blob/main/docs/user-guides/QUICK_REFERENCE.md)** - Command cheat sheet
- 💻 **[Developer Guide](https://github.com/abdulbaquee/sentinel-ai/blob/main/docs/developer/)** - Technical documentation
- 🏭 **[Production Deployment](https://github.com/abdulbaquee/sentinel-ai/blob/main/docs/developer/PRODUCTION_DEPLOYMENT.md)** - Enterprise setup guide

## 🔗 **Related Repositories**

- **[Main Repository](https://github.com/abdulbaquee/sentinel-ai)** - Source code and development (private)
- **[Documentation](https://github.com/abdulbaquee/sentinel-ai/tree/main/docs)** - Complete documentation
- **[Issue Tracker](https://github.com/abdulbaquee/sentinel-ai/issues)** - Bug reports and feature requests

## 🌟 **Features**

### **Code Analysis Tools**

- **Psalm** - Static analysis for type safety
- **PHP_CodeSniffer** - PSR-12 coding standards
- **PHPStan** - Advanced static analysis
- **PHP-CS-Fixer** - Code style fixes
- **PHPMetrics** - Code quality metrics

### **Advanced Capabilities**

- **Interactive Fixing** - Step-by-step issue resolution
- **Smart Caching** - Faster subsequent analyses
- **Multiple Output Formats** - JSON, HTML, text reports
- **CI/CD Integration** - Perfect for automated workflows
- **Enterprise Ready** - Scalable for large codebases

## 📊 **Performance**

| Project Size          | Analysis Time | Memory Usage        |
| --------------------- | ------------- | ------------------- |
| Small (< 1K files)    | < 30 seconds  | 256MB               |
| Medium (1K-10K files) | 1-5 minutes   | 512MB-1GB           |
| Large (> 10K files)   | 5-15 minutes  | 1GB+ (with caching) |

## 🚀 **Installation Options**

### **Global Installation**

```bash
# Download installer
curl -sSL https://raw.githubusercontent.com/abdulbaquee/sentinel-ai-releases/main/install.sh | bash

# Verify installation
sentinel --version
```

### **Project-Specific Installation**

```bash
# Download to project directory
curl -L https://github.com/abdulbaquee/sentinel-ai-releases/releases/latest/download/sentinel.phar -o sentinel
chmod +x sentinel

# Use in project
./sentinel analyze src/
```

### **Docker Usage**

```dockerfile
FROM php:8.4-cli
RUN curl -L https://github.com/abdulbaquee/sentinel-ai-releases/releases/latest/download/sentinel.phar -o /usr/local/bin/sentinel \
    && chmod +x /usr/local/bin/sentinel
```

## 📋 **System Requirements**

- **PHP**: 8.1+ (8.2+ recommended)
- **Memory**: 256MB minimum, 1GB+ for large projects
- **Platform**: Linux, macOS, Windows
- **Dependencies**: None (self-contained PHAR)

## 🔄 **Update Instructions**

```bash
# Check current version
sentinel --version

# Update to latest version
curl -sSL https://raw.githubusercontent.com/abdulbaquee/sentinel-ai-releases/main/install.sh | bash
```

## 📞 **Support & Community**

- 🐛 **[Report Issues](https://github.com/abdulbaquee/sentinel-ai/issues)** - Bug reports and feature requests
- 💬 **[Discussions](https://github.com/abdulbaquee/sentinel-ai/discussions)** - Community support
- 📧 **Email**: support@sentinel-ai.dev (if applicable)
- 📖 **[Documentation](https://github.com/abdulbaquee/sentinel-ai/tree/main/docs)** - Complete guides

## 📄 **License**

This project is licensed under the [MIT License](LICENSE) - see the license file for details.

## 🙏 **Acknowledgments**

Sentinel AI is built on top of excellent open-source tools:

- **[Psalm](https://psalm.dev/)** - Vimeo's static analysis tool
- **[Symfony Console](https://symfony.com/doc/current/components/console.html)** - Command-line interface
- **[Box](https://github.com/box-project/box)** - PHAR compilation
- **PHP Community** - For amazing tools and libraries

---

**⭐ If Sentinel AI helps improve your code quality, please consider starring this repository!**

**🚀 Ready to improve your PHP code quality? [Download the latest release](https://github.com/abdulbaquee/sentinel-ai-releases/releases/latest)!**
