HISTFILE="$HOME/.zsh_history"
HISTSIZE=100000
SAVEHIST=100000

setopt EXTENDED_HISTORY        # record timestamp per command
setopt INC_APPEND_HISTORY      # write as commands run, not at shell exit
setopt SHARE_HISTORY           # share across concurrent shells and splits
setopt HIST_IGNORE_ALL_DUPS    # keep only the most recent copy of a duplicate
setopt HIST_IGNORE_SPACE       # omit commands prefixed with a space
setopt HIST_REDUCE_BLANKS      # strip superfluous whitespace
setopt HIST_VERIFY             # expand a !! reference for review before running
setopt HIST_FIND_NO_DUPS       # skip duplicates when searching

# Search history for what is already typed, keeping the cursor at the end.
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey '^[[A' up-line-or-beginning-search
bindkey '^[[B' down-line-or-beginning-search
