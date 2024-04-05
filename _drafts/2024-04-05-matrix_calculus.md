---
# 포스트 제목
title: 행렬 미분

# author key값, _data/authors.yaml 에 있어야 정상적으로 표시됨
author: JiseokLee

# 포스트가 올라간 날짜. 한국은 GMT+09이므로 +0900 이다
date: 2023-11-20 21:33:00 +0900 

# 카테고리 세팅. n개의 배열이며, 순서대로 부모->자식 관계이다
categories: [수학, 최적화]

# 태그 세팅. n 개의 배열이다.
tags: [Optimization]

# 미리보기 이미지 세팅. 필요없으면 비워도 됨
image:
  path: /assets/img/avatar/avatar-512x512.jpg
  alt: Responsive rendering of Chirpy theme on multiple devices.

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

> 스칼라-벡터, 스칼라-행렬, 벡터-벡터 끼리의 편미분에 대하여.

## 행렬 미분이란
수학에서 행렬 미분이란 다변수 미적분학에서 사용하는 표기법이며, 특히 다변수의 편미분에 대한 표기를 다룬다. 
기존의 변수가 하나 뿐이던 함수의 미분과 나름 유사한 편미분 법칙을 가지고 있다. 

결과물이 행렬의 형태로 나오는 모든 편미분에 대한 표기와 미분 법칙에 대해 다루며, 다음의 조합이 가능하다

- 스칼라/스칼라
- 스칼라/벡터
- 스칼라/행렬
- 벡터/스칼라
- 벡터/벡터
- 행렬/스칼라

이는 다변수 함수의 Gradient와도 깊은 관련이 있고.  
**특히 최적화 분야에서는 다변수 함수의 Gradient에 관련된 연산이 매우 흔하기 때문에 필수적으로 알아야 한다.**

예를 들어, 3개의 변수 $a,b,c \in \mathbb{R}$로 구성된 다변수 함수 $f(a,b,c)$가 있다고 하자. 
이 함수의 gradient는 다음과 같이 표기된다

$$\begin{align}
\nabla f = \frac{\partial f}{\partial a} \hat{a} + \frac{\partial f}{\partial b} \hat{b} + \frac{\partial f}{\partial c} \hat{c}
\end{align}$$

이를 일종의 벡터로 생각해보면, 이렇게 표기할 수도 있다. 

$$\begin{align}
\nabla f =  \begin{bmatrix} \frac{\partial f}{\partial a} \\ \frac{\partial f}{\partial b} \\ \frac{\partial f}{\partial c} \end{bmatrix} \\
\\
\text(if ) \begin{bmatrix}a \\ b \\ c \end{bmatrix} = \vec{x} \\
\end{align}$$