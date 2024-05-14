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

