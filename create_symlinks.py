#!/usr/bin/env python
"""Create symlinks for dotfiles."""

import os
import sys
import shutil


"""The dotfiles you wish to symlink."""
DOTFILES = {
    ".bash_aliases",
    ".bash_darwin",
    ".bash_linux",
    ".bash_profile",
    ".bashrc",
    ".gitconfig",
    ".gitexclude",
    ".config",
}
"""The home path for your user."""
HOME_PATH = os.path.expanduser('~')
"""The path to the dotfiles repository."""
REPO_PATH = os.path.dirname(os.path.abspath(os.path.join(os.getcwd(),
                                                         __file__)))


class _AlreadyExistsBase(Exception):
    def __init__(self, link_path, *args, **kwargs):
        self.link_path = link_path
        super(_AlreadyExistsBase, self).__init__(*args, **kwargs)


class InvalidLinkAlreadyExists(_AlreadyExistsBase):
    """Raised if a bad link exists where a link is to be created."""
    def __init__(self, link_path, link_dst, actual_dst, *args, **kwargs):
        self.link_dst = link_dst
        self.actual_dst = actual_dst
        super(InvalidLinkAlreadyExists, self).__init__(link_path, *args,
                                                       **kwargs)


class FileAlreadyExists(_AlreadyExistsBase):
    """Raised when a file exists where a link is to be created."""


class DirectoryAlreadyExists(_AlreadyExistsBase):
    """Raised when a directory exists where a link is to be created."""


def split_dotfile(dotfile):
    """Split dotfile path into (dirname, filename)."""
    return os.path.dirname(dotfile), os.path.basename(dotfile)


def create_directory(dirname):
    """Create the directory for dotfiles if it doesn't already exist."""
    dirpath = os.path.join(HOME_PATH, dirname)
    if not os.path.isdir(dirpath):
        os.makedirs(dirpath)


def create_symlink(dirname, filename):
    """Create the symlink to the dotfile."""
    link_path = os.path.join(HOME_PATH, dirname, filename)
    link_dst = os.path.join(REPO_PATH, dirname, filename)
    if os.path.islink(link_path):
        actual_dst = os.readlink(link_path)
        if actual_dst != link_dst:
            raise InvalidLinkAlreadyExists(link_path, link_dst, actual_dst)
    elif os.path.isdir(link_path):
        raise DirectoryAlreadyExists(link_path)
    elif os.path.exists(link_path):
        raise FileAlreadyExists(link_path)
    else:
        os.symlink(link_dst, link_path)


def main(dotfiles):  # pragma: no cover
    """Interactively create symlinks for all of the dotfiles."""
    for dotfile in dotfiles:
        dirname, filename = split_dotfile(dotfile)
        create_directory(dirname)
        try:
            create_symlink(dirname, filename)
            # TODO: give user the option to backup or diff if something
            #       already exists
        except InvalidLinkAlreadyExists as exception:
            print "Link already exists but is invalid:"
            print "  link_path", exception.link_path
            print "  link_dst:", exception.link_dst
            print "  actual_dst:", exception.actual_dst
            delete = raw_input("Do you want to replace this link? [Y/n]: ")
            if delete.lower() in ['', 'y', 'yes']:
                os.remove(exception.link_path)
                create_symlink(dirname, filename)
        except FileAlreadyExists as exception:
            print "File already exists at:"
            print "  link_path:", exception.link_path
            delete = raw_input("Do you want to delete this file? [Y/n]: ")
            if delete.lower() in ['', 'y', 'yes']:
                os.remove(exception.link_path)
                create_symlink(dirname, filename)
        except DirectoryAlreadyExists as exception:
            print "Directory already exists at:"
            print "  link_path:", exception.link_path
            delete = raw_input("Do you want to delete this directory? [Y/n]: ")
            if delete.lower() in ['', 'y', 'yes']:
                shutil.rmtree(exception.link_path)
                create_symlink(dirname, filename)


if __name__ == '__main__':
    # Additional arguments will override default behavior.
    if len(sys.argv) > 1:
        DOTFILES = set(sys.argv[1:])
        REPO_PATH = os.getcwd()
    main(DOTFILES)
