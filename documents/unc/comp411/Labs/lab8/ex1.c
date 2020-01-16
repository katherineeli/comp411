#include<stdio.h>

int NchooseK(int n, int k);

int main() {

  int n, k, result;

 while(!(n==0||k==0)){
    scanf("%d", &n);
    scanf("%d", &k);
    if (n!=0){
     result = NchooseK(n, k);
     printf("%d\n", result);
   }
  }
}

int NchooseK(int n, int k) {
  if(n==k || k==0||n==0){
    return 1;
  }
    return NchooseK(n-1, k-1) + NchooseK(n-1, k);
}

