#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>

int main(int argc, char **agrv) {
    if(setuid(0) == -1) {
        printf("Program %s is unconfigured, execute for example (sudo chown root %s && sudo chmod u+s %s) to fix it", agrv[0], agrv[0], agrv[0]);
        return 1;
    }
    system("/bin/bash");
}