#include <stdio.h>
#include <stdlib.h>

/*
 *  Name: Justin Yan
 *  Student Number: 301403282
 */


typedef unsigned char *byte_pointer;

void show_bytes(byte_pointer start, size_t len) {
    size_t i;

    // For 3a    
    /*
    for (i = 0; i < len; i++)
        printf("%p  0x%.2x\n", &start[i], start[i]); 
    printf("\n");	
    */

    // For 3c
    for (i = 0; i < len; i++)
        printf("%p  0x%.2x\n", (start + i), *(start + i));         
    printf("\n");
}

/*
Answer for 3b)
    I believe that the CSIL computer I'm using is a little endian computer.
    This is because from the print of show_bytes, we can see that the Most
    significant byte is stored at the smallest/lowest memory address, and the
    Least significant byte is stored in the biggest/largest.

    Example: 
        ival = 12345
        0x7ffeb33b611c  0x39
        0x7ffeb33b611d  0x30
        0x7ffeb33b611e  0x00
        0x7ffeb33b611f  0x00

        We can see that the first byte that was printed was 39, the Least 
        significant byte,  since the for loop is printing the smallest
        address first.   

*/

void show_int(int x) {
	printf("\nival = %d\n", x); 
    show_bytes((byte_pointer) &x, sizeof(int)); 
}

void show_float(float x) {
    printf("fval = %f\n", x); 	
    show_bytes((byte_pointer) &x, sizeof(float));
}

void show_pointer(void *x) {
	printf("pval = %p\n", x); 
    show_bytes((byte_pointer) &x, sizeof(void *));
}

void show_bits(int x) {
    int bits[32];
    int temp;
    // if 0, it just prints 32 0s
    if (x == 0){
        for (int i = 0; i < 32; i++)
            bits[i] = 0;

    // if greater than 0, it prints normally, as if it was unsigned.
    } else if (x > 0) {
        temp = x;
        int i = 0;
        while (temp > 0) {
            int powerTwo = 1;
            for (int power = 0; power < 31-i; power++){
                powerTwo = powerTwo * 2;
            }

            if ((temp - powerTwo) < 0){
                bits[i] = 0;
            } else {
                bits[i] = 1;
                temp = temp - powerTwo;
            }
            i++;
        }

    // if less than 0, it prints it as a signed binary number.
    } else if (x < 0) {
        temp = abs(x);
        int i = 0;
        while (temp > 0) {
            int powerTwo = 1;
            for (int power = 0; power < 31-i; power++){
                powerTwo = powerTwo * 2;
            }

            if ((temp - powerTwo) < 0){
                bits[i] = 0;
            } else {
                bits[i] = 1;
                temp = temp - powerTwo;
            }
            i++;
        }

        for(int r = 0; r < 32; r++) {
            if(bits[r] == 0){
                bits[r] = 1;
            } else {
                bits[r] = 0;
            }
        }
        if (bits[31] == 1) {
            bits[31] = 0;
            
            int check = 1;
            while(1){
                if (bits[31-check] == 1)
                    bits[31-check] = 0;
                else 
                    bits[31-check] = 1;
                    break;
            } 
        } else {
            bits[31] = 1;
        }
        
    }

    //prints the bit pattern
    for (int a = 0; a < 32; a++){
        printf("%d", bits[a]);
    }
    printf("\n");
}

int mask_LSbits(int n) {
    int mask;
    printf("%ld\n", (__CHAR_BIT__* sizeof(int)));
    if (n >= (__CHAR_BIT__ * sizeof(int)))
        mask = -1;
    else if (n <= 0)
        mask = 0;
    else 
        mask = (1 << n) - 1;
    return mask;
}