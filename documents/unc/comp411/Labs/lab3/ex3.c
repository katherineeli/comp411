/* Example: analysis of text */

#include <stdio.h>
#include <string.h>
#include <ctype.h>
#include <stdbool.h>

#define MAX 1000 /* The maximum number of characters in a line of input */

int main()
{
  char text[MAX];
  int i, n, m, j, k=0, l=0, p, length, counter;
  bool palindrome;

  puts("Type some text (then ENTER):");

  /* Save typed characters in text[]: */

  fgets(text, MAX, stdin);
  length = strlen(text);

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
  char invletters[MAX], lowletters[MAX];
   for(j=0; j < length; j++){
    if(!ispunct(reversed[j]) && !isspace(reversed[j])){
      invletters[k]=reversed[j];
      k++;
   }
  }
//printf("%s\n",invletters);
 int o = 0;
 while(o<k){
 lowletters[o]=tolower(invletters[o]);
 o++;
}
//printf("%s\n", lowletters);
 palindrome = true;
 counter = strlen(invletters) - 1;
 while(counter >=0){
//  if(tolower(invletters[l])!= tolower(invletters[counter])){
  if(lowletters[l] != lowletters[counter]){
    palindrome = false;
  }
  l++;
  counter--;
 }
  if (palindrome){
    printf("Found a palindrome!\n");
 }
}
