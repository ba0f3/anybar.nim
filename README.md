# anybar.nim
Nim client for Anybar

## Installation
```nimble install anybar```

## Usage

### Library
```
import anybar

newAnybar().change("cyan")

# custom port
newAnybar(port=Port(1739)).change('red')

# custom host
newAnybar(host="10.0.0.1").change('red')
```

### Command line:
    anybar red
