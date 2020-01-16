#include <stdio.h>
#include <string.h>
#define MAX_BUF 1024

int main () {

  char buf[MAX_BUF];
  int length, i;
  // other stuff

  do {
   // read a line
   fgets(buf, MAX_BUF, stdin);
   // calculate its length
   length = strlen(buf);
   if(length==1){
    break;
  }
   // modify the line by switching characters
   for(i=0; i<length; i++){
    if(buf[i] == 'e'|| buf[i] == 'E'){
	buf[i] = '3';
    } else if(buf[i] == 'i'||buf[i] == 'I'){
      buf[i] = '1';
    } else if(buf[i] == 'o'|| buf[i] == 'O'){
      buf[i] = '0';
    } else if(buf[i] == 's'|| buf[i] == 'S'){
      buf[i] = '5';
    }
  }
   // print the modified line
   printf("%s", buf);
  } while (length > 1);

}
