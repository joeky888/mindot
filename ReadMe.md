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
* gpm (if it is installed)
    * By default, left mouse click is copying and right mouse click is pasting

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

### Change the default 16 colors

In order to change the original 16 tty colors, you need to reinstall fbterm from github.

```sh
sudo apt remove fbterm -y
sudo apt install libgpm-dev libconfig1-dev libfreetype6-dev libx86-dev pkg-config -y
git clone https://github.com/ccapitalK/fbterm.git && cd fbterm
./configure && make && sudo make install
```

then edit fbtermrc file like this

```conf
color-foreground=7
color-background=0
color-0=000000
color-1=AA0000
color-2=00AA00
color-3=AA5500
color-4=0000AA
color-5=AA00AA
color-6=00AAAA
color-7=AAAAAA
color-8=555555
color-9=FF5555
color-10=55FF55
color-11=FFFF55
color-12=5555FF
color-13=FF55FF
color-14=55FFFF
color-15=FFFFFF
```

Here is my fbtermrc setting, with Monokai colors

```conf
color-0=000000
color-1=AF0000
color-2=00AF00
color-3=FFFF00
color-4=66D9EF
color-5=AE81FF
color-6=A1EFE4
color-7=F8F8F2
color-8=7E8E91
color-9=F92672
color-10=A6E22E
color-11=F4BF75
color-12=66D9EF
color-13=AE81FF
color-14=A1EFE4
color-15=FFFFFF
```
