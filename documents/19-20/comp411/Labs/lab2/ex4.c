#include <stdio.h>
void main(){
 int i, n = 0;
 int numbers[6];

 printf("Enter six integers:\n");
 for(i=0;i < 6; i++) {
    scanf("%d", &n);
    numbers[i] = n;
 }
 printf("1234567890bb1234567890\n");
 printf("%10i%12i\n", numbers[0], numbers[1]);
 printf("%10i%12i\n", numbers[2], numbers[3]);
 printf("%10i%12i\n", numbers[4], numbers[5]);
}
