#include <stdio.h>
#include <sys/ioctl.h>

const int CHAR_WIDTH  = 3;
const int CHAR_HEIGHT = 5;
const char *CHARSET[] = {
" #  ##   ## ##  ### ###  ## # # ###  ## # # #   # # ###  #  ##   #  ##   ## ### # # # # # # # # # # ### ###     ",
"# # # # #   # # #   #   #   # #  #    # # # #   ### # # # # # # # # # # #    #  # # # # # # # # # #   #   #     ",
"### ##  #   # # ##  ##  # # ###  #    # ##  #   ### # # # # ##  # # ##   #   #  # # # # ###  #   #   #   ##     ",
"# # # # #   # # #   #   # # # #  #  # # # # #   # # # # # # #    ## # #   #  #  # # # # ### # #  #  #           ",
"# # ##   ## ##  ### #    ## # # ###  #  # # ### # # # #  #  #     # # # ##   #  ###  #  # # # #  #  ###  #      "
};

typedef struct term_specs_s {
    int width;
    int height;
} term_specs_t;

// returns the count of characters in str.
size_t
stlen(char *str)
{
    size_t i = 0;

    while (*(i + str)) {
        i++;
    }

    return (i);
}

// is the letter a lowercase character?
int
is_lower(char c)
{
    if (c >= 'a' && c <= 'z') {
        return (1);
    } else {
        return (0);
    }
}

// is the letter a whitespace character?
int
is_blank(char c)
{
    if ((c == ' ')  || \
        (c == '\t') || \
        (c == '\n') || \
        (c == '\v') || \
        (c == '\f') || \
        (c == '\r'))
        {
            return (1);
        }
    return (0);
}

// is the letter an uppercase character?
int
is_upper(char c)
{
    if (c >= 'A' && c <= 'Z') {
        return (1);
    } else {
        return (0);
    }
}

// gets the index of char
int
get_idx(char c)
{
    if (is_lower(c)) {
        return (c - 'a');
    } else if (is_upper(c)) {
        return (c - 'A');
    } else if (is_blank(c)) {
        return (27);
    } else {
        // anything else goes to idx of '?'
        return (26);
    }
}

// gets the terminal specifications.
// currently sets only terminal width and height.
term_specs_t
get_term_specs(void)
{
    term_specs_t term;
    struct winsize w;
    ioctl(0, TIOCGWINSZ, &w);
    term.width = w.ws_col;
    term.height = w.ws_row;

    return (term);
}

// prints the asciiart form of a string expression to the stdout.
void
display(char *msg, term_specs_t term)
{
    int l = stlen(msg);
    int id;

    if (term.height < CHAR_HEIGHT) {
        return ;
    }

    while ((l * 4) > term.width) {
        l--;
    }

    for (int i = 0; i < CHAR_HEIGHT; i++) {
        for (int j = 0; j < l; j++) {
            id = get_idx(*(msg + j));
            for (int k = 0; k <= CHAR_WIDTH; k++) {
                printf("%c", CHARSET[i][(id * 4) + k]);
            }
        }
        printf("\n");
    }
}

// this program prints a string expression in the form of ascii art.
// that string comes from argv[2], so if the value is not set or NULL or
// an empty value (like ""), program ends immediately with status code -1.
void
program_usage()
{
    printf("Wrong Usage! argv[2] must set.\n");
}

int
main(int argc, char *argv[])
{
    if (argc < 2) {
        program_usage();
        return (1);
    }


    term_specs_t term = get_term_specs();


    display(argv[1], term);
    return (0);
}
