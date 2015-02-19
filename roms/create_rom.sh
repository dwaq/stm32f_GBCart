if [ -z ${1+x} ]; then
	echo "Usage: sh create_rom.sh ROM.gb"
else
	cp $1 rom.gb
	xxd -i rom.gb | sed 's/unsigned/unsigned const/g' > rom.h
	rm rom.gb
fi
