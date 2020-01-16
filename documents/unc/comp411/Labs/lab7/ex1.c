#include <stdio.h>

int AA[100];  		// linearized version of A[10][10]
int BB[100];  		// linearized version of B[10][10]
int CC[100];  		// linearized version of C[10][10]
int m;       		// actual size of the above matrices is mxm, where m is at most 10

int main() {
    scanf("%d", &m);
    for(int x=0;x<m;x++){
        for(int y=0; y<m; y++){
            scanf("%d", &AA[x*m+y]);
        }
    }
    for(int x=0; x<m; x++){
        for(int y=0; y<m; y++){
            scanf("%d", &BB[x*m+y]);
        }
    }
    for(int i=0; i<m; i++){
        for(int j=0; j<m; j++){
            CC[i*m+j] = 0;
            for(int k=0; k<m; k++){
                CC[i*m+j] += AA[i*m+k]*BB[k*m+j];
            }
        }
    }
    for(int k=0; k<m; k++){
        for(int l=0; l<m; l++){
            printf("%d ", CC[k*m+l]);
        }
        printf("\n");
    }
    return 0;
}