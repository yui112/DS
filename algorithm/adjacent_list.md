```c++
#include <cstdio>
#include <vector>

using namespace std;

const int Max = 100;

int main(){
    vector <int> myGraphp[Max];
    
    int n, m;
    
    scanf("%d %d", &m, &m);
    
    for (int i=0; i<m;i++){
        int a, b;
        
        scanf("%d %d", &a, &b);
        
        myGraph[a].push_back(b);
        myGraph[b].push_back(a);
        
        
    }
    
    for (int i=1;i<=n;i++){
        printf("%d : ", i);
        
        for (int j=0; j<myGraph[i].size();j++){
            printf("%d ", myGraph[i][j]);
        }
        
        print("\n")
    }
    return 0;
}
```

