#include <stdio.h>

int main()
{
    for(int r = 0; r < 256; r++)
    {
        for(int g = 0; g < 256; g++)
        {
            for(int b = 0; b < 256; b++)
            {
                printf("\E[0;38;2;%d;%d;%dmHello world!\t", r, g, b);
            }
        }
    }
}