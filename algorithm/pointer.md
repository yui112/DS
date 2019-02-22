---
typora-copy-images-to: ../algorithm
---

# Pointer

- 컴퓨터 내부에 대해 알아야 함
- 값을 저장하는 것이 아닌, 값의 위치를 저장하는 변수

```c++
int main(){
    int* myPointer; //주소를 담는 변수
    int a;
    
    a = 5;
    myPointer = &a;
    
    printf("%d\n", *myPointer); //주소가 가르키는 값을 출력하라
    return 0;
}
```

![image-20190222133846573](/Users/yunsungsong/Documents/github_peter/algorithm/image-20190222133846573.png)

myPointer 의 위치에 접근하면 a를 찾을 수가 있다.

