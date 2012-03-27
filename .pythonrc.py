import os
import atexit
import readline
import rlcompleter

# HISTORY_PATH = os.path.expanduser("~/.pyhistory")
HISTORY_PATH = "/Users/laocoon/.pyhistory"

# tab completion

readline.parse_and_bind("tab:complete")

# save/restore history

def save_history(path=HISTORY_PATH):
    import readline
    readline.write_history_file(path)

if os.path.exists(HISTORY_PATH):
    readline.read_history_file(HISTORY_PATH)

atexit.register(save_history)

# remove names to play nice

del os, atexit, readline, rlcompleter, save_history, HISTORY_PATH
