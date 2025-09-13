# D Development Container

This directory contains the configuration for a VS Code development container tailored for D programming language development.

## What's Included

### D Compilers and Tools
- **DMD**: The reference D compiler
- **LDC**: LLVM-based D compiler for optimized builds
- **DUB**: D package manager and build tool

### Development Tools
- **DCD**: D Completion Daemon for code completion and analysis
- **dfmt**: D source code formatter
- **dscanner**: D static analysis tool
- **GDB**: GNU Debugger for debugging D applications

### VS Code Extensions
- **code-d**: Provides D language support in VS Code
- **serve-d**: D language server for enhanced IDE features

## Container Features

### Base Environment
- Ubuntu 22.04 LTS
- Non-root user (`vscode`) with sudo access
- Git support

### Build Environment
- Complete C/C++ build tools (needed for D native development)
- pkg-config for library management

## Usage

The container is configured to:
1. Automatically install and configure all D development tools
2. Set up VS Code with appropriate D language extensions
3. Provide debugging support with GDB
4. Enable build and run tasks for DUB projects

### Commands Available in Container

```bash
# Compile and run D code
dmd source/app.d -of=app && ./app

# Using DUB (recommended)
dub build          # Build the project
dub run            # Build and run the project
dub test           # Run tests

# Code quality tools
dfmt source/app.d  # Format D source code
dscanner source/   # Static analysis

# Debugging
gdb ./app          # Debug the compiled executable
```

### VS Code Integration

The container automatically configures VS Code with:
- Build tasks (accessible via `Ctrl+Shift+P` → "Tasks: Run Task")
- Debug configuration (press `F5` to start debugging)
- Integrated terminal with all D tools available

## Customization

To modify the container:
1. Edit `devcontainer.json` for VS Code settings and extensions
2. Edit `Dockerfile` to change the container environment
3. Rebuild the container using VS Code's "Dev Containers: Rebuild Container" command

## Troubleshooting

### Container Build Issues
- Ensure Docker is running and has sufficient resources
- Check internet connectivity for downloading packages
- Try rebuilding without cache: "Dev Containers: Rebuild Container"

### D Compilation Issues
- Verify DUB configuration in `dub.json`
- Check D source file syntax
- Ensure all imports are available

### IDE Features Not Working
- Restart the D language server: `Ctrl+Shift+P` → "D: Restart Language Server"
- Check that DCD is running: `ps aux | grep dcd`
- Verify extension installation in container