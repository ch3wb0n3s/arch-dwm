#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

# Run startup menu if this is an interactive shell
if [[ $- == *i* ]]; then
    [[ -f ~/startup.sh ]] && . ~/startup.sh
fi