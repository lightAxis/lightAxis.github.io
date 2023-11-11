---
# 포스트 제목
title: 사원수(Quaterion)

# author key값, _data/authors.yaml 에 있어야 정상적으로 표시됨
author: JiseokLee

# 포스트가 올라간 날짜. 한국은 GMT+09이므로 +0900 이다
date: 2023-11-11 10:40:00 +0900 

# 카테고리 세팅. n개의 배열이며, 순서대로 부모->자식 관계이다
categories: [수학, 회전변환에 관하여]

# 태그 세팅. n 개의 배열이다.
tags: [Mathmatics, Attitude Representation, Vector Rotation, Vector Transform]

# 미리보기 이미지 세팅. 필요없으면 비워도 됨
image:
  path: /assets/img/posts/mathmatics/rotation/8-로드리게스-회전/jacket.png
  alt: 복소수의 확장, 4차원수 쿼터니안

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

## what is quaternion and history?

Quaternions are a mathematical notation used to represent orientations and rotations of objects in three dimensions. They are a type of hypercomplex number and consist of a real part and three imaginary parts.

**Definition of Quaternion:**
A quaternion \( q \) is typically written as:

\[ q = a + bi + cj + dk \]

where \( a, b, c, \) and \( d \) are real numbers, and \( i, j, \) and \( k \) are the fundamental quaternion units. Quaternions extend the concept of complex numbers. They have properties that make them particularly useful in applications that require computation and interpolation of rotations, such as 3D computer graphics, robotics, and theoretical physics.

**History:**
Quaternions were first described by Sir William Rowan Hamilton in 1843. Hamilton was searching for ways to extend complex numbers (which can be used to describe points in two dimensions) to higher dimensions. His moment of discovery reportedly came while walking along the Royal Canal in Dublin, Ireland. He was struck by the insight that four dimensions were needed, not three, and he carved the fundamental formula of quaternion multiplication into a bridge:

\[ i^2 = j^2 = k^2 = ijk = -1 \]

This breakthrough provided a non-commutative field, meaning that the multiplication of quaternions is not commutative, unlike real numbers or complex numbers (i.e., \( pq \neq qp \) in general for quaternions \( p \) and \( q \)).

**Development and Applications:**
After Hamilton's discovery, quaternions were initially used in physics and mathematics, and for a time, they were a major topic of study among mathematicians. However, with the development of vector calculus, the use of quaternions waned in most fields. Vector calculus seemed more intuitive and was easier to use for many problems in physics and engineering.

However, quaternions saw a resurgence in the latter half of the 20th century with the advent of computer graphics and robotics. In these fields, the properties of quaternions are highly advantageous for several reasons:

1. **Avoidance of Gimbal Lock:** Unlike Euler angles, quaternions do not suffer from gimbal lock, which is a loss of one degree of freedom in 3D space due to the mathematical singularity that occurs with Euler angles.

2. **Efficiency:** Quaternion operations are computationally efficient and stable for iterative calculations, which is beneficial for real-time systems such as flight simulations and computer games.

3. **Interpolation:** Spherical Linear Interpolation (SLERP) between quaternions gives smooth rotation animations and is computationally more efficient than matrix operations.

4. **Compactness:** A rotation in three dimensions can be represented by just four numbers (one real and three imaginary parts), as opposed to the nine numbers needed for a 3x3 rotation matrix.

Quaternions are now standard in fields that require the representation and calculation of rotations, and their use continues to grow as we push the boundaries of technology and mathematics.


## why need 4 dimension?, is there any method using only a+bi+cj? is that related with commutative or distributive property of number?

Hamilton's quest for extending complex numbers into higher dimensions was motivated by the desire to describe rotations in three-dimensional space. Complex numbers, which can be written in the form \( a + bi \), work perfectly for rotations in two dimensions, but extending this to three dimensions proved to be non-trivial.

Hamilton tried for many years to find a way to multiply triplets of numbers in a way that could represent three-dimensional rotations but was unsuccessful. The breakthrough came when he realized that a four-dimensional system was necessary. The need for a four-dimensional system arises from the requirement to maintain certain mathematical properties—specifically, the properties that make complex numbers so useful, such as the ability to represent rotation and scale, and the existence of multiplicative inverses for every non-zero element.

Let's break down why a third term \( cj \) alone doesn't suffice:

- **Rotations in 3D:** A system that describes rotations in three dimensions needs to account for the fact that rotation about one axis affects the subsequent rotation about another axis. Complex numbers inherently cannot capture this because they only allow for rotation in a plane. To represent 3D rotations, you need a mechanism that encodes an additional degree of freedom, which quaternions provide with their extra dimensions.

- **Non-commutativity:** In three dimensions, rotations are not commutative; that is, rotating an object around the X-axis and then the Y-axis will yield a different result than doing the same rotations in the opposite order. Hamilton's realization was that a four-dimensional system could naturally encode this non-commutative behavior.

- **Distributive Property:** While the distributive property (i.e., \( a(b + c) = ab + ac \)) is a fundamental property in algebra that both complex numbers and quaternions share, it wasn't the distributive property that was the issue in extending to three dimensions—it was the non-commutativity of rotation in three-dimensional space.

- **Multiplicative Inverses:** In complex numbers, for every non-zero element, there is a multiplicative inverse. Hamilton wanted to preserve this property in any extension. Quaternions maintain this property, as every non-zero quaternion has an inverse.

As for whether you could stop at three dimensions with something like \( a + bi + cj \), it turns out you can't if you want a consistent algebraic structure that includes division (multiplicative inverses) and can represent 3D rotations. Attempting to define a three-dimensional "complex number" system runs into problems with defining a consistent multiplication operation that has the properties we want, like associativity, the existence of a multiplicative identity, and inverses for every non-zero element.

Quaternions, with their four components, satisfy these requirements. They are associative and distributive, have a multiplicative identity (1), and every non-zero quaternion has a multiplicative inverse. The additional dimension allows for a consistent and useful algebraic structure, which includes the ability to describe rotations in three dimensions. The non-commutative nature of quaternion multiplication mirrors the non-commutative nature of 3D rotations, making them an ideal tool for such applications.