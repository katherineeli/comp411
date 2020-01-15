/* Example: analysis of text */

#include <stdio.h>
#include <string.h>

#define MAX 1000 /* The maximum number of characters in a line of input */

int main()
{
  char text[MAX];
  int i, n, m, length, counter = 0;
  
  puts("Type some text (then ENTER):");
  
  /* Save typed characters in text[]: */
    
  fgets(text, MAX, stdin);
  length = strlen(text)-1;
  
  /* Analyse contents of text[]: */
  char reversed[length];
  for(i=0; text[i]!= '\0'; i++){
   m = i-1;
}
  for(n=0; n<i; n++){
   reversed[n] = text[m];
   m--;
}
  printf("Your input in reverse is:\n%s\n", reversed);
  for (i=0; i < length -1; i++){
   if(text[i]==reversed[i]){
    counter++;
  }
 }
  if (counter == length-1){
    printf("Found a palindrome!\n");
 }
}
