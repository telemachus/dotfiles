#!/usr/bin/env dash

set -e

hic=$PWD

brew install --build-from-source --with-default-names lua53

for mod in tapered tableutils split luacov luacheck luaposix
do
	luarocks install ${mod}
done

cd $HOME/projects

if [ ! -d lua-getopt ]; then
	git clone https://telemachus@bitbucket.org/telemachus/lua-getopt.git
fi
cd $HOME/projects/lua-getopt && luarocks make

cd $HOME/projects

if [ ! -d lua-utilitybelt ]; then
	git clone https://telemachus@bitbucket.org/telemachus/lua-utilitybelt.git
fi
cd $HOME/projects/lua-utilitybelt && luarocks make

cd $hic
