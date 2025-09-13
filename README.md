# d-example
Example program in the D programming language

## Development Container

This repository includes a devcontainer configuration for developing D applications using Visual Studio Code and Docker.

### Prerequisites

- [Docker](https://www.docker.com/)
- [Visual Studio Code](https://code.visualstudio.com/)
- [Dev Containers extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)

### Getting Started

1. Clone this repository
2. Open it in Visual Studio Code
3. When prompted, click "Reopen in Container" or press `Ctrl+Shift+P` and select "Dev Containers: Reopen in Container"
4. Wait for the container to build (this may take a few minutes on first run)
5. Once ready, you can build and run the D application:
   ```bash
   dub build
   dub run
   ```

### Included Tools

The devcontainer includes:
- DMD (D compiler)
- LDC (LLVM-based D compiler)
- DUB (D package manager)
- DCD (D Completion Daemon for IDE support)
- dfmt (D code formatter)
- dscanner (D static analysis tool)
- GDB (debugger)

### VS Code Extensions

The following extensions are automatically installed:
- code-d: D language support
- serve-d: D language server

### Building and Running

Use the provided VS Code tasks:
- `Ctrl+Shift+P` → "Tasks: Run Task" → "dub build" to build
- `Ctrl+Shift+P` → "Tasks: Run Task" → "dub run" to run
- `F5` to debug the application
