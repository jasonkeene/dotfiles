import os

from mock import patch
import pytest

import create_symlinks
from create_symlinks import split_dotfile, create_directory, create_symlink


# split_dotfile

@pytest.mark.parametrize(('dotfile', 'result'), [
    ('.testrc', ('', '.testrc')),
    ('.dirname/testfile', ('.dirname', 'testfile')),
    ('.dirname/nested/testfile', ('.dirname/nested', 'testfile')),
])
def test_split_dotfile(dotfile, result):
    assert split_dotfile(dotfile) == result


# create_directory

@pytest.mark.parametrize("dirname", [
    '',
    '.test_dirname',
    '.nested/test_dirname',
    '.multi/nested/test_dirname',
])
def test_create_directory(tmpdir, dirname):
    test_home_dir = str(tmpdir.join('test_home_dir'))
    dirpath = os.path.join(test_home_dir, dirname)
    with patch('create_symlinks.HOME_PATH', new=test_home_dir):
        create_directory(dirname)
        assert os.path.isdir(dirpath)


@pytest.mark.parametrize("dirname", [
    '',
    '.test_dirname',
    '.nested/test_dirname',
    '.multi/nested/test_dirname',
])
def test_dirname_already_exists(tmpdir, dirname):
    test_home_dir = str(tmpdir.join('test_home_dir'))
    dirpath = os.path.join(test_home_dir, dirname)
    os.makedirs(dirpath)
    with patch('create_symlinks.HOME_PATH', new=test_home_dir):
        create_directory(dirname)
        assert os.path.isdir(dirpath)


# create_symlink

@pytest.mark.parametrize("presplit_dotfile", [
    ('', '.test_dotfile'),
    ('.dirname', 'test_dotfile'),
    ('.nested/dirname', 'test_dotfile'),
    ('.multi/nested/dirname', 'test_dotfile'),
])
def test_create_symlink(tmpdir, presplit_dotfile):
    test_home_dir = str(tmpdir.join('test_home_dir'))
    test_repo_dir = '/test/repo/path'
    with patch('create_symlinks.HOME_PATH', new=test_home_dir):
        create_directory(presplit_dotfile[0])
        with patch('create_symlinks.REPO_PATH', new=test_repo_dir):
            link_path = os.path.join(test_home_dir, *presplit_dotfile)
            link_dst = os.path.join(test_repo_dir, *presplit_dotfile)
            create_symlink(*presplit_dotfile)
            assert os.path.islink(link_path)
            assert os.readlink(link_path) == link_dst


def test_symlink_already_exists(tmpdir):
    dirname = '.dirname'
    dotfile = 'test_dotfile'
    test_home_dir = str(tmpdir.join('test_home_dir'))
    test_repo_dir = '/test/repo/path'
    with patch('create_symlinks.HOME_PATH', new=test_home_dir):
        create_directory(dirname)
        with patch('create_symlinks.REPO_PATH', new=test_repo_dir):
            link_path = os.path.join(test_home_dir, dirname, dotfile)
            link_dst = os.path.join(test_repo_dir, dirname, dotfile)
            os.symlink(link_dst, link_path)
            create_symlink(dirname, dotfile)
            assert os.path.islink(link_path)
            assert os.readlink(link_path) == link_dst


def test_symlink_already_exists_but_with_different_target(tmpdir):
    dirname = '.dirname'
    dotfile = 'test_dotfile'
    test_home_dir = str(tmpdir.join('test_home_dir'))
    test_repo_dir = '/test/repo/path'
    with patch('create_symlinks.HOME_PATH', new=test_home_dir):
        create_directory(dirname)
        with patch('create_symlinks.REPO_PATH', new=test_repo_dir):
            link_path = os.path.join(test_home_dir, dirname, dotfile)
            link_dst = os.path.join(test_repo_dir, dirname, dotfile)
            os.symlink('/bad/target', link_path)
            with pytest.raises(create_symlinks.InvalidLinkAlreadyExists):
                create_symlink(dirname, dotfile)


def test_file_already_exists(tmpdir):
    dirname = '.dirname'
    dotfile = 'test_dotfile'
    test_home_dir = str(tmpdir.join('test_home_dir'))
    test_repo_dir = '/test/repo/path'
    with patch('create_symlinks.HOME_PATH', new=test_home_dir):
        create_directory(dirname)
        with patch('create_symlinks.REPO_PATH', new=test_repo_dir):
            link_path = os.path.join(test_home_dir, dirname, dotfile)
            link_dst = os.path.join(test_repo_dir, dirname, dotfile)
            open(link_path, 'w').close()
            with pytest.raises(create_symlinks.FileAlreadyExists):
                create_symlink(dirname, dotfile)
