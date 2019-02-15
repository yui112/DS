---
typora-copy-images-to: ../algorithm
---

# 함수

```c++
int getSum(int first, int second){
    return first + second;
}

it main(){
    int a, b;
    int result;
    
    scanf("%d %d", &a, &b);
    
    result = getSum(a,b);
    
    printf("%d\n", result);
    
    return 0;
}
```

