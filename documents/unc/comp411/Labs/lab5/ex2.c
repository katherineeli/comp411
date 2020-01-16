#include <stdio.h>

int A[10][10];
int B[10][10];
int C[10][10];

int main() {
  int n;
  scanf("%d", &n);
  for(int x=0;x<n;x++){
   for(int y=0; y<n; y++){
    scanf("%d", &A[x][y]);
  }
 }
  for(int x=0; x<n; x++){
   for(int y=0; y<n; y++){
    scanf("%d", &B[x][y]);
   }
  }
  for(int i=0; i<n; i++){
   for(int j=0; j<n; j++){
    C[i][j] = 0;
    for(int k=0; k<n; k++){
     C[i][j] += A[i][k]*B[k][j];
   }
  }
 }
  for(int k=0; k<n; k++){
   for(int l=0; l<n; l++){
    printf("%6d", C[k][l]);
   }
   printf("\n");
  }
 return 0;
}
