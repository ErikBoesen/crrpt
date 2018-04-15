#include <stdio.h>
#include <string.h>
#include <stdlib.h>

int main(int argc, char* argv[]) {
    FILE *f = fopen(strcat(getenv("HOME"), "/Desktop/hey"), "w+");
    fprintf(f, "This came from launching %s!\n", argv[0]);
    fclose(f);
}
