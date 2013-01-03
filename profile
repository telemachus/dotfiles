[[ -f $HOME/.bashrc ]] && source $HOME/.bashrc

trap '. $HOME/bin/kill-ssh-agent; exit' 0
