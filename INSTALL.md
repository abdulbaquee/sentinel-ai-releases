# 📦 Sentinel AI Installation Guide

Complete installation guide for all platforms and use cases.

## 🚀 Quick Installation

### Automated Installation (Recommended)

```bash
curl -sSL https://raw.githubusercontent.com/abdulbaquee/sentinel-ai-releases/main/install.sh | bash
```

### Manual Installation

#### Linux/macOS
```bash
# Download the appropriate binary
curl -L https://github.com/abdulbaquee/sentinel-ai-releases/releases/latest/download/sentinel-linux-x86_64 -o sentinel
chmod +x sentinel
sudo mv sentinel /usr/local/bin/

# Verify installation
sentinel --version
```

#### Windows
```powershell
# Download Windows batch file
curl -L https://github.com/abdulbaquee/sentinel-ai-releases/releases/latest/download/sentinel-windows-x86_64.bat -o sentinel.bat

# Use directly or add to PATH
.\sentinel.bat --version
```

#### Universal PHAR
```bash
# Works on all platforms with PHP
curl -L https://github.com/abdulbaquee/sentinel-ai-releases/releases/latest/download/sentinel.phar -o sentinel
chmod +x sentinel
./sentinel --version
```

## 📋 System Requirements

- **PHP**: 8.1+ (8.2+ recommended)
- **Memory**: 256MB minimum, 1GB+ for large projects
- **Disk**: ~100MB for installation + cache space
- **Platform**: Linux, macOS, Windows

## 🔧 Installation Methods

### Method 1: Global Installation (Recommended)

**Pros:**
- ✅ Available system-wide as `sentinel`
- ✅ Easy to use in any project
- ✅ Automatic updates with reinstall

**Installation:**
```bash
curl -sSL https://raw.githubusercontent.com/abdulbaquee/sentinel-ai-releases/main/install.sh | bash
```

### Method 2: Project-Specific Installation

**Pros:**
- ✅ Version control per project
- ✅ No system modifications
- ✅ Portable

**Installation:**
```bash
cd your-project/
curl -L https://github.com/abdulbaquee/sentinel-ai-releases/releases/latest/download/sentinel.phar -o sentinel
chmod +x sentinel
./sentinel analyze src/
```

### Method 3: Docker Installation

**Pros:**
- ✅ Isolated environment
- ✅ Consistent across teams
- ✅ Easy CI/CD integration

**Dockerfile:**
```dockerfile
FROM php:8.4-cli

# Install Sentinel AI
RUN curl -L https://github.com/abdulbaquee/sentinel-ai-releases/releases/latest/download/sentinel.phar -o /usr/local/bin/sentinel \
    && chmod +x /usr/local/bin/sentinel

WORKDIR /app
COPY . .

# Run analysis
CMD ["sentinel", "analyze", "src/"]
```

**Usage:**
```bash
docker build -t my-app-analysis .
docker run --rm -v $(pwd):/app my-app-analysis
```

## 🏢 Enterprise Installation

### Package Managers

#### Homebrew (macOS/Linux)
```bash
# Coming soon
brew install abdulbaquee/tap/sentinel-ai
```

#### Chocolatey (Windows)
```powershell
# Coming soon
choco install sentinel-ai
```

#### APT Repository (Ubuntu/Debian)
```bash
# Coming soon
curl -fsSL https://releases.sentinel-ai.dev/gpg | sudo apt-key add -
echo "deb https://releases.sentinel-ai.dev/apt stable main" | sudo tee /etc/apt/sources.list.d/sentinel-ai.list
sudo apt update && sudo apt install sentinel-ai
```

### Internal Distribution

For organizations wanting to host internally:

```bash
# Download and host on internal server
wget https://github.com/abdulbaquee/sentinel-ai-releases/releases/latest/download/sentinel.phar
# Host on internal server: https://tools.company.com/sentinel.phar

# Update install script for internal URL
sed 's|github.com/abdulbaquee/sentinel-ai-releases|tools.company.com|g' install.sh > internal-install.sh
```

## 🔄 Updates

### Check Current Version
```bash
sentinel --version
```

### Update to Latest
```bash
# If installed via script
curl -sSL https://raw.githubusercontent.com/abdulbaquee/sentinel-ai-releases/main/install.sh | bash

# If installed manually
curl -L https://github.com/abdulbaquee/sentinel-ai-releases/releases/latest/download/sentinel.phar -o sentinel
```

### Subscribe to Updates
- ⭐ **Star this repository** to get notifications
- 👀 **Watch releases** on GitHub
- 📧 **RSS feed**: https://github.com/abdulbaquee/sentinel-ai-releases/releases.atom

## 🛠️ Troubleshooting

### Common Issues

**❌ Permission Denied**
```bash
# Solution: Fix permissions
chmod +x sentinel
# Or use sudo for system installation
sudo mv sentinel /usr/local/bin/
```

**❌ Command Not Found**
```bash
# Solution: Check PATH
echo $PATH
# Add to PATH if needed
export PATH="/usr/local/bin:$PATH"
# Make permanent in ~/.bashrc or ~/.zshrc
```

**❌ PHP Not Found**
```bash
# Solution: Install PHP
# Ubuntu/Debian
sudo apt install php8.2-cli

# macOS
brew install php

# Windows
# Download from https://windows.php.net/
```

**❌ Out of Memory**
```bash
# Solution: Increase PHP memory
php -d memory_limit=1G sentinel analyze src/
```

### Platform-Specific Issues

#### Windows

**PowerShell Execution Policy:**
```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

**Path Issues:**
```cmd
# Add to Windows PATH via System Properties > Environment Variables
# Or use full path
C:\path\to\sentinel.bat --version
```

#### macOS

**Gatekeeper Issues:**
```bash
# If macOS blocks execution
xattr -d com.apple.quarantine sentinel
```

#### Linux

**Missing Extensions:**
```bash
# Install required PHP extensions
sudo apt install php8.2-cli php8.2-xml php8.2-mbstring php8.2-tokenizer
```

## 🧪 Verify Installation

After installation, verify everything works:

```bash
# Check version
sentinel --version

# Test basic functionality
echo '<?php echo "Hello World!";' > test.php
sentinel analyze test.php
rm test.php

# Check available commands
sentinel --help
```

## 🚫 Uninstallation

### Automatic Uninstall
```bash
curl -sSL https://raw.githubusercontent.com/abdulbaquee/sentinel-ai-releases/main/uninstall.sh | bash
```

### Manual Uninstall
```bash
# Remove binary
sudo rm /usr/local/bin/sentinel

# Remove cache (optional)
rm -rf ~/.cache/sentinel-ai
```

## 📞 Support

**🐛 Installation Issues:**
- [Create an issue](https://github.com/abdulbaquee/sentinel-ai-releases/issues)
- Include: OS, PHP version, error messages

**📖 Documentation:**
- [User Guide](README.md#documentation)
- [FAQ](https://github.com/abdulbaquee/sentinel-ai/discussions)

**💬 Community:**
- [GitHub Discussions](https://github.com/abdulbaquee/sentinel-ai/discussions)
- [Stack Overflow](https://stackoverflow.com/questions/tagged/sentinel-ai)

---

**🎉 Ready to analyze your PHP code? Run `sentinel --help` to get started!**
