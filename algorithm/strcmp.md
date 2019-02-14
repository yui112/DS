# strcmp(A,B)

두 문자열이 같은지를 비교

1. 길이가 같아야 함
2. 위치별 문자가 같아야 함
3. 같으면 0을 반환, 아니면 음수 또는 양수를 반환하여 결과를 판단한다.

```c++
#include <stdio.h>
#include <string.h>

int main(){
    char A[100], B[100];
    
    scanf("%s", A);
    scanf("%s", B);
    
    int lenA, lenB;
    
    lenA = strlen(A);
    lenB = strlen(B);
    
    if(lenA == lenB) {
        bool flag = false;
        
        for(int i=0;i<lenA;i++){
            if(A[i] != B[i]){
                flag = true;
                
            }
        }
        if{flag == true}{
            printf("Different\n");
            }
        else printf("Same!\n");
        	}
    else {
        printf("Different!\n");
    }
    
    return 0;
}
```

```c++
#include <stdio.h>
#include <string.h>

int main(){
    char A[100], B[100];
    
    scanf("%s", A);
    scanf("%s", B);
    
    if(strcmp(A,B) == 0) printf("Same!\n");
    else printf("Different!\n");
    
    return 0;
}
```

