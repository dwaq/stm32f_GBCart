if [ -z ${1+x} ]; then
	echo "Usage: sh create_logo.sh LOGO.png"
else
	./make_logo.py $1 logo.bin
	cp logo.bin logo_tmp.bin
	xxd -i logo.bin > logo.h
	rm logo_tmp.bin
fi
