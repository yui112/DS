# 문자열 입력 및 출력방법1

```c++
#include <stdio.h>

int main(){
    char myString[10];
    
    myString[0] = 'h';
    myString[1] = 'e';
    myString[2] = 'l';
    myString[3] = 'l';
    myString[4] = '0';
	myString[5] = '\0'; #문자열의 마지막엔 \0을 넣어줘서 문자열 끝임을 표시해줘야한다.    
    
    printf("%s\n", myString);
    return 0;
}
```

# 문자열 입력 및 출력방법2

```c++
#include <stdio.h>

int main(){
	char myString[] = "hello";
    
    printf("%s\n", myString);
    
    return 0;
}

```

# 문자열과 관련된 함수

strlen(x)		#x의 길이를 반환

stcmp(A,B) 	#A와 B가같은지 판단

strcpy(A,B)	#B를 A에 복사 



## strlen(x)

```c++
#include <stdio.h>
#incldue <string.h>

int main(){
    char A[] = "hello";
    
   	int len = strlen(A);
    printf("%d\n", len);
    
    return 0;
}
```

길이를 찾는 방법은 해당 저장소에서 \n 을 찾아서 그 위치를 출력하는 방법.

이를 직접 구현하기 위해서는 아래와 같다.

```c++
#include <stdio.h>
#incldue <string.h>

int main(){
    char myString[100];
    scanf("%s", myString); #문자열에서는 &를 넣지않고 입력받는다!
    
    #띄어쓰기 앞까지만 인식을 한다. 때문에 이를 위해서는 gets(myString) 함수를 입력하면 띄어쓰기도 인식함.
    pirntf("%s\n", myString);
    
    #길이를 출력
    int cnt = 0;
    int index = 0;
    while(1) {
        if(myString[index] == '\0'){
            break;
        }
        else {
            cnt++;
        }
        index++;
        
        printf("$d\n", cnt);
    }
    
    return 0;
    
}
```

