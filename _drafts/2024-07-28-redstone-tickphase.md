---
# 포스트 제목
title: Tick Phase와 TileTick & BlockEvent 매커니즘

# author key값, _data/authors.yaml 에 있어야 정상적으로 표시됨
author: JiseokLee

# 포스트가 올라간 날짜. 한국은 GMT+09이므로 +0900 이다
date: 2024-07-28 21:33:00 +0900 

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

> 마인크래프트의 Tick Phase와 레드스톤 최적화에 사용되는 기본적인 tick phase order를 소개한다.  

> 참고 : [Minecraft - Tick](https://technical-minecraft.fandom.com/wiki/Tick)  
> 참고 : [Spark guides - TPS & MSPT](https://spark.lucko.me/docs/guides/TPS-and-MSPT)  
> 참고 : [github - redstoe resources](https://gist.github.com/pwouik/a3f5b4afcb3ff9ea0eeebb21b4a9ebdf)  

테크 블로그에 게임의 포스팅을 쓰는게 좀 나도 황당하긴 한데. 그래도 쓰고 싶다.

개인적으로 마인크래프트라는 게임을 오랫동안 즐겨왔지만. 그동안은 주로 테크니컬 모드팩을 즐겼기 때문에 레드스톤을 다룰 기회가 잘 없었다.
그러다가 최근 모드가 아예 없는 1.21버전 서버에 초대를 받아 활동할 기회가 있었는데, 이를 계기로 레드스톤을 만지게 되었다.

개인적으로 서버에 활동하는 분들 중 레드스톤에 대해 잘 아시는 분이 없어서. 이 참에 레드스톤에 대해 제대로 공부하고 서버에 수준 높은 레드스톤 시스템을 구축해 서버에 도움이 되고자 했다.

재미있는건 이 과정에서 레드스톤 최적화에 대해 알게 되었는데. 생각보다 기술적이고 컴퓨터 공학적인 부분이 많았다.
특히 마인크래프트라는 게임의 한 프레임에 일어나는 절차들을 낱낱이 해부하고 이용하며. 회로의 크기, 복잡도, 동작 속도를 최적화 하는 이론적인 배경과 결과들은 경이로울 정도였다.

이런 재미있는 정보를 나만 알긴 아까우니 앞으로 몇몇 포스팅을 통해 마인크래프트 레드스톤에 숨겨진 재미있는 기술적인 부분들도 소개하고자 한다.

## What is Redstone?

레드스톤은 마인크래프트의 신호 시스템이다. 이를 통해 블록들을 연결하고, 신호를 통해 블록들을 제어할 수 있다.

## Game Tick

마인크래프트는 게임 내의 사건을 tick 이라는 단위로 처리한다. 보통은 1초를 20tick으로 나누어 처리하는데, 이 tick의 주기를 변화시키면 그만큼 게임이 느려지거나 빨라진다.
간단히 생각하면 게임의 1프레임이다.

물론 게임의 실제 렌더링 프레임은 144Hz, 165Hz 등의 주기로 더 빠르게 동작하지만, 게임 내의 모든 상호작용은 20tick의 주기로 이루어진다. 이를 통해 게임의 안정성을 유지하고, 여러가지 이벤트들을 동기화할 수 있다.
이러한 게임의 메인 tick을 Game Tick이라고 한다. 줄여서 gt 라고도 표기한다. 0.05초의 인게임 시간 이라고 생각해도 된다.

1gt 안에 일어나는 일들은 대략적으로 다음과 같다.

- 몹의 움직임 및 AI 계산
- 블록의 업데이트 (물의 흐름, 식물의 성장, 블록의 생성 및 파괴, 레드스톤 회로의 동작 등)
- 게임 내 날씨 변화
- 플레이어의 행동 처리
- 지형 생성 및 업데이트
- 등등

이러한 일들은 모두 1gt 안에 처리되어야 하며, 이를 넘어가게 되면 게임이 느려지거나 렉이 걸릴 수 있다.
1초에 몇 틱을 계산했는지를 TPS(Tick Per Second)라고 하며, 이 값이 20에 가까울수록 게임이 부드럽게 동작하고. 20보다 낮아지면 게임이 느려지거나 렉이 걸릴 수 있다.
또는 1tick을 계산하는데 걸린 시간으로도 볼 수 있는데. 이는 mspt(Milliseconds Per Tick)로 표기한다.

## Tick Phase

In Java Edition, in each game loop the following actions are processed in order:

Important tick phases for redstone is displayed in bold

- Reset next tick time if lagging 2s behind expected tick time
- Compute next tick time
- Increment tick count
- Functions with tick or load tags are executed
- Each dimension is ticked in order of overworld, the nether, the end and custom dimensions. For each dimension:
  - Send time every 20 gameticks to players
  - Update world border bounds
  - Advance weather cycle
  - Update Daylight cycle time
  - Player sleeping logic
  - Run scheduled commands
  - **Scheduled block ticks**
  - Scheduled fluid ticks
  - Raid logic
  - Update chunks load level
  - For all chunks in random order:
    - Spawn mobs
    - Tick ice and snow
    - Random ticks
  - Send block changes to players
  - Update points of interest
  - Unloads chunks
  - **Execute block events**
  - Tick dragon fight
  - For all non-passenger entities:
    - Check if it can despawn
    - Tick entity
    - Tick passengers
  - **Tick block entities**
  - Handle game events
- **Send queued packets and handle incoming packets for each players**
- Send player info to players
- Autosave every 6000 ticks
- Run pending tasks and wait for next tick

The following actions, those are directly related to redstone in each tick are :

1. Scheduled block ticks (Tile tick phase)
2. Execute block events (Block event phase)
3. Tick block entities (Tile Entity phase)
4. Send queued packets and handle incoming packets for each players (User input phase)

The order of these phases are very important for extrem performance optimization of redstone contraption. Such as instant mechanics, zero-tick mechanics etc.

## Tile Tick Phase

Tile ticks are actions sheduled to happen in a given number of ticks at a block. When the tile tick is executed, the block executes an action depending on its type.

In this phase the game selects scheduled tile ticks which have their processing tick (the result of taking the tick number(world counter) from the tick the update was scheduled in + the delay of the tile tick) smaller than or equal to the current tick, and move them to a different list, where they are executed. Some redstone components such as observers and lamps doesn’t check if there is a tiletick in the executing list before scheduling a new one.

There are two different schedulers that get processed after one another: block tile ticks, then fluid tile ticks.

The scheduled delay of major redstone components for contraption in game tick is listed below.

|Component|Delay(gt)|
|---|---|
|Repeater|2,4,6,8|
|Comparator|2|
|Observer|2|
|Redstone Torch|2|
|Dispenser|4|
|Dropper |4|
|Redstone Lamp|4|

Check out all component's delay in [here](https://techmcdocs.github.io/pages/GameTick/TileTicks/)

### Tile Tick Queue

Tile tick queue is a list of tile ticks that are scheduled to be executed in the current tick. The game selects scheduled tile ticks which have their processing tick smaller than or equal to the current tick, and move them to a different list, where they are executed. Basically in the same game tick, processing order is FIFO(First input, First output). But this order can be changed due to TTP(Tile Tick Priority) rules.

### TTP (Tile Tick Priority)

For most of the time, the tile tick queue is processed in the order they were scheduled. However, there are some exceptions to this rule. The game has a priority system for tile ticks, which is used to determine the order in which tile ticks are executed. This is called TTP(Tile Tick Priority).

TTP rules are as follows:

1. Tile ticks with a higher priority(ex, -1 has higher priority that 0) are executed before tile ticks with a lower priority.
2. Tile ticks with the same priority are executed in the order they were scheduled.

The scheduled tick priority rule for major redstone components are listed below.

|Component|Priority|
|---|---|
|Repeater, facing another diode| -3|
|Repeater, not facing another diode, powering | -1|
|Repeater, not facing another diode, depowering | -2|
|Comparator, facing another diode| -1|
|Comparator, not facing another diode| 0|
|Other components|0|

> diode : Repeater, Comparator  
> facing another diode : facing another diode that is not facing it  
> unpowered repeater that is not receiving power when ticked : -2

These rules are the main cause of some components are not interact with 2gt(1 redstone tick) pulse. Such as comparator, redstone torch.

## Block event phase

Block events are actions that are scheduled to happen in a given number of ticks at a block. When the block event is executed, the block executes an action depending on its type.

Including things like these :

- **Piston extension & retraction**
- **Noteblock plays note**
- Chest open/close
- Gateway start cooldown
- Mob spawner delay reset
- Etc.

> Important events are bolded.

Block events are stored in a LinkedHashSet. The game loops through block events and processes them. And Piston block events can activate and schedule another block event that is added at the end of the LinkedHashSet. This allow chaining multiple blockevents in the same tick, leades to zero-tick mechanics.

Also, block events are send directly to client side to render the block event. This is why pistons are rendered instantly when they are activated.

### Block Event Queue & HastSet

In the block event phase, the game iterates through the block event queue and processes each block event. This queue is called 'synchedBlockEventQueue' using data structure, 'ObjectLinkedOpenHashSet'. This data structure includes both List & HashSet inside.

When block event enqueued, HastSet checks the uniqueness of the block event. If the block event is new and unique, it is added to the end of the List. Otherwise discarded. This allows the game to process the block events in the order they were scheduled, and also allows the game to process same events only once.

### Block Event Hashing

ObjectLinkedOpenHastSet ignore the events that already exist in the scheduled block event queue. So knowing what determines the uniqueness of the block event is important.

As a result, the properties below are used to determine event hash :

- Block position(x,y,z)
- Type of block
- Attributes of block
- Type of block event
- Data of the block event

The block event type and data table for note block & piston are listed below.

|Block Name| Type| Data |Called When
|---|---|---|---|
|Noteblock |0 |0 |played|
|Extending Piston |0| direction piston is facing  |
|Retracting Piston| 1 |direction piston is facing  |
|Moving Piston |2| direction piston is facing  |

Full table of block event type and data can be found [here](https://techmcdocs.github.io/pages/GameTick/)

So basically you cannot schedule the same block event twice in the same tick. This also means you cannot activate the same piston twice in the same tick. That is the fundamental limitation of 0-tick mechanics.

## Tile entity phase

Tile/Block entities are processed in this phase. This includes things such as:

- **Moving blocks turn into normal blocks**
- **Moving blocks push entities and slime give velocity**
- Furnaces check for items in their inventory
- **Hoppers push and pull items**
- Sculk sensors activate.

> Important events are bolded.

This uses the same Queue system just like Tile Tick Queue. The game selects scheduled tile entities which have their processing tick smaller than or equal to the current tick, and move them to a different list, where they are executed.

As this phase is later than tile tick & block event phase, hoppers always move or push items after all tile ticks and block events are processed. This is why hoppers are not affected by 0-tick mechanics.

## User input phase

Player inputs are processed in this phase. This includes things such as:

- Flipping levers
- Pushing buttons
- Placing blocks
- Breaking blocks

As this phase is later than all other phases, player interaction delay is always 1gt. This is why you can send 2gt(1rt) pulse to the redstone components such as comparator & redstone torch manually by player interaction with lever.

## Conclusion

We overlooked the tick phase of the minecraft, and scoped the important phases for redstone contraption.

Tile tick phase is the phase that executes the scheduled tile ticks like repeater or redstone torch. Block event phase is the phase that executes the scheduled block events such as pistons and noteblocks. Tile entity phase is the phase that executes the scheduled tile entities such as hoppers and pushed blocks. User input phase is the phase that executes the player inputs.

Understanding the order of these phases is crucial for optimizing redstone contraption.
On the next post, we will dive into basic redstone powering mechanism and order of block update & state change event.

termiology :

- gt : game tick. 1/20  second
- rt : redstone tick. 1/10 second

- item sorter :  아이템을 스스로 정렬하고 필터링하는 모든 시스템
- chest hull :  아이템 상자를 담고있는 복도. 보통 slice와 UI로 구성되며, 필요한 만큼 구조를 늘리거나 확장할 수 있는 구조가 많다.
- slice : 반복 가능한 회로 구조. 주로 tileable 함.
- n-wide tileable : 어떤 회로나 모듈이 간섭 없이 배치될 수 있는 최소 너비가 n블럭임.
- n-wide AB tileable : 어떤 회로나 모듈이이 간섭 없이 교대로 배치될 수 있는 최소 너비가 N블럭임. (n-wide ABC tileable 처럼 계속 확장될 수 있음)
- Single Item Sorter : 제일 간단한 형태의 아이템 분류기. 하나의 상자에 한 종류의 아이템만 필터링 가능한 구조.
- Multi Item Sorter(MIS) : 하나의 상자에 여러 종류의 아이템을 필터링 가능한 구조. single item sorter가 너무 많은 공간을 차지하는 단점을 극복하기 위해 등장함.
- dropper line : 드로퍼를 이용한 아이템 전달 라인. 아이템을 n블럭 전달하려면 원칙적으론 2n gt의 시간이 걸리지만, BED(Block Event Delay), TTP(Tile Tick Priority), Observer Update 등을 이용해 1gt 으로 줄이는 경우가 많음(instant dropper)
- hopper line : 호퍼를 이용한 아이템 전달 라인. 드로퍼 라인보다 느리지만 별도의 회로 없이도 아이템을 전달할 수 있음.

심화 개념 : tick phase

왜 hopper unlock 과 동시에 템이 빨려 들어가는가?

tick phase와 관련이 있음

마인크래프트에서 1tick 안에 일어나는 일들에는 순서가 정해져 있고, 이를 tick phase라 함.
수많은 페이즈가 있지만, 레드스톤에 가장 중요한 페이즈는 다음 순서로 일어남.

1. tile tick phase
2. block event phase
3. tile entity phase
4. user input phase

tile tick phase
모든 타일의 scheduled tick이 처리되는 페이즈.
여기서 scheduled tick이란 과거의 tick 에서 지금 tick에 일어나라고 예약된 행동을 의미함.
예를 들어, repeater의 경우는 2gt, 4gt, 6gt, 8gt 뒤에 신호를 보내도록 행동을 예약함.

scheduled tick은 queue 형태로 저장되어 있으며, FIFO(First In First Out)순서로 처리됨.
따라서 기본적으론 먼저 예약된 행동이 먼저 처리됨.
하지만 세부적으론 나중에 설명할 TTP(tile tick priority) 에 의해 처리 순서가 변경될 수 있음.

block event phase
블록 이벤트가 처리되는 페이즈. 대표적으로 피스톤이 확장 또는 수축하기 시작하거나, 노트블럭이 소리를 내는 이벤트가 이때 처리됨.
피스톤이나 노트블럭에 옵저버가 붙어있다면, 이 시점에 옵저버가 업데이트 되고 tick schedule queue에 예약을 넣음.

tile entity phase
모든 타일 엔티티의 행동이 처리되는 페이즈. 대표적으로 호퍼가 아이템을 빼거나 넣는 행동이 여기에 해당함.
피스톤에 의해 블럭이 옮겨질 때, 모션이 끝나고 그 블럭이 다시 월드에 실체화되는 때도 이때임.

user input phase
사용자에 의해 넣어진 모든 입력들이 처리되는 페이즈. 레버를 누르거나 버튼을 누르거나 블럭을 부수는 등의 행동이 여기에 해당함.

hopper가 lock-> unlock으로 상태가 바뀌는 이벤트는, tile tick phase에서 연결된 레드스톤 토치의 상태가 바뀔 때 발생함.
이후에 tile entity phase에선 hopper가 이미 unlock 되어있으므로, push&pull 행동을 재개함.

이 모든 행동은 tick phase 순서에 따라 일어나므로, 같은 1gt 안에서 동시에 일어날 수 있음.
이게 호퍼가 같은 틱 안에서 unlock 됨과 동시에 아이템을 빨아들이는 이유임.

심화개념 2 -  scheduled tick queue
왜 레드스톤 토치는 리피터의 1rt 펄스를 무시하는가?

리피터에 의해서 토치가 신호를 받는 상황임.
이땐 리피터가 먼저 자신이 꺼지는 예약을 큐에 넣고, 그 다음에 레드스톤 토치가 상태 반전 예약을 큐에 넣기 때문.
그래서 리피터가 이미 꺼진 다음에 레드스톤 토치가 상태를 반전하려 하기 때문에 토치가 꺼지지 않음.

결과적으로 리피터가 1rt 펄스를 쏴서 레드스톤 토치를 끄려고 해도, 레드스톤 토치는 상태가 변화하지 않음

이를 표로 이해하면 다음과 같음.

1 신호1 리피터0 토치1 (  A:3gt 시점에 리피터 켜짐 예약됨)
2 신호1 리피터0 토치1
3 신호0 리피터1 토치1 (A 실행됨.   B:5gt시점에 리피터 꺼짐 예약됨, C:5gt 시점에 토치 신호반전 예약됨,)
4 신호0 리피터1 토치1
5 신호0 리피터0 토치1 (B가 먼저 실행되면서 리피터 꺼짐, C 실행되지만 이미 리피터가 꺼져있으므로 토치는 꺼지지 않음)

이와 같은 이유로 다른 레드스톤 부품으로부터 오는 1rt 펄스는 대부분 무시됨.
예를 들면 레드스톤 토치나 비교기는 옵저버의 1rt 펄스에도 반응하지 않음.

그런데 희한하게 리피터는 1rt 펄스에 반응함. 이는 예약 내용이 약간 다르기 때문임.
토치나 비교기는 예약을 처리할 때, 현재 상태를 고려해서 신호를 반전시킬지, 신호 세기를 바꿀지 결정함.

반면 리피터는 1gt 펄스도 맘대로 2gt, 4gt, 6gt, 8gt 로 늘려서 보냄.
이는 예약 내용 자체가 처리 시점의 input에 상관 없이 신호를 발생하도록 되어있기 때문임.
그래서 처리 시점에 옵저버가 이미 꺼져있더라도, 리피터는 예약된 신호를 그대로 발생시킴.

심화개념 3 - TTP(Tile Tick Priority)
TTP는 tile tick phase에서 발생하는 이벤트들의 우선순위를 결정하는 규칙임.
지금 시점에 실행되어야 하는 scheduled tick 이벤트가 여러개라면, 기본적으로 queue에 넣어진 순서대로 처리됨.
하지만 TTP가 적용되면, 이 순서가 변경될 수 있음.

알려진 TTP 규칙은 다음과 같음
리피터, 비교기 TTP규칙 테이블

따라서, 다음과 같이 회로를 구성한 경우, 반드시 리피터가 있는 쪽의 피스톤이 먼저 작동함.
TTP를 사용하면 같은 tick 안에서 블럭이 작동하는 순서를 조작할 수 있고. 이는  
0-tick 기술로 이어짐.
