# Zed Configuration Backup

Personal configuration for the [Zed](https://zed.dev) code editor. Includes Vim keybindings, compile and run tasks for Rust, Java, C++, and Python, boilerplate generators, and language server settings.

Works on both Windows and Ubuntu / Debian environments.

---

## Installation

### Ubuntu / Debian (Uni Lab)

1. Install build dependencies if they are not already installed:
   ```bash
   sudo apt update && sudo apt install -y build-essential openjdk-21-jdk python3 git
   ```

2. Clone this repository and run the installer:
   ```bash
   git clone https://github.com/abirwalker/zed-config.git
   cd zed-config
   chmod +x ./install.sh
   ./install.sh
   ```

The script backs up any existing `~/.config/zed` directory and copies the Linux-specific settings and tasks.

### Windows

Clone the repository and run the PowerShell installer:
```powershell
git clone https://github.com/abirwalker/zed-config.git
cd zed-config
powershell -ExecutionPolicy Bypass -File .\install.ps1
```

The script creates a backup of `%APPDATA%\Zed` before installing configuration files.

---

## Keybindings

### Normal Mode (Vim)

| Shortcut | Command | Function |
| :--- | :--- | :--- |
| `Space b` | `task::Spawn` | Insert boilerplate matching active file type (Rust / Java / C++ / Python) |
| `Space r` | `task::Spawn` | Compile and run active Rust file (`cargo run` if `Cargo.toml`, else `rustc`) |
| `Space j` | `task::Spawn` | Run active Java file (`java` on Windows, `javac` + `java` on Linux) |
| `Space c` | `task::Spawn` | Compile and run C++ file (`g++`) |
| `Space p` | `task::Spawn` | Run active Python file (`python3` on Linux, `python` on Windows) |
| `Space t` | `task::Spawn` | Open tasks modal |
| `Space d` | `debugger::Start` | Open DAP debug session |
| `Space .` | `editor::ToggleCodeActions` | Show code actions (quick-fix / auto-import) |

### Global and Insert Mode

| Shortcut | Context | Function |
| :--- | :--- | :--- |
| `j k` | Insert Mode | Return to normal mode |
| `Ctrl+F5` | Global | Run active Java file |
| `Shift+F5` / `F4` | Global | Start debugger |
| `F5` | Global | Open tasks modal |
| `Ctrl+b` | Global | Toggle project panel |
| `Ctrl+Shift+f` | Global | Search in project |
| `Ctrl+s` | Global | Save current buffer |

---

## Snippets

### Java

- `java` + `Tab`: Class structure with `import java.util.Scanner;`. Cursor lands on class name, next `Tab` enters `main`.
- `input` + `Tab`: `Scanner input = new Scanner(System.in);`

### C++

- `cpp` + `Tab`: `#include <bits/stdc++.h>` template with `cin.tie(NULL)` fast I/O setup.

---

## Templates (`Space b`)

### C++ (`.cpp`)

```cpp
#include <bits/stdc++.h>
using namespace std;

int main() {
    ios_base::sync_with_stdio(false);
    cin.tie(NULL);

    return 0;
}
```

### Java (`.java`)

Automatically names the class to match the file (for example, `Calculator.java`):

```java
import java.util.Scanner;

public class Calculator {
    public static void main(String[] args) {
        
    }
}
```

### Rust (`.rs`)

```rust
fn main() {
    println!("Hello, world!");
}
```

---

## File Structure

```text
zed-config/
├── install.ps1         # Windows installer
├── install.sh          # Linux installer
├── keymap.json         # Keybindings and Vim mappings
├── debug.json          # DAP debugger presets
├── snippets/
│   ├── java.json       # Java snippets
│   └── cpp.json        # C++ snippets
├── linux/              # Linux-specific task and editor settings
│   ├── settings.json
│   └── tasks.json
├── settings.json       # Windows editor settings
├── tasks.json          # Windows tasks
└── README.md
```
