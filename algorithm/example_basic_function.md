---
typora-copy-images-to: ../algorithm
---

```c++
for(int i=0; i<n; i++){
    printSpace(n-i-1); //공백출력
    printStar(i+1); //별 출력
    printNewLine(); //한줄 띄우는 것
       
}
```



![image-20190221163308049](/Users/yunsungsong/Documents/github_peter/algorithm/image-20190221163308049.png)

```c++
void printSpace(int s){
    for(int i=0;i<s;i++){
        printf(" ");
    }
}

void printStar(int s){
    for(int i=0;i<s;i++){
        printf("*");
    }
}

void printNewLine(){
    printf("\n")
}
```

