---
# 포스트 제목
title: 오일러 각(Euler Angle)

# author key값, _data/authors.yaml 에 있어야 정상적으로 표시됨
author: JiseokLee

# 포스트가 올라간 날짜. 한국은 GMT+09이므로 +0900 이다
date: 2023-11-07 10:40:00 +0900 

# 카테고리 세팅. n개의 배열이며, 순서대로 부모->자식 관계이다
categories: [수학, 회전변환에 관하여]

# 태그 세팅. n 개의 배열이다.
tags: [Mathmatics, Attitude Representation, Vector Rotation, Vector Transform]

# 미리보기 이미지 세팅. 필요없으면 비워도 됨
image:
  path: /assets/img/posts/mathmatics/rotation/8-로드리게스-회전/jacket.png
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

## 오일러와 3차원 회전

오일러는 1775년 오일러 각(Euler Angle)과 오일러의 회전 정리(Euler's Rotation Theorem)을 발표한다.  

`오일러 각(Euler Angle)`은 강체의 3차원 자세에 대한 표현법으로, 좌표축에 대한 3번의 elemental Rotation으로 회전된 강체의 좌표계를 표현하는 방법이다.  

전통적인 오일러 각 (Classic Euler Angle)은 첫번째와 세번째의 회전축이 동일한 축이지만, 변형된 형태(Tait-Bryan Angle)는 3개의 서로 다른 축을 회전시켜 표현한다. 
항공체의 자세를 직관적으로 표현하기 위해 변형된 방식이 Tait-Bryan 인 까닭에 요즘에는 이쪽이 훨씬 자주 쓰인다. 

`오일러의 회전 정리(Euler's Rotation Theorem)`는 구면 기하학에 대한 정리로써, 
내용은 다음과 같다 : 

구를 중심을 지나는 임의의 축들로 여러번 회전 시켰을 때, 회전 전과 후에 위치가 변하지 않은 구면상의 2개의 점을 지나는 지름을 언제나 찾을 수 있다.
> 참조 : [Euler's Rotation Theorem](https://en.wikipedia.org/wiki/Euler%27s_rotation_theorem)

한마디로 3차원 회전 변환의 합성 역시 3차원 회전 변환이라는 뜻이다.  

이게 대단한 이유는 당시에는 행렬이 없었기 때문이다.  
행렬의 발명 시기는 1850년인데, 이는 1840년의 로드리게스 회전, 1884년의 쿼터니안보다 나중에 일이다.   

대체 오일러는 무슨 싸움을 했던 걸까.

## 오일러 각의 기본 개념과 종류

### 기본 개념과 표기
[그림1](오일러 각 그림)

그림1에서 보다시피, 오일러 각은 특정 좌표계 축을 잡고 나머지를 회전시키는 elemental rotation을 3번 합성하는 방식이다. 이때 좌표계 축을 회전시키는 순서와, 회전시키는 기준에 대한 방법을 표기해 줘야 한다.  
그 후에는, 각 좌표계축의 회전 각도만 간단하게 표시하는 편이다. 

elemental rotation 은 특정 좌표축을 중심으로 나머지 좌표축을 회전시킨다. 
따라서 $x,y,z$만 가능하며 돌리는 순서에 따라 다음과 같이 표기한다.

예시 : $z,y,x$ 축 방향으로 순서대로 돌리면, $z-y-x$ or 3-2-1로 표시한다.

[그림2](intrinsic 과 extrinsic 회전)

> 참고 : [intrinsic & extrinsic rotations](https://en.wikipedia.org/wiki/Davenport_chained_rotations#Intrinsic_rotations)


다음으로 회전시키는 기준계는 intrinsic과 extrinsic이 있다.
intrinsic은 회전된 좌표계의 축 방향으로 돌리는 방식이며,
extrinsic은 회전하지 않는 기준 좌표계의 축 방향으로 돌리는 방법이다. 

예를 들어, $x$축으로 $\alpha$, $y$축으로 $\beta$,$z$축으로 $\gamma$만큼 순서대로 intrinsic 회전을 한 오일러 각은 다음과 같이 표현한다.  

$Z-Y-X$, intrinsic

이를 좌표계를 사용해 표현하면 다음과 같다. 

기준 좌표계 $I$로부터, 최종 좌표계 $B$ 까지 차례대로 $z$회전, $y$회전, $x$회전을 적용하면서
$I \rightarrow B'\rightarrow B'' \rightarrow B$ 좌표계 순서대로 바뀐다고 하자.

기준 좌표계 $I$의 3축 성분을 $I_x, I_y, I_z$라 하면, 다음의 절차대로 회전시킨다. 

- 처음에 기준 좌표계 $I_x, I_y,I_z$ 부터 시작한다
- $I_z$ 축으로 $\alpha$만큼 회전하여 (z축 intrinsic) $B'_x, B'_y, B'_z$ 좌표계를 만든다.
- $B'_y$ 축으로 $\beta$만큼 회전하여 (y축 intrinsic) $B''_x, B''_y, B''_z$ 좌표계를 만든다.
- $B''_x$ 축으로 $\gamma$만큼 회전하여 (x축 intrinsic) $B_x, B_y, B_z$ 좌표계를 만든다.

만약 extrinsic 회전이었다면, 다음의 절차대로 회전시킨다.

- 처음에 기준 좌표계 $I_x, I_y,I_z$ 부터 시작한다
- $I_z$ 축으로 $\alpha$만큼 회전하여 (z축 extrinsic) $B'_x, B'_y, B'_z$ 좌표계를 만든다.
- $I_y$ 축으로 $\beta$만큼 회전하여 (y축 extrinsic) $B''_x, B''_y, B''_z$ 좌표계를 만든다.
- $I_x$ 축으로 $\gamma$만큼 회전하여 (x축 extrinsic) $B_x, B_y, B_z$ 좌표계를 만든다.


### Classic Euler Angle
오일러가 처음 발표했던 오일러 각은 지금과는 조금 다른 형태였다.  

제일 큰 특징은 1번째와 3번째로 회전시키는 회전축이 동일한 회전축이라는 것이다. 예를 들면 x-z-x나 z-y-z 등이 있다. 

[그림3](클래시컬 오일러 앵글 사진 위키피디아 참조)

진짜로 3개의 각도를 사용해서 3차원의 자세를 표현하는 데에만 목적이 있었으며,
종류는 총 6개다. (Z-X-Z, X-Y-X, Y-Z-Y, Z-Y-Z, X-Z-X, Y-X-Y)

### Tait-Bryan Angle

20세기 초, 수학자 겸 물리학자인 Peter Guthrie Tait와 George Hartley Bryan의 앞 글자를 따서, 새로운 오일러 각 표현법이 생겨났다.

Tait는 헤밀턴(쿼터니안을 발명한 사람)과 가까운 사이었으며, 3차원 회전에 대한 다양한 수학적인 업적을 남겼다. Bryan은 항공동역학에서 유체의 흐름과 안정성을 연구하고 있었으며, 항공기의 안정성에 대한 수학적인 이론과 자세, 방향에 대한 개념을 연구했다.

Bryan의 연구는 특히 항공기의 동역학에 있어서 직관적인 자세 표현법이 필요했다. 기체가 옆으로 구르는 rolling, 앞뒤로 기울어지는 pitching, 수직축을 기준으로 회전하는 yawing(또는 heading) 등의 수치를 사용해서 3차원 자세를 표현하는 방법이 필요했다.

기존의 오일러각은 3개의 각도로 3차원의 모든 자세를 표현할 수 있었지만, 각각의 숫자가 직관적인 편이 아니었기에 새로운 오일러 각 표현법을 만들었다.

[그림4](타잇브라이언 앵글 사진 위키피디아 참조)

제일 큰 차이점은 기존 오일러 각과는 달리, 3개의 회전축이 전부 다르다는 것이다. 

Z-Y-X, X-Y-Z 처럼 서로 다른 3개의 축에 대한 회전으로 각각의 각도를 해석할 수 있다.  
이때 항공체의 Body 좌표계를 NED 방향으로 잡으면, X,Y,Z축의 회전이 각각 roll pitch yaw 방향과 일치하게 된다.

따라서 항공기나 비행체에 한해서 Tait-Bryan angle의 각도를 각각 roll, pitch, yaw라 부른다. 

[그림5](항공기의 roll pitch yaw)

> 참고 : [항공기의 Body Frame, NED](https://www.vectornav.com/resources/inertial-navigation-primer/math-fundamentals/math-refframes)


## 짐벌락(Gimbal Lock)

짐벌은 기계장치의 일종으로, 여러개의 회전 링들을 중첩시켜 매달아서 내부에 매달린 물체의 3차원 자세를 조종하는 플랫폼이다.  
이 중에서도 3D 짐벌에 사용되는 수학적 모델이 오일러 각 방식과 일치한다. 

아래의 영상을 보면, 어떤 것인지 이해할 수 있다.
[유튜브영상](짐벌락)

2번째 회전각이 $\frac{\pi}{2}, -\frac{\pi}{2}$가 되면 1번째와 3번째 회전링이 같은 면 상에 정렬되면서 회전 자유도를 하나 잃어버리게 된다.  
이는 원하는 방향으로의 각속도를 만들어 낼 수 없다는 뜻이 된다. 

항공역학에서 이 짐벌락 문제는 자세 제어에 매우 치명적이다.  
모든 actuator는 물체의 가속도 또는 각가속도에 영향을 미치므로, 현재 자세에서 원하는 자세로 되기 위한 목표 방향으로의 각속도와 각가속도를 표현할 수 있어야 한다. 하지만 특정 자세에서는 오일러 각의 3개 각도들을 미분해도 표현할 수 없는 각속도 방향이 생긴다.  
아폴로 11호도 오일러 각을 사용한 탓에 자세 제어에 애를 먹었다.

짐벌락을 피하기 위해서 또 등장하는게 쿼터니안이다. Axis-Angle 방식도 가능하지만, 0근처에서 미분이 불안정하다는 단점이 있다.

## 회전 행렬 형태

> intrinsic 회전 기준에서, 각각의 $x,y,z$ 축에 대한 element rotation은 회전 행렬 $R_x, R_y, R_z$로 표현될 수 있으며, 다음과 같다.
> 
> $$\begin{align}
> R_x(\theta) &= \begin{bmatrix} 1 & 0 & 0 \\ 0 & \cos{\theta} & -\sin{\theta} \\ 0 & \sin{\theta} & \cos{\theta} \end{bmatrix} \\
> R_y(\theta) &= \begin{bmatrix} \cos{\theta} & 0 & \sin{\theta} \\ 0 & 1 & 0 \\ -\sin{\theta} & 0 & \cos{\theta} \end{bmatrix} \\
> R_z(\theta) &= \begin{bmatrix}\cos{\theta} & -\sin{\theta} & 0 \\ \sin{\theta} & \cos{\theta} & 0 \\ 0 & 0 & 1\end{bmatrix} 
> \end{align}$$
{: .prompt-info}

주의할 점은, $R_y$의 방향이 나머지들과 반대라는 점인데, 이는 우리가 오른손 법칙을 따르는 좌표계를 사용하기 때문이다.  

[그림6](오른손 법칙과 각도 마이너스)

그림 6을 보자. $y$축으로 $\theta$만큼 회전하면, $x-z$ 평면상에서는 $-\theta$ 만큼 회전하는 것이기 때문에, 기존의 2차원 회전 행렬 형태에서 반대 방향으로 회전시키는 것 처럼 보인다.

다음의 예시를 생각해 보자.  
intrinsic 회전 방식에 $x \rightarrow y \rightarrow z$ 순서를 가진 오일러 각 회전이다. 

위의 [오일러 각의 기본 개념과 표기](#기본-개념과-표기) 에서 적용했던 회전 순서를 다시 나열하면, $I \rightarrow_x B' \rightarrow_y B'' \rightarrow_z B$ 순서로 회전될 것이며, 각각의 회전에 대한 회전 행렬은 $R_x, R_y, R_z$로 쓸 수 있다.

이제 공간상에 고정된 벡터 $P$를 생각해 보자. $P_A$가 벡터 $P$를 $A$ 좌표계에서 관찰한 위치 라고 하자. 그렇다면 다음의 관계가 성립한다. 

