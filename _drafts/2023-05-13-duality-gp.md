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

## Lagrangian

함수 $f: \mathbb{R}^n \rightarrow \mathbb{R}$, $x \in \mathbb{R}^n$에 대해서, $m$개의 등식 제약 조건 $l_i(x)=0, i=1 \cdots m$, $p$개의 부등식 제약 조건 $h_j(x) \leq 0, j=1 \cdots p$를 가지는 최적화 문제를 생각해보자. 
모든 제약 조건과 부등식 제약 조건을 지키는 영역을 feasible set $D$라 하고, 이때의 optimal solution을 $x^* $ 라 하자.

$$\begin{align}
& \min_x f(x) \\
\text{s.t.} & \text{ } l_i(x) = 0, i=1 \cdots m \\
& h_j(x) \leq 0, j=1 \cdots p

\end{align}$$

[이전 포스트]({% post_url /수학/최적화/2023-05-13-duality-lp %}#{{"lagrangian-dual-problem" |url_encode}})에서, General Linear Program에 대한 라그랑지안을 정의했었다. 

이번에는 일반 문제(General Problem)에 대한 라그랑지안을 정의하면 다음과 같다 : 

> **Lagrangian of General Programing**
> 
> $$\begin{align}
> \mathcal{L}(x, u,v) &= f(x) + \sum_{i=1}^{m} u_i l_i(x) + \sum_{j=1}^{p} v_j h_j(x) \\
> &= f(x) + u^T g(x) + v^T h(x) \nonumber \\
> \nonumber \\
> u &\in \mathbb{R}^m , v \geq 0, \text{ where } v \in \mathbb{R}^p \nonumber \\
> \end{align}$$
{:.prompt-info}

이때의 라그랑지안도 역시 다음 부등식을 만족한다 : 


$$\begin{align}
\mathcal{L}(x,u,v) &=  f(x) + \sum_{i=1}^{m} u_i \underbrace{l_i(x)}_{= 0} + \sum_{j=1}^{p} \underbrace{v_j h_j(x)}_{\leq 0}  \leq f(x), \forall x \in D \\
\nonumber \\
f^* &= f(x^* )=\min_{x\in D} f(x) \geq \min_{x\in D} \mathcal{L}(x,u,v) \geq \min_x \mathcal{L}(x,u,v) := g(u,v)\\
\end{align}$$

