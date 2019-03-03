![image-20190303181101984](/Users/yunsungsong/Library/Application Support/typora-user-images/image-20190303181101984.png)

```c++
priorityQueue myPG:

myPQ.push(1)
myPQ..push(4)
mypQ.pop()
    
print myPQ.top()
```

```c++
#incldue <stio.h>

const int MAX = 100;

struct priorityQueue {
    int data[MAX];
    int len = 0;
    
    void push(int x) {
        data[len++] = x;
    }    
    
    void pop(){
        //1. 우선순위가 가장 높은원소를 찾는다.
        //2, 그원소를 제거하고 뒤의 원소를 앞으로 땡긴다
        
        int myMax = -98765522, myMaxInx = -1;
        
        for(int i=0;i<len;i++){
            if(data[i] > myMax){
                myMax = data[i];
                myMaxInx = i
            }
        }
    }
}


```

