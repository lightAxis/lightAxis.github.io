---
# 포스트 제목
title: 쌍대성(Duality)-General Programming

# author key값, _data/authors.yaml 에 있어야 정상적으로 표시됨
author: JiseokLee

# 포스트가 올라간 날짜. 한국은 GMT+09이므로 +0900 이다
date: 2024-05-14 00:36:00 +0900 

# 카테고리 세팅. n개의 배열이며, 순서대로 부모->자식 관계이다
categories: [수학, 최적화]

# 태그 세팅. n 개의 배열이다.
tags: [Optimization]

# 미리보기 이미지 세팅. 필요없으면 비워도 됨
image:
  path: /assets/img/posts/mathmatics/optimization/duality-gp/jacket.jpg
  alt:  Primal 문제와 Dual 문제의 형태

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

일반 문제(General Problem)의 쌍대성(Duality)과 Duality Gap에 대해 알아보자.

> 참고 1 : [Duality (Optimization)](https://en.wikipedia.org/wiki/Duality_(optimization))   
> 참고 2 : [모두를 위한 컨벡스 최적화, Duality in General Programs](https://convex-optimization-for-all.github.io/contents/chapter11/)   
> 참고 3 : [CMU-convex optimiazation, Duality in General Programs](https://www.stat.cmu.edu/~ryantibs/convexopt/lectures/dual-gen.pdf)  

## Lagrangian & Dual function

### Lagrangian

함수 $f: \mathbb{R}^n \rightarrow \mathbb{R}$, $x \in \mathbb{R}^n$에 대해서, $m$개의 등식 제약 조건 $l_i(x)=0, i=1 \cdots m$, $p$개의 부등식 제약 조건 $h_j(x) \leq 0, j=1 \cdots r$를 가지는 최적화 문제를 생각해보자. 
모든 제약 조건과 부등식 제약 조건을 지키는 영역을 feasible set $D$라 하고, 이때의 optimal solution을 $x^* $ 라 하자.

$$\begin{align}
& \min_x f(x) \\
\text{s.t.} & \text{ } l_i(x) = 0, i=1 \cdots m \\
& h_j(x) \leq 0, j=1 \cdots r

\end{align}$$

[이전 포스트]({% post_url /수학/최적화/2023-05-13-duality-lp %}#{{"lagrangian-dual-problem" |url_encode}})에서, General Linear Program에 대한 라그랑지안을 정의했었다. 

이번에는 일반 문제(General Problem)에 대한 라그랑지안을 정의하면 다음과 같다 : 

> **Lagrangian of General Programing**
> 
> $$\begin{align}
> \mathcal{L}(x, u,v) &= f(x) + \sum_{i=1}^{m} v_i l_i(x) + \sum_{j=1}^{r} u_j h_j(x) \\
> &= f(x) + u^T g(x) + v^T h(x) \nonumber \\
> \nonumber \\
> v &\in \mathbb{R}^m , u \geq 0, \text{ where } u \in \mathbb{R}^r \nonumber \\
> \end{align}$$
{:.prompt-info}

### Dual Function

이때의 라그랑지안도 역시 다음 부등식을 만족한다 : 

$$\begin{align}
\mathcal{L}(x,u,v) &=  f(x) + \sum_{i=1}^{m} v_i \underbrace{l_i(x)}_{= 0} + \sum_{j=1}^{r} \underbrace{u_j h_j(x)}_{\leq 0}  \leq f(x), \forall x \in D \\
\nonumber \\
f^* &= f(x^* )=\min_{x\in D} f(x) \geq \min_{x\in D} \mathcal{L}(x,u,v) \geq \min_x \mathcal{L}(x,u,v) := g(u,v)\\
\end{align}$$

이때, $g(u,v)$는 라그랑지안의 최소값을 의미하고 이를 **Dual Function**이라 한다.  
Dual function은 dual feasible 한 $u \geq 0, v$에 대해 최적값 $f^* $ 의 lower bound를 제공한다. 따라서 모든 가능한 $u,v$에 대해 $g(u,v)$를 최대화 하면 제일 큰 lower bound를 얻게 된다.

이때 strong duality라는 조건이 성립한다면, 최대화 된 lower bound의 값과 원래 문제의 optimal value가 일치하게 된다. 수식으로 표현하면 $\max g(u,v) = g^* = f^* $이다.  
이러한 상황이 되면, primal 문제와 dual 문제는 같은 최적값을 가지게 된다.

예시로 다음과 같은 2차 문제를 생각해보자. $Q \succ 0$ 이다.

$$\begin{align}
\min_x & \quad \frac{1}{2}x^T Qx + c^T x = f(x) \nonumber \\
\text{s.t. } & \quad Ax=b \nonumber \\
& \quad x \geq 0
\end{align}$$

이 문제의 라그랑지안은 다음과 같다 : 

$$\begin{align}
\mathcal{L}(x,u,v) &= \frac{1}{2}x^T Qx + c^T x + u^T(-x) + v^T (Ax-b) \label{lag-qp}
\end{align}$$

이제 $u,v$에 대한 lagrangian dual function은 다음과 같다 : 

$$\begin{align}
g(u,v) &= \min_x \mathcal{L}(x,u,v) \\
\nonumber \\
\frac{\partial \mathcal{L}}{\partial x} & = Qx + c - u + A^T v = 0 \nonumber \\
\Rightarrow x^* &= Q^{-1} (u-A^T v - c) \label{lag-dual} \\
\nonumber \\
\ref{lag-qp}, \ref{lag-dual} \Rightarrow g(u,v) &= -\frac{1}{2} (u-A^T v - c)^T Q^{-1} (u-A^T v - c) - b^T v \\
\end{align}$$

이렇게 구해진 $g(u,v)$는 모든 가능한 $u,v$들에 대해 primal 문제의 최적값 $f^* $의 lower bound이다. 이제 이를 $u,v$에 대해 최대화 하면 된다.

## Duality Gap

어떤 primal 문제 $f(x)$ 에 대해 dual 문제 $g(u,v)$ 를 정의했어도, 두 문제의 최적값이 같지 않을 수 있다. 즉, $\min f(x) = f^* \neq g^* = \max g(u,v)$ 일 수 있다는 뜻이다.  
이때 두 문제의 최적값의 차이를 **Duality Gap**이라 하며, 일반적인 경우에는 $f^* \geq g^* $ 이다.

duality gap($\Delta$)은 다음과 같이 정의된다 :

$$\begin{align}
f(x) - g(u,v) = \Delta \geq 0
\end{align}$$

이때 fealible set $D$ 안의 모든 $x$에 대해 $f^* \geq g(u,v)$ 이므로,

$$\begin{align}
f(x) - f^* \leq f(x) - g(u,v) = \Delta
\end{align}$$

duality gap 이 0이 되면 양쪽 문제의 optiminal solution이 같은 값을 가리키게 된다. 그 뿐만 아니라 $f(x)- g(u,v) \leq \epsilon$ 이면 $f(x) - f^* \leq \epsilon$임을 의미하므로 iterative 한 최적화 방법에서 수렴 판정으로 duality gap을 사용할 수 도 있다.

$\Delta \geq 0$인 상황을 weak dualiy라 한다. 많은 primal-dual method들은 weak duality를 이용하여 primal 문제의 최적값과 dual 문제의 최적값을 비교하고, 이를 이용하여 양 방향에서 최적화를 동시에 수행한다.


## Strong Duality
> 참고 : [Weak Duality](https://en.wikipedia.org/wiki/Weak_duality)  
> 참고 : [Strong Duality](https://en.wikipedia.org/wiki/Strong_duality)  

$\Delta = 0$인 상황을 strong duality라 한다. 즉, primal 문제와 dual 문제의 최적값이 같은 경우를 말하며, $f^* = g^* $ 임을 뜻한다. 

strong duality를 갖추기 위한 충분조건으로는 여러가지가 있는데 자주 사용되는 것들은 다음과 같다.

- Slater's condition
- KKT condition
- Linear Programming

이 중 Slater's condition과 KKT condition이 자주 사용되는데. 

Slater's condition은 convex optimization에 대해서만 적용되는 조건이다. 이 조건은 primal 문제가 convex하고, feasible set $D$가 nonempty interior를 가지면 strong duality를 갖는다는 것이다.

다른말로 하자면, convex optimization 문제에, strictrly feasible 한 $x\in \mathbb{R}^n$이 하나라도 있으면 strong duality가 성립한다는 것이다. 
