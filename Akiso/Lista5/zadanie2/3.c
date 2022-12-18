#include <signal.h>
#include <stdio.h>
#include <unistd.h>
#include <sys/wait.h>

void handle(int dummy) {
    signal(SIGUSR1, handle);
    printf("\tI cought signall!\n");
}

int main() {
    signal(SIGUSR1, handle);
    printf("now i will send 100 SIGUSR1 to mychild, so in theory you will see that he cought it 100 times\n");

    pid_t child;

    child = fork();

    if(child == 0) {
        sleep(3);
        printf("\tEnd of work, dad, are you proud of me?\n");
        return 0;
    }

    for (int i = 0; i < 100; i++) {
        kill(child, SIGUSR1);
    }
    
    int buffor; 
    wait(&buffor);
    printf("No\n");
}