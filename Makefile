DOTFILES := $(shell pwd)

all: crossplatform dotfiles

crossplatform:
		sh $(DOTFILES)/script/all.sh

dotfiles:
		sh $(DOTFILES)/script/bootstrap.sh

mac:	crossplatform dotfiles
		sh $(DOTFILES)/script/mac.sh

linux:	crossplatform dotfiles
		sh $(DOTFILES)/script/linux.sh

windows: crossplatform dotfiles
		sh $(DOTFILES)/script/windows.sh
