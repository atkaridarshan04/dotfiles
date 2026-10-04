SHELL := /bin/bash
GHOSTTY := /Applications/Ghostty.app/Contents/MacOS/ghostty

.PHONY: check install

check:
	@echo "== zsh syntax =="
	@rc=0; for f in .zshrc .zsh/*.zsh; do \
	  if zsh -n "$$f" 2>&1; then echo "  ok  $$f"; else echo "  FAIL  $$f"; rc=1; fi; \
	done; exit $$rc
	@echo "== bash syntax =="
	@bash -n install.sh && echo "  ok  install.sh"
	@command -v shellcheck >/dev/null && shellcheck install.sh && echo "  ok  shellcheck" || true
	@echo "== starship config =="
	@out=$$(STARSHIP_CONFIG=$$PWD/.config/starship.toml starship print-config 2>&1 >/dev/null); \
	  if [ -n "$$out" ]; then echo "$$out"; exit 1; else echo "  ok  no warnings"; fi
	@echo "== ghostty config =="
	@if [ -x "$(GHOSTTY)" ]; then \
	  out=$$("$(GHOSTTY)" +validate-config --config-file=$$PWD/.config/ghostty/config 2>&1 | cat); \
	  if [ -n "$$out" ]; then echo "$$out"; exit 1; else echo "  ok  valid"; fi; \
	else echo "  skip  ghostty not installed"; fi
	@echo "== iterm2 profile =="
	@python3 -c "import json;d=json.load(open('iterm2/Catppuccin-Mocha.json'))['Profiles'][0];\
	assert all(k in d for k in ('Name','Guid'));print('  ok  valid, has Name and Guid')"
	@echo "== palette =="
	@python3 scripts/check-palette.py

install:
	@./install.sh
