#import "../lib.typ": universal-bachelor // <#模板开发>
#import universal-bachelor: *

// 参考 本科毕业论文（设计）书写范例（理工类）.doc 进行编写
// 编译命令  typst compile ./templates/universal-bachelor.typ --root ./
// 实时预览  typst watch ./templates/universal-bachelor.typ --root ./

#show: doc.with(
  thesis-info: (
    title-cn: "RISC-V指令集乱序处理器设计",
    title-en: "Design of RISC-V Out-of-Order Processor",
    author: "王靳",
    student-id: "220111012",
    supervisor: "薛睿高级实验师",
    profession: "计算机科学与技术",
    college: "深圳校区计算机科学与技术学院",
    institute: "哈尔滨工业大学",
    year: 2026,
    month: 5,
  ),

  // 图表选项
  figure-options: (
    // extra-kinds, extra-prefixes 表示需要执行计数器重置和引用的图表类型
    // 参考 https://github.com/RubixDev/typst-i-figured/blob/main/examples/basic.typ
    // 示例：extra-kinds: ("atom",), extra-prefixes: (atom: "atom:")，即新建一个 atom 类型，并使用 @atom: 来引用
    extra-kinds: (), extra-prefixes: (:),
  ),

  // 参考文献配置
  bibliography: bibliography.with("refs.bib", full: true, style: "gb-t-7714-2015-numeric-hit.csl"),

  abstract-cn: [
    随着开源指令集架构 RISC-V 的快速发展，基于开源生态开展高性能处理器研究已成为体系结构领域的重要方向。乱序执行通过动态调度与寄存器重命名提升指令级并行性，是现代处理器获得高性能的关键机制。本文围绕“RISC-V 指令集乱序处理器设计”，完成了从核心微架构到系统软件支撑的整体实现与验证。

    在微架构设计方面，本文实现了单发射乱序处理器，采用统一物理寄存器的寄存器重命名方案，支持乱序执行与顺序提交，并通过重排序机制实现精确异常。存储层次方面，实现了基于 VIPT 结构且采用 PLRU 替换策略的 ICache 与 DCache，以降低访存开销并兼顾地址转换场景下的访问效率。体系结构支持方面，实现了 M/S/U 三级特权架构、Sv39 虚拟内存机制与中断处理机制，为操作系统运行提供了完整硬件基础。

    为保证设计正确性，本文基于 Chisel、Verilator 与 Rust 构建验证平台，结合差分测试与调试追踪工具对关键模块进行系统验证。实验结果表明，所实现处理器在乱序执行、缓存访问、异常中断处理与虚拟内存管理等关键功能上均满足设计预期，并已成功运行 xv6 教学操作系统。本文工作为 RISC-V 乱序处理器的教学与工程实践提供了可复现的实现路径与系统级参考。
  ],
  keywords-cn: ("RISC-V", "乱序执行", "Chisel", "SoC", "差分测试"),

  abstract-en: [
    With the rapid development of the open-source RISC-V instruction set architecture, high-performance processor research based on open ecosystems has become an important direction in computer architecture. Out-of-order execution improves instruction-level parallelism through dynamic scheduling and register renaming, and is a key mechanism for modern high-performance processors. This thesis focuses on the design of a RISC-V out-of-order processor and completes an integrated implementation and verification flow from core microarchitecture to system software support.

    At the microarchitectural level, a single-issue out-of-order processor is implemented with a unified physical-register-based register renaming scheme. The design supports out-of-order execution and in-order commit, and achieves precise exceptions through reorder mechanisms. In the memory hierarchy, VIPT-based instruction and data caches are implemented to reduce memory access overhead while maintaining efficiency under address translation. In architectural support, the M/S/U privilege architecture, the Sv39 virtual memory scheme, and the interrupt mechanism are fully implemented, providing complete hardware support for operating system execution.

    To ensure correctness, a verification platform based on Chisel, Verilator, and Rust is built, and key modules are validated with differential testing and debugging/tracing tools. Experimental results show that the processor meets design expectations in out-of-order execution, cache access, exception and interrupt handling, and virtual memory management, and successfully boots and runs the xv6 teaching operating system. This work provides a reproducible implementation path and a system-level reference for RISC-V out-of-order processor education and engineering practice.
  ],
  keywords-en: ("RISC-V", "Out-of-Order Execution", "VIPT Cache", "Sv39", "xv6"),

// 结论
  conclusion: [
    本文对局部多孔质气体静压止推轴承的静态特性和稳定性进行了理论研究，对于局部多孔质气体静压径向轴承、圆锥轴承和球轴承仅需对止推轴承压力分布的数学模型进行适当的坐标变换即可对其特性进行求解。同时，本文对局部多孔质气体静压止推轴承进行了实验研究并与整体多孔质和小孔节流止推轴承的静态特性和稳定性进行了实验对比。

    本论文的主要创造性工作归纳如下：

    \1. 建立了基于分形几何理论的多孔质石墨渗透率与分形维数之间关系的数学模型，该模型可预测多孔质石墨的渗透率，并可直观描述各种孔隙的大小对渗透率的影响。通过实验验证了该模型的正确性。

    \2. 分别建立了基于气体连续性方程、Navier-Stokes 方程、Darcy 定律以及气体状态方程的局部多孔质气体静压轴承的承载能力、静态刚度和质量流量的数学模型，利用有限元法进行求解，给出了局部多孔质气体静压轴承的承载能力、静态刚度和质量流量特性曲线。

    ……

    今后还应在以下几个方面继续深入研究：

    \1. 本文仅是采用了局部多孔质圆柱塞这种节流方式，在以后的研究中，可以通过改变局部多孔质材料的形状来改变节流方式，从而通过性能对比，获得最优的节流效果。

    ……
  ],
  // 创新性成果，若没有则可以移除或设置为 none
  achievement:  [
    #par(first-line-indent: 0em)[
      *一、发表的学术论文*
    ]

    [1] ×××，×××. Static Oxidation Model of Al-Mg/C Dissipation Thermal Protection Materials［J］. Rare Metal Materials and Engineering, 2010, 39(Suppl. 1): 520-524.（SCI收录，IDS号为669JS）

    [2] ×××，×××. 精密超声振动切削单晶铜的计算机仿真研究［J］. 系统仿真学报，2007，19（4）：738-741，753.（EI收录号：20071310514841）

    [3] ×××，×××. 局部多孔质气体静压轴向轴承静态特性的数值求解［J］. 摩擦学学报，2007（1）：68-72.（EI收录号：20071510544816）

    [4] ×××，×××. 硬脆光学晶体材料超精密切削理论研究综述［J］. 机械工程学报，2003，39（8）：15-22.（EI收录号：2004088028875）

    [5] ×××，×××. 基于遗传算法的超精密切削加工表面粗糙度预测模型的参数辨识以及切削参数优化［J］. 机械工程学报，2005，41（11）：158-162.（EI收录号：2006039650087）

    [6] ×××，×××. Discrete Sliding Mode Cintrok with Fuzzy Adaptive Reaching Law on 6-PEES Parallel Robot［C］. Intelligent System Design and Applications, Jinan, 2006: 649-652.（EI收录号：20073210746529）

    #par(first-line-indent: 0em)[
      *二、申请及已获得的专利（无专利时此项不必列出）*
    ]

    [1] ×××，×××. 一种温热外敷药制备方案：中国，88105607.3［P］. 1989-07-26.

    #par(first-line-indent: 0em)[
      *三、参与的科研项目及获奖情况*
    ]

    [1] ×××，×××. ××气体静压轴承技术研究, ××省自然科学基金项目.课题编号：××××.

    [2] ×××，×××. ××静载下预应力混凝土房屋结构设计统一理论. 黑江省科学技术二等奖, 2007.
  ],
  // 致谢
  acknowledgement: [
    衷心感谢导师×××教授对本人的精心指导。他的言传身教将使我终身受益。

    感谢×××教授，以及实验室全体老师和同窗们的热情帮助和支持！

    本课题承蒙××××基金资助，特此致谢。

    ……
  ],
  digital-signature-option: (
    // 三种电子签名模式
    // e-digital-signature-mode.off 不启用电子签名功能
    // e-digital-signature-mode.default 直接添加电子版签名图片
    // e-digital-signature-mode.scanned-copy 不显示此页的 typst 渲染结果，并将其替换为扫描件，允许传入 image 或者 pdf
    mode: e-digital-signature-mode.default,

    // default mode
    // 作者电子签名图片及其偏移
    author-signature: [ #lorem(2) ],
    author-signature-offsets: (
      (dx: 13em, dy: 19.15em),
      (dx: 13em, dy: 46.8em),
    ),
    // 导师电子签名图片及其偏移
    supervisor-signature: [ #lorem(3) ],
    supervisor-signature-offsets: (
      (dx: 13em, dy: 49.8em),
    ),

    // 日期及其偏移
    date-array: (
      (datetime.today().year(), datetime.today().month(), datetime.today().day(), ),
      (datetime.today().year(), datetime.today().month(), datetime.today().day(), ),
      (datetime.today().year(), datetime.today().month(), datetime.today().day(), ),
    ),
    date-offsets: (
      (
        (dx: 26em, dy: 19.15em),
        (dx: 30.25em, dy: 19.15em),
        (dx: 32.5em, dy: 19.15em),
      ),
      (
        (dx: 26em, dy: 46.8em),
        (dx: 29.6em, dy: 46.8em),
        (dx: 32em, dy: 46.8em),
      ),
      (
        (dx: 26em, dy: 49.8em),
        (dx: 29.6em, dy: 49.8em),
        (dx: 32em, dy: 49.8em),
      ),
    ),
    // 是否显示原创性声明页的页码
    // show-declaration-of-originality-page-number: false,

    // scanned-copy mode
    // mode 设置为 e-digital-signature-mode.scanned-copy 时允许您直接插入扫描件
    scanned-copy: [
      // 若扫描件是图片，则可以直接设置图片
      // #image("../image/templates/shenzhen-master/shenzhen-master_页面_21.png")

      // 若扫描件是 pdf，则可以转换成图片或使用 muchpdf 来插入
      // #import "@preview/muchpdf:0.1.0": muchpdf
      // #let data = read("universal-bachelor.pdf", encoding: none)
      // #muchpdf(data, pages: 13)
    ]
  )
)


= #[绪#h(1em)论]

== 研究背景与意义

RISC-V 作为开源、模块化、可扩展的指令集架构，正在从学术研究走向产业化部署。相较于传统封闭指令集，RISC-V 在授权成本、生态开放性和可定制能力方面具有显著优势，为高校和科研机构开展处理器全栈设计提供了可行路径。与此同时，面向高性能场景的处理器普遍依赖乱序执行技术来提升指令级并行性和流水线吞吐率，因此围绕 RISC-V 乱序处理器开展研究具有明确的工程价值与教学价值。

从产业需求看，掌握高性能处理器核心微架构的自主设计能力，是推进自主可控芯片技术体系建设的重要基础。从教学与科研实践看，当前公开资料中存在“简单顺序核容易入门、工业级乱序核复杂度过高”的鸿沟，不利于学习者系统理解乱序执行关键机制。基于此，本文以可实现、可验证、可复现为导向，设计并实现一款面向教学与工程过渡场景的 RISC-V 乱序处理器与配套 SoC 平台。

== 国内外研究现状

在乱序执行理论与微架构方面，寄存器重命名、发射队列动态调度、重排序缓冲区和分支预测等机制已较为成熟，相关研究形成了完整的方法体系。典型工业处理器长期采用乱序执行以提升性能，学术界也围绕精确异常恢复、访存顺序约束和预测器结构持续优化。

在开源 RISC-V 处理器领域，国外项目如 BOOM 展示了参数化乱序核的完整实现路径，Rocket 及其 SoC 生成框架提供了较成熟的基础设施；国内项目如香山在高性能方向取得了显著进展，并推动了开源生态建设。然而，上述高性能项目普遍规模庞大、实现复杂，学习与二次开发门槛较高。另一方面，教学场景常用的顺序流水处理器虽然结构清晰，但难以覆盖乱序执行核心问题。

在设计方法与验证方法方面，Chisel 在复杂硬件系统开发中的应用不断扩大，差分测试在处理器功能验证中的有效性也得到广泛实践。基于参考模型进行逐指令状态比对，能够显著提高问题定位效率，已成为处理器开发中重要的验证手段。

== 现有研究不足与本文切入点

综合现有工作，当前研究与工程实践主要存在以下不足。第一，教学级与工业级乱序处理器之间缺乏复杂度适中的进阶参考设计，学习者难以从顺序执行平滑过渡到完整乱序微架构。第二，Chisel 生态下可复用外设 IP 与系统级集成案例仍相对有限，处理器核心与 SoC 级工程实践之间缺少统一范式。第三，部分工作重实现、轻验证，缺乏覆盖模块级到系统级的验证闭环，导致复杂场景下的问题定位成本较高。

针对上述不足，本文选择“单发射乱序处理器 + 完整 SoC 平台 + 多层次验证体系”的研究路线：在控制实现复杂度的前提下保留乱序执行核心机制；将处理器核、总线、存储与外设进行统一集成；通过差分测试、追踪工具与操作系统运行验证形成闭环，提升设计的可复现性和工程可用性。

== 本文主要工作与技术路线

本文采用分阶段、增量式技术路线推进研究工作。第一阶段构建 RV32I 多周期处理器与 SoC 基础平台，完成 AXI4 分层总线、多层次存储体系以及 UART、GPIO、PS2、VGA 等外设集成，并实现 M-mode 异常处理机制。第二阶段围绕缓存与乱序执行核心能力展开，完成 L1 指令缓存设计与验证，并逐步引入寄存器重命名、发射队列、重排序缓冲区与分支预测等模块。第三阶段面向系统级验证，扩展特权架构与操作系统支持能力，逐步完成 xv6 乃至 Linux 引导相关工作。

在验证方法上，本文构建了以 Verilator 为底座、Rust 为主控的仿真平台，集成 Spike 差分测试、调试器与多类追踪工具，对处理器体系结构状态进行持续校验。该框架既用于功能正确性验证，也用于复杂 bug 的快速定位。根据中期进展，当前已完成基础 SoC、验证平台与部分缓存系统实现，RT-Thread 已在处理器上运行，后续将继续完成数据缓存与乱序流水线整合。

== 论文组织结构

全文其余章节安排如下：第二章介绍处理器开发环境、验证框架与关键技术基础；第三章阐述多周期处理器核心、总线系统与 SoC 集成实现；第四章介绍缓存子系统与关键优化机制；第五章重点描述单发射乱序执行微架构设计与实现；第六章给出系统级验证方法、实验结果与性能分析；第七章总结全文工作并展望后续改进方向。

#pagebreak()

= 基于FLUENT软件的轴承静态特性研究

== 引言

利用现成的商用软件来研究流场，可以免去对N-S方程求解程序的……

=== 边界条件的设定

本文采用……，则每一个方向上的……由公式 
@eqt:formula-1 @eqt:formula-2 求得：

$ phi = D^2_p / 150 psi^3 / (1 - psi)^2 $ <formula-1>

$ C_2 = 3.5 / D_p ((1 - psi)) / psi^3 $ <formula-2>

式中 $D_p$ —— 多孔质材料的平均粒子直径（m）；

#h(1em) $psi$ —— 孔隙度（孔隙体积占总体积的百分比）；

#h(1em) $phi$ —— 特征渗透性或固有渗透性（m2）。

……

== 本章小结

……

= 局部多孔质静压轴承的试验研究

== 引言

在前面几章中，分别对局部多孔质材料的渗透率……

== 多孔质石墨渗透率测试试验

……

1号试样的试验数据见 @tbl:1号试样的实验数据。

#figure(
  table(
    columns: (1fr, 1fr, 1fr, 1fr, 1fr, 1fr),
    stroke: none,
    align: center + horizon,
    table.hline(),
    [供气压力 #linebreak() $P_s ("MPa")$],
    [流量测量 #linebreak() $M prime (m^3\/h)$ ],
    [#v(.5em) 流量修正值 #linebreak() #v(.5em)
    $M (m_3\/s) \ times 10^(-4)$ #v(.25em)],
    [压力差 #linebreak() $Delta P ("Pa")$ ],
    [$lg Delta P$],
    [$lg M$],
    table.hline(stroke: .5pt),
    // ---
    [0.15],
    [0.009],
    [0.023 12],
    [46 900],
    [4.671 17],
    [-5.636 01],
    // ---
    [0.2],
    [0.021],
    [0.045 84],
    [96 900],
    [4.986 32],
    [-5.338 76],
    table.hline(),
  ),
  caption: [1号试样渗透率测试数据(温度：T=16 ℃ 高度：H=5.31 mm)],
  supplement: [表],
)<1号试样的实验数据>

#linebreak()

#figure(
  table(
    columns: (1fr, 1fr, 1fr, 1fr, 1fr, 1fr),
    stroke: none,
    align: center + horizon,
    table.hline(),
    [供气压力 #linebreak() $P_s ("MPa")$],
    [流量测量 #linebreak()$M prime (m^3\/h)$ ],
    [#v(.5em) 流量修正值 #linebreak() #v(.5em)
    $M (m_3\/s) \ times 10^(-4)$ #v(.25em) ],
    [压力差 #linebreak() $Delta P ("Pa")$ ],
    [$lg Delta P$],
    [$lg M$],
    table.hline(stroke: .5pt),
    // ---
    [0.15],
    [0.009],
    [0.023 12],
    [46 900],
    [4.671 17],
    [-5.636 01],
    // ---
    [0.2],
    [0.021],
    [0.045 84],
    [96 900],
    [4.986 32],
    [-5.338 76],
    table.hline(),
  ),
  caption: [试样渗透率测试数据],
  supplement: [表],
)<试样渗透率测试数据>

== 本章小结

……

#pagebreak()

= 其他 Typst 使用示例

== 图表

使用`@fig:`来引用图片： @fig:square #lorem(4)

#figure(
  square(size: 8em, stroke: 2pt),
  caption: [A curious figure.],
  supplement: [图],
) <square>

#strike[图表之后第一段默认不缩进，如需缩进，可以手动调用`#indent`实现缩进。]

#figure(
  table(
    columns: 4,
    [t], [1], [2], [3],
    [y], [0.3s], [0.4s], [0.8s],
  ),
  caption: text(lang: "en")[Timing results],
  supplement: [表],
) <time-results>

#figure(
  table(
    columns: 4,
    stroke: none,
    table.hline(),
    [t],
    [1],
    [2],
    [3],
    table.hline(stroke: .5pt),
    [y],
    [0.3s],
    [0.4s],
    [0.8s],
    table.hline(),
  ),
  caption: [Timing results（三线表）],
  supplement: [表],
) <time-results-three-line-table>

使用`@tbl:`来引用表格： @tbl:time-results @tbl:time-results-three-line-table

== 伪代码

#[
  #import "@preview/algo:0.3.6": algo, i, d, comment, code

  使用`@algo:`来引用伪代码， 支持`algo`和`lovelace`包，如#[@algo:XXX算法]、#[@algo:XXXX算法]和#[@algo:lovelace-algo]所示

  #set par(first-line-indent: 0em)

  #algorithm-figure(
    algo(
      title: "Fib",
      parameters: ("n",),
      stroke: none,
      fill: none,
      breakable: true,
    )[
      if $n < 0$:#i\
        return null#d\
      if $n = 0$ or $n = 1$:#i\
        return $n$#d\
      \
      let $x <- 0$\
      let $y <- 1$\
      for $i <- 2$ to $n-1$:#i #comment[so dynamic!]\
        let $z <- x+y$\
        $x <- y$\
        $y <- z$#d\
        \
      return $x+y$
    ],
    caption: [斐波那契数列1],
    supplement: [算法],
    label-name: "XXX算法",
  )

  #algorithm-figure(
    algo(
      title: "Fib",
      parameters: ("n",),
      stroke: none,
      fill: none,
      breakable: true
    )[
      if $n < 0$:#i\        // use #i to indent the following lines
        return null#d\      // use #d to dedent the following lines
      if $n = 0$ or $n = 1$:#i #comment[you can also]\
        return $n$#d #comment[add comments!]\
      return #smallcaps("Fib")$(n-1) +$ #smallcaps("Fib")$(n-2)$ \
    ],
    caption: [斐波那契数列2],
    supplement: [算法],
    label-name: "XXXX算法",
  )

  #import "@preview/lovelace:0.2.0": *

  #algorithm-figure(
    pseudocode(
      no-number,
      [#h(-1.25em) *input:* integers $a$ and $b$],
      no-number,
      [#h(-1.25em) *output:* greatest common divisor of $a$ and $b$],
      [*while* $a != b$ *do*],
      ind,
      [*if* $a > b$ *then*],
      ind,
      $a <- a - b$,
      ded,
      [*else*],
      ind,
      $b <- b - a$,
      ded,
      [*end*],
      ded,
      [*end*],
      [*return* $a$],
    ),
    caption: [The Euclidean algorithm],
    label-name: "lovelace-algo",
  )

]

== 代码块

#[

  #code-figure(
    ```rs
    fn main() {
        println!("Hello, World!"); // 这是一行注释
    }
    ```,
    caption: [XXX代码],
    supplement: [代码],
    label-name: "XXX代码",
  )

  与 Markdown 类似，代码可以高亮显示，使用`@lst:`来引用代码块： @lst:XXX代码
]