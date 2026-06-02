#import "../index.typ": template, tufted
#show: template.with(
  title: "一生一芯 F3 阶段学习记录",
  date: datetime(year: 2026, month: 6, day: 1),
  description: "一生一芯 F3 阶段的学习记录",
)

#import "@preview/theorion:0.6.0": *

#let question = note-block.with(
  fill: rgb("#118D8D"),
  title: theorion-i18n-map.at("exercise"),
  icon-name: "pencil",
)

= F3 数字逻辑电路基础 学习记录

#tip-block[
请使用白天模式阅读本章节

在黑夜模式下, 图片的显示将难以识别, 建议使用白天模式进行阅读.
]

== 通过晶体管搭建门电路

=== 分析门电路

#question[
  尝试分析以下门电路的行为和功能.

  #image("./imgs/F3-1.png")
]

这个门电路的行为:

#table(
  columns: (1fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr),
  align: (center, center, center, center, center, center, center),
  table.header([A], [B], [P1], [P2], [N1], [N2], [Y]),
  [0], [0], [导通], [导通], [截止], [截止], [1],
  [0], [1], [导通], [截止], [截止], [导通], [0],
  [1], [0], [截止], [导通], [导通], [截止], [0],
  [1], [1], [截止], [截止], [导通], [导通], [0],
)

其中，只有 $A$ 和 $B$ 同时为 $0$ 时，输出 $Y$ 为 $1$，其余情况 $Y$ 均为 $0$ ，即

$ Y = overline(A) dot overline(B) = overline(A + B) $

说明这个门电路的功能是 *或非(NOR)门* .

== 或门的晶体管结构

#question[
  以下是或门的逻辑符号, 尝试画出或门的晶体管结构.
  
  #image("./imgs/F3-2.png")
]

结合上一题或非门和非门就可以得到，或门的晶体管结构如下图所示:

#figure(
  image("./imgs/2_OR_gate.svg"),
  caption: [或门的晶体管结构]
)

=== 对比两种实现的晶体管所需要的数量

#question[
  #table(
    columns: (1fr, 1fr),
    align: (center + horizon, center + horizon),
    gutter: 10pt,
    image("./imgs/F3-3-nand-gate1.png"), image("./imgs/F3-3-nand-gate2.png")
  )
  
  不难分析, 上述晶体管结构同样实现了三输入与非门的功能. 尝试对比两种实现方式中所需晶体管的数量.

  Hint: 对于用门电路搭建的设计, 其晶体管数量可看作是设计中用到的所有门电路的晶体管数量之和.
]

- 通过一个两输入与门和一个两输入与非门来搭建一个三输入与非门需要的晶体管数量为

$ 6 ("AND gate") + 4 ("NAND gate") = 10 "个" $

- 使用晶体管来搭建三输入与非门需要的晶体管数量为 $6$ 个

=== 用其他门电路搭建异或门

#question[
尝试在Logisim中用上文提到的门电路搭建一个异或门. 搭建后, 通过仿真检查你的方案是否正确.

实现正确后, 计算你的方案使用了多少个晶体管.
]

设 $plus.o$ 为异或运算，由于 $A plus.o B = A overline(B) + overline(A) B$ ，可以得到如@fig:xor-gate-1 所示的电路

#figure(
  image("./imgs/4_XOR_gate_1.svg"),
  caption: [异或门的晶体管结构 1]
) <fig:xor-gate-1>

如@fig:xor-gate-1 所示，异或门需要的晶体管数量为

$ 2 times 2 ("NOT gate") + 2 times 6 ("AND gate") + 2 times 6 ("OR gate") = 28 "个" $

=== 寻找更优的搭建方案

#question[
不考虑全定制电路, 尝试寻找一种晶体管数量最少的方案来实现异或门, 并在Logisim中测试你的方案是否正确.

Hint: 有一种方案只需要使用14个晶体管, 因此最优方案的晶体管数量应不多于14个.
]

设 $plus.o$ 为异或运算，从异或运算的逻辑意义“两个输入不同时为$1$”出发，可以得到逻辑表达式:

$ A plus.o B = (A + B) dot overline(A B) $

根据 *还原律* 和 *反演率(德·摩根定律)* ，对原逻辑表达式取两次非之后得到

$
A plus.o B & = overline(overline((A + B) dot overline(A B))) \
& = overline(overline(A + B) + A B)
$

对于上式，我们需要以下三个逻辑门：

- $X = overline(A + B)$ : 使用一个 NOR 门实现，消耗 4 个晶体管.

- $Y = A B$ : 使用一个 AND 门实现，消耗 6 个晶体管.

- $Z = overline(X + Y)$ : 使用一个 NOR 门实现，消耗 4 个晶体管.

总共消耗 $4 + 6 + 4 = 14$ 个晶体管.

Logisim 中的实现如@fig:xor-gate-2 所示

#figure(
  image("./imgs/5_XOR_gate_2.svg"),
  caption: [异或门的晶体管结构 2]
) <fig:xor-gate-2>

=== 异或门的全定制电路

#question[
下图是异或门的一种全定制实现, 尝试分析其行为.

#image("./imgs/F3-6.png")
]

这个门电路的行为:

#table(
  columns: (1fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr),
  align: (center, center, center, center, center, center, center),
  table.header([A], [B], [P1], [N1], [P2], [N2], [P3], [N3], [Y]),
  [0], [0], [导通], [截止], [截止], [截止], [导通], [导通], [0],
  [0], [1], [导通], [截止], [截止], [截止], [导通], [导通], [1],
  [1], [0], [截止], [导通], [导通], [截止], [截止], [截止], [1],
  [1], [1], [截止], [导通], [截止], [导通], [截止], [截止], [0],
)

=== 设计同或门

#question[
还有另一种操作是"同或"操作, 当输入A和B相同时, 结果为`1`, 否则为`0`. 同或操作可以认为是异或操作结果的取反.

尝试在Logisim中用上文提到的门电路搭建一个同或门. 搭建后, 通过仿真检查你的方案是否正确.
]

设 $dot.o$ 为同或运算，从同或运算的逻辑意义“两个输入相同时为$1$”出发，可以得到逻辑表达式:

$ A plus.o B = A B + overline(A) dot overline(B) $

根据 *反演率(德·摩根定律)* 

$ A plus.o B = A B + overline(A + B) $

根据 *还原律* 和 *反演率(德·摩根定律)* ，对原逻辑表达式取两次非之后得到

$
A plus.o B & = overline(overline(A B + overline(A + B))) \
& = overline(overline(A B) dot (A + B))
$

对于上式，我们需要以下三个逻辑门：

- $X = overline(A B)$ : 使用一个 NAND 门实现，消耗 4 个晶体管.

- $Y = A + B$ : 使用一个 OR 门实现，消耗 6 个晶体管.

- $Z = overline(A B)$ : 使用一个 NAND 门实现，消耗 4 个晶体管.

总共消耗 $4 + 6 + 4 = 14$ 个晶体管.

Logisim 中的实现如@fig:nxor-gate-1 所示

#figure(
  image("./imgs/7_NXOR_gate_1.svg"),
  caption: [同或门的晶体管结构]
) <fig:nxor-gate-1>

=== 同或门的全定制电路

#question[
尝试用最少数量的晶体管搭建一个同或门.

Hint: 有一种方案只需要使用6个晶体管, 因此最优方案的晶体管数量应不多于6个.
]

模仿前面异或门的设计，我们可以使用两个反相器和一个传输门实现同或门，如@fig:nxor-gate-2 所示

#figure(
  image("./imgs/8_NXOR_gate_2.svg"),
  caption: [同或门的全定制电路]
) <fig:nxor-gate-2>

== 进位计数法

=== 八进制(octal)计数法

#question[
在计算机中, 有的场景也会使用八进制, 其原理和十六进制类似, 感兴趣的同学可以自行推导八进制和十进制之间, 以及  方法.
]

- 八进制与十进制之间的转换

  - 对于十进制转八进制，可以使用除 $8$ 取余法，将十进制数不断除以 $8$ 过程中得到的余数分别对应 $a_0a_1 dots a_(n-2)a_(n-1)$ .

  - 对于八进制转十进制，需要将每一位乘上对应的位权，即对于 $n$ 位八进制数 $a_(n-1)a_(n-2) dots a_1a_0$ , 其真值可通过以下加权求和展开式得到:

$ sum_(i=0)^(n-1) a_i times 8^i = a_(n-1) times 8^(n-1) + a_(n-2) times 8^(n-2) + dots.c + a_1 times 8 + a_0 $

- 八进制和二进制之间的转换

  每 $3$ 位二进制数对应 $1$ 位八进制数, 具体的对应关系如@tbl:bin-oct 所示

#figure(
  table(
    columns: (1fr, 1fr, 1fr, 1fr),
    align: center,
    table.header([八进制数], [二进制数], [八进制数], [二进制数]),
    [0], [000], [4], [100],
    [1], [001], [5], [101],
    [2], [010], [6], [110],
    [3], [011], [7], [111],
  ),
  caption: [八进制与二进制数转换表]
) <tbl:bin-oct>

== 通过门电路搭建基本组合逻辑电路

=== 搭建2-4译码器

#question[
尝试在Logisim中用门电路搭建一个2-4译码器, 它有2位输入, 4位输出. 搭建后, 通过仿真检查你的方案是否正确.

Logisim中也直接提供了译码器等现成的元件, 但我们还是要求大家使用门电路来搭建它们, 从而更好地学习数字电路的基本原理.
]

在 Logisim 中用门电路搭建的 2-4 译码器如@fig:Decoder_2to4 所示

#figure(
  image("./imgs/10_Decoder_2To4.svg"),
  caption: [2-4 译码器的门电路实现]
) <fig:Decoder_2to4>

=== Logisim中的子电路功能

#question[
译码器在后续的数字电路设计中会经常用到, 为了避免用户重复设计相同的电路, Logisim提供了子电路功能, 相应电路只需要设计一次, 后续即可反复实例化. 具体操作方式请阅读官方手册中的`Subcircuits(子电路)`部分.

学习如何使用Logisim的子电路功能后, 尝试将你设计的译码器封装成子电路.
]

创建新的电路图将 Probe 替换为 Pin (Output) 即可，如@fig:Decoder_2to4_subcircuit 所示:

#figure(
  image("./imgs/11_Decoder_2To4.svg"),
  caption: [2-4 译码器的 Logisim 子电路]
) <fig:Decoder_2to4_subcircuit>

=== 译码器的扩展

#question[
3-8译码器有3位输入, 8位输出. 尝试实例化若干个2-4译码器(具体数量交给你的思考), 并添加少量门电路, 从而实现3-8译码器的功能. 搭建后, 通过仿真检查你的方案是否正确.

在Logisim中, 模块的输入信号和输出信号通常连接到一些输入或输出元件, 通过这些元件的状态, 可以得知输入信号或输出信号的当前值. 如果你想了解中间信号的当前值, 可以使用元件库提供的`Probe(探针)`元件, 你可以在Logisim元件库的`Wiring(线路)`类别下找到它, 具体使用方式请RTFM.
]

在 Logisim 中用 2-4 译码器和少量门电路搭建的 2-4 译码器如@fig:Decoder_3to8 所示

#figure(
  image("./imgs/12_Decoder_3To8.svg"),
  caption: [使用 2-4 译码器搭建的 3-8 译码器]
) <fig:Decoder_3to8>

=== 搭建七段数码管译码器

#question[
尝试在Logisim中通过门电路搭建一个七段数码管译码器, 它有4位输入和8位输出, 分别与拨码开关和七段数码管相连. 七段数码管译码器支持十进制数字的显示, 即当输入对应0-9时, 七段数码管显示对应的数字; 对于其他输入, 七段数码管只显示小数点. 搭建后, 通过仿真检查你的实现是否正确.

Hint:

七段数码管元件可在元件库中找到, 实例化后, 可以通过将鼠标指针悬停在元件的端口上, 来查看该端口的功能描述.
可以先用n选1译码器生成一组独热码, 然后再通过一层或门来分别决定每个发光二极管在哪些输入的情况下应该点亮.
]

在 Logisim 中通过门电路搭建的十进制七段数码管译码器如@fig:7SegmentDisplay_DEC 所示

#figure(
  image("./imgs/13_7SegmentDisplay_DEC.svg"),
  caption: [使用门电路搭建的十进制七段数码管译码器]
) <fig:7SegmentDisplay_DEC>

=== 搭建七段数码管译码器(2)

#question[
尝试在Logisim中通过门电路搭建一个支持十六进制数字的七段数码管译码器. 和上述的十进制数字相比, 当输入对应10-15时, 七段数码管分别显示A, b, C, d, E, F. 搭建后, 通过仿真检查你的实现是否正确.
]

在 Logisim 中通过门电路搭建的十六进制七段数码管译码器如@fig:7SegmentDisplay_HEX 所示

#figure(
  image("./imgs/14_7SegmentDisplay_HEX.svg"),
  caption: [使用门电路搭建的十六进制七段数码管译码器]
) <fig:7SegmentDisplay_HEX>

=== 搭建编码器

#question[
尝试在Logisim中通过门电路搭建一个16-4编码器, 它有16位输入和4位输出, 分别与拨码开关和七段数码管译码器相连, 使得编码器的输出结果通过十六进制数字显示在七段数码管中. 搭建后, 通过仿真检查你的实现是否正确.
]

在 Logisim 中通过门电路搭建的16-4编码器及其输出测试电路图如@fig:Encoder_16to4 所示

#figure(
  grid(
    image("./imgs/15_Encoder_16To4_1.svg", width: 85%),
    image("./imgs/15_Encoder_16To4_2.svg", width: 85%),
  ),
  caption: [使用门电路搭建的16-4编码器及其测试]
) <fig:Encoder_16to4>

=== 搭建4-2优先编码器

#question[
根据上述真值表, 尝试列出每一位输出的逻辑表达式. 然后尝试在Logisim中通过门电路搭建一个4-2优先编码器. 搭建后, 通过仿真检查你的方案是否正确.

实现后, 对比4-2编码器和4-2优先编码器所需的门电路数量.
]

#figure(
  table(
    columns: (1fr, 1fr, 1fr, 1fr, 1fr, 1fr),
    table.header(
      table.cell(colspan: 4)[输入], table.cell(colspan: 2)[输出],
      [$A_3$], [$A_2$], [$A_1$], [$A_0$], [$Y_1$], [$Y_0$]
    ),
    [0], [0], [0], [1], [0], [0],
    [0], [0], [1], [X], [0], [1],
    [0], [1], [X], [X], [1], [0],
    [1], [X], [X], [X], [1], [1],
    [0], [0], [0], [0], [X], [X],
  ),
  caption: [4-2优先编码器真值表]
) <tbl:4-2priority_encoder>

- 根据真值表（@tbl:4-2priority_encoder），我们可以得到 $Y_1Y_2$ 的表达式为:

$ Y_1 = A_3 + A_2 $
$ Y_0 = A_3 + overline(A_2) dot A_1 $

- 使用 Logisim 实现的 4-2 优先编码器如@fig:Priority_Encoder_4to2 所示

#figure(
  image("./imgs/16_Priority_encoder_4To2.svg"),
  caption: [Logisim 实现的 4-2 优先编码器]
) <fig:Priority_Encoder_4to2>

- 对比4-2编码器和4-2优先编码器所需的门电路数量：

  - 4-2 编码器使用了 $2$ 个非门，$4$ 个与门，共 $6$ 个门电路
  
  - 4-2 有限编码器使用了 $1$ 个非门，$1$ 个与门，$2$ 个或门，共 $4$ 个门电路

=== 优先编码器的扩展

#question[
16-4优先编码器有16位输入, 4位输出. 尝试实例化若干个4-2优先编码器, 并添加少量门电路, 从而实现16-4优先编码器的功能. 然后将16-4优先编码器与拨码开关和七段数码管译码器相连, 使其输出结果通过十六进制数字显示在七段数码管中. 搭建后, 通过仿真检查你的实现是否正确.
]

使用 4-2 优先编码器实现的 16-4 优先编码器如@fig:Priority_Encoder_16to4 所示

#figure(
  image("./imgs/17_Priority_encoder_16To4.svg"),
  caption: [使用 4-2 优先编码器实现的 16-4 优先编码器]
) <fig:Priority_Encoder_16to4>

=== 前导0和前导1的计数

#question[
计算机有时候需要计算一个数据的"前导0"的数量, 即需要计算该数据的二进制表示的高位有多少个连续的0. 假设数据的位宽是16位, 那么对于数据16392, 其二进制表示是0b0100000000001000, 因此前导0的数量为1.

类似可定义"尾随0", 即数据的二进制表示的低位有多少个连续的0. 同样以数据16392为例, 其尾随0的数量为3. 类似可定义"前导1"和"尾随1".

思考一下, 如何通过优先编码器快速计算它们?
]

- 计算前导 0 时，需要将 16 位数据按最高位接最高优先级输入，最低位接最低优先级输入的顺序接入 16-4 优先编码器中，因为优先编码器会输出从左到右第一个 “1” 所在位置的二进制序号 $P$ ，前导 0 的数量等于总位数减去从左到右第一个 “1” 的序号，即 $15 − P$ ，所以只需将编码器的 4 位输出信号直接经过非门进行按位取反，即可得到前导 0 的数量。

- 计算尾随 0 时，需要将 16 位数据按最低位接最高优先级输入，最高位接最低优先级输入的顺序接入 16-4 优先编码器，从高位开始寻找第一个1”，最后同样将编码器的 4 位输出结果按位取反，即可得到尾随0的数量。

- 计算前导1时，其本质是计算原数据反码的前导 0，因此只需在数据输入优先编码器之前，先用非门将这 16 位信号全部按位取反，然后将取反后的数据按正常顺序接入优先编码器，最后对得到的4位输出结果再次按位取反，即可得到原数据前导 1 的数量。

- 计算尾随1时，需要将原始 16 位数据通过非门阵列进行按位取反，接着将取反后信号的连线顺序完全颠倒接入优先编码器，直接寻找原数据低位的连续1，最后将优先编码器的4位输出结果按位取反，即可得到尾随 1 的数量。

=== 搭建1位2选1选择器

#question[
尝试在Logisim中通过门电路搭建一个1位2选1选择器. 搭建后, 通过仿真检查你的方案是否正确.
]

在 Logisim 中通过门电路搭建的1位2选1选择器如@fig:Mux_1bit_2to1 所示

#figure(
  image("./imgs/19_Mux_1bit_2To1.svg"),
  caption: [使用门电路搭建的16-4编码器]
) <fig:Mux_1bit_2to1>

=== 搭建3位4选1选择器

#question[
尝试画出3位4选1选择器的电路结构图, 然后在Logisim中通过门电路搭建一个3位4选1选择器. 搭建后, 通过仿真检查你的方案是否正确.

Hint:

如果你不理解"3位4选1选择器"的含义, 你需要先仔细阅读上文对"1位2选1选择器"的说明

对于数据中的每一位, 都可以复用n选1译码器生成的选择信号进行选择
]

3 位 4 选 1 选择器，即根据控制端的输入，从 4 路 3 位中选择其中 1 路进行输出。

因此，

- 对于输入：

  - 在数据端，一共有 $4 times 3 = 12$ 位输入，这里记为：
  
  #align(
    center,
    table(
      columns: (auto, auto, auto, auto),
      stroke: none,
      table.header([], table.vline(), [第 1 位], [第 2 位], [第 3 位]),
      table.hline(),
      [第 1 路], [$D_00$], [$D_01$], [$D_02$],
      [第 2 路], [$D_10$], [$D_11$], [$D_12$],
      [第 3 路], [$D_20$], [$D_21$], [$D_22$],
      [第 4 路], [$D_30$], [$D_31$], [$D_32$],
    )
  )
  
  - 在控制端，一共有 $log_2(4) = 2$ 位输入，这里记为 $S_0, S_1$ .

- 对于输出：

  一共有 $3$ 位输出，记为 $Y_0, Y_1, Y_2$ .

在 Logisim 中通过门电路搭建的 3 位 4 选 1 选择器如@fig:Mux_3bit_4to1 所示，其中2-4译码器的实现见@fig:Decoder_2to4_subcircuit .

#figure(
  image("./imgs/20_Mux_3bit_4To1.svg"),
  caption: [使用门电路搭建的 3 位 4 选 1 选择器]
) <fig:Mux_3bit_4to1>

=== 搭建可切换进位计数制的七段数码管

#question[
通过5个拨码开关和1个七段数码管, 实现如下功能: 其中4个拨码开关当作数据输入, 剩下1个拨码开关作为进位计数制的选择, 当选择信号为`0`时, 七段数码管以十进制方式显示数据; 当选择信号为`1`时, 七段数码管以十六进制方式显示数据. 在输入数据为10-15时, 两种显示方式有所不同.
]

采用自顶向下的搭建方法：

先将整个转换器视为一个完整的模块，不难画出主电路图(@fig:21_main)

#figure(
  image("./imgs/21_main.svg"),
  caption: [可切换进位计数制的七段数码管的主电路图]
) <fig:21_main>

接下来，使用 8 个 1 位 2 选 1 选择器选择两种二进制转 7 位数码管信号模块实现不同显示方式的转换(@fig:SegmentDisplay_Switcher)

#figure(
  image("./imgs/21_SegmentDisplay_Switcher.svg", width: 120%),
  caption: [使用 1 位 2 选 1 选择器实现的显示方式转换模块]
) <fig:SegmentDisplay_Switcher>

其余部分参考之前练习中的解答实现，这里不再赘述，具体实现见下：

#figure(
  image("./imgs/21_BIN2DEC_Segment.svg"),
  caption: [以十进制方式显示数据的模块实现]
)

#figure(
  image("./imgs/21_BIN2HEX_Segment.svg"),
  caption: [以十六进制方式显示数据的模块实现]
)

#figure(
  image("./imgs/21_Encoder_4to16.svg"),
  caption: [4 - 16 编码器]
)

#figure(
  image("./imgs/21_Mux_1bit_2to1.svg"),
  caption: [1 位 2 选 1 选择器]
)

=== 搭建比较器

#question[
尝试在Logisim中通过门电路搭建一个4位比较器, 然后通过两组拨码开关对比两组数据是否相等, 若相等, 则点亮一个LED灯. 搭建后, 通过仿真检查你的方案是否正确.
]

使用 4 个同或门和一个 4 输入的与门实现，如@fig:Equal 所示

#figure(
  image("./imgs/22_Equal.svg"),
  caption: [4 位比较器]
) <fig:Equal>

=== 搭建1位全加器

#question[
尝试列出1位全加器的真值表, 并在Logisim中通过门电路搭建一个1位全加器. 搭建后, 通过仿真检查你的方案是否正确.
]

1 位全加器的真值表如@tbl:FA-truth-table 所示

#figure(
  table(
    columns: (1fr, 1fr, 1fr, 1fr, 1fr),
    table.header(
      table.cell(colspan: 3)[输入], table.cell(colspan: 2)[输出],
      [$A$], [$B$], [$C_("in")$], [$S$], [$C_("out")$]
    ),
    [0], [0], [0], [0], [0],
    [0], [0], [1], [1], [0],
    [0], [1], [0], [1], [0],
    [0], [1], [1], [0], [1],
    [1], [0], [0], [1], [0],
    [1], [0], [1], [0], [1],
    [1], [1], [0], [0], [1],
    [1], [1], [1], [1], [1],
  ),
  caption: [1 位全加器真值表]
) <tbl:FA-truth-table>

记 $plus.o$ 为异或运算，根据真值表可以得出

$
S = A plus.o B plus.o C_("in") \
C_("out") = (A dot B) + (C_("in") dot (A plus.o B))
$

在 logisim 中通过门电路搭建的 1 位全加器如@fig:1bit-FullAdder 所示

#figure(
  image("./imgs/23_1bit_Full_Adder.svg"),
  caption: [使用门电路搭建的1位全加器]
) <fig:1bit-FullAdder>

=== 搭建1位全加器(2)

#question[
尝试实例化若干个半加器, 并添加少量门电路, 从而实现一个1位全加器. 搭建后, 通过仿真检查你的方案是否正确.
]

在 logisim 中通过门电路搭建的 1 位b半加器如@fig:1bit-HalfAdder 所示

#figure(
  image("./imgs/24_1bit_Half_Adder.svg"),
  caption: [使用门电路搭建的1位半加器]
) <fig:1bit-HalfAdder>

使用 2 个 1 位半加器和 1 个或门可以搭建 1 位全加器，如@fig:1bit-FullAdder-2 所示

#figure(
  image("./imgs/24_1bit_Full_Adder.svg"),
  caption: [使用2个1位半加器和1个或门搭建的1位全加器]
) <fig:1bit-FullAdder-2>

=== 搭建4位加法器

#question[
尝试在Logisim中通过门电路搭建一个4位加法器, 用七段数码管按十六进制显示加法器的两个输入和结果, 并用一个LED灯指示加法结果是否产生进位. 搭建后, 通过仿真检查你的方案是否正确.
]

使用 4 个 1 位全加器可以搭建 4 位全加器，如@fig:4bit-FullAdder 所示

#figure(
  image("./imgs/25_4bit_Full_Adder.svg", width: 60%),
  caption: [使用4个1位全加器搭建的4位全加器]
) <fig:4bit-FullAdder>

测试电路如@fig:25_main 所示，部分组件已在前文中实现，这里不再赘述

#figure(
  image("./imgs/25_main.svg", width: 80%),
  caption: [4位全加器测试电路]
) <fig:25_main>

== 整数的机器级表示

=== 搭建4位减法器

#question[
根据4位加法器的设计思路, 尝试在Logisim中通过门电路搭建一个4位减法器, 用七段数码管按十六进制显示减法器的两个输入和结果, 并用一个LED灯指示减法结果是否产生借位. 搭建后, 通过仿真检查你的方案是否正确.
]

首先，搭建半减器，其真值表如@tbl:HS-truth-table 所示:

#figure(
  table(
    columns: (1fr, 1fr, 1fr, 1fr),
    table.header(
      table.cell(colspan: 2)[输入], table.cell(colspan: 2)[输出],
      [$X$], [$Y$], [$D$], [$B_("out")$]
    ),
    [0], [0], [0], [0],
    [0], [1], [1], [1],
    [1], [0], [1], [0],
    [1], [1], [0], [0],
  ),
  caption: [半减器的真值表]
) <tbl:HS-truth-table>

记 $plus.o$ 为异或运算，可以得到半减器的逻辑表达式为

$
D = X plus.o Y \
B_("out") = overline(X) dot Y
$

据此，可以使用 Logisim 搭建出如@fig:1bit-HalfSubstractor 所示的半减器

#figure(
  image("./imgs/26_Half_Substractor.svg", width: 100%),
  caption: [Logisim 中使用门电路实现的半减器]
) <fig:1bit-HalfSubstractor>

参考@fig:1bit-FullAdder-2 所示的全加器实现，我们可以使用半减器搭建全减器，如@fig:1bit-FullSubstractor 所示.

#figure(
  image("./imgs/26_1bit_Full_Subtractor.svg"),
  caption: [Logisim 中使用半减器实现的 1 位全减器]
) <fig:1bit-FullSubstractor>

最后，使用全减器搭建 4 位减法器，如@fig:4bit-FullSubstractor 所示

#figure(
  image("./imgs/26_4bit_Full_Subtractor.svg"),
  caption: [Logisim 中使用1 位全减器实现的 4 位全减器]
) <fig:4bit-FullSubstractor>

测试电路如@fig:26_main 所示

#figure(
  image("./imgs/26_main.svg"),
  caption: [Logisim 中使用1 位全减器实现的 4 位全减器]
) <fig:26_main>

=== 搭建4位原码加法器

#question[
理解原码加法器的工作原理后, 尝试用加法器, 减法器和多路选择器等部件, 在Logisim中搭建一个4位原码加法器. 为了显示符号位, 你可以额外实例化一个七段数码管, 结果为负数时显示负号`-`, 否则不显示. 搭建后, 通过仿真检查你的方案是否正确.
]

首先，搭建如@fig:4bit_Adder_Substractor 所示的 4 位加法器和减法器(和之前搭建的方法不同之处在于使用了 Splitter 和 4 位的 Pin)

#figure(
  grid(
    columns: 2,
    image("./imgs/27_Adder_4bit.svg"),
    image("./imgs/27_Substractor_4bit.svg"),
  ),
  caption: [改进后的 4 位加法器和减法器]
) <fig:4bit_Adder_Substractor>

因为原码加法器需要处理异号数字相加的问题，所以还需要设计一个比较器，如@fig:Comparator_Greater 所示

#figure(
  image("./imgs/27_Is_Greater_4bit.svg"),
  caption: [改进后的 4 位加法器和减法器]
) <fig:Comparator_Greater>

接下来，就可以开始搭建如@fig:27_main 所示的原码加法器了（这里 4 位 2 选 1 选择器直接使用 Logisim 内置元件，不再自行实现）

#figure(
  image("./imgs/27_main.svg"),
  caption: [使用 Logisim 搭建的 4 位原码加法器]
) <fig:27_main>


#quote-block[
  未完待续...
]