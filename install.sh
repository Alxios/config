#!/bin/bash

# Default install
DEFAULT=true
# LN contain files which will get a symlink
LN=("aliases" "ls_colors" "vim" "vimrc" "zshrc")
# DEST is the destination dir
DEST=$HOME
# SRC is the source dir
SRC="${DEST}/.dotfiles"

# display usage of the script
function usage()
{
    echo -e "Usage: $1 <options>\n"
    echo "By default the following symlink will be created :"
    for i in ${LN[@]}; do
        echo -e "\t${DEST}/.${i} -> ${SRC}/${i}"
    done
    echo ""
    echo "Suported options :"
    echo -e "\t-a|--available-files : list all available file on which you can crete symlink"
    echo -e "\t-c|--clean : delete all symlink and restore previous file if any"
    echo -e "\t-e|--existing : list all existing symlink"
    echo -e "\t-f|--files file1,file2 : give a list a files comma separated"
    echo -e "\t-h|--help : display this help"
    echo -e "\t-l|--symlink: update symlink"
    echo -e "\t-s|--submodules : init and update submodules"
    echo -e "\t-g|--geam : my personnal config /!\\ DO NOT USE IT"
    echo -e "\t--g42 : my personnal config for 42 /!\\ DO NOT USE IT"
    exit 0
}

# create the symlink
function do_ln()
{
    for i in ${LN[@]}; do
        if [[ -f "${SRC}/${i}" ]] || [[ -d "${SRC}/${i}" ]]; then
            if [[ -f "${DEST}/.${i}" ]] || [[ -d "${DEST}/.${i}" ]]; then
                mv "${DEST}/.${i}" "${DEST}/.${i}.old"
            fi
            ln -s "${SRC}/${i}" "${DEST}/.${i}"
        fi
    done
}

# delete the symlink
function rm_ln()
{
    FILES=$(ls ${SRC})
    for i in ${FILES[@]}; do
        if [[ -L "${DEST}/.${i}" ]]; then
            rm "${DEST}/.${i}"
            if [[ -f "${DEST}/.${i}.old" ]] || [[ -d "${DEST}/.${i}.old" ]]; then
                mv "${DEST}/.${i}.old" "${DEST}/.${i}"
            fi
        fi
    done
}

# list the existing symlink
function existing()
{
    FILES=$(ls ${SRC})
    for i in ${FILES[@]}; do
        if [[ -L "${DEST}/.${i}" ]]; then
            ls -l "${DEST}/.${i}"
        fi
    done
}

# redifine LN variable based on user input
function get_files_list()
{
    IFS=','
    LN=($1)
}

# get the arg of the script
while test $# -gt 0; do
    case "$1" in
        -h|--help)
            usage $0
            ;;
        -c|--clean)
            DELETE=true
            unset DEFAULT
            ;;
        -l|--symlink)
            if [[ -n "${DEFAULT}" ]]; then
                unset DEFAULT
            fi
            SYMLINK=true
            ;;
        -f|--full)
            FULL=true
            ;;
        *)
            usage $0
            ;;
    esac
    shift
done

if [[ -n "${DELETE}" ]] || [[ -n "${SYMLINK}" ]]; then
    rm_ln
fi

if [[ -n "${DEFAULT}" ]] || [[ -n "${SYMLINK}" ]]; then
    # if it's me, add the git config
    LN+=("gitconfig" "gitignore_global")

	do_ln
fi

if [[ -n "${FULL}" ]]; then
    cd $HOME
    if [[ ! -L "$HOME/sgoinfre" ]]; then
        ln -s /nfs/sgoinfre
    fi
    brew update
    source $HOME/.zshrc
    brew install htop tig
	brew install valgrind
fi
