```c++
#include <stdio.h>

int main(){
    int* address;
    int x;
    
    x = 3;
    address = &x; //x의 위치를 가진다.
    
    printf("%d\n", *address); //address 의 변수값을 출력
    printf("%p\n", address); //address가 가진 값을 출력함
    
    return 0;
}
```

