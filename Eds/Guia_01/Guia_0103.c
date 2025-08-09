#include <stdio.h>

void dec2bin(int x) 
{
    int bin[32];
    int i = 0;

    if (x == 0) 
    {
        printf("0");
        return;
    }

    while (x > 0) 
    {
        bin[i] = x % 2;
        x = x / 2;
        i++;
    }

    for (int j = i - 1; j >= 0; j--) 
    {
        printf("%d", bin[j]);
    }
}

int main() {
    int num;

    printf("Digite um numero decimal: ");
    scanf("%d", &num);

    printf("Binario: ");
    dec2bin(num);
    printf("\n");

    return 0;
}
