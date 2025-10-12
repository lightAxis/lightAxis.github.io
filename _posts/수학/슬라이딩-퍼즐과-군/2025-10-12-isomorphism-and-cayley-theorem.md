---
# 포스트 제목
title: 군 동형과 케일리 정리(Cayley's Theorem)

# author key값, _data/authors.yaml 에 있어야 정상적으로 표시됨
author: JiseokLee

# 포스트가 올라간 날짜. 한국은 GMT+09이므로 +0900 이다
date: 2025-10-12 18:15:00 +0900

# 카테고리 세팅. n개의 배열이며, 순서대로 부모->자식 관계이다
categories: [수학, 슬라이딩 퍼즐과 군]

# 태그 세팅. n 개의 배열이다.
tags: [수학, 퍼즐, 군론]

# 미리보기 이미지 세팅. 필요없으면 비워도 됨
image:
  path: /assets/img/posts/mathmatics/sliding/5-군동형-케일리정리/jacket.png
  alt: 대칭군의 위엄
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

> 군 동형과 케일리 정리란 무엇일까? 왜 '대칭군' 이라는 거창한 이름이 붙을 수 있었을까?

> 참고 1 : [https://en.wikipedia.org/wiki/Cayley%27s_theorem](https://en.wikipedia.org/wiki/Cayley%27s_theorem)  
> 참고 2 : [https://dec41.user.srcf.net/notes/IA_M/groups.pdf](https://dec41.user.srcf.net/notes/IA_M/groups.pdf)  


## 케일리 정리(Cayley's theorem)

사실 케일리 정리는 슬라이딩 퍼즐의 해결 가능성을 논할 때 쓰이진 않는다. 관심이 없다면 이 포스트는 그냥 넘어가는걸 추천한다.

하지만 군론에서 매우 중요한 정리이고, 그 내용도 가히 충격적이기에 그냥 내가 소개하고 싶어서 쓴다.

> **케일리 정리 (Cayley's theorem)**  
> 
> 모든 군 $G$는 어떤 집합 $X$에 대한 대칭군 $Sym(X)$의 부분군(subgroup)과 동형(isomorphic)이다.  
{: .prompt-info}

즉, 모든 군은 반드시 어떤 대칭군의 부분군과 똑같이 생겼다는 뜻이다.
이는 모든 군이 대칭군의 부분군으로 표현될 수 있음을 의미하며, 대칭군이 군론에서 가장 기본적이고 중요한 군임임을 시사한다.

**이제 '대칭군' 이라는 단어의 체급이 느껴지지 않는가?**  

군론이 자연에 존재하는 모든 대칭을 설명할 수 있다고 호언장담할 만 하다.

### 군 동형(Isomorphism)

케일리 정리를 이해하려면, 먼저 정의에 써 있는 동형(isomorphic)이 무엇인지 알아야 한다.

어떠한 두 군이 동형이라는 것은, 그 두 군이 구조적으로 완전히 동일하며, 사실상 같은 객체로 취급해도 된다는 뜻이다.  
즉, 하나의 군에서 나타나는 모든 성질이 동형인 다른 군에서도 똑같이 나타남을 보장한다.

군 동형은 다음과 같이 정의된다 : 

> **군 동형 (Group isomorphism)**
> 
> 두 군 $(G, \cdot)$와 $(H, \ast)$가 있을 때,  
> 만약 어떤 전단사 함수 $\phi : G \to H$가 존재하여  
> 모든 $g_1, g_2 \in G$에 대해 $\phi(g_1 \cdot g_2) = \phi(g_1) \ast \phi(g_2)$를 만족한다면,  
> 
> $G$와 $H$는 동형이며, $\phi$를 군 동형 사상(isomorphism)이라고 한다.  
{: .prompt-info}

예를 들어, 정사각형의 회전을 나타내는 순환군, $C_4$ 군을 다음과 같이 생각해보자 : 

$$\begin{align}
C_4 = \{ e, r, r^2, r^3 \}, \quad r^4 = e
\end{align}$$

이걸 다르게 표현하면 : 

$$\begin{align}
C_{4,C} = \{ 1, i, -1, -i \}, \quad i \in \mathbb{C}
\end{align}$$

도 될 수 있다. 

이때, 다음과 같은 전단사 함수 $\phi : C_4 \to C_{4,C}$를 생각해보자 :

$$\begin{align}
\phi(e) = 1, \quad \phi(r) = i, \quad
\phi(r^2) = -1, \quad \phi(r^3) = -i
\end{align}$$

이 함수는 전단사 함수이며, 모든 $g_1, g_2 \in C_4$에 대해 $\phi(g_1 \cdot g_2) = \phi(g_1) \ast \phi(g_2)$를 만족한다.
따라서, $C_4$는 자기 자신과 동형이며, $\phi$는 군 동형 사상이다.

### 군 동형의 성질

또 군 동형의 정의로부터 다음 성질들도 알 수 있다 : 

1. **항등원 보존 (Identity preservation)** :  
   만약 $\phi : G \to H$가 군 동형 사상이라면, $\phi(e_G) = e_H$이다.  

   즉, $G$의 항등원 $e_G$는 $H$의 항등원 $e_H$로 대응된다.  

   증명 :  
   $G$와 $H$가 군이고, 각각의 항등원을 $e_G$, $e_H$라고 하자.  
   모든 $g \in G$에 대해 군 동형 사상이 성립하므로, $g = e_G$도 포함된다 : 

   $$\begin{align}
    \phi(e_G \cdot e_G) &= \phi(e_G) \ast \phi(e_G) \\
    \phi(e_G) &= \phi(e_G) \ast \phi(e_G) \\
    \phi(e_G) \ast \phi(e_G)^{-1} &= \phi(e_G) \ast \phi(e_G) \ast \phi(e_G)^{-1} \\
    \therefore \quad e_H &= \phi(e_G)
   \end{align}$$

2. **역원 보존 (Inverse preservation)** :   
   만약 $\phi : G \to H$가 군 동형 사상이라면, 모든 $g \in G$에 대해 $\phi(g^{-1}) = \phi(g)^{-1}$이다.   

   즉, $G$의 원소 $g$의 역원 $g^{-1}$는 $H$의 원소 $\phi(g)$의 역원 $(\phi(g))^{-1}$로 대응된다.  

   증명 :  
   임의의 $g \in G$에 대해, 군 동형 사상이 성립하므로 : 
   $$\begin{align}
   \phi(g \cdot g^{-1}) &= \phi(g) \ast \phi(g^{-1}) \\
   \phi(e_G) &= \phi(g) \ast \phi(g^{-1}) \\
   e_H &= \phi(g) \ast \phi(g^{-1}) \\
   \therefore \quad \phi(g)^{-1} &= \phi(g^{-1})    
   \end{align}$$

1. **군의 크기 보존 (Order preservation)** :  
   만약 $\phi : G \to H$가 군 동형 사상이라면, $|G| = |H|$이다.  
   즉, $G$와 $H$의 원소의 개수는 같다.  

   증명 : $\phi$가 전단사 함수이므로, 정의역과 공역의 크기가 같다.

드디어 케일리 정리를 증명할 준비가 되었다.

## 케일리 정리의 증명

먼저 군 $G$의 원소 $g \in G$에 대해, 다음과 같은 함수 $\phi_g : G \to G$를 정의하자 :

$$\begin{align}
\phi_g(x) = g \cdot x, \quad \forall x \in
G
\end{align}$$

이 함수는 $G$의 원소 $x$에 대해, $g$를 왼쪽에서 곱하는 함수이다.

모든 $\phi_g$의 집합은 다음과 같이 정의하겠다 : 

$$\begin{align}
H = \{ \phi_g \mid g \in G \}
\end{align}$$

### $\phi_g(x)$의 전단사성 증명

먼저 이 함수가 전단사 함수임을 보이자. 

1. **단사성 증명** :  
   임의의 $x_1, x_2 \in G$에 대해 : 
   $$\begin{align}
   \phi_g(x_1) &= \phi_g(x_2) \\
   g \cdot x_1 &= g \cdot x_2 \\
   x_1 &= x_2, \quad \text{cancellation property}
   \end{align}$$

   물론 반대 방향도 성립한다.  
   즉, $x_1 = x_2 \Leftrightarrow \phi_g(x_1) = \phi_g(x_2)$가 됨에 따라, $\phi_g$는 단사 함수가 된다.

2. **전사성 증명** :  
   임의의 $y \in G$에 대해, $\phi_g(x) = y$라 하면,  
   $$\begin{align}
   \phi_g(x) = g \cdot x &= y \\
   \therefore x &= g^{-1} \cdot y \in G
   \end{align}$$    
   
   따라서, 공역의 모든 원소는 최소 하나의 정의역의 원소에 의해 대응되므로, $\phi_g$는 전사 함수도 된다.  

3. **전단사성 증명** :  
   $\phi_g$는 단사 함수이면서 전사 함수이므로, 전단사 함수가 된다. 

이 때, 이 전단사 함수의 정의역과 공역이 모두 $G$이므로,  
대칭군의 정의에 의해, $\phi_g \in Sym(G)$이다

### $H \subseteq Sym(G)$ 증명

다음으로, 모든 $\phi_g$의 집합인 $H$가 군을 이루는지 보자.

1. **항등원 존재** :  
   $G$의 항등원 $e_G$에 대해, $\phi_{e_G}(x) = e_G \cdot x = x$이므로,  
   $\phi_{e_G}$는 항등원이다.

2. **역원 존재** :  
   임의의 $\phi_g \in H$에 대해, $\phi_{g^{-1}}$가 $\phi_g$의 역원이다.  
   즉, 모든 $x \in G$에 대해 : 
   $$\begin{align}
   \phi_g(\phi_{g^{-1}}(x)) &= \phi_g(g^{-1} \cdot x) \\
   &= g \cdot (g^{-1} \cdot x) \\
   &= (g \cdot g^{-1}) \cdot x \\
   &= e_G \cdot x \\
   &= x
   \end{align}$$    

3. **닫힘성** :  
   임의의 $\phi_{g_1}, \phi_{g_2} \in H$에 대해,  
   $$\begin{align}
   (\phi_{g_1} \circ \phi_{g_2})(x) &= \phi_{g_1}(\phi_{g_2}(x)) \\
   &= \phi_{g_1}(g_2 \cdot x) \\
   &= g_1 \cdot (g_2 \cdot x) \\
   &= (g_1 \cdot g_2) \cdot x \\
   &= \phi_{g_1 \cdot g_2}(x)
   \end{align}$$    
   
   따라서, $\phi_{g_1} \circ \phi_{g_2} = \phi_{g_1 \cdot g_2} \in H$이다.

4. **결합법칙** :  
   전단사 함수의 결합 법칙에 의해 자명하게 성립한다.

따라서, $H$는 군을 이루며,  
각각의 원소가 $Sym(G)$의 원소이므로, $H \subseteq Sym(G)$이다.

### $G \cong H$ 증명

마지막으로 두 군 $G$와 $H$가 동형임을 보이자. 즉, 군 동형 사상 $\phi : G \to H$가 존재함을 보이면 된다.

다음과 같이 함수를 정의하자 :

$$\begin{align}
\phi(g) = \phi_g, \quad \forall g \in G
\end{align}$$

이 함수는 전단사 함수이며, 모든 $g_1, g_2 \in G$에 대해 :

$$\begin{align}
\phi(g_1 \cdot g_2) &= \phi_{g_1 \cdot g_2} \\
&= \phi_{g_1} \circ \phi_{g_2} \\
&= \phi(g_1) \circ \phi(g_2)
\end{align}$$   

따라서, $\phi$는 군 동형 사상이 되며,  
$G$와 $H$는 동형이다. 즉, $G \cong H$이다.

### 결론

이로써 케일리 정리가 증명되었다. 

$G$와 동형인 군 $H$는 $Sym(G)$의 부분군이므로, $G$는 $Sym(G)$의 부분군과 동형이 된다. 

## 마치며

슬라이딩 퍼즐과 아무 관련도 없지만, 괜히 이야기 하고 싶어서 쓴 케일리 정리였다. 

이 정리의 결론도 충격이지만, 증명 과정에서의 아이디어도 정말 재미있다.  
$g$를 왼쪽에서 곱하는 함수 $\phi_g$가 전단사 함수임을 이용하는 발상은 정말 기발하다.

이 증명은 나에게, 군을 단순한 원소의 집합이 아니라 함수의 집합으로도 바라보는 시각을 갖게 해준 것 같다.  
정의에만 부합하면 그 어떤 대상도 동일시하는 수학의 방식도 느낄 수 있었다. 

다음 포스팅은 순열의 부호에 대해 알아보겠다. 여기부터 본격적으로 슬라이딩 퍼즐과 관련이 생긴다.