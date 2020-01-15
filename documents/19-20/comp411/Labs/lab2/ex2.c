#include <stdio.h>

void main(){
 int i;
 double n = 0, max = 0, min = 0, product = 1, sum = 0;
 printf("Enter 10 floating-point numbers:\n");
 for (i=1; i<=10; i++){
     scanf("%lf", &n);
     sum +=n;
     product *= n;
   if (n < min){
     min = n;
 } if ( n > max) {
     max = n;
 }
}
 printf("Sum is %.5lf\nMin is %.5lf\nMax is %.5lf\nProduct is %.5lf\n", sum, min, max, product); 
}
