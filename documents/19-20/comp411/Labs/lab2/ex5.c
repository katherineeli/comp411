#include <stdio.h>
#include <stdbool.h>
void main(){
 int i, n, x, y, w, h;
 bool input;
 input = true;
 while(input){
  printf("Please enter width and height:\n");
  scanf("%d", &w);
  if(w == 0){
   input = false;
   printf("End\n");
   break;
  } else {
   scanf("\n%d", &h);
   for(i=1; i<=w;i++){
    if(i==w){
     printf("+\n");
    } else if (i == 1){
     printf("+");
    } else {
     printf("-");
    }
   } for(n=2; n<h; n++){
      for(x=1; x<=w;x++){
       if(x==w){
        printf("|\n");
       } else if (x==1){
        printf("|");
       } else {
        printf("~");
       }
      }
    } if (h>1){
     for(y=1; y<=w; y++){
       if(y==w){
        printf("+\n");
       } else if (y==1){
        printf("+");
       } else {
        printf("-");
       }
     }
   }
  }
 }
}
