# Changelog

All notable changes to Sentinel AI releases will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Planned
- Package manager support (Homebrew, Chocolatey, APT)
- Multi-language support for installation scripts
- Enhanced CI/CD integration examples

## [1.0.4] - 2025-08-16

### Added
- ✅ **Cross-Platform PHAR Builds**: Native binaries for Linux, macOS, Windows
- ✅ **Windows Support**: Native batch wrapper for Windows environments
- ✅ **Enhanced Installation**: Robust installation script with error handling
- ✅ **Public Distribution**: Dedicated public repository for releases

### Changed
- **Infrastructure**: Modernized GitHub Actions workflows
- **Build System**: Updated Box PHAR compiler to v4.5.1
- **CI/CD**: Optimized 6-check workflow for faster feedback
- **Documentation**: Comprehensive user guides and installation instructions

### Fixed
- **Windows PHAR Compilation**: Resolved all Windows-specific build issues
- **PHP 8.2+ Compatibility**: Removed typed constants for broader compatibility
- **Static Analysis**: Reduced Psalm issues by 45% (138→76 issues)
- **Code Style**: Full PSR-12 compliance across codebase

### Security
- **PHAR Integrity**: Self-contained execution without external dependencies
- **Minimal Permissions**: Runs with minimal system privileges required
- **Secure Downloads**: All releases signed and checksummed

### Performance
- **Analysis Speed**: Optimized for large codebases with intelligent caching
- **Memory Usage**: Efficient memory management (256MB-1GB depending on project size)
- **Cross-Platform**: Consistent performance across all supported platforms

## [1.0.3] - 2025-08-15

### Added
- Basic PHAR distribution
- Linux and macOS support
- Initial release automation

### Fixed
- Core functionality stabilization
- Basic error handling

## [1.0.2] - 2025-08-14

### Added
- Enhanced code analysis features
- Improved reporting capabilities

### Fixed
- Various bug fixes and improvements

## [1.0.1] - 2025-08-13

### Added
- Initial autofix functionality
- Basic HTML reporting

### Fixed
- Stability improvements

## [1.0.0] - 2025-08-12

### Added
- Initial public release
- Core static analysis functionality
- Basic CLI interface
- Support for Psalm, PHPStan, PHP_CodeSniffer

---

## Release Types

- **Major** (x.0.0): Breaking changes, major new features
- **Minor** (x.y.0): New features, backwards compatible
- **Patch** (x.y.z): Bug fixes, security updates

## Support Policy

- **Latest Version**: Full support with new features and bug fixes
- **Previous Minor**: Security fixes and critical bug fixes for 6 months
- **Older Versions**: End of life, upgrade recommended

## Migration Guide

### From 1.0.3 to 1.0.4
- **No breaking changes** - Direct replacement
- **Enhanced features** - All existing functionality preserved
- **New capabilities** - Windows support and improved installation

### Future Migrations
- Migration guides will be provided for any breaking changes
- Automated migration tools when possible
- Deprecation notices with advance warning

---

For detailed release information, see individual release notes in the [releases section](https://github.com/abdulbaquee/sentinel-ai-releases/releases).
