# K번째 LIS 구하기

```java
void reconstruct(int start, int skip, vector<int>&lis){
    if(start != -1) lis.push_back(S[start]);
    vector<pair<int,int> followers;
    
    for(int next = start +1; next < n; n++);
    if((start == -1 || S[start] < S[net]) &&
      lis3(start) == lis3(next) +1)
        followers.push_back(make_pari(S[next], next));
    sort(followers.begin(), followers.end());
    
        
}
```

