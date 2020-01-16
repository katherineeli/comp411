#include <stdio.h>
#include <string.h>

char animals[20][15];
char lyrics[20][60];
int number;

void main(){
    int i=0, line=0;
    while(1){
        fgets(animals[i], 15, stdin);
//	animals[i][strlen(animals[i])-1] = '\0';
        fgets(lyrics[i], 60, stdin);
//	lyrics[i][strlen(lyrics[i])-1] = '\0';
        line += 2;
        if (strcmp(animals[i], "END\n") == 0){
            line -=2;
            break;
        }
        animals[i][strlen(animals[i])-1] = '\0';
        lyrics[i][strlen(lyrics[i])-1] = '\0';
        i++;
    }

    printf("There was an old lady who swallowed a %s;\n", animals[0]);
//    for(int j=1; j<line/2; j++){
//        printf("%*s", j, "");
//        printf("She swallowed the %s to catch the %s;\n", animals[j-1], animals[j]);
//    }
//
//    for(int k=line/2; k>0; k--){
//        printf("%*s", k-1, "");
//        printf("I don't know why she swallowed a %s - %s\n", animals[k-1], lyrics[k-1]);
//    }
    for (int j = 1; j < line / 2; j++){
        for (int k = 0; k < j; k++){
            printf(" ");
        }
        printf("She swallowed the %s to catch the %s;\n", animals[j-1], animals[j]);
    }

    for (int j = line / 2; j > 0; j--){
        for (int k = 0; k < j-1; k++){
            printf(" ");
        }
        printf("I don't know why she swallowed a %s - %s", animals[j-1], lyrics[j-1]);
    }
}

