---
typora-copy-images-to: ../algorithm
---

# 함수

![image-20190216170316555](/Users/yunsungsong/Documents/github_peter/algorithm/image-20190216170316555.png)

```c++
int getMin(int first, int scecond){
    if(first < second){
        return first;
    }
    else{
        return second;
    }
}

int main(){
    int a, b;
    int result;
    
    scanf("%d %d", &a, &b);
    
    result = getMin(a,b);
    printf("%d\n", result);
    
    return 0;
}

```

