### Max 찾기

```c++
#include <stdio.h>

int main() {

    int data[9];
    int max = -1;
    int index = -1;

    for (int i=0; i<9; i++){
        scanf("%d", &data[i]);
    }

    for (int i=0; i<9; i++){
        if(data[i]>max){
            max = data[i];
            index = i;


        }

    }

    printf("max num: %d, loc num: %d ", max, index+1);

}
```

### 2번째 최소값 찾기

```c++
#include <stdio.h>

int main() {

    int data[9];
    int min = 99999;
    int index = 99999;

    for (int i=0; i<9; i++){
        scanf("%d", &data[i]);
    }

    for (int i=0; i<9; i++){
        if(data[i]<min){
            min = data[i];
            index = i;

        }

    }

    data[index] = 99999;
    min = 99999;

    for (int i=0; i<9; i++){
        if(data[i]<min){
            min = data[i];
            index = i;
        }

    }

    printf("max num: %d, loc num: %d ", min, index+1);

}
```

