DOTFILES := $(shell pwd)

all: crossplatform dotfiles

crossplatform:
		sh $(DOTFILES)/script/all.sh

dotfiles:
		sh $(DOTFILES)/script/bootstrap.sh

mac:
		sh $(DOTFILES)/script/mac.sh

linux:
		sh $(DOTFILES)/script/linux.sh

windows:
		sh $(DOTFILES)/script/windows.sh
