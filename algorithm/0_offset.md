# Offset



```c++
#include <stdio.h>

int main() {

    int num[5][5];
    char result[5][5];

    for (int i = 0; i < 5; i++) {
        for (int j = 0; j < 5; j++) {
            scanf("%d", &num[i][j]);
        }

    }

//    for (int i = 0; i < 5; i++) {
//        for (int j = 0; j < 5; j++) {
//            printf("%d ", num[i][j]);
//        }
//
//        printf("\n");
//
//    }

    for (int i = 0; i < 5; i++) {
        for (int j = 0; j < 5; j++) {
            if(num[i][j]< num[i-1][j] && num[i][j+1] && num[i+1][j+1] && num[i][j-1]){
                result[i][j] = "*";
            }

            else {
                result[i][j] = num[i][j];
            }

        }
    }

    for (int i = 0; i < 5; i++) {
        for (int j = 0; j < 5; j++) {
            printf("%d ", result[i][j]);
        }

        printf("\n");

    }

}
```