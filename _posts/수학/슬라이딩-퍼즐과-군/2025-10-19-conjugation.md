---
# 포스트 제목
title: 대칭군의 켤례류와 3-cycle 분해
# author key값, _data/authors.yaml 에 있어야 정상적으로 표시됨
author: JiseokLee

# 포스트가 올라간 날짜. 한국은 GMT+09이므로 +0900 이다
date: 2025-10-19 22:20:00 +0900

# 카테고리 세팅. n개의 배열이며, 순서대로 부모->자식 관계이다
categories: [수학, 슬라이딩 퍼즐과 군]

# 태그 세팅. n 개의 배열이다.
tags: [수학, 퍼즐, 군론]

# 미리보기 이미지 세팅. 필요없으면 비워도 됨
image:
  path: /assets/img/posts/mathematics/sliding/8-conjugation/jacket.png
  alt: 다양한 군의 켤례류
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
published: true

---

> 모든 순열을 만들어 내는 법

> 참고 1 : [https://en.wikipedia.org/wiki/Parity_of_a_permutation](https://en.wikipedia.org/wiki/Parity_of_a_permutation)  
> 참고 2 : [https://dec41.user.srcf.net/notes/IA_M/groups.pdf](https://dec41.user.srcf.net/notes/IA_M/groups.pdf)  
> 참고 3 : [https://jweilhammer.github.io/sliding-puzzle-solver/](https://jweilhammer.github.io/sliding-puzzle-solver/)  

앞선 포스트에서 우리는 슬라이딩 퍼즐의 불변량을 알아보았다.  
하지만, 불변량을 알아냈다고 해서 그게 슬라이딩 퍼즐이 풀릴 수 있는지를 판별하는 직접적인 척도는 되지 못한다. 

앞서 증명된 것은, 불변량이 다른 두 퍼즐 상태가 서로 도달할 수 없다는 것이지, 
불변량이 같은 두 퍼즐 상태는 항상 도달 가능하다는 것을 증명하진 못했다. 

우리가 진짜 원하는, 퍼즐의 상태만 보고도 그것이 풀릴 수 있는지를 판별하게 위해서는, 도달 가능성까지 증명되어야 한다.

이번 포스팅은 그 증명을 위해 필요한 군론의 사전 지식을 설명한다.

## 3-cycle 분해

앞서서 우리가 마치 모든 순열을 transposition(2-cycle)들의 곱으로 나타낼 수 있음을 보인 것 처럼, 
모든 짝순열을 3-cycle들의 곱으로 나타낼 수 있음도 보일 수 있다. 

### 2-cycle을 3-cycle로 바꾸기

먼저 앞선 포스팅에서 증명한, 임의의 순열 $\sigma in S_n$에 대해 다음이 성립한다 : 

> $$\sigma = \tau_1 \tau_2 ... \tau_k, \quad \tau_i \text{ is transposition}$$
> 
> $$\text{if } \text{sgn} (\sigma) = +1, \text{ then k is even}$$
{: .prompt-info}


즉, 모든 짝순열 $\sigma \in A_n$에 대해, $\sigma = \tau_1 \tau_2 ... \tau_{2k}, k \in \mathbb{N}$인 transposition들의 곱으로 나타낼 수 있다.

이제 임의의 짝수개의 2-cycle을 3-cycle들의 곱으로 나타낼 수 있음을 보여보자. 

이를 위해 다음 두 가지 등식을 이용한다 :

1. 공통 원소가 있는 교환들 :  
$(a\ b) (b \ c) = (a\ b\ c)$

2. 공통 원소가 없는 교환들 :  
$(a\ b) (c\ d) = (a\ c\ b)(b\ d\ a)$

이제 끝났다.  

### 짝순열의 3-cycle 분해 정리

임의의 짝순열 $\sigma = \tau_1 \tau_2 ... \tau_{2k}$ 일 때, 이를 각각 다음과 같이 쪼개본다. 

$$\sigma = (\tau_1 \tau_2) (\tau_3 \tau_4) ... (\tau_{2k-1} \tau_{2k})$$

각각의 괄호 안의 2-cycle 쌍은, 두 가지 경우 밖에 없다. 공통원소가 있는 교환들이거나, 없는 교환들이거나. 
따라서 위에서 증명한 두 가지 등식을 사용하면, 각각의 2-cycle 쌍을 전부 3-cycle들의 곱으로 바꿀 수 있다. 

즉, 다음 결론이 나온다 : 

> 3-cycle decomposition theorem
>
> 임의의 짝순열 $\sigma \in A_n$은, 항상 3-cycle들의 곱으로 나타낼 수 있다 :
> $$\sigma = \rho_1 \rho_2 ... \rho_m, \quad \rho_i \text{ is 3-cycle}$$
{: .prompt-info}

즉, 모든 짝순열은, 적절한 3-cycle들의 곱으로 구성 가능하다는 뜻이다.
그 조합을 구체적으로 구성할 수도 있지만, 우리는 존재성만 보여도 충분하다.

### 홀순열은 3-cycle로 못 만드나?

그렇다면 홀순열은 3-cycle들의 곱으로 나타낼 수 있을까?  
당연히 불가능하다. 

앞서서 $sgn$ 함수의 성질로, 다음이 성립함을 보였었다 : 

$$sgn(\sigma \tau) = sgn(\sigma) \cdot sgn(\tau)$$

그런데 3-cycle은 항상 짝순열이다. 즉 $sgn(\rho_i) = +1$이다.

따라서 3-cycle만을 합성하여 만드는 모든 순열, $\sigma = \rho_1 \rho_2 ... \rho_m$에 대해서 : 

$$sgn(\sigma) = sgn(\rho_1) \cdot sgn(\rho_2) \cdot ... \cdot sgn(\rho_m) = +1$$
$$\therefore sgn(\sigma) \in A_n$$

결국 **홀순열은 3-cycle들의 곱만으로는 절대 나타낼 수 없다.**   

## conjugation

conjugation(켤례 작용)이란, 군론에서 어떤 군의 원소를 다른 원소로 감싸는 연산이다 : 

> **conjugation**
>
> $$\text{If } g, h \in G, \text{ then the conjugate of } g \text{ by } h \text{ is } hgh^{-1}.$$
{: .prompt-info}

그리고 어떠한 군 $G$의 원소 $g$에 대해, 그 원소의 모든 conjugation들을 모아놓은 집합을 그 원소의 conjugacy class(켤례류) 라고 한다. 

> **conjugacy class**
>
> $$\text{The conjugacy class of } g \text{ in } G \text{ is the set } \{ hgh^{-1} | h \in G \}.$$
{: .prompt-info}

'class'라는 단어가 보통 의미하는 '분류' 라는 뜻 처럼, conjugacy class는 군의 원소들을 conjugation에 따라 분류한 것이다.

### 순열군의 conjugacy class

그런데 순열군의 경우, conjugacy class는 매우 흥미로운 성질을 가진다 : 

> $$\text{for } \tau_n := n\text{-cycle}, $$  
> $$\text{the conjugacy class of } \tau_n \text{ in } S_m \text{ is the set of all } n\text{-cycles in } S_m.$$
{: .prompt-info}

n-cycle의 켤례류는 그 순열군 내의 모든 n-cycle들의 집합이 된다는 것이다. 

**증명(충분조건)**

n-cycle의 켤례가 반드시 n-cycle임을 보이자. 

$\tau_n = (a_1 \ a_2 \ \cdots \ a_n)$, $\alpha \in S_m$ 에 대해 다음을 생각해보자 : 

$$\alpha \tau_n \alpha^{-1}$$

순열군 $S_m$의 모든 원소들은, $m$개의 원소를 가진 집합의 전단사 함수이다.  
전단사 함수는 역함수가 항상 존재하고, 단사이므로 서로 다른 원소들을 서로 다른 원소들로 매핑한다.  
따라서, 다음이 반드시 존재한다 : 

$\alpha(a_i) = b_i, a_i = \alpha^{-1}(b_i) \quad (i = 1, 2, ..., n)$

이제 다음을 계산해보자 : 

$$\begin{align}
\alpha \tau_n \alpha^{-1} (b_1) &= \alpha \tau_n (a_1) = \alpha(a_2) = b_2 \\
\alpha \tau_n \alpha^{-1} (b_2) &= \alpha \tau_n (a_2) = \alpha(a_3) = b_3 \\
&\ \vdots \\
\alpha \tau_n \alpha^{-1} (b_n) &= \alpha \tau_n (a_n) = \alpha(a_1) = b_1 \\
\nonumber \\
\forall x \notin \{b_1, b_2, ..., b_n\}, &\text{ let } \alpha(x)^{-1} = x'\\
\alpha \tau_n \alpha^{-1} (x) &= \alpha \tau_n (x') = \alpha(x') = x \\
\end{align}$$

이를 종합하면, 사실상 다음과 같은 형태가 됨을 알 수 있다 : 

$$\begin{align}
\alpha (a_1 \ a_2 \ \cdots \ a_n) \alpha^{-1} &= (b_1 \ b_2 \ \cdots \ b_n) \\
&= (\alpha(a_1) \ \alpha(a_2) \ \cdots \ \alpha(a_n)) \\
\end{align}$$

즉, n-cycle의 켤례는 사실상 기존 n-cycle의 원소들을 다른 원소들로 치환한 또 다른 n-cycle이 됨을 알 수 있다.

**증명(필요조건)**

임의의 $n$-cycle $\tau_n = (a_1\ a_2\ ...\ a_n) \in S_m$에 대해, 임의의 $n$-cycle $\rho_n = (b_1\ b_2\ ...\ b_n) \in S_m$이 주어졌다고 하자. 이때, $\rho_n$을 $\tau_n$의 켤례로 만드는 $h \in S_m$가 존재함을 보이자. 

사실 이미 앞에서 보인 바와 같이, 다음과 같은 $h$를 정의하면 된다 :

$$h(a_i) = b_i \quad (i = 1, 2, ..., n)$$

이제 $h \tau_n h^{-1}$는, 앞의 계산과 동일하게 : 

$$\begin{align}
h \tau_n h^{-1} &= (h(a_1) \ h(a_2) \ ... \ h(a_n)) \\
&= (b_1 \ b_2 \ ... \ b_n) \\
&= \rho_n \\
\end{align}$$

가 된다. 

이렇게 서로 다른 임의의 두 n-cycle은 서로 켤례 관계임을 증명했다. 

충분조건과 필요조건을 모두 증명했으므로, 순열군에서 n-cycle의 켤례류는 모든 n-cycle에 대한 집합이 된다.

## 마치며

이로써 슬라이딩 퍼즐의 불변량에 대한 도달 가능성 증명에 필요한 사전 지식을 전부 설명했다.  
다음 포스팅에서 이 지식들을 바탕으로 슬라이딩 퍼즐의 도달 가능성을 증명할 것이다.

3-cycle이니 conjugation이니 대체 왜 나오는가 싶겠지만, 다음 포스팅에서 곧 알게 될 것이다.