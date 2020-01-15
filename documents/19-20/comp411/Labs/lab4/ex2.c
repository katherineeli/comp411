
#include <stdio.h>  /* Need for standard I/O functions */
#include <string.h> /* Need for strlen() */

#define NUM 25   /* number of strings */
#define LEN 1000  /* max length of each string */

int main()
{
  char Strings[NUM][LEN];

  printf("Please enter %d strings, one per line:\n", NUM);
  for(int j=0; j<NUM; j++){
   fgets(Strings[j], LEN, stdin);
  }

  puts("\nHere are the strings in the order you entered:");
  for (int k = 0; k<NUM; k++){
   printf("%s", Strings[k]);
  }
  /* Bubble sort */
 int compare;
 char temp[LEN];
 for(int j = 0; j<NUM; j++){
  for (int l = j+1; l<NUM; l++){
   compare = strcmp(Strings[j], Strings[l]);
   if (compare > 0){
    strcpy(temp, Strings[j]);
    strcpy(Strings[j], Strings[l]);
    strcpy(Strings[l], temp);
  }
 }
}
  /* Output sorted list */
  puts("\nIn alphabetical order, the strings are:");
  for (int i = 0; i<NUM; i++){
   printf("%s", Strings[i]);
 }

}
