---
# 포스트 제목
title: 로드리게스 회전(Rodrigues rotation)

# author key값, _data/authors.yaml 에 있어야 정상적으로 표시됨
author: JiseokLee

# 포스트가 올라간 날짜. 한국은 GMT+09이므로 +0900 이다
date: 2023-11-01 20:40:00 +0900 

# 카테고리 세팅. n개의 배열이며, 순서대로 부모->자식 관계이다
categories: [수학, 회전변환에 관하여]

# 태그 세팅. n 개의 배열이다.
tags: [Mathmatics, Attitude Representation, Vector Rotation, Vector Transform]

# 미리보기 이미지 세팅. 필요없으면 비워도 됨
image:
  path: /assets/img/posts/mathmatics/rotation/7-2차원과-3차원-회전의-차이/jacket.png
  alt: 3차원의 회전은 무엇이 달라질까

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

> 임의의 축에 대한 벡터의 회전, 로드리게스 회전에 대해 알아보자.

> 참고 : [Rodrigues' rotation formula](https://en.wikipedia.org/wiki/Rodrigues%27_rotation_formula)

## 로드리게스 회전 공식

지금까지 2D 평면에서는 회전축이 항상 평면에 수직인 축 (가상의 $z$축)이었기에, 회전된 각도 $\theta$만으로 결정할 수 있었다.  
하지만 3D 공간에서는 회전축이 완전한 자유도를 가진 단위벡터 $\vec{u}$로 표시되므로, 이제 기존의 회전 각도 $\theta$에 회전축 벡터 $\vec{u}$까지 생각해야 한다.

이를 사용하여 공간상의 벡터를 회전시키는 방식을 `로드리게스 회전(Rodrigues rotation)` 이라 한다.  

> 로드리게스 회전 공식은 벡터 $\vec{v}$를 회전축 $\vec{u}$에 대해 각도 $\theta$만큼 회전시키는 공식이며, 다음과 같다.
> 
> $$\begin{align}
> \vec{v_{rot}} = \vec{v} \cos{\theta} + \left(\vec{u} \times \vec{v} \right) \sin{\theta} + \vec{v} \left(\vec{u} \cdot \vec{v} \right)\left( 1 - \cos{\theta} \right) \label{e1}
> \end{align}$$
{: .prompt-info}

[그림1](임의의 축에 대해 회전되는 벡터 v, v평행, v수직이 표시된 그림임)

## 로드리게스 회전 공식의 유도

그림1을 통해 회전시킬 벡터를 회전되는 벡터와 회전되지 않는 2개의 벡터로 분리 할 수 있다. 

그 중 회전축에 평행한 성분을  $\vec{v_{}}$, 회전축에 수직인 성분을 $\vec{v_{\bot}}$라 했을 때, 다음과 같이 표현할 수 있다.

