# Load bash functions
if [ -f "$BASHRC_SRC_DIR"/bash_functions ]; then
	source "$BASHRC_SRC_DIR"/bash_functions
fi

# Load bash aliases
if [ -f "$BASHRC_SRC_DIR"/bash_aliases ]; then
	source "$BASHRC_SRC_DIR"/bash_aliases
fi
