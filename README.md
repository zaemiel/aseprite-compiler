# Aseprite Compiler

The Aseprite Compiler is a 2-click installation script that will compile for you the [Aseprite](https://www.aseprite.org/) program from [its sources](https://github.com/aseprite/aseprite) for Ubuntu and Linux Mint destributions.

It was tested on freshly installed:
* Linux Mint 21 (based on Ubuntu 22.04)

# Installation and using

### Step 1

You need `curl` to use this script. You can install it with:

```bash
sudo apt install curl
```

### Step 2

To download Aseprite dependencies and compile it from sources just execute this command in shell:

```
bash <(curl -sSL https://raw.githubusercontent.com/zaemiel/aseprite-compiler/master/aseprite-compiler.sh)
```

## What does Aseprite Compiler?

Aseprite Compiler:
* Installs Aseprite dependencies, and clones the Aseprite repository
* Downloads compiled version of Skia (it's also Aseprite dependency)
* Compiles Asprite
* Moves compiled Asprite to the `~/Applications/Aseprite` folder
* Creates the desktop file to allow access to Aseprite from system menu.

## Links
* [Aseprite website](https://www.aseprite.org/)
* [Aseprite Github page](https://github.com/aseprite/aseprite)


# License
[The MIT License](https://github.com/pyenv/pyenv/blob/master/LICENSE)
