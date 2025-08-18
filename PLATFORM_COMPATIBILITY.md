# 🌍 Platform Compatibility Report

## Supported Platforms

### ✅ **macOS** (Intel & Apple Silicon)
- **Status**: ✅ Fully Supported
- **Installation**: `curl -sSL https://raw.githubusercontent.com/abdulbaquee/sentinel-ai-releases/main/install.sh | bash`
- **Binary Wrapper**: `sentinel-macos-x86_64`
- **Requirements**: PHP 8.2+, macOS 10.15+
- **Package Managers**: Homebrew support planned
- **Tested**: ✅ macOS Monterey, ✅ macOS Ventura, ✅ macOS Sonoma

### ✅ **Linux** (x86_64)
- **Status**: ✅ Fully Supported  
- **Installation**: `curl -sSL https://raw.githubusercontent.com/abdulbaquee/sentinel-ai-releases/main/install.sh | bash`
- **Binary Wrapper**: `sentinel-linux-x86_64`
- **Requirements**: PHP 8.2+, glibc 2.17+
- **Package Managers**: APT/YUM support planned
- **Tested**: ✅ Ubuntu 20.04+, ✅ CentOS 8+, ✅ Debian 11+

### ✅ **Windows** (x86_64)
- **Status**: ✅ Fully Supported
- **Installation**: 
  - PowerShell: `iwr -useb https://raw.githubusercontent.com/abdulbaquee/sentinel-ai-releases/main/install.ps1 | iex`
  - Manual: Download `sentinel-windows-x86_64.bat`
- **Binary Wrapper**: `sentinel-windows-x86_64.bat`
- **Requirements**: PHP 8.2+, Windows 10+, PowerShell 5.0+
- **Package Managers**: Chocolatey support planned
- **Tested**: ✅ Windows 10, ✅ Windows 11, ✅ Windows Server 2019+

## �� Installation Methods Comparison

| Method | macOS | Linux | Windows | Pros | Cons |
|--------|-------|-------|---------|------|------|
| **Automated Script** | ✅ | ✅ | ✅ | Easy, auto-updates | Requires internet |
| **Direct PHAR** | ✅ | ✅ | ✅ | Universal, portable | Manual updates |
| **Package Manager** | 🟡 | 🟡 | 🟡 | System integration | Coming soon |
| **Docker** | ✅ | ✅ | ✅ | Isolated, consistent | Docker overhead |

## 🔧 System Requirements

### Minimum Requirements
- **PHP**: 8.1+ (8.2+ recommended)
- **Memory**: 256MB available RAM
- **Disk**: 100MB free space + project cache
- **Internet**: Required for installation and updates

### Recommended Requirements
- **PHP**: 8.2+ with OPcache enabled
- **Memory**: 1GB+ available RAM for large projects
- **Disk**: 1GB+ for cache and reports
- **CPU**: Multi-core for parallel analysis

## 🚀 Installation Commands

### Quick Install (All Platforms)
```bash
# Unix/Linux/macOS
curl -sSL https://raw.githubusercontent.com/abdulbaquee/sentinel-ai-releases/main/install.sh | bash

# Windows PowerShell
iwr -useb https://raw.githubusercontent.com/abdulbaquee/sentinel-ai-releases/main/install.ps1 | iex

# Universal PHAR (any platform with PHP)
curl -L https://github.com/abdulbaquee/sentinel-ai-releases/releases/latest/download/sentinel.phar -o sentinel
chmod +x sentinel
```

### Manual Installation
```bash
# macOS
curl -L https://github.com/abdulbaquee/sentinel-ai-releases/releases/latest/download/sentinel-macos-x86_64 -o sentinel
chmod +x sentinel
sudo mv sentinel /usr/local/bin/

# Linux
curl -L https://github.com/abdulbaquee/sentinel-ai-releases/releases/latest/download/sentinel-linux-x86_64 -o sentinel
chmod +x sentinel
sudo mv sentinel /usr/local/bin/

# Windows (PowerShell)
Invoke-WebRequest -Uri "https://github.com/abdulbaquee/sentinel-ai-releases/releases/latest/download/sentinel-windows-x86_64.bat" -OutFile "sentinel.bat"
```

## 🧪 Verification Commands

### Test Installation
```bash
# Check version
sentinel --version

# Test basic functionality
sentinel analyze --help

# Run quick test
echo '<?php echo "test";' > test.php && sentinel analyze test.php && rm test.php
```

### Platform-Specific Tests
```bash
# macOS: Test with Homebrew PHP
brew install php && sentinel --version

# Linux: Test with system PHP
sudo apt install php8.2-cli && sentinel --version

# Windows: Test with downloaded PHP
php --version && sentinel --version
```

## 🐛 Known Issues & Workarounds

### macOS
- **Gatekeeper Warning**: Run `xattr -d com.apple.quarantine sentinel` if blocked
- **Rosetta 2**: Intel binary works on Apple Silicon via Rosetta
- **Homebrew PHP**: Preferred over system PHP for better compatibility

### Linux
- **Missing Extensions**: Install `php8.2-xml php8.2-mbstring php8.2-tokenizer`
- **Permission Denied**: Use `sudo` for `/usr/local/bin` installation
- **Old PHP**: Update to PHP 8.2+ for best performance

### Windows
- **Execution Policy**: Run `Set-ExecutionPolicy RemoteSigned` in PowerShell
- **PATH Issues**: Manually add installation directory to Windows PATH
- **Antivirus**: Some AV software may flag PHAR files (false positive)

## 📊 Compatibility Matrix

| Feature | macOS | Linux | Windows | Notes |
|---------|-------|-------|---------|-------|
| **Core Analysis** | ✅ | ✅ | ✅ | Full feature parity |
| **Interactive Mode** | ✅ | ✅ | ✅ | Terminal colors supported |
| **PHAR Execution** | ✅ | ✅ | ✅ | Native PHP PHAR support |
| **File Permissions** | ✅ | ✅ | 🟡 | Windows has different model |
| **Symlinks** | ✅ | ✅ | 🟡 | Windows requires admin rights |
| **Case Sensitivity** | ✅ | ✅ | 🟡 | Windows filesystem is case-insensitive |

## 🔄 Update Process

### Automatic Updates (Recommended)
```bash
# Re-run installer (all platforms)
curl -sSL https://raw.githubusercontent.com/abdulbaquee/sentinel-ai-releases/main/install.sh | bash
```

### Manual Updates
```bash
# Check current version
sentinel --version

# Download latest PHAR
curl -L https://github.com/abdulbaquee/sentinel-ai-releases/releases/latest/download/sentinel.phar -o sentinel
chmod +x sentinel
```

## 🏢 Enterprise Deployment

### Internal Distribution
```bash
# Host on internal server
wget https://github.com/abdulbaquee/sentinel-ai-releases/releases/latest/download/sentinel.phar
# Host at: https://tools.company.com/sentinel.phar

# Update installer script
sed 's|github.com/abdulbaquee/sentinel-ai-releases|tools.company.com|g' install.sh > internal-install.sh
```

### Docker Distribution
```dockerfile
FROM php:8.2-cli
RUN curl -L https://github.com/abdulbaquee/sentinel-ai-releases/releases/latest/download/sentinel.phar -o /usr/local/bin/sentinel \
    && chmod +x /usr/local/bin/sentinel
WORKDIR /app
CMD ["sentinel", "analyze", "src/"]
```

## 📞 Platform-Specific Support

### macOS Users
- **Homebrew Issues**: [Homebrew troubleshooting](https://docs.brew.sh/Troubleshooting)
- **PHP Installation**: `brew install php`
- **Permission Issues**: Use `sudo` or install to `~/.local/bin`

### Linux Users  
- **Package Manager**: Use distribution's PHP package
- **Dependency Issues**: Install `php-cli php-xml php-mbstring`
- **AppArmor/SELinux**: May need policy updates for PHAR execution

### Windows Users
- **PHP Installation**: [Windows PHP Download](https://windows.php.net/download/)
- **PATH Configuration**: System Properties → Environment Variables
- **PowerShell Issues**: Run as Administrator if needed

---

## ✅ Verification Status

**Last Updated**: August 18, 2025  
**Version Tested**: v1.0.6  
**Platforms Verified**: ✅ macOS ✅ Linux ✅ Windows  
**Installation Methods**: ✅ Automated ✅ Manual ✅ Docker  

**🎉 All platforms are fully functional and ready for production use!**
