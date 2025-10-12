---
# 포스트 제목
title: Primal-Dual Interior Point Method

# author key값, _data/authors.yaml 에 있어야 정상적으로 표시됨
author: JiseokLee

# 포스트가 올라간 날짜. 한국은 GMT+09이므로 +0900 이다
date: 2024-05-17 00:36:00 +0900 

# 카테고리 세팅. n개의 배열이며, 순서대로 부모->자식 관계이다
categories: [수학, 최적화]

# 태그 세팅. n 개의 배열이다.
tags: [Optimization]

# 미리보기 이미지 세팅. 필요없으면 비워도 됨
image:
  path: /assets/img/posts/mathematics/optimization/primal-dual-ipm/jacket.jpg
  alt:  primal과 dual 양쪽에서 동시에 수렴하는 모습

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

primal 과 dual 문제를 동시에 고려하여 centering step을 한단계로 줄이는 primal-dual interior point method에 대해서 알아보자.

> 참고 1 : [Interior point method](https://en.wikipedia.org/wiki/Interior-point_method)   
> 참고 2 : [모두를 위한 컨벡스 최적화, primal-dual interior point method](https://convex-optimization-for-all.github.io/contents/chapter17/)   
> 참고 3 : [CMU-convex optimiazation, primal-dual interior point method](https://www.stat.cmu.edu/~ryantibs/convexopt/lectures/primal-dual.pdf)  

직전의 포스트에서 소개한 [Interior point method]({% post_url /수학/최적화/2023-05-16-interior-point-method %}) 를 변형한 것이다.

Primal과 Dual 문제를 동시에 고려함으로써 centering step에서 반드시 feasible 해야 한다는 제한을 완화시켰다. 동시에 newton step 방식도 변경되어 inner iteration이 없고, 기존에 비해 정확도가 높다. 

## Revisits

KKT 조건을 다시 한번 상기해보자. 

최적화 문제를 다음과 같이 정의하자.

$$\begin{align}
\min_{x} & \quad f(x) \nonumber \\
\text{s.t.} & \quad h_i(x) \leq 0, i=1 \cdots m \nonumber \\
& \quad l_j(x) \leq 0, j=1 \cdots r
\end{align}$$

이 문제의 lagrangian은 다음과 같다 : 

$$L(x, u, v) = f(x) + \sum_{i=1}^{m} u_i h_i(x) + \sum_{j=1}^{r} v_j l_j(x), u_i \geq 0$$

Interior point method에서 사용했던 perturbed KKT 조건은 다음과 같다.

$$\begin{align}
\nabla f(x) + \sum_{i=1}^{m} u_i \nabla h_i(x) + \sum_{j=1}^{r} v_j \nabla l_j(x) &= 0 \label{pkkt-1}  \\
l_j(x) &= 0  \label{pkkt-2} \\
h_j(x) &\leq 0 \label{pkkt-3}  \\
u_i &\geq 0 \label{pkkt-4}\\
u_i h_i(x) &= \tau\\
\end{align}$$

이전 포스트에서 $\tau = -\frac{1}{t}$ 였다. 

이때, perturbed KKT 조건 중에서 등식 부분만을 행렬을 사용해 다시 표기하면 다음과 같다. 

$$\begin{align}
\nabla f(x) + \nabla h(x) u + \nabla l(x) v & = 0 \label{mpkkt-1} \\
U h(x) + \tau \mathbb{1} &= 0 \label{mpkkt-2} \\
l(x) &= 0 \label{mpkkt-3} \\
u, -h(x) &> 0\label{mpkkt-4} \\
\nonumber \\
h(x) = \begin{bmatrix} h_1(x) \\ \vdots \\h_m(x) \end{bmatrix}, \quad l(x) = \begin{bmatrix} l_1(x) \\ \vdots \\l_r(x) \end{bmatrix}&, \nonumber \\
u = \begin{bmatrix} u_1 \\ \vdots \\u_m \end{bmatrix}, \quad v = \begin{bmatrix} v_1 \\ \vdots \\v_r \end{bmatrix}&, \nonumber \\
\mathbb{1} = \begin{bmatrix} 1 \\ \vdots \\1 \end{bmatrix}, U = diag(u) & \nonumber
\end{align}$$

## Primal-Dual Newton Step

이제 primal-dual interior point method를 살펴보자. 

먼저 우리가 0으로 만들어야 할 residual, $r$을 다음과 같이 정의한다 : 

$$\begin{align}
r(x,u,v) = \begin{bmatrix} \nabla f(x) + \nabla h(x) u + \nabla l(x) v \\ U h(x) + \tau \mathbb{1} \\ l(x) \end{bmatrix}
\end{align}$$

이는 perturbed kkt 식을 바탕으로 0이 되어야 하는 값들($\ref{mpkkt-1}$,$\ref{mpkkt-2}$,$\ref{mpkkt-3}$)을 정리한 것이다. 

이제 $r=0$으로 만들기 위해, 1차 테일러 근사를 사용하여 다음과 같이 풀어쓸 수 있다.

$$\begin{align}
r(x + \Delta x, u + \Delta u, v + \Delta v) &\approx r(x,u,v) + \begin{bmatrix} \nabla r(x,u,v) \end{bmatrix} \begin{bmatrix} \Delta x \\ \Delta u \\ \Delta v \end{bmatrix} = 0 \\
\nonumber \\
&\therefore \nabla r(x,u,v) \begin{bmatrix} \Delta x \\ \Delta u \\ \Delta v \end{bmatrix} = -r(x,u,v) 
\end{align}$$

1차 테일러 근사를 한 결과를 0으로 만들 수 있는 $\Delta x, \Delta u, \Delta v$를 찾는 것이 primal-dual interior point method의 목표이다.

이때, $[\nabla r(x,u,v)]$를 크게 풀어 쓰면, 다음과 같다 : 

$$\begin{align}
&\nabla r(x,u,v)\begin{bmatrix}\nabla x \\ \nabla u \\ \nabla v\end{bmatrix}  \nonumber \\[1em]
&=\begin{bmatrix} \nabla^2 f(x) + \sum_i u_i \nabla^2 h_i(x) + \sum_j v_j \nabla^2 l_j(x) & \nabla h(x) & \nabla l(x) \\
U \nabla h(x)^T & diag(h(x)) & 0 \\
\nabla l(x)^T & 0 & 0
\end{bmatrix} \begin{bmatrix} \nabla x \\ \nabla u \\ \nabla v\end{bmatrix} \nonumber \\
&= -r(x,u,v)
\end{align}$$

이제 $[\nabla r(x,u,v)]^{-1}$을 구하면, 현재 $\Delta x, \Delta u, \Delta v$를 구할 수 있고, 이를 이용하여 다음과 같이 업데이트를 할 수 있다.

$$\begin{align}
\begin{bmatrix} x \\ u \\ v \end{bmatrix}_{k+1} &= \begin{bmatrix} x \\ u \\ v \end{bmatrix}_{k} + \theta_k \begin{bmatrix} \Delta x \\ \Delta u \\ \Delta v \end{bmatrix} \\
&= \begin{bmatrix} x \\ u \\ v \end{bmatrix}_{k} - \theta_k [\nabla r(x,u,v)]^{-1} r(x,u,v)

\end{align}$$

지금까지의 과정에서 feasible set $D$ 안에 $x$가 위치해야 한다는 제약이 없음을 알 수 있다. 

이때, $\theta_k$는 step size로, backtracking line search를 약간 변형하여 결정된다.

## Multi-stage backtracking line search

step size, $\theta_k$를 결정할 떄, 아직 고려하지 못했던 부등식 조건, $\ref{mpkkt-4}$ 이 만족하도록 하는 step size로 정하는 것이 중요하다. 

Primal-Dual Newton Step은 iterative하지 않기 때문에 정확한 해가 아니라, 해의 방향만 구한 것으로 볼 수 있다. 따라서 $\theta_k$를 적절하게 골라서 feasible set을 유지하도록 해야 한다.

알고리즘의 각 스텝에서 구하는 변수를 다음과 같이 표현하자.

$$\begin{align}
x^+ = x + \theta \Delta x, \quad u^+ = u + \theta \Delta u, \quad v^+ = v + \theta \Delta v
\end{align}$$

이때, 다음 목적을 가지고 $\theta$를 찾는다.
- $u > 0$이 될 것
- $h(x) < 0$ 이 될 것
- $\lVert r(x,u,v) \rVert$ 을 감소시킬 것

위 조건들을 만족하는 step size를 찾기 위해 다단계 백트래킹 라인 서치(multi-stage backtracking line search)를 사용한다.

미리 파라미터 $\alpha, \beta \in (0,1)$을 정하고 들어간다. 보통 $\alpha = 0.5, \beta = 0.9$로 많이 사용한다. 

**1. Dual Feasibility**

$u^+ = u + \theta \Delta u >0$을 만족하는 제일 큰 $\theta_{max}$를 찾는다. 단, $\theta_{max} \leq 1$의 상한 안에서.

**2. Primal Feasibility**

$\theta = 0.99 \theta_{max}$로 초기화 한 후, $h(x^+) = h(x + \theta \Delta x) < 0$ 를 만족할 때 까지 $\theta = \beta \theta$로 업데이트 하면서 찾는다.

**3. Line Search**

$\lVert r(x^+, u^+, v^+) \rVert_2 \leq (1-\alpha \theta)\lVert r(x,u,v) \rVert_2$를 만족할 때 까지 $\theta = \beta \theta$로 업데이트 하면서 찾는다. 

이렇게 찾은 $\theta$를 사용하여 primal-dual 변수를 업데이트 한다. 


## Primal-Dual Interior Point Method

이제 primal-dual interior point method를 정리하면 이렇다.

기존의 [Interior Point Method]({% post_url /수학/최적화/2023-05-16-interior-point-method %}#{{"path-following-method" |url_encode}})에서의 변수를 조금 변형하여 다음과 같이 정의한다.

$$\begin{align}
\tau(x,u) &= -\frac{h(x)^T u} {m}, \\
\tau &= \frac{1}{t}, \quad t > 0, \\
\sigma &= \frac{1}{\mu}, \quad \mu > 1,
\end{align}$$

$t$는 barrier function의 가파른 정도를 나타내며, 클 수록 더 가파르다. $\mu$는 매 step마다 $t=\mu t$로 업데이트 하여 barrier function을 가파르게 만드는 파라미터이다. 

이제 Primal-Dual 알고리즘은 다음과 같다.

> **Primal-Dual Interior Point Method**
> 
> 1. $\sigma \in (0,1)$ 을 고른다. 
> 2. $(x_0, u_0, v_0)$ 을 고른다. 이때 $h(x_0) < 0, u_0 > 0$ 이어야 한다
> 3. $k=0, 1, \cdots$에 대해 다음을 반복한다.  
> _Newton Step_  
> 3-1. $(x,u,v) = (x_k, u_k, vk0)$  
> 3-2. $\tau = \sigma \tau(x_k, u_k)$를 계산한다.  
> 3-3. 이때의 $(\Delta x, \Delta u, \Delta v)$를 계산한다.   
> _Multi-stage backtracking line search_  
> 3-4. $\theta_k$를 계산한다.  
> _Primal-Dual Update_  
> 3-5. $(x_{k+1}, u_{k+1}, v_{k+1}) = (x_k, u_k, v_k) + \theta_k (\Delta x, \Delta u, \Delta v)$  
> 3-6. $-h(x_{k+1})^Tu \leq \epsilon$ 그리고 $(\lVert r_{prim} \rVert_2^2 + \lVert r_{dual} \rVert_2^2)^{1/2} \leq \epsilon$ 이면 종료한다.  
{:.prompt-info}