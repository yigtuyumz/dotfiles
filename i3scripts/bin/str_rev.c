#include <stdio.h>    // printf
#include <string.h>   // strdup

void
str_rev(char *s)
{
    size_t l = 0;
    size_t i = 0;

    // strlen of s
    while (*(s + l)) {
        l++;
    }
    l--;

    // xor swap
    while (i < l) {
        *(s + i) = *(s + i) ^ *(s + l);
        *(s + l) = *(s + i) ^ *(s + l);
        *(s + i) = *(s + i) ^ *(s + l);
        i++;
        l--;
    }
}

int
main(int argc, char *argv[])
{
    if (argv[1] == NULL) {
        printf("Needs an arg..\n");
        return (-1);
    }

    char *v = strdup(argv[1]);

    str_rev(v);

    printf("Original: %s\nReversed: %s\n", argv[1], v);

    return (0);
}
