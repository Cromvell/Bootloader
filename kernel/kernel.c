
void main() {
    unsigned char* vidmem = (unsigned char*)0xb8000;

    vidmem[1] = 'X';
    vidmem[3] = 'Y';
    vidmem[5] = 'Z';
}