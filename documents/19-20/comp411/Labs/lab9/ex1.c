#include <stdio.h>

 int n;
// char pattern[21];

 void makepatterns(int N, char pattern[]) {
	if(N == 0){
	for(int i=n; i>0; i--){
	  printf("%d", pattern[i-1]);	//print pattern
	 }
	  printf("\n");
	} else {
	  pattern[N-1]=0;			//set left to 0
	  makepatterns(N-1,pattern);	//recursive call
	  pattern[N-1]=1;			//set left to 1
	  makepatterns(N-1,pattern);	//recursive call
	}
 }
 void main() {
	char pattern[21];	//max 20 + null
//	int n;
	scanf("%d", &n);	//read N
	pattern[n] = '\0';	//terminate string at N
	makepatterns(n, pattern); //generate all patterns
 }
