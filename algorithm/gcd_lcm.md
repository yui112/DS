![image-20181106134045786](/Users/yunsungsong/Library/Application Support/typora-user-images/image-20181106134045786.png)

```c++
#include <stdio.h>

int main() {
    int m, n;
    scanf("%d %d", &m, &n);
    int temp = 0;
    if (n>m){
        temp = m;
        m = n;
        n = temp;
    }

    int m1 = m;
    int n1 = n;

    while(m1 % n1 !=0){
        temp = m1 % n1;
        m1 = n1;
        n1 = temp;


    }

    printf("%d\n%d", n1, m*n/n1 );

}
```