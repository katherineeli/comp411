#include <stdio.h>

int main(){
 int A[3][3];  // matrix A
 int B[3][3];  // matrix B
 int C[3][3];  // matrix to store their sum
 int i, n;

 printf("Please enter 9 values for matrix A:\n");
 for(i=0; i<3; i++){
  for(n=0; n<3; n++){
   scanf("%d", &A[n][i]);
  }
 }
 printf("Please enter 9 values for matrix B:\n");
 for(i=0; i<3; i++){
  for(n=0; n<3; n++){
   scanf("%d", &B[n][i]);
  }
 }
 printf("C = B + A =\n");
 for(i=0; i<3; i++){
  for(n=0; n<3; n++){
   C[n][i] = A[n][i] + B[n][i];
   printf("%10d", C[n][i]);
  }
 printf("\n");
 }
 return 0;
}
