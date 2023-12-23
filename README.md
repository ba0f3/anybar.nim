# anybar.nim

Nim client for [Anybar](https://github.com/tonsky/AnyBar), an OS X menubar status indicator.

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

# tell app to quit
newAnybar().quit()
```

### Command line

    anybar red
    anybar -p:1739 yellow
    anybar -h:10.0.0.1 green
    anybar -h:10.0.0.1 -p:1739 blue

    anybar quit
