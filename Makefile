DOTFILES := $(shell pwd)

all: crossplatform dotfiles

crossplatform:
		sh $(DOTFILES)/script/generic.sh

platform:
		sh $(DOTFILES)/script/platform.sh

dotfiles:
		sh $(DOTFILES)/script/bootstrap.sh

mac:	platform crossplatform dotfiles

linux:	crossplatform dotfiles platform

windows: crossplatform dotfiles platform
