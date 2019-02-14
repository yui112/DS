# strcpy

```c++
#include <stdio.h>
#include <string.h>

int main(){
   	char A[100];
    char B[100];
    
    scanf("%s\n", A);
    scanf("%s\n", B);
    
    printf("%s\n", A);
    printf("%s\n", B);
    
    int lenB == strlen(B);
    
    for(int i=0; i<lenB;i++){
        A[i] = B[i];
    }
    
    #strcpy(A,B); 를 하면 똑같이 할 수 있다.
    
    A[lenB] = '\0';
    
    printf("%s\n", B);
    
    return 0;
}
```



