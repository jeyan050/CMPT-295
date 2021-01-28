#include <stdio.h>
#include <stdlib.h>

typedef unsigned char *byte_pointer;

void show_bytes(byte_pointer, size_t);
void show_bits(int);
void show_int(int);
void show_float(float);
void show_pointer(void *) ;
int  mask_LSbits(int);

int main() {
    int ival = 12345;
    float fval = (float) ival;
    int *pval = &ival;

    show_int(ival);
    show_float(fval);
    show_pointer(pval);

    

/* Add your test cases here in order
   to test your new functions. */
    show_bits(12345);
    show_bits(-12345);

    printf("\n");

    int test1 = mask_LSbits(32);
    int test2 = mask_LSbits(15);
    printf("%d , %d\n", test1, test2);

    return 0;

}