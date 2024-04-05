---
# 포스트 제목
title: 물리적인 벡터의 기초 연산과 행렬 표현

# author key값, _data/authors.yaml 에 있어야 정상적으로 표시됨
author: JiseokLee

# 포스트가 올라간 날짜. 한국은 GMT+09이므로 +0900 이다
date: 2023-11-20 21:33:00 +0900 

# 카테고리 세팅. n개의 배열이며, 순서대로 부모->자식 관계이다
categories: [수학, 선형대수학]

# 태그 세팅. n 개의 배열이다.
tags: [Kinematics Dynamics]

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

> 동역학에서 사용하는 벡터들의 모든 연산 및 공식 정리


## 물리적인 벡터의 정의

기존의 숫자 2, 3, 0.4 같은 것들은 오로지 크기만을 가질 뿐, 방향은 가지지 않는다.
하지만 자석력이나 미는 힘 등은 크기 뿐만 아니라 방향도 같이 고려해야 한다. 

> 물리에서는 크기와 방향을 동시에 가진 물리량을 표현하는 것을 `벡터`라 한다.  
> 크기만 가진 것은 `스칼라` 라고 한다. 
{: .prompt-info}

> 어디까지나 물리적인 관점에서 본 벡터의 정의일 뿐이지, 수학에서 정의하는 벡터는 결이 많이 다르다.
> 수학에서의 벡터의 정의는 벡터공간(가군)의 원소이기만 하면 되며, 어떤 물리량을 나타내는 것도 아니고, 기하학적인 의미를 가지는 것도 아니다. 관점이 완전 다르다. 
> 
## 벡터의 표기

어떤 벡터 a는 통상 $\vec{a}$로 표기하며, 내용은 $\vec{a} = (a_1, a_2, \cdots , a_n)$으로 표기한다.

각각의 벡터는 성분(component)과 차원(dimension)이라는 것이 존재한다.  
- 성분은 해당 벡터 각각의 숫자(스칼라) $a_1, a_2, a_3, \cdots, a_n$ 을 말한다. 
- 차원은 성분의 개수를 말한다.   
예시에서 $\vec{a}$의 성분의 개수가 $n$개 이므로 $\vec{a}$는 $n$차원 벡터가 된다. 

> 실수 성분을 가진 n차원 벡터를 보통 다음과 같이 표기한다. 
> 
> $$\begin{align}
> \vec{a} &\in \mathbb{R}^n, \mathbb{R} : \text{Set of Real Number}& \nonumber \\
> \nonumber \\
> \vec{a} &= (a_1, a_2, \cdots, a_n) : \text{Ordered set notation} \nonumber \\[10pt]
> \vec{a} &= \begin{bmatrix}a_1 \\ a_2 \\ \vdots \\ a_n \end{bmatrix} = \begin{bmatrix}a_1 & a_2 & \cdots & a_n \end{bmatrix}^T : \text{Matrix notation} 
> \end{align}$$
{: .prompt-info}

> 참고 : [Vector Notation](https://en.wikipedia.org/wiki/Vector_notation), [Types of Numbers](https://en.wikipedia.org/wiki/List_of_types_of_numbers#Main_types)  

> 행렬 표현 방식에서 가로로 쓰는 버전도 있긴 하지만, 이는 공변벡터(Covariance), 반변벡터(Contravariance)와 관련되어 있다. 우리가 사용하는 벡터는 거의 반변벡터이므로 세로로 표기하는 경우가 많다. ([공변 벡터 & 반변 벡터](https://en.wikipedia.org/wiki/Covariance_and_contravariance_of_vectors))

> 위치를 나타내는 벡터가 반변 벡터 중 하나이며, 공변벡터는 종종 covector 또는 dual vector 라고도 부른다.

## 벡터의 연산들

다음의 0이 아닌 벡터, $\vec{a}, \vec{b} \in \mathbb{R}^n, \vec{a}=(a_1, a_2,\cdots,a_n), \vec{b} = (b_1, b_2, \cdots,b_n)$와 $\vec{a_3}, \vec{b_3} \in \mathbb{R}^3$와 스칼라 $k \in \mathbb{R}$에 대해서 다음의 연산이 가능하다

- 덧셈 뺄셈  
$\vec{a}\pm \vec{b} = (a_1 \pm b_1, a_2 \pm b_2 ,\cdots, a_n \pm b_n)$

- 스칼라곱  
$k\vec{a} = (k a_1, k a_2, \cdots, k a_n)$

- 내적  
$\vec{a} \cdot \vec{b} = a_1b_1 + a_2 b_2 + \cdots + a_n b_n$

- 외적
$\vec{a_3} \times \vec{b_3} = \left(\begin{vmatrix}a_2 & a_3 \\\ b_2 & b_3\end{vmatrix}, - \begin{vmatrix}a_1 & a_3 \\\ b_1 & b_3 \end{vmatrix}, \begin{vmatrix} a_1 & a_2 \\\ b_1 & b_2 \end{vmatrix} \right)$  
$= (a_2b_3 - a_3b_2, a_3b_1 - a_1b_3, a_1b_2 - a_2b_1)$  
행렬식을 사용해서 정의하기도 한다.   
$\begin{vmatrix}i & j & k \\\ a_1 & a_2 & a_3 \\\ b_1 & b_2 & b_3\end{vmatrix}$
> 참고 : [벡터곱](https://en.wikipedia.org/wiki/Outer_product)

- 노름(norm), 또는 크기  
$\lVert \vec{a} \rVert = \sqrt{a_1^2 + a_2^2 + \cdots + a_n^2}$

- 미분  
$\frac{d}{dt}\vec{a} = \left( \frac{d}{dt}a_1, \frac{d}{dt}a_2, \cdots , \frac{d}{dt}a_n \right)$

- 적분  
$\int{\vec{a}}=\left(\int{a_1}, \int{a_2}, \cdots , \int{a_n}\right)$
 
## 벡터 연산의 행렬 표현

보통 벡터 $\vec{a}$를 행렬 방식으로 표현하면 위의 벡터 화살표가 사라진 $a$로 표기하곤 한다. 

- 덧셈 뺄셈    
$a\pm b = \begin{bmatrix}a_1 \pm b_1 \\\ a_2 \pm b_2 \\\ \vdots \\\ a_n \pm b_n\end{bmatrix}$

- 스칼라 곱  
$ka = \begin{bmatrix} ka_1 \\ ka_2 \\ \vdots \\ ka_n \end{bmatrix}$

- 내적  
$a^Tb = a_1b_1 + a_2b_2 + \cdots + a_nb_n$

- 외적  
$[a]_\times b = \begin{bmatrix} 0 & -a_3 & a_2 \\\ a_3 & 0 & -a_1 \\\  -a_2 & a_1 & 0\end{bmatrix} \begin{bmatrix} b_1 \\\ b_2 \\\ b_3 \end{bmatrix}$
> 참고 : [Cross product matrix](https://en.wikipedia.org/wiki/Cross_product#Conversion_to_matrix_multiplication)

- 노름(norm), 크기  
$\sqrt{a^Ta} = \sqrt{\lVert \vec{a} \rVert^2} = \lVert \vec{a} \rVert$


## 벡터 연산의 기하학적 의미

예시로 0이 아닌 2차원 벡터 $\vec{a}, \vec{b} \in \mathbb{R}^2$를 들어보자. 

- 벡터  
$\vec{a} = (a_1, a_2)$  
그림1, 크기가 $\lVert \vec{a} \rVert$, 방향은 $(a_1, a_2)$쪽인 벡터

- 스칼라 곱  
$k\vec{a}$  
그림2, 벡터를 방향은 유지하고 크기만 $k$배 

- 벡터의 덧셈  
$\vec{a} + \vec{b}$  
그림3, $\vec{a}$만큼 움직인 다음 $\vec{b}$만큼 또 움직인 벡터

- 벡터의 뺄셈  
$\vec{a} - \vec{b}$  
그림4, $\vec{a}$만큼 움직인 다음 $-\vec{b}$만큼 또 움직인 벡터

- 내적  
$\vec{a} \cdot \vec{b}$  
그림5, $\lVert \vec{a} \rVert \lVert \vec{b} \rVert \cos{\theta}$의 크기를 가지는 스칼라. $\theta$는 두 벡터 사이의 각도.   
$\vec{a} \cdot \vec{b} = 0 <=> \vec{a} \bot \vec{b}$

- 외적  
$\vec{a} \times \vec{b} = \vec{c}$  
그림 6, 오른손 법칙 방향으로 두 벡터에 전부 수직. $\vec{a} \bot \vec{c}, \vec{b} \bot \vec{c}$  
결과 벡터의 길이는 다음과 같음. 
$\lVert \vec{a} \times \vec{b} \rVert = \lVert \vec{a} \rVert \lVert \vec{b} \rVert \sin{\theta}$   
$\vec{a} \times \vec{b} = 0 <=> \vec{a} \parallel \vec{b}$

## 추가적인 성질

- 분배법칙  
$k(\vec{a}+\vec{b}) = k\vec{a}+k\vec{b}$  
$\vec{a}\cdot(\vec{b}+\vec{c})=\vec{a}\cdot\vec{b} + \vec{a}\cdot\vec{c}$  
$\vec{a}\times(\vec{b}+\vec{c})=\vec{a}\times\vec{b} + \vec{a}\times\vec{c}$  

- 내적 교환법칙  
$\vec{a}\cdot \vec{b}= \vec{b} \cdot \vec{a}$

- 외적 반가환성(anti-commutativity)  
$\vec{a}\times\vec{b} = -(\vec{b} \times \vec{a})$

- 스칼라 삼중곱  
$\vec{a}\cdot(\vec{b}\times\vec{c}) = \vec{b}\cdot(\vec{c}\times \vec{a}) = \vec{c}\cdot(\vec{a}\times\vec{b})$  
3개의 벡터로 이루어진 평행육면체의 부피와 같다

- 벡터 삼중곱  
$\vec{a}\times(\vec{b} \times \vec{c}) = \vec{b}(\vec{a}\cdot \vec{c}) - \vec{c}(\vec{a}\cdot\vec{b})$  
bac-cab, 백캡 공식 이라고도 불린다. 

- 외적 행렬의 제곱  
$[v]_\times^2 = \begin{bmatrix} x^2 & xy & xz \\\ xy & y^2 & yz \\\ xz & yz & z^2 \end{bmatrix}-(x^2+y^2+z^2)I=vv^T-(v^Tv)I$


