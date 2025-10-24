---
# 포스트 제목
title: 슬라이딩 퍼즐의 도달 가능성
# author key값, _data/authors.yaml 에 있어야 정상적으로 표시됨
author: JiseokLee

# 포스트가 올라간 날짜. 한국은 GMT+09이므로 +0900 이다
date: 2025-10-23 00:39:00 +0900

# 카테고리 세팅. n개의 배열이며, 순서대로 부모->자식 관계이다
categories: [수학, 슬라이딩 퍼즐과 군]

# 태그 세팅. n 개의 배열이다.
tags: [수학, 퍼즐, 군론]

# 미리보기 이미지 세팅. 필요없으면 비워도 됨
image:
  path: /assets/img/posts/mathematics/sliding/8-슬라이딩-퍼즐의-도달가능성/jacket.png
  alt: 슬라이딩 퍼즐의 모든 상태를 만들기
# 홈에 pin으로 걸어놓을지 결정한다.
pin: false

# table of content를 사용할지 여부
toc: true

# 댓글을 열지 말지
comments: true

# mathjax 사용 여부
math: true

# mermaid 차트 사용 여부
mermaid: false

# 이 포스트를 보여줄지 말지
published: false

---

> 슬라이딩 퍼즐의 모든 상태를 만들기

> 참고 1 : [https://en.wikipedia.org/wiki/Parity_of_a_permutation](https://en.wikipedia.org/wiki/Parity_of_a_permutation)  
> 참고 2 : [https://en.wikipedia.org/wiki/15_puzzle#Solvability](https://en.wikipedia.org/wiki/15_puzzle#Solvability)  
> 참고 3 : [https://dec41.user.srcf.net/notes/IA_M/groups.pdf](https://dec41.user.srcf.net/notes/IA_M/groups.pdf)  
> 참고 4 : [https://jweilhammer.github.io/sliding-puzzle-solver/](https://jweilhammer.github.io/sliding-puzzle-solver/)  


## Revisit : 슬라이딩 퍼즐의 불변량

앞선 포스트들에서 우리는 슬라이딩 퍼즐의 조각을 순열로 보고, 다음 불변량을 정의했다.

> **슬라이딩 퍼즐의 불변량(Invariant)**
>
> $$I(\sigma, a, b) = \text{sgn}(\sigma) \cdot (-1)^{a+b}$$
>
> $\sigma$는 세로가 $n$칸, 가로가 $m$칸인 슬라이딩 퍼즐에서,
> 슬라이딩 퍼즐을 현재 상태로 섞는 순열 $\sigma \in S_{nm}$로 정의된다.  
>
> 현재 빈칸의 좌표 $(a, b)$는 슬라이딩 퍼즐의 좌측 상단을 (1,1)로 하고, 우측 하단을 (n,m)으로 하는 2D 좌표계에서 나타낸다.
{: .prompt-info}

![불변량예시](/assets/img/posts/mathematics/sliding/9-슬라이딩-퍼즐의-도달가능성/invariant1.png){: width="450" height="300" }
_그림 1 : 불변량의 예시_

예를 들어, 그림 1의 슬라이딩 퍼즐의 불변량은 다음과 같다 : 

$$\begin{align}
\sigma &= (9 \ 10 \ 14 \ 13 \ 19 \ 15) (16 \ 17 \ 18 \ 20 ) \\
&= \left\{ (9 \ 10) (10 \ 14) ( 14 \ 13) (13 \ 19) (19 \ 15) \right\} \left\{ (16 \ 17) (17 \ 18) (18 \ 20) \right\}\\
\therefore \text{sgn}(\sigma) &= (-1)^{5} \cdot (-1)^{3} = 1 \\
a &= 4, b = 1 \\
\therefore I(\sigma, a, b) &= 1 \cdot (-1)^{4+1} = -1
\end{align}$$

즉, 아무리 빈칸을 움직여도 영원히 그림 2과 같은 상태로 바뀔 수 없다 : 

![불변량예시2](/assets/img/posts/mathematics/sliding/9-슬라이딩-퍼즐의-도달가능성/invariant2.png){: width="450" height="300" }
_그림 2 : 불변량이 다른 퍼즐_

그림 2의 불변량은 다음과 같다 : 

$$\begin{align}
\sigma &= (18 \ 19) \\
\therefore \text{sgn}(\sigma) &= (-1)^{1} = -1 \\
a &= 4, b = 5 \\
\therefore I(\sigma, a, b) &= -1 \cdot (-1)^{4+5} = 1
\end{align}$$

## 도달 가능성

그런데 아쉽게도 불변량에 대한 것은 반쪽자리 증명이다.

우리는 어떤 퍼즐이 풀 수 있는지가 더 궁금한데, 불변량은 단지 '어떤 퍼즐은 절대 풀 수 없다' 는 것만 알려주기 때문이다.

먼저 도달 가능성에 대해 정의하자. 

> **도달 가능성**
>
> 슬라이딩 퍼즐의 두 상태 $P_1 = (\sigma_1, a_1, b_1), P_2 = (\sigma, a_2, b_2)$가 있을 때,  
> $P_1$에서 $P_2$로 슬라이딩 퍼즐의 합법적인 움직임으로 도달할 수 있으면, 두 상태는 도달 가능하다고 한다.  
{: .prompt-info}

우리는 앞서서, 불변량이 다르면 도달 가능하지 않다 는 것을 보였다.  
즉, 위 명제의 대우인, **도달 가능하다면, 불변량이 같다** 는 것까진 보인 상태다

여기서 반대 방향도 증명한다면.  
즉, **불변량이 같다면, 도달 가능하다** 를 증명한다면, 도달 가능성과 불변량은 완전한 동치관계가 된다. 

그때부터는 도달 가능한지를 오로지 불변량만 보고 판단할 수 있게 된다. 사실상 같은 말이 되는 거니까. 

이제부터 목표는, 불변량이 같은 두 상태 $P_1 = (\sigma_1, a_1, b_1), P_2 = (\sigma_2, a_2, b_2)$가 있을 때,  
$P_1$에서 $P_2$로 슬라이딩 퍼즐의 합법적인 움직임으로 도달할 수 있음을 보이는 것이다.

먼저 다음 사항들을 고려하여 문제를 축소하자. 

### 1. 초기 빈칸의 위치는 동일하다

물론 빈칸과 조각의 구분 없이 순수한 순열로써 취급할 수도 있겠으나, 그건 우리가 생각하는 퍼즐의 가해 가능성과는 다르다.  
지금 따지는 건 어디까지나 슬라이딩 퍼즐을 풀 수 있냐는 문제이므로, 빈칸의 초기 위치가 $(a_0, b_0)$로 동일하다는 가정 하에 진행한다.  

### 2. 원점으로부의 도달 가능성만 증명

1번 가정에 의해, $P_1, P_2$의 초기 상태가 $e$로 동일하다.  
따라서, 어떠한 순열 $\rho$가 존재하여, $P_1$의 상태를 합법적으로 섞어 $P_2$가 된다고 했을 때, 
다음과 같이 분해할 수 있다 : 

$$\begin{align}
\text{let }\rho_1(P_1) &= e \quad \rho_2(P_2) = e, \quad \rho(P_1) = P_2 \\
\rho_1(P_1) & = e = \rho_2 (P_2) \\
\rho_2^{-1} \circ \rho_1 (P_1) &= P_2 \\
\therefore \rho &= \rho_2^{-1} \circ \rho_1 \\
\end{align}$$

즉, 각 상태로부터 공통 초기 상태로 도달 가능함만 보이면, 두 상태 간의 도달 가능성도 증명된다.  
$\rho, \rho_1, \rho_2 \in S_{nm}$임을 잊지 말자. 애초에 군이므로 합성도 당연히 군의 원소이다. 


### 3. 빈칸이 초기 위치에 있을 때의 짝순열만 고려
1번 가정에 의해, 초기 상태의 빈칸 위치는 $(a_0, b_0)$이다.  
이때 초기 불변량은 다음과 같다 : 

$$I(e, a_0, b_0) = \text{sgn}(e) \cdot (-1)^{a_0 + b_0} =(-1)^{a_0 + b_0}$$

이제 빈칸이 초기 위치에 없는, 즉, $(a, b) \neq (a_0, b_0)$인 상태의 임의의 불변량을 $I(\sigma, a, b)$라 하자.  
여기서 빈칸을 다시 초기 위치로 옮길 건데, 먼저 가로축을 맞추고, 다음 세로축을 맞추는 교환만으로 움직일 것이다.  
그 절차대로 빈칸을 움직이는 순열을 $\tau$라 하자.

이 규칙으로 빈칸을 움직여, 다시 빈칸이 초기 위치로 돌아온 현재 상태는 $\sigma' = \tau \sigma$가 된다.

이때, 불변량을 유지해야 하므로 다음이 성립한다.

$$\begin{align}
I(\sigma', a_0, b_0) &= \text{sgn}(\tau) \cdot \text{sgn}(\sigma') \cdot (-1)^{a_0 + b_0} \\
&= (-1)^{a_0 + b_0} \\
\therefore \text{sgn}(\tau \cdot \sigma) &= 1 \\
\end{align}$$

이제, 만약 우리가 빈칸을 초기 위치에 고정한 상태로 나머지 조각의 모든 짝순열을 합법적으로 만들 수 있음을 보인다면,  
다음이 성립한다 : 

$$\begin{align}
\text{Let } (\rho \in A_{nm}, a_0, b_0) &\text{ is reachable from } (e, a_0, b_0) \\
\text{Then } I(\tau \cdot \sigma, a, b) &\text{ is reachable from } (e, a, b)  \\
\text{As } \sigma &= \tau^{-1} \rho \\
\end{align}$$

여기서 핵심은, 빈칸을 $(a,b) \rightarrow (a_0, b_0)$ 으로 움직이는 순열, $\tau$를 기계적으로 정의할 수 있다는 것이다.  
즉, 임의의 $\sigma \in S_{nm}$에 대해서 $\tau$가 항상 존재한다는 것이 핵심이다.

현재 상태가 어떻든 간에, $\tau$와의 합성 결과는 항상 짝순열이 되므로, 만약 우리가 모든 짝순열을 만들 수 있음을 보인다면, 자동적으로 $\tau^{-1}$을 곱해서 나머지 모든 상태도 도달할 수 있음을 알 수 있다. 

결과적으로, 우리는 **빈칸을 초기 위치에 고정한 채, 나머지 조각의 모든 짝순열을 합법적으로 만들 수 있는지만 증명하면 된다.**

## 3-cycle conjugation

이제 빈칸이 초기 위치에 고정된 상태에서 나머지 조각의 모든 짝순열을 합법적으로 만들 수 있음을 보이자.  
앞서 증명한 3-cycle 분해와 conjugacy class를 이용할 것이다. 

일단 슬라이딩 퍼즐에는 아주 간단한 3-cycle이 존재하는데, 시계나 반시계 방향으로 빈칸 주변의 조각 3개를 교환하면 끝이다. 

![3-cycle예시]

다만 이 3-cycle만으로는 국소적인 싸이클만 만들 수 있다는 한계가 있다. 

여기서 순열군의 conjugacy class의 성질을 사용할 것이다. 

앞서 언급한 순열군 $S_n$의 conjugacy class의 성질은 다음과 같다 : 

> **순열군의 켤례류의 성질**
> 어떤 순열 $\sigma \in S_n$과 임의의 원소 $g \in S_n$에 대하여,  
> $\sigma$의 켤례류 $g \circ \sigma \circ g^{-1}$는 $\sigma$와 같은 cycle type을 가진다
{: .prompt-info}

즉, 원래의 $\sigma$가 3-cycle이라면, 그 켤례류는 모든 가능한 3-cycle이 될 수 있다는 뜻이다.

이를 슬라이딩 퍼즐에 적용하면, 빈칸을 고정한 상태에서 아무 3개의 조각을 서로 교환할 수 있다. 

전략은 다음과 같다

1. 행동 $\sigma \in S_{nm}$으로 원하는 3개의 조각을 빈칸 주변에 모은다. 
2. 빈칸 주변의 3개의 조각을 시계/반시계 방향으로 교환한다.
3. 행동 $\sigma^{-1}$으로 원래 위치로 조각들을 되돌린다.

이를 통해, 빈칸을 고정한 상태에서 임의의 3-cycle을 합법적으로 만들 수 있다.

그림으로 보면 이렇게 된다 

