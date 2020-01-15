#include <stdio.h>
int main(){
 int i, num;
 num = 0;
 do {
 printf("Enter a number from 1 to 20:\n");
 scanf("%d", &num);
 if (num < 1 || num > 20) {
   printf("Number is not in the range from 1 to 20\n");
   break;
 } else {
   printf("Here are the first %d ordinal numbers:\n", num);
 }
 for (i=1; i <=num; i++) {
    if(i == 1){
	printf("1st\n");
    } else  if(i == 2){
	printf("2nd\n");
    } else if(i == 3){
	printf("3rd\n");
    } else {
	printf("%dth\n", i);
    }
 }
} while(num < 1);
}
