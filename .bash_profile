# Add `~/bin` to the `$PATH`
export PATH="$HOME/bin:$PATH"

# Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`.
# * ~/.extra can be used for other settings you don’t want to commit.
for file in ~/.{path,bash_prompt,exports,aliases,functions,extra}
do
	[ -r "$file" ] && [ -f "$file" ] && source "$file"
done
unset file

if which rbenv &> /dev/null
then
    eval "$(rbenv init -)"
fi

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob

# Append to the Bash history file, rather than overwriting it
shopt -s histappend

# Autocorrect typos in path names when using `cd`
shopt -s cdspell

# Enable some Bash 4 features when possible:
# * `autocd`, e.g. `**/qux` will enter `./foo/bar/baz/qux`
# * Recursive globbing, e.g. `echo **/*.txt`
for option in autocd /globstar
do
	shopt -s "$option" 2> /dev/null
done

# Add tab completion for many Bash commands (requires brew install bash-completion)
if [[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]]
then
	source "/usr/local/etc/profile.d/bash_completion.sh"
fi

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2- | tr ' ' '\n')" scp sftp ssh;

# Tab completion for kubectl, (requires brew install bash-completion)
if which kubectl &> /dev/null
then
    source <(kubectl completion bash)
fi
