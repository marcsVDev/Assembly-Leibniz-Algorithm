all:
	nasm -f elf64 pi.asm -o pi.o
	gcc pi.o -o pi -no-pie

run: all
	./pi
