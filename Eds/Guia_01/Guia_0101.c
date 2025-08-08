/*
 Guia_0101.v
 842527 - Gabriel Ferreira Pereira
 Questão 01c) 
*/

#include <stdio.h>

void dec2bin ( int x ) 
{
    int bin[32];
    int i = 0;

    while (x > 0) {
        bin[i] = x % 2;
        x = x / 2;
        i++;
    }

    for (int j = i - 1; j >= 0; j--) 
    {
        printf("%d", bin[j]);
    }
    printf("\n");
    getchar();
}

int main() {
    dec2bin(163);

    return 0;
}
