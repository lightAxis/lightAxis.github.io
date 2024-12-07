---
# 포스트 제목
title: Powering mechanism과 update order

# author key값, _data/authors.yaml 에 있어야 정상적으로 표시됨
author: JiseokLee

# 포스트가 올라간 날짜. 한국은 GMT+09이므로 +0900 이다
date: 2024-07-28 23:37:00 +0900 

# 카테고리 세팅. n개의 배열이며, 순서대로 부모->자식 관계이다
categories: [게임, 마인크래프트]

# 태그 세팅. n 개의 배열이다.
tags: [Minecraft Redstone]

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

> 마인크래프트 레드스톤의 파워링 메커니즘과 업데이트 순서에 대해 알아보자.

> 참고 : [github - redstoe resources](https://gist.github.com/pwouik/a3f5b4afcb3ff9ea0eeebb21b4a9ebdf)   
> 참고 : [Block Update](https://minecraft.wiki/w/Block_update)

For the basic redstone components & concepts, check this [article](https://minecraft.fandom.com/wiki/Redstone_mechanics) first . 

## Soft-Powered & Hard Powered 
Blocks that recieves power can be soft-powered or hard-powered. Soft-powered blocks can only send the signals to redstone components such as repeaters, comparators, pistons, hoppers etc. Hard-powered blocks can send signals to any block that can recieve power including redstone dusts. 
powered block can be a piston, redstone lamp itself. 
Each redstone dust and component has different powering method to adjecent blocks. 

For example, This is a hard-powered block. both redstone dust & other components are powered through block. 
그림 1

This is soft-powered block. only redstone components are powered. 
그림 2

## update order

There's a specific order when some events propagate through other adjacent blocks in minecraft. These are called update order. Most considered update order in redstone contraption is : 

- block update order
- redstone dust update order
- shape change event update order

Each update orders are slighty or significantly different from each other. And these orders are the main reason why some redstone contraptions work at specific directions, we call it `directional` & `directionless` circuit.
 
These are the most important concept in redstone optimization to make the contraption work as intended. 90% of redstone optimizations are sophisticatlly manipulate the update orders of components to accelerate the contraption.


## Block update order

A block update is an in-game mechanism that occurs when a block is modified in some way. Limited to the computing power of a computer, the game can not process all blocks at all times, which is why the game needs a mechanism such as a block update. When a block changes (due to a player, an entity, or a chunk tick, etc.), it notifies nearby blocks that they should check if they need to respond to the change.

Many blocks emits the block update signal including all redstone stuffs. Most of them check the blocks in 1 block radius. But some blocks like redstone dust, redstone torch checks the blocks in 2 block radious in default. 

Observers, repeater, comparators are pretty different. They check the block they are facing, and the block adjecent to that block. 

Check [here](https://minecraft.wiki/w/Block_updates) for the full block update region. 

When do this update, minecraft itself has a pre-defined priority list to find and propagate the block update signal : 

> **Block update order**
> 
> 1. -X 
> 2. +X
> 3. -Y
> 4. +Y
> 5. -Z
> 6. +Z
{:.prompt-info}

For example, when multiple components are attached to powered block, block update signal will propagate to the components in the order of the list. 
And block that recieved the update event can also propagate the signal to other blocks in the same order. Like torches, comparators, repeaters.
This leads to chain reaction of the block update event

Block update event uses BFS(Breadth First Search) algorithm to find the next block to update. And start with the hard-powered blocks first. After than soft-powered blocks.

The algorithm is like this : 

> **Algorithm 1 : Block Update**
>
> **Input**: initial block $B_i$ to update  
> 
> Empty block event queue : $Q$  
> push $B_i \rightarrow Q$  
> 
> $\quad$ **while** $Q$ is not empty  
> $\quad$ pop front Block $B$ from $Q$  
> $\quad$ $\quad$ **foreach** Neighbouring block $B_a$ of $B$  
> $\quad$ $\quad$ $\quad$ trigger Block Update Event of $B_a$  
> $\quad$ $\quad$ $\quad$ push $B_a$ $\rightarrow Q$ by type of $B$
{:.prompt-info}

Example : figure 1 describle the actual block update order of redstone torch.

## Redstone dust update order

really complicated, but most of the time just follow the block update order. 

full order is at [here](https://youtu.be/2mjZuWJDB0k?si=33cdxbyDMjM1MqVU)

## Shape change event update order

Shape change event is a subclass of block update event. In case of some blocks like pistons, rails, fences, crops, etc. they emit a shape change event when they change their shape.


