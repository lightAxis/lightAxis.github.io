---
# 포스트 제목
title: 쿼터니언과 회전행렬,각속도

# author key값, _data/authors.yaml 에 있어야 정상적으로 표시됨
author: JiseokLee

# 포스트가 올라간 날짜. 한국은 GMT+09이므로 +0900 이다
date: 2023-11-16 23:00:00 +0900 

# 카테고리 세팅. n개의 배열이며, 순서대로 부모->자식 관계이다
categories: [수학, 회전변환에 관하여]

# 태그 세팅. n 개의 배열이다.
tags: [수학, 회전 변환, 쿼터니언, 각속도, 회전 행렬]

# 미리보기 이미지 세팅. 필요없으면 비워도 됨
image:
  path: /assets/img/posts/mathmatics/rotation/10-복소수의-확장-쿼터니언/jacket.png
  alt: 복소수의 확장, 4차원수 쿼터니언

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

> 쿼터니언으로부터 회전 행렬을 유도해 본다.
> 쿼터니언의 미분과, 각속도 벡터와의 관계를 유도한다.

## 회전 행렬로의 변환

쿼터니언 $q = w + xi+yj+zk = w + \vec{v}$를 사용한 3차원 벡터의 회전 행렬을 유도해 본다.

앞서  쿼터니언의 곱에 대해 다음의 식이 성립함을 보고 가자

$$\begin{align}
&q_1, q_2 \in \mathbb{H}, \nonumber \\
&q_1 = w_1 + \vec{v_1},  q_2 = w_2 + \vec{v2}, \nonumber \\
\nonumber \\
q_1 \otimes q_2 &= \left(w_1 w_2 - \vec{v_1} \cdot \vec{v_2}\right) + \left(w_1\vec{v_2} + w_2 \vec{v_1} + \vec{v_1} \times \vec{v_2}\right) \label{e1}
\end{align}$$

증명은 [이 포스트]({% post_url /수학/회전변환에-관하여/2023-11-16-quat-and-3D-rotation %}#{{ "쿼터니안-곱의-행렬과-벡터-표현" | url_encode}}) 에서 확인할 수 있다.

다음으로, 벡터의 연산에 대해서 다음이 성립함을 보고 가자

$$\begin{align}
\vec{a}, \vec{b}, \vec{c} &\in \mathbb{R}^3, \nonumber \\
a,b,c &\text{ : in matrix form} \nonumber \\
\nonumber \\
&\text{1. } \vec{a} \cdot \vec{b} = \vec{b} \cdot \vec{a}, \nonumber \\
&a^T b = b^T a \nonumber \\
\nonumber \\
&\text{2. } \vec{a}\times\vec{b} = - \vec{b} \times \vec{a} \nonumber \\
&\left[a\right]_\times b  = -\left[b\right]_\times a \nonumber \\
\nonumber \\
&\text{3. } \vec{a} \times \vec{a} = 0, \nonumber \\
&\left[a\right]_\times a = 0\nonumber \\
\nonumber \\
&\text{4. } \vec{a}\cdot\left(\vec{b} \times \vec{c} \right) = \vec{b}\cdot\left(\vec{c} \times \vec{a}\right) = \vec{c} \cdot\left(\vec{a} \times \vec{b}\right), \nonumber \\
&\text{(스칼라 삼중곱, scalar triple product)} \nonumber \\
\nonumber \\
&\text{5. }\vec{a}\times\left(\vec{b}\times\vec{c}\right) = \vec{b}\left(\vec{a}\cdot\vec{c}\right) - \vec{c}\left(\vec{a}\cdot\vec{b}\right) \nonumber \\
&\text{(벡터 삼중곱, vector triple product)} \nonumber \\
&\text{(백캡 공식, bac-cab)} \nonumber
\end{align}$$

이제 3차원 벡터, $\vec{p}\rightarrow \vec{p'}$의 회전 식을 전개하겠다.

$$\begin{align}
\vec{p'} &= q \otimes \vec{p} \otimes \overline{q} \nonumber \\

\vec{p'} &= \begin{bmatrix}w \\ \vec{v}\end{bmatrix} \otimes \begin{bmatrix}0 \\ \vec{p}\end{bmatrix} \otimes \begin{bmatrix}w \\ -\vec{v}\end{bmatrix}=\begin{bmatrix} (a) \\ (b) \end{bmatrix} \nonumber \\
\nonumber \\
(a) &: -w(\vec{v}\cdot\vec{p}) + w(\vec{p}\cdot\vec{v}) + (\vec{v} \times \vec{p})\cdot \vec{v} \nonumber \\
&= -w(\vec{v}\cdot\vec{p}) + w(\vec{v}\cdot\vec{p}) + \vec{p}\cdot(\vec{v}\times\vec{v}) \nonumber \\
&= 0 \nonumber \\
\nonumber \\
(b) &: (\vec{v}\cdot\vec{p})\vec{v} + w^2 \vec{p} + w(\vec{v}\times\vec{p})+\left[ w\vec{p}\times(\vec{v}\times\vec{p})\right]\times(-\vec{v}) \nonumber \\
&=  (\vec{v}\cdot\vec{p})\vec{v} + w^2 \vec{p} + w(\vec{v}\times\vec{p})+\vec{v}\times\left[ w\vec{p} + (\vec{v}\times\vec{p}) \right] \nonumber \\
&=  (\vec{v}\cdot\vec{p})\vec{v} + w^2 \vec{p} + w(\vec{v}\times\vec{p})+w(\vec{v}\times \vec{p}) + \vec{v}\times(\vec{v}\times\vec{p}) \nonumber \\
\nonumber \\
\text{as, } & \vec{v}\times(\vec{v}\times\vec{p}) = \vec{v}(\vec{v}\cdot\vec{p}) - \vec{p}(\vec{v}\cdot\vec{v})=(\vec{v}\cdot\vec{p})\vec{v}-\vec{p}\lVert \vec{v} \rVert^2 \nonumber \\
&= 2(\vec{v}\cdot\vec{p})\vec{v} + (w^2 - \lVert \vec{v} \rVert^2)\vec{p}+2w(\vec{v}\times\vec{p}) \nonumber \\
\nonumber \\
\text{in matrix form, }\nonumber \\
\text{as, }&(\vec{v}\cdot\vec{p})\vec{v} = (v^T p)v = v(v^T p)=(v v^T)p \nonumber \\
&= \left( 2vv^T + (w-v^Tv)I + 2w[v]_\times \right)p = p' \nonumber \\
&= Rp \nonumber \\
\nonumber \\
\therefore R &= 2vv^T + (w^2 -x^2 -y^2 -z^2)I+2w[v]_\times \nonumber \\
&= \begin{bmatrix} 2x^2 & 2xy & 2xz \\ 2xy & 2y^2 & 2yz \\ 2xz & 2yz & 2z^2 \end{bmatrix} + (w^2-x^2-y^2-z^2)I \nonumber \\
& \text{ }+\begin{bmatrix} 0 & -2wz & 2wy \\ 2wz & 0 & -2wx \\ -2wy & 2wx & 0 \end{bmatrix} \nonumber \\
\nonumber \\
\text{as, }& w^2 = 1 - x^2 -y^2 -z^2, \nonumber \\
&w^2-x^2-y^2-z^2 = 1 - 2x^2 - 2y^2 - 2z^2\nonumber \\
\nonumber \\
\therefore R &= \begin{bmatrix} 1-2(y^2+z^2) & 2(xy-wz) & 2(xz+wy) \\ 2(xy + wz) & 1-2(x^2+z^2) & 2(yz-wx) \\ 2(xz-wy) & 2(yz+wx) & 1-2(x^2+y^2)\end{bmatrix}
\end{align}$$

> 따라서 쿼터니언 $q \in \mathbb{H}, q=w+xi+yj+zk$ 에 대해 3차원 벡터 회전 행렬은 다음과 같다.
>
> $$\begin{align}
> R &= \begin{bmatrix} 1-2(y^2+z^2) & 2(xy-wz) & 2(xz+wy) \\ 2(xy + wz) & 1-2(x^2+z^2) & 2(yz-wx) \\ 2(xz-wy) & 2(yz+wx) & 1-2(x^2+y^2)\end{bmatrix}
> \end{align}$$
{: .prompt-info}

## 쿼터니언의 미분과 각속도

복소수가 $\dot{z}\bar{z} = \dot{\theta}$의 관계가 있던 것 처럼, 쿼터니언도 각속도 벡터와의 관계가 있을까?

복소수와 미분을 통한 각속도의 관계는 [이 포스트]({% post_url /수학/회전변환에-관하여/2023-10-28-non-differenciable-angle-complex %}#{{ "복소수의-미분과-각속도" | url_encode}}) 에서 유도했다.

복소수 때 처럼 쿼터니언을 미분해 보면 다음과 같다.

$$\begin{align}
\frac{d}{dt}q &= \frac{d}{dt}\left(\cos{\theta} + \vec{u}\sin{\theta}\right) \nonumber \\
&= \dot{\theta}\vec{u} \left[\cos{\theta} + \vec{u}\sin{\theta}\right] + \dot{\vec{u}}\cos{\theta} \nonumber \\
&= ???
\end{align}$$

음.. 뭐 아무 감이 안잡힌다.  
다른 방식으로 접근해 보자.

**이번에는 미분의 정의를 사용할 것이다.**

$$\begin{align}
\lim_{\Delta t\rightarrow 0}{\frac{q(t + \Delta t) - q(t)}{\Delta t}} = \dot{q}
\end{align}$$

기준계 $I$와 Body 좌표계 $B$가 있다.
$I$에서 관찰한 $B$의 임의의 시간 $t$에서의 자세 쿼터니언을 $q(t)$라 하자.  
이제 $q(t)$에서 $\Delta t$초 만큼 각속도 벡터 $\vec{\omega}$로 회전된 다음의 자세 쿼터니언을 $q(t + \Delta t)$라 하자.  
이때, $\vec{\omega}$가 기준계 $I$에서 관찰한 각속도 벡터, $\vec{\omega_I}$인 경우, 다음이 성립한다.

$$\begin{align}
q(t + \Delta t) = q_{\omega} \otimes q(t) \\
q_\omega = e^{\normalsize  \frac{\Delta t}{2}\vec{\omega}}
\end{align}$$

이제, 쿼터니언의 미분을 구해보자

$$\begin{align}
q(t + \Delta t) - q(t) &= \left(e^{\normalsize  \frac{\Delta t}{2}\vec{\omega}} - 1\right) \otimes q(t) \nonumber \\
&= \left[ \cos{\left( \frac{\Delta t}{2} \lVert \vec{\omega} \rVert \right)} - 1 + \frac{\vec{\omega}}{\lVert \vec{\omega}  \rVert} \sin{\left( \frac{\Delta t}{2} \lVert \vec{\omega} \rVert  \right)} \right] \otimes q(t) \nonumber \\
\nonumber \\
\lim_{\Delta t\rightarrow 0}{\frac{q(t + \Delta t) - q(t)}{\Delta t}} &= \left[ \lim_{\Delta t \rightarrow 0}{\frac{\cos{\left( \frac{\Delta t}{2} \lVert \vec{\omega} \rVert \right)} - 1}{\Delta t}} + \frac{\vec{\omega}}{\lVert \vec{\omega} \rVert} \lim_{\Delta t \rightarrow 0}{\frac{\sin{\left( \frac{\Delta t}{2} \lVert \vec{\omega} \rVert  \right)} }{\Delta t}} \right] \otimes q(t) \nonumber \\[5pt]
&= \left[0 + \frac{\vec{\omega}}{\lVert \vec{\omega} \rVert} \frac{\lVert \vec{\omega} \rVert}{2} \right] \otimes q(t) \nonumber \\[5pt]
\nonumber \\
\therefore \frac{d}{dt}q(t)&= \frac{\vec{\omega}}{2} \otimes q(t), \label{e2} \\
=> \dot{q} &= \frac{\vec{\omega}}{2}\otimes q \nonumber \\
\end{align}$$

> 위 식 $\eqref{e2}$을 정리하면, 쿼터니언과 각속도에 대한 식은 다음과 같다.
>
> $$\begin{align}
> 2\dot{q}\otimes \bar{q} &= \vec{\omega_I} \\
> \vec{\omega} &: \vec{\omega_I}, \text{angular Velocity represented at }I\text{ frame} \nonumber
> \end{align}$$
{: .prompt-info}

> 하지만, 비행체의 자세 제어 분야에서는 오히려 $I$프레임 말고, $B$ 프레임에서 표현된 각속도 벡터가 더 쓸모 있다.
>
> $\bar{q} \otimes \vec{\omega_I} \otimes q = \vec{\omega_B}$로 프레임 변환을 할 수 있으니,  
> 다음과 같이 구할 수 있다.
>
> $$\begin{align}
> \bar{q} \otimes \left(2\dot{q} \otimes \bar{q}\right) \otimes q &= \bar{q} \otimes (\vec{\omega_I}) \otimes q \nonumber \\
> \nonumber \\
> \therefore 2\bar{q} \otimes \dot{q} &= \vec{\omega_B} \\
> \vec{\omega_B} &:\text{angular Velocity represented at }B\text{ frame} \nonumber
> \end{align}$$
{: .prompt-info}

이 관계는 다양한 곳에 적용될 수 있는데, 예를 들면 강체의 Euler-Lagrange Equation에서 일반화 좌표계(generalized coordinate)로 쿼터니언을 사용할 때 적용 가능하다.
