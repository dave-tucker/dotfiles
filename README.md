# DTDD - dave_tucker does dotfiles

## Dotfiles

Dotfiles are all those `.` files that sit in your `~` and customize your system. Here are mine.
I've gone one step further than just including my dotfiles. I've also included all of my system customizations and installers for the packages I use most. Why a new repository and not a fork you might ask? The honest answer is that there wasn't one repo that fit my tastes well enough so I ended up taking what I considered to be the "best" elements from a number of other repos.

What I like about my dotfiles:

- Uses the [Base16 Ocean theme](https://github.com/chriskempson/base16)
- Nicely Organised
- Multi-Platform MakeFile-based installer

# What's included

- Oh-My-Zsh
    + Agnoster theme
    + Base 16 Ocean Shell Color Fix
    + Any `.zsh` file in the dotfiles project is included in zshrc
- Ubuntu Mono fonts (vanilla and powerline modded)
- A massive gitconfig
- Homebrew 
    + Installs Homebrew AND `brew install`'s all of my favourite packages
    + Uses `homebrew-cask` to install all my applications
- Base16-Ocean colors for IntelliJ (and other IDEA IDE's)
- Base16-Ocean iTerm2 colors
- Vain Hacker defaults for OSX (hacker defaults + eye candy)
- My Python settings
    + Pip install useful packages
    + Python dotfiles
- Some sensible Ruby settings
- Sublime Text
    + Spacegray theme and Base16-Ocean Colors
    + Package Control and a lot of plugins
    + Customizations for Python development
- Vim
    + Base 16 Ocean colors
    + A very basic vimrc

# Installation

    # install cross-platform things and dotfiles
    make

    # just the dotfiles
    make dotfiles

    # install os-specific things
    make mac | linux | windows

> If you are planning on using this you will want to `s/dave_tucker/<your_username>` and `s/Dave Tucker/<your_name`. Also, you should change `DEFAULT_USER` and `PROJECTS` in `zshrc`

## Thanks

- [@chriskempson](https://github.com/chriskempson/base16) - for base16
- [@robyrussell](https://github.com/robbyrussell/oh-my-zsh) - for oh-my-zsh
- [@holman](https://github.com/holman/dotfiles) - inspiration for organisation and install scripts
- [@skwp](https://github.com/skwp/dotfiles) - another inspiration dotfiles repo
- [@mathiasbyens](https://github.com/mathiasbynens/dotfiles) - for his awesome osx customization script
- [@matthewmccullough](https://github.com/matthewmccullough/dotfiles) - for sharing his gitconfig
- [@phinze](https://github.com/phinze/homebrew-cask/tree/master/Casks) - for homebrew-cask
- [@kkga](https://github.com/kkga/spacegray) - for the SpaceGray theme for Sublime Text

## License

Copyright 2014 Dave Tucker
Licensed under the MIT License
