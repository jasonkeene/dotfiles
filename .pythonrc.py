import sys


def interactive_setup():
    """Setup interactive interpreter with history and tab completion."""
    import os
    import atexit
    import readline

    history_path = os.path.expanduser("~/.pyhistory")  # where to store history
    history_length = 2000  # how many of lines of history to store

    # enable tab completion
    readline.parse_and_bind("tab:complete")

    # restore history if it exists
    if os.path.exists(history_path):
        readline.read_history_file(history_path)
    # save history ot exit

    def save_history(path=history_path, length=history_length):
        import readline
        readline.set_history_length(length)
        readline.write_history_file(path)
    atexit.register(save_history)


# only run on 2.7
if sys.version_info[:2] == (2, 7):
    interactive_setup()


# do not litter!
del sys, interactive_setup
