#include <stdio.h>
#include <string.h>

char animals[20][15];
char lyrics[20][60];
int  number;

void nurseryrhyme(int current) {
//  printf("%d", current);                        // print "current" number of spaces

//  printf("recursive call");                         // print something before the recursive call
  if(current == 0){                                               // you need to check if the current level is 0
   printf("There was an old lady who swallowed a %s;\n", animals[0]);     //   if so, print "There was an old lady..."
  } else if (current > 0){                                              //   or if it is > 0, print "She swallowed ..."
    printf("%*s", current, "");
    printf("She swallowed the %s to catch the %s;\n", animals[current-1], animals[current]);
  }
  if(current < number-1){                        // if we are not at the last animal, make the recursive call
    nurseryrhyme(current+1);
   // printf("%*s", current, "");
   // printf("I don't know why she swallowed a %s - %s\n", animals[current], lyrics[current]);
  }
    printf("%*s", current, "");
    printf("I don't know why she swallowed a %s - %s\n", animals[current], lyrics[current]);

}

int main(){
  int i=0;

  while (1) {
   fgets(animals[i], 15, stdin);                    // read the next animal name
   fgets(lyrics[i], 60, stdin);
   if (strcmp(animals[i], "END\n") == 0){       // if it is "END\n", we are done reading
      break;
    }
    animals[i][strlen(animals[i])-1] = '\0';    // determine the length of the string read
    lyrics[i][strlen(lyrics[i])-1] = '\0'; 
    i++;
  }
  number = i;

  nurseryrhyme(0);
}
