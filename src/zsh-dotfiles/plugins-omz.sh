#!/bin/sh -e
printf '\n' >>"${_REMOTE_USER_HOME}/.zshrc"

# https://github.com/zsh-users/zsh-completions
git clone 'https://github.com/zsh-users/zsh-completions' "${ZSH_CUSTOM:-${ZSH:-$_REMOTE_USER_HOME/.oh-my-zsh}/custom}/plugins/zsh-completions"
echo 'fpath+=${ZSH_CUSTOM:-${ZSH:-$HOME/.oh-my-zsh}/custom}/plugins/zsh-completions/src' >>"$_REMOTE_USER_HOME/.zshrc"

# https://github.com/zsh-users/zsh-autosuggestions/blob/master/INSTALL.md
git clone 'https://github.com/zsh-users/zsh-autosuggestions' "${ZSH_CUSTOM:-${ZSH:-$_REMOTE_USER_HOME/.oh-my-zsh}/custom}/plugins/zsh-autosuggestions"
sed -ri 's/^\s*plugins=\((.*)\)/plugins=(\1 zsh-autosuggestions)/g' "$_REMOTE_USER_HOME/.zshrc"
echo 'export ZSH_AUTOSUGGEST_STRATEGY=(history completion)' >>"$_REMOTE_USER_HOME/.zshrc"

# https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/INSTALL.md
git clone 'https://github.com/zsh-users/zsh-syntax-highlighting' "${ZSH_CUSTOM:-${ZSH:-$_REMOTE_USER_HOME/.oh-my-zsh}/custom}/plugins/zsh-syntax-highlighting"
echo '. ${ZSH_CUSTOM:-${ZSH:-$HOME/.oh-my-zsh}/custom}/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh' >>"$_REMOTE_USER_HOME/.zshrc"

# https://github.com/zsh-users/zsh-history-substring-search
git clone 'https://github.com/zsh-users/zsh-history-substring-search' "${ZSH_CUSTOM:-${ZSH:-$_REMOTE_USER_HOME/.oh-my-zsh}/custom}/plugins/zsh-history-substring-search"
sed -ri 's/^\s*plugins=\((.*)\)/plugins=(\1 zsh-history-substring-search)/g' "$_REMOTE_USER_HOME/.zshrc"

# https://github.com/zdharma/history-search-multi-word#oh-my-zsh-omz
git clone 'https://github.com/z-shell/H-S-MW' "${ZSH_CUSTOM:-$_REMOTE_USER_HOME/.oh-my-zsh/custom}/plugins/H-S-MW"
sed -ri 's/^\s*plugins=\((.*)\)/plugins=(\1 H-S-MW)/g' "$_REMOTE_USER_HOME/.zshrc"
