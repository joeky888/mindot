Debian

![Virtualbox](https://i.imgur.com/fVouqMd.png)

Ubuntu server + CJK characters

![Virtualbox](https://i.imgur.com/eJpa9D6.png)

Fbterm + Tmux + Vim + GPM = 256 colors + Mouse without X

CJK characters are supported.

Tested on Debian and Ubuntu server under Virtualbox.

Warning: this project is only tested under Virtualbox, backup everything if you like to test it on other machines.

Install
====
```bash
(sudo) apt install curl zsh gpm -y # zsh and gpm are optional

# Don't use sudo in the following line
curl -s https://raw.githubusercontent.com/j16180339887/mindot/master/install.sh | bash

(sudo) reboot
```

Features
=====
* bashrc
    * No plugins, just one file
    * Command `upgradeMindot` is to upgrade mindot
    * Bash and Zsh compatible
    * It is also the zshrc file (Yes, .bashrc is also used as .zshrc)
* tmux.conf
    * No plugins, just one file
    * Display public IP address
    * Minimal [Byobu](https://github.com/dustinkirkland/byobu) key mappings
        *  F2 - New tab
        *  F3 - Next tab
        *  F4 - Previous tab
        *  F7 - Copy mode (Press Q to leave Copy mode)
* vimrc
    * No plugins, just one file
    * Autocompletion
    * 256-color Monokai theme
    * Support mouse selection and mouse scrolling if `gpm` is installed
    * Credit: [Minivim](https://github.com/sd65/MiniVim)
* fbtermrc
    * Use Ubuntu Mono font and Droid Sans Fallback font
    * Font size by default is 20

## Vim key mappings

| Keys      | Action                                                | Description |
| --------- | ----------------------------------------------------- | ----------- |
| Ctrl S    | Save current file                                     | Just like modern text editors |
| Tab       | Indent                                                | |
| Shift Tab | Unindent                                              | |

## Extra commands in vim

| Command   | Action                                                    | Description |
| --------- | --------------------------------------------------------- | ----------- |
| AutoCompleteEnable    | Enable autocompletion  | |
| AutoCompleteDisable   | Disable autocompletion | |

The code is under Public-domain licence.
