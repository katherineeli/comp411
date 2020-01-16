
#include <stdio.h>  /* Need for standard I/O functions */
#include <string.h> /* Need for strlen() */


#define NUM 25   /* number of strings */
#define LEN 1000  /* max length of each string */


int my_compare_strings(char string1[], char string2[]) {
 int i = 0;
 while (string1[i] != '\0' || string2[i] != '\0'){
  if (string1[i] < string2[i]) {
   return -1;
  } else if (string1[i] > string2[i]){
   return 1;
  }
  i++;
 }
 return 0;
}

void my_swap_strings(char string1[], char string2[]) {
  char temp;    // char variable used in swapping one character at a time

  for (int n=0; n<LEN; n++){
   if (string1[n]=='\0' && string2[n]=='\0'){
    break;
   }
   temp = string1[n];
   string1[n] = string2[n];
   string2[n] = temp;
 }
}


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
 for(int j = NUM -1; j> 0; j--){
  for (int l = 0; l<j; l++){
   compare = my_compare_strings(Strings[l], Strings[l+1]);
   if (compare ==1){
    my_swap_strings(Strings[l], Strings[l+1]);
  }
 }
}
  /* Output sorted list */
  puts("\nIn alphabetical order, the strings are:");
  for (int i = 0; i<NUM; i++){
   printf("%s", Strings[i]);
 }

}
