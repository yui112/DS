---
typora-copy-images-to: ../algorithm
---

```c++
int getMin(int first, int second){
    if(first<second)
        return first;
    else
        return second;
}

int main(){
    int a,b, result;
    scanf("%d %d", &a, &b);
    result = getMin(a,b);
    printf("%d\n", result);
    return 0;
}


```

![image-20190220184438925](/Users/yunsungsong/Documents/github_peter/algorithm/image-20190220184438925.png)



void는 반환값이 없을 때

```c++
void printStars(int c){
    for(int i=0;i<c;i++){
        printf("n")
    }
}

int main(){
    int n;
    scanf("%d", &n);
    
    for(int i=0;i<n;i++){
        printStars(n);
        printf("\n");
    }
}
```

![image-20190220184801659](/Users/yunsungsong/Documents/github_peter/algorithm/image-20190220184801659.png)

여기서 i 는 서로 다른 변수임