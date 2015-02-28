#!/bin/bash

# Generate cscope & ctags index files

bp_usage () {
	echo "$(basename "$0") [directory path] -- generate cscope & ctags index files in directory path"
	exit 1
}

if [[ $# -ne 1 || !(-d $1) ]]; then
	bp_usage
fi

CSCOPE_FILE=cscope.files
CSCOPE_OUT=cscope.out
CTAGS=tags

# change to project dir
cd $1

if [ -e $CSCOPE_FILE ]; then
	rm $CSCOPE_FILE
	echo "remove cscope file map..."
fi

if [ -e $CSCOPE_OUT ]; then
	rm ${CSCOPE_OUT%.*}*${CSCOPE_OUT#*.}
	echo "remove cscope index file..."
fi

if [ -e $CTAGS ]; then
	rm $CTAGS
	echo "remove ctags file..."
fi

find . -name "*.h" -o -name "*.c" -o -name "*.cpp" -o -name "*.S" > $CSCOPE_FILE
echo "create cscope file (.h .c .cpp .S) map..."
cscope -Rbq -i $CSCOPE_FILE
echo "create cscope index file..."
ctags -R
echo "create ctags index file..."

exit 0
