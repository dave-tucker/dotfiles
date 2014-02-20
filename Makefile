DOTFILES := $(shell pwd)

all: dotfiles mac

dotfiles:
		sh $(DOTFILES)/script/bootstrap.sh

mac:
		sh $(DOTFILES)/script/mac.sh

