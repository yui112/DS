Temp

```c++
#include <stdio.h>

int main() {
    int n,i,j;

    scanf("%d", &n);
    int data[n+2][n+2];

    for(i=0; i<n+2; i++) {
        for (j = 0; j < n + 2; j++) {
            if (i == 0 || j == 0 || i == n + 1 || j == n + 1) {
                data[i][j] = 99999999;
            }
            else {
                scanf("%d", &data[i][j]);
            }
        }
    }

    for(i=1; i<n+1; i++){
        for(j=1; j<n+1; j++){
            bool down = data[i][j] < data[i+1][j];
            bool up = data[i][j] < data[i-1][j];
            bool left = data[i][j] < data[i][j-1];
            bool right = data[i][j] < data[i][j+1];

            if (up && down && left && right){
                printf("* ");
            }

            else {
                printf("%d ", data[i][j]);
            }
        }

        printf("\n");

        }
}


```

