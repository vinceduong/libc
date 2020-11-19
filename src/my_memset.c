#include "libft.h"

void *my_memset(void *b, int c, size_t len)
{
    unsigned char *string = b;

    for (size_t i = 0; i < len; i++)
    {
        string[i] = c;
    }

    return (void *)string;
}
