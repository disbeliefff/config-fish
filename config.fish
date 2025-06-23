source ~/.config/fish/aliases/aliases.fish


set -x GOPATH $HOME/go
fish_add_path --path /usr/local/go/bin $GOPATH/bin

set -g theme_powerline_fonts no
set -g theme_nerd_fonts yes
set -g theme_title_display_user yes
set -g theme_display_k8s_context yes
set -g theme_display_k8s_context yes
set -g theme_display_k8s_namespace yes
set -g theme_k8s_context_color yellow
set -g theme_k8s_namespace_color brgreen
set -g theme_display_docker_machine yes
set -g theme_git_worktree_support yes
set -g theme_color_scheme dark

for file in ~/.config/fish/completions/*.fish
    source $file
end 