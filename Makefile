# Automatically generate lists of sources using wildcards.
C_SOURCES = $(wildcard kernel/*.c drivers/*.c)
HEADERS = $(wildcard kernel/*.h drivers/*.h)

# TODO: Make sources dep on all header files

# Convert the *.c filenames to *.o to give a list of object files to build
OBJ = ${C_SOURCES:.c=.o}

# Default build target
all: os-image

# Run bochs to simulate booting of our code
run: all
	bochs -f misc/bochsrc

# This is the actual disk image that the coputer loads
# which is the combination of our compiled bootsector and kernel
os-image: boot/boot_sect.bin kernel.bin
	cat $^ > os-image

# This builds the binary of our kernel from two object files:
# 	- the kernel_entry which jumps to main() in our kernel
#	- the compiled C kernel
kernel.bin: kernel/kernel_entry.o ${OBJ}
	ld -m elf_i386 -o $@ -Ttext 0x1000 $^ --oformat binary

# Generic rule for compiling C code to an object files
# For simplicity, we C files depend on all header files.
%.o : %.c ${HEADERS}
	gcc -m32 -ffreestanding -c $< -o $@

# Assemble the kernel_entry
%.o : %.asm
	nasm $< -f elf32 -o $@

%.bin : %.asm
	nasm $< -f bin -I 'boot/' -o $@

# Clean away all generated files
clean:
	rm -rf *.bin *.dis *.o os-image
	rm -rf kernel/*.o boot/*.bin drivers/*.o

# Disassemble our kernel
kernel.dis : kernel/kernel.bin
	ndisasm -b 32 $< > $@
