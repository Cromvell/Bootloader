
void main() {
    unsigned char* vidmem = (unsigned char*)0xb8000;

    vidmem[0] = 'X';
    vidmem[2] = 'Y';
    vidmem[4] = 'Z';
}