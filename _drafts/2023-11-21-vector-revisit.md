---
# 포스트 제목
title: 벡터 기초 연산

# author key값, _data/authors.yaml 에 있어야 정상적으로 표시됨
author: JiseokLee

# 포스트가 올라간 날짜. 한국은 GMT+09이므로 +0900 이다
date: 2023-11-20 21:33:00 +0900 

# 카테고리 세팅. n개의 배열이며, 순서대로 부모->자식 관계이다
categories: [역학, 동역학]

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

## 벡터의 연산들

다음의 벡터, $\vec{a}, \vec{b} \in \mathbb{R}^n, \vec{a}=(a_1, a_2,\cdots,a_n), \vec{b} = (b_1, b_2, \cdots,b_n)$와 $\vec{a_3}, \vec{b_3} \in \mathbb{R}^3$와 스칼라 $k \in \mathbb{R}$에 대해서 다음의 연산이 가능하다

- 덧셈 뺄셈  
$\vec{a}\pm \vec{b} = (a_1 \pm b_1, a_2 \pm b_2 ,\cdots, a_n \pm b_n)$

- 스칼라곱  
$k\vec{a} = (k a_1, k a_2, \cdots, k a_n)$

- 내적  
$\vec{a} \cdot \vec{b} = a_1b_1 + a_2 b_2 + \cdots + a_n b_n$

- 외적
$\vec{a_3} \times \vec{b_3}=\left(\begin{vmatrix}a_2 & a_3 \\ b_2 & b_3\end{vmatrix}, - \left\right)$