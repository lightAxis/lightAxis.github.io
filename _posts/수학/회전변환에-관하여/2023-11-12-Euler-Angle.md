---
# 포스트 제목
title: 오일러 각(Euler Angle)

# author key값, _data/authors.yaml 에 있어야 정상적으로 표시됨
author: JiseokLee

# 포스트가 올라간 날짜. 한국은 GMT+09이므로 +0900 이다
date: 2023-11-12 20:40:00 +0900 

# 카테고리 세팅. n개의 배열이며, 순서대로 부모->자식 관계이다
categories: [수학, 회전변환에 관하여]

# 태그 세팅. n 개의 배열이다.
tags: [수학, 회전 변환, 오일러 각]

# 미리보기 이미지 세팅. 필요없으면 비워도 됨
image:
  path: /assets/img/posts/mathmatics/rotation/9-오일러-각/jacket.png
  alt: 오일러가 제안했던 3차원 회전 방식

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

> 오일러가 제안했던 3차원 회전 방식, 오일러 각(Euler Angle)에 대해 알아보자

> 참고 : [Euler Angles](https://en.wikipedia.org/wiki/Euler_angles)  
> 오일러각은 그림 그리기도 너무 까다롭고, 내용도 중구난방이 많아서, 영문 위키를 많이 참조했다.

## 오일러와 3차원 회전

오일러는 1775년 오일러 각(Euler Angle)과 오일러의 회전 정리(Euler's Rotation Theorem)을 발표한다.  

`오일러 각(Euler Angle)`은 강체의 3차원 자세에 대한 표현법으로, 좌표축에 대한 3번의 elemental Rotation으로 회전된 강체의 좌표계를 표현하는 방법이다.  

전통적인 오일러 각 (Classic Euler Angle)은 첫번째와 세번째의 회전축이 동일한 축이지만, 변형된 형태(Tait-Bryan Angle)는 3개의 서로 다른 축을 회전시켜 표현한다. 
항공체의 자세를 직관적으로 표현하기 위해 변형된 방식이 Tait-Bryan 인 까닭에 요즘에는 이쪽이 훨씬 자주 쓰인다. 

`오일러의 회전 정리(Euler's Rotation Theorem)`는 구면 기하학에 대한 정리로써, 
내용은 다음과 같다 : 

구를 중심을 지나는 임의의 축들로 여러번 회전 시켰을 때, 회전 전과 후에 위치가 변하지 않은 구면상의 2개의 점을 지나는 지름을 언제나 찾을 수 있다.
> 참조 : [Euler's Rotation Theorem](https://en.wikipedia.org/wiki/Euler%27s_rotation_theorem){: width="500" height="400"}

한마디로 3차원 회전 변환의 합성 역시 3차원 회전 변환이라는 뜻이다.  

이게 대단한 이유는 당시에는 행렬이 없었기 때문이다.  
행렬의 발명 시기는 1850년인데, 이는 1840년의 로드리게스 회전, 1844년의 쿼터니안보다 나중에 일이다.   

대체 오일러는 무슨 싸움을 했던 걸까.

## 오일러 각의 기본 개념과 종류

### 기본 개념과 표기
![그림1](/assets/img/posts/mathmatics/rotation/9-오일러-각/classical-euler.png){: width="500" height="400"}
_그림 1: 오일러 각 (classical). [참고](https://en.wikipedia.org/wiki/Euler_angles#)_


그림1에서 보다시피, 오일러 각은 특정 좌표계 축을 잡고 나머지를 회전시키는 elemental rotation을 3번 합성하는 방식이다. 이때 좌표계 축을 회전시키는 순서와, 회전시키는 기준에 대한 방법을 표기해 줘야 한다.  
그 후에는, 각 좌표계축의 회전 각도만 간단하게 표시하는 편이다. 

elemental rotation 은 특정 좌표축을 중심으로 나머지 좌표축을 회전시킨다. 
따라서 $x,y,z$만 가능하며 돌리는 순서에 따라 다음과 같이 표기한다.

예시 : $z,y,x$ 축 방향으로 순서대로 돌리면, $z-y-x$ or 3-2-1로 표시한다.

![그림2](/assets/img/posts/mathmatics/rotation/9-오일러-각/intrinsic.png){: width="500" height="400"}
![그림3](/assets/img/posts/mathmatics/rotation/9-오일러-각/extrinsic.png){: width="500" height="400"}
_그림 2: intrinsic과 extrinsic 회전 [참고](https://en.wikipedia.org/wiki/Euler_angles#)_

> 참고 : [intrinsic & extrinsic rotations](https://en.wikipedia.org/wiki/Davenport_chained_rotations#Intrinsic_rotations)


다음으로 회전시키는 기준계는 intrinsic과 extrinsic이 있다.
intrinsic은 회전된 좌표계의 축 방향으로 돌리는 방식이며,
extrinsic은 회전하지 않는 기준 좌표계의 축 방향으로 돌리는 방법이다. 

> 예를 들어, $x$축으로 $\alpha$, $y$축으로 $\beta$,$z$축으로 $\gamma$만큼 순서대로 intrinsic 회전을 한 오일러 각은 다음과 같이 표현한다.  
> 
> $Z-Y-X$, intrinsic, $(\alpha, \beta, \gamma)$
{: .prompt-info}

이를 좌표계를 사용해 표현하면 다음과 같다. 

기준 좌표계 $I$로부터, 최종 좌표계 $B$ 까지 차례대로 $z$회전, $y$회전, $x$회전을 적용하면서
$I \rightarrow B'\rightarrow B'' \rightarrow B$ 좌표계 순서대로 바뀐다고 하자.

기준 좌표계 $I$의 3축 성분을 $I_x, I_y, I_z$라 하면, 다음의 절차대로 회전시킨다. 

- 처음에 기준 좌표계 $I_x, I_y,I_z$ 부터 시작한다
- $I_z$ 축으로 $\alpha$만큼 회전하여 (z축 intrinsic) $B^{\prime}_x, B^{\prime}_y, B^{\prime}_z$ 좌표계를 만든다.
- $B'_y$ 축으로 $\beta$만큼 회전하여 (y축 intrinsic) $B^{\prime\prime}_x, B^{\prime\prime}_y, B^{\prime\prime}_z$ 좌표계를 만든다.
- $B''_x$ 축으로 $\gamma$만큼 회전하여 (x축 intrinsic) $B_x, B_y, B_z$ 좌표계를 만든다.

만약 extrinsic 회전이었다면, 다음의 절차대로 회전시킨다.

- 처음에 기준 좌표계 $I_x, I_y,I_z$ 부터 시작한다
- $I_z$ 축으로 $\alpha$만큼 회전하여 (z축 extrinsic) $B^{\prime}_x, B^{\prime}_y, B^{\prime}_z$ 좌표계를 만든다.
- $I_y$ 축으로 $\beta$만큼 회전하여 (y축 extrinsic) $B^{\prime\prime}_x, B^{\prime\prime}_y, B^{\prime\prime}_z$ 좌표계를 만든다.
- $I_x$ 축으로 $\gamma$만큼 회전하여 (x축 extrinsic) $B_x, B_y, B_z$ 좌표계를 만든다.


### Classic Euler Angle

![그림3](/assets/img/posts/mathmatics/rotation/9-오일러-각/classical-euler.png){: width="500" height="400"}
_그림 3: 기존 오일러 각의 구조 [참고](https://en.wikipedia.org/wiki/Euler_angles#Classic_Euler_angles)_

오일러가 처음 발표했던 오일러 각은 지금과는 조금 다른 형태였다.  

제일 큰 특징은 1번째와 3번째로 회전시키는 회전축이 동일한 회전축이라는 것이다. 예를 들면 x-z-x나 z-y-z 등이 있다. 

진짜로 3개의 각도를 사용해서 3차원의 자세를 표현하는 데에만 목적이 있었으며,
종류는 총 6개다. (Z-X-Z, X-Y-X, Y-Z-Y, Z-Y-Z, X-Z-X, Y-X-Y)

### Tait-Bryan Angle

![그림4](/assets/img/posts/mathmatics/rotation/9-오일러-각/tait-bryan-angle.png){: width="500" height="400"}
_그림 4: 개선된 오일러 각의 구조 [참고](https://en.wikipedia.org/wiki/Euler_angles#Tait%E2%80%93Bryan_angles)_

20세기 초, 수학자 겸 물리학자인 Peter Guthrie Tait와 George Hartley Bryan의 앞 글자를 따서, 새로운 오일러 각 표현법이 생겨났다.

Tait는 헤밀턴(쿼터니안을 발명한 사람)과 가까운 사이었으며, 3차원 회전에 대한 다양한 수학적인 업적을 남겼다. Bryan은 항공동역학에서 유체의 흐름과 안정성을 연구하고 있었으며, 항공기의 안정성에 대한 수학적인 이론과 자세, 방향에 대한 개념을 연구했다.

Bryan의 연구는 특히 항공기의 동역학에 있어서 직관적인 자세 표현법이 필요했다. 기체가 옆으로 구르는 rolling, 앞뒤로 기울어지는 pitching, 수직축을 기준으로 회전하는 yawing(또는 heading) 등의 수치를 사용해서 3차원 자세를 표현하는 방법이 필요했다.

기존의 오일러각은 3개의 각도로 3차원의 모든 자세를 표현할 수 있었지만, 각각의 숫자가 직관적인 편이 아니었기에 새로운 오일러 각 표현법을 만들었다.

제일 큰 차이점은 기존 오일러 각과는 달리, 3개의 회전축이 전부 다르다는 것이다. 

Z-Y-X, X-Y-Z 처럼 서로 다른 3개의 축에 대한 회전으로 각각의 각도를 해석할 수 있다.  
이때 항공체의 Body 좌표계를 NED 방향으로 잡으면, X,Y,Z축의 회전이 각각 roll pitch yaw 방향과 일치하게 된다.

> 대부분의 경우, 항공기에서 사용하는 오일러 각은 intrinsic, Z-Y-X 순서의 오일러 각이며,  
> 각각 X,Y,Z축의 회전 각도를 roll$(\phi)$, pitch$(\theta)$, yaw$(\psi)$ 라 부른다.
{: .prompt-tip}

![그림5](/assets/img/posts/mathmatics/rotation/9-오일러-각/rpy.png){: width="500" height="400"}
_그림 5 : 항공기의 Body Frame과 roll, pitch, yaw_

> 참고 : [Euler angles, altiernative name](https://en.wikipedia.org/wiki/Euler_angles#Alternative_names)  
> 참고 : [항공기의 Body Frame, NED](https://www.vectornav.com/resources/inertial-navigation-primer/math-fundamentals/math-refframes)


## 짐벌락(Gimbal Lock)

짐벌은 기계장치의 일종으로, 여러개의 회전 링들을 중첩시켜 매달아서 내부에 매달린 물체의 3차원 자세를 조종하는 플랫폼이다.  
이 중에서도 3D 짐벌에 사용되는 수학적 모델이 오일러 각 방식과 일치한다. 

아래의 영상을 보면, 어떤 것인지 이해할 수 있다.

{% include embed/youtube.html id='zc8b2Jo7mno?si=UmTyWRx1qiJcDF65&amp;start=44' %}

2번째 회전각이 $\frac{\pi}{2}$ 또는 $-\frac{\pi}{2}$가 되면 1번째와 3번째 회전링이 같은 면 상에 정렬되면서 회전 자유도를 하나 잃어버리게 된다.  
이는 원하는 방향으로의 각속도를 만들어 낼 수 없다는 뜻이 된다. 

항공역학에서 이 짐벌락 문제는 자세 제어에 매우 치명적이다.  
모든 actuator는 물체의 가속도 또는 각가속도에 영향을 미치므로, 현재 자세에서 원하는 자세로 되기 위한 목표 방향으로의 각속도와 각가속도를 표현할 수 있어야 한다. 하지만 특정 자세에서는 오일러 각의 3개 각도들을 미분해도 표현할 수 없는 각속도 방향이 생긴다.  
아폴로 11호도 오일러 각을 사용한 탓에 자세 제어에 애를 먹었다.

짐벌락을 피하기 위해서 또 등장하는게 쿼터니안이다. Axis-Angle 방식도 가능하지만, 0근처에서 미분이 불안정하다는 단점이 있다.

## 회전 행렬 형태

> intrinsic 회전 기준에서, 각각의 $x,y,z$ 축에 대한 element rotation은 회전 행렬 $R_x, R_y, R_z$로 표현될 수 있으며, 다음과 같다.
> 
> $$\begin{align}
> R_x(\theta) &= \begin{bmatrix} 1 & 0 & 0 \\ 0 & \cos{\theta} & -\sin{\theta} \\ 0 & \sin{\theta} & \cos{\theta} \end{bmatrix} \label{e0} \\[5pt]
> R_y(\theta) &= \begin{bmatrix} \cos{\theta} & 0 & \sin{\theta} \\ 0 & 1 & 0 \\ -\sin{\theta} & 0 & \cos{\theta} \end{bmatrix} \\[5pt]
> R_z(\theta) &= \begin{bmatrix}\cos{\theta} & -\sin{\theta} & 0 \\ \sin{\theta} & \cos{\theta} & 0 \\ 0 & 0 & 1\end{bmatrix} 
> \end{align}$$
{: .prompt-info}

주의할 점은, $R_y$의 방향이 나머지들과 반대라는 점인데, 이는 우리가 오른손 법칙을 따르는 좌표계를 사용하기 때문이다.  

![그림6](/assets/img/posts/mathmatics/rotation/9-오일러-각/right_hand_axis_y.png){: width="500" height="400"}
_그림 6: y축 회전과 x-z 평면_

그림 6을 보자. $y$축으로 $\theta$만큼 회전하면, $x-z$ 평면상에서는 $-\theta$ 만큼 회전하는 것이기 때문에, 기존의 2차원 회전 행렬 형태에서 반대 방향으로 회전시키는 것 처럼 보인다.

다음의 예시를 생각해 보자.  
intrinsic 회전 방식에 $x \rightarrow y \rightarrow z$ 순서를 가진 오일러 각 회전이다. 

위의 [오일러 각의 기본 개념과 표기](#기본-개념과-표기) 에서 적용했던 회전 순서를 다시 나열하면, $I \rightarrow_x B' \rightarrow_y B'' \rightarrow_z B$ 순서로 회전될 것이며, 각각의 회전에 대한 회전 행렬은 $R_x, R_y, R_z$로 쓸 수 있다.

이제 공간상에 고정된 벡터 $P$를 생각해 보자. $P_A$가 벡터 $P$를 $A$ 좌표계에서 관찰한 위치 라고 하자. 그렇다면 다음의 관계가 성립한다. 


$$\begin{align}
R_x^T P_I &= P_{B'} \nonumber \\
R_y^T P_{B'} &= P_{B''} \nonumber \\
R_z^T P_{B''} &= P_B \label{e05} \\
\nonumber \\
=> R_z^T R_y^T R_x^T P_I &= P_B \nonumber \\
 P_I &= R_x R_y R_z P_B \nonumber \\
&= R P_B \nonumber \\
\nonumber \\
\therefore R = R_x R_y R_z \label{e1}
\end{align}$$

그리고 Extrinsic의 경우에는 회전 행렬이 반대로 된다.  
축 회전순서는 X-Y-Z로 동일하지만, extricsic인 경우에는 다음과 같다.

$$\begin{align} 
R = R_z R_y R_x \label{e2}
\end{align}$$

따라서 식 $\eqref{e1}, \eqref{e2}$를 정리하면 다음과 같다.

> 오일러 각 순서 $a - b - c$ , $(a,b,c \in \{x,y,z\})$ 에 대해서 벡터 회전 행렬 $R$은
> 
> $$\begin{align} \large
> R &= R_{a} R_{b} R_{c} \text{, if intrinsic} \nonumber \\
> &= R_{c} R_{b} R_{a} \text{, if extrinsic} \label{e3} \\
> \end{align}$$
>
> 각 회전 행렬 $R_x, R_y, R_z$에 대해서는 식 $\eqref{e0}$를 참고
{: .prompt-info}

> [Euler Angle의 영문 위키피디아](https://en.wikipedia.org/wiki/Euler_angles#Rotation_matrix)에 가면, 모든 오일러 각 방식의 회전 행렬과, 회전 행렬에서 다시 오일러 각으로의 역변환이 계산되어 있다.  
> 
> 해당 페이지에 소개된 표기 방식은 이렇다
> - column vector를 곱함으로써 동작하는 회전 행렬 기준
> - active rotation(벡터를 회전시키는) 회전 행렬 기준
> - 곱해진 순서는 intrinsic 회전 기준
> - 오른손 법칙 좌표계 기준
{: .prompt-tip}

## 오일러각-각속도 변환 행렬

제일 흔한 intrinsic, Z-Y-X의 오일러 각 $v=(\theta_x, \theta_y, \theta_z)$에 대해서 각속도 변환 행렬을 구해보자. 

강체의 자세를 표현했다면, 그 자세의 각속도 벡터 $\omega$가 있을 것이다. 
이때, 기준 좌표계 $I$ 에서 그 각속도 벡터를 표현한 $\omega_I$가 있고, Body 좌표계 $B$ 에서 그 각속도 벡터를 표현한 $\omega_B$가 있다. 

2차원의 자세와는 달리, 3차원의 좌표계에서는 임의의 회전축을 따라 회전한다. 따라서 3차원 벡터의 좌표계 변환 처럼 회전축 벡터의 좌표계 변환이 가능하고, 보통은 $B$좌표계 기준의 $\omega_B$를 Body Rate라 부른다. 

제어에 있어서는 Body Rate가 훨씬 유용한데 이는 다음의 이유 때문이다. 

- 기준계에서 관찰한 강체의 질량관성모멘트 $I$가 상수가 아니다.  
즉, $\frac{dI}{dt}\neq 0$이다. 그래서 회전과 관련한 물리식을 미분할 때 열받는다. 
- Body 좌표계에서 관찰한 강체의 질량관성모멘트 $I$는 상수다.  
즉, $\frac{dI}{dt} = 0$이기 때문에 미분이 훨씬 수월하다.
- 비행체는 actuator가 몸체에 달려있으므로, 어쨌든 body frame 기준으로 힘을 해석하고 제어하는 것이 수월하다.

그렇다면 오일러각으로 표현된 자세의 Body rate, $\omega_B$는 어떻게 알 수 있을까?

[앞서](#오일러-각의-기본-개념과-종류) 했던 것과 같이, 3번의 element rotation을 3번의 프레임 회전 변환으로 분해해 보면 다음과 같다.

$$\begin{align}
\text{Z-Y-X rotation from } I \rightarrow B \nonumber \\
  I \rightarrow_z B' \rightarrow_y B'' \rightarrow_x B
\end{align}$$

element rotation은 현재 프레임의 하나의 축을 잡고 그 축을 중심으로 회전시켜서 다음 프레임으로 변환된다. 만약 element rotation이 $x$ 축에 대해서 $\theta_x$만큼 돌리는 회전이라면, 그때의 각속도 벡터는 $\begin{bmatrix} \dot{\theta_x} & 0 & 0\end{bmatrix}^T$가 된다. 

이제 $\omega_{A->B}^C$ 를 프레임 $A$에 상대적인 프레임 $B$의 각속도 벡터를 프레임 $C$에서 관찰한 것 이라 하자.

우리가 구하고자 하는 것은 $\omega_{I->B}^B$ , body rate 벡터는 다음과 같이 구할 수 있다. 

$$\begin{align}
\omega_{I->B}^B &= \omega_{I->B'}^B + \omega_{B'->B''}^B + \omega_{B''->B}^B \label{e4} \\
\nonumber \\
\text{from } \eqref{e05}, \nonumber \\
&= R_x^T R_y^T R_z^T \omega_{I->B'}^I + R_x^T R_y^T \omega_{B'->B''}^{B'} + R_x^T \omega_{B''->B}^{B''} \nonumber \\[10pt]
&= R_x^T R_y^T R_z^T \begin{bmatrix} 0 \\ 0 \\ \dot{\theta_z} \end{bmatrix} + R_x^T R_y^T \begin{bmatrix} 0 \\ \dot{\theta_y} \\ 0 \end{bmatrix} + R_x^T \begin{bmatrix} \dot{\theta_x} \\ 0 \\ 0 \end{bmatrix} \nonumber \\[10pt]
&= R_x^T R_y^T \begin{bmatrix} 0 \\ 0 \\ \dot{\theta_z} \end{bmatrix} + R_x^T \begin{bmatrix} 0 \\ \dot{\theta_y} \\ 0 \end{bmatrix} + \begin{bmatrix} \dot{\theta_x} \\ 0 \\ 0 \end{bmatrix} \\[10pt]
&= \eta(v)\begin{bmatrix}\dot{\theta_x} \\ \dot{\theta_y} \\ \dot{\theta_z} \end{bmatrix} = \eta(v)\dot{v}, \\[5pt]
\eta &: \text{Body Rate Convert Matrix} \nonumber
\end{align}$$

실제 변환 행렬 $\eta$의 값을 구하면 각각의 열 벡터들의 합이며, 다음과 같다. 

$$\begin{align}
R_x^T R_y^T &= \left[\begin{array}{c|c|c}?&?&R_3 \end{array} \right] \nonumber \\[7pt]
&= \left[\begin{array}{c|c|c}?&?&
\begin{matrix} -\sin{\theta_y} \\ \sin{\theta_x}\cos{\theta_y} \\ \cos{\theta_x}\cos{\theta_y}\end{matrix}
\end{array} \right] \nonumber \\[7pt]
R_x^T &= \left[\begin{array}{c|c|c}?&R_2&? \end{array} \right] \nonumber \\[7pt]
&= \left[\begin{array}{c|c|c}?&
\begin{matrix}0 \\ \cos{\theta_x} \\ -\sin{\theta_x}\end{matrix}
&?\end{array} \right] \nonumber \\[7pt]
I &= \left[\begin{array}{c|c|c}R_1&?&?\end{array}\right] \nonumber \\[7pt]
&= \left[\begin{array}{c|c|c}
\begin{matrix}1\\0\\0\end{matrix}
&?&?\end{array}\right]\nonumber \\[7pt]
\nonumber \\
\therefore \eta &= \left[\begin{array}{c|c|c}R_1&R_2&R_3\end{array}\right] \nonumber \\[7pt]
&= \begin{bmatrix} 1 & 0 & -\sin{\theta_y} \\ 0 & \cos{\theta_x} & \sin{\theta_x} \cos{\theta_y} \\ 0 & -\sin{\theta_x} & \cos{\theta_x} \cos{\theta_y} \end{bmatrix} \\
\end{align}$$

결과적으로 다음과 같다.

> Intrinsic, Z-Y-X Tait-Bryan Angle에서, 오일러각 벡터 $v=\begin{bmatrix}\theta_x & \theta_y & \theta_z\end{bmatrix}^T$에 대해,  
> Body Rate 벡터 $\omega_B$와, 각속도 변환 행렬 $\eta(v)$는 다음과 같다.
> 
> $$\begin{align}
> \therefore \omega_B &= \begin{bmatrix} 1 & 0 & -\sin{\theta_y} \\ 0 & \cos{\theta_x} & \sin{\theta_x} \cos{\theta_y} \\ 0 & -\sin{\theta_x} & \cos{\theta_x} \cos{\theta_y} \end{bmatrix} \begin{bmatrix} \dot{\theta_x} \\ \dot{\theta_y} \\ \dot{\theta_z} \end{bmatrix} \\
> &= \eta(v) \dot{v} \nonumber
> \end{align}$$
{: .prompt-info}

위와 같은 과정을 거치면, 어떠한 오일러각 종류도 각속도 벡터로 변환할 수 있다.  
식 $\eqref{e4}$에서 벡터의 기준계만 전부 $I$로 바꿔서 다시 유도하면, 기준 좌표계 $I$에서 관찰한 각속도 벡터 $\omega_I$에 대해서도 유도할 수 있다. 근데 대부분의 경우 쓸모 없다.  

## 각속도-오일러각 변환 행렬과 짐벌락

재미있는 점은, 이를 통해서 짐벌락의 수학적인 조건을 확인할 수 있는데, 이는 다음과 같다. 
각속도 변환 행렬 $\eta$의 역행렬이 존재한다면, 각속도 벡터도 오일러 각의 변화량으로 변환될 수 있음을 의미한다. 

$\eta^{-1}$의 실제 모습은 다음과 같다.

$$\begin{align}
v &= \begin{bmatrix} \theta_x & \theta_y & \theta_z \end{bmatrix}^T = \begin{bmatrix} \phi & \theta & \psi \end{bmatrix}^T \nonumber \\
&= \begin{bmatrix} \text{roll} & \text{pitch} & \text{yaw} \end{bmatrix}^T\nonumber \\
\nonumber \\
\eta(v)^{-1}\omega_B &= \dot{v} \nonumber \\
\eta(v)^{-1} &= 
\begin{bmatrix} 
1   & 0               & -\sin{\theta_y}               \\ 
0   & \cos{\theta_x}  & \sin{\theta_x} \cos{\theta_y} \\ 
0   & -\sin{\theta_x} & \cos{\theta_x} \cos{\theta_y} 
\end{bmatrix}^{-1} \nonumber \\[8pt]
&= \begin{bmatrix}  
1 & \sin{\theta_x} \tan{\theta_y} & \cos{\theta_x} \tan{\theta_y} \\
0 & \cos{\theta_x} & -\sin{\theta_x} \\
0 & \sin{\theta_x} \cos{\theta_y} & \cos{\theta_x} \sec{\theta_y} 
\end{bmatrix} \label{e5}
\end{align}$$

위 식 $\eqref{e5}$를 보면, $\eta^{-1}$은 $\theta_y = \pm \frac{\pi}{2}$가 되면 존재하지 않는다.  
이는 특정 자세에서는 각속도 벡터가 오일러각의 변화량으로 변환될 수 없음을 의미한다. 원하는 방향으로 자세를 변화시킬 수 없다. 

즉, 짐벌락에 걸린 것이다. 

## 오일러 각 표현법의 장단점

### 장점
**직관적이다**  
오일러 각 표현법은 각각의 각도가 직관적이다. Tait-Bryan angle등의 표현에서는 x,y,z축 각도를 바로바로 roll, pitch, yaw로 대응시킬 수 있다.  
각도값의 변화가 실제 자세에 어떻게 반영될 지 상상하기 쉽다.
이 점 때문에, 3D 포토샵이나 컴퓨터 그래픽스 등의 직관성이 중요한 부분에서 많이 사용되곤 한다.

**움직임 제한이 용이**  
때로는 자세를 제한하고 싶을 때 유용하다. 예를 들어 양 옆으로 30도 이상 기울어지지 않게 막고 싶거나, 고개를 90도 이상 돌리지 못하게 막고 싶을 때 유용하다.

### 단점

**짐벌락**  
오일러 각 표현법의 가장 치명적인 단점 중 하나이다. 특정 자세에서 하나의 회전 자유도를 잃어버리는 이 현상은 제한없는 연속적인 회전이 필요한 분야에 적용하기에 큰 걸림돌이다.  
물론 쿼터니안은 이런 거 없다.

**표현 방식의 애매모호함**  
오일러 각 표현법은 intrinsic & extrinsic이나, x-y-z 등의 추가적인 사항들을 미리 약속해야 사용할 수 있다. 이는 3개의 오일러 각의 배열만으로는 이것이 어떤 회전을 의미하는지 알 수 없음을 의미한다.  
조금만 부주의하면 오일러 각을 다르게 해석해서 실수나 오류가 날 수 있다.

**특이점**  
element rotation을 다루는 과정에서, 어떤 경우에는 0으로 나누거나 하는 등의 정의되지 않은 연산이 일어날 수 있다. 수치 에러에 취약한 편.

**수학적으로 복잡함**  
오일러 각 표현과 다른 표현법 사이의 변환 (로드리게스, 회전 행렬, 쿼터니안 등) 방식이 까다로운 편이다. 수학적으로도 복잡하며, 삼각함수를 포함하기 때문에 컴퓨팅 자원을 많이 소모한다.

**보간이 힘들다**  
2개의 서로 다른 자세를 오일러 각으로 보간하는 것은 힘들다. 선형 보간된 오일러 각은 애니메이션이나 시뮬레이션 상에서 이상한 모션으로 종종 이어진다. 
결국 구면 보간 방식을 사용해야 하는데, 이는 쿼터니안이 해결할 수 있다.

결론은 오일러 각 표현법은 사람에게 직관적이라는 점을 빼면, 수학적으로는 영 좋은 방법은 아니다.

> 다음 포스트는 입이 닳도록 언급한 사원수(쿼터니안)에 대해 다룰 것이다.