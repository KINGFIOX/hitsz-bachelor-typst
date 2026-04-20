#import "../lib.typ": universal-bachelor // <#模板开发>
#import universal-bachelor: *

// 参考 本科毕业论文（设计）书写范例（理工类）.doc 进行编写
// 编译命令  typst compile ./main/bachelor.typ --root ./

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
    extra-kinds: (),
    extra-prefixes: (:),
  ),

  // 参考文献配置
  bibliography: bibliography.with("refs.bib", style: "gb-t-7714-2015-numeric-hit.csl"),

  abstract-cn: [
    随着开源指令集架构 RISC-V 的快速发展，基于开源生态开展高性能处理器研究已成为体系结构领域的重要方向。乱序执行通过动态调度与寄存器重命名提升指令级并行性，是现代处理器获得高性能的关键机制。本项目围绕“RISC-V 指令集乱序处理器设计”，完成了从核心微架构到系统软件支撑的整体实现与验证。

    在微架构设计方面，本项目实现了前后端解耦的单发射乱序处理器，采用统一物理寄存器的寄存器重命名方案，支持乱序执行与顺序提交，并通过重排序机制实现精确异常；前端分支预测采用 GShare+IJTC+RAS 组合方案。存储层次方面，实现了基于 VIPT 结构且采用 PLRU 替换策略的 ICache 与 DCache，以降低访存开销并兼顾地址转换场景下的访问效率。体系结构支持方面，实现了 M/S/U 三级特权架构、Sv39 虚拟内存机制与中断处理机制，为操作系统运行提供了完整硬件基础。

    为保证设计正确性，本项目基于 Chisel、Verilator 与 C++20 构建验证平台，结合差分测试与调试追踪工具对关键模块进行系统验证。在性能评估方面，基于 MicroBench、Dhrystone 与 CoreMark 三组基准程序并结合 RTL 寄存器与 DPI-C 事件的混合性能计数器对处理器进行了多维度定量分析：IPC 达到 0.43–0.56，Dhrystone 成绩为 1.596 DMIPS/MHz、CoreMark 为 1.540 CoreMark/MHz，ICache 命中率 $>$ 99.9%、DCache 命中率 97.5%–99.9%、分支预测命中率 87.2%–94.6%。实验结果表明，所实现处理器在乱序执行、缓存访问、异常中断处理与虚拟内存管理等关键功能上均满足设计预期，并已成功运行 xv6 教学操作系统。本项目工作为 RISC-V 乱序处理器的教学与工程实践提供了可复现的实现路径与系统级参考。
  ],
  keywords-cn: ("RISC-V", "乱序执行", "Chisel", "SoC", "差分测试"),

  abstract-en: [
    With the rapid development of the open-source RISC-V instruction set architecture, conducting high-performance processor research within an open ecosystem has become a significant direction in computer architecture. Out-of-order execution improves instruction-level parallelism through dynamic scheduling and register renaming, serving as a key mechanism for achieving high performance in modern processors. This thesis presents a complete design and verification of a RISC-V out-of-order processor, spanning from core microarchitecture to system software support.

    In terms of microarchitectural design, this work implements a single-issue out-of-order processor with a decoupled frontend-backend architecture. The processor employs a unified physical register file based register renaming scheme, supports out-of-order execution with in-order commit, and achieves precise exceptions through a reorder buffer mechanism. The frontend branch prediction adopts a combined GShare+IJTC+RAS scheme. For the memory hierarchy, VIPT-structured ICache and DCache with Pseudo-LRU replacement policy are implemented to reduce memory access latency while accommodating address translation scenarios. In terms of architectural support, M/S/U three-level privilege modes, the Sv39 virtual memory mechanism, and interrupt handling are implemented, providing a complete hardware foundation for operating system execution.

    To ensure design correctness, a verification platform is built using Chisel, Verilator, and C++20, incorporating differential testing against the Spike reference model along with debugging and tracing tools for systematic module-level verification. For performance evaluation, a hybrid performance counter framework combining RTL registers with DPI-C event hooks is developed and exercised against MicroBench, Dhrystone and CoreMark benchmarks: the processor achieves an IPC of 0.43–0.56, 1.596 DMIPS/MHz on Dhrystone and 1.540 CoreMark/MHz on CoreMark, with ICache hit rate above 99.9%, DCache hit rate of 97.5%–99.9%, and branch-prediction hit rate of 87.2%–94.6%. Experimental results demonstrate that the implemented processor meets design expectations across all key functionalities including out-of-order execution, cache access, exception and interrupt handling, and virtual memory management. The processor has successfully booted the xv6 teaching operating system. This work provides a reproducible implementation path and system-level reference for RISC-V out-of-order processor education and engineering practice.
  ],
  keywords-en: ("RISC-V", "Out-of-Order Execution", "Chisel", "SoC", "Difftest"),

  // 结论
  conclusion: [
    本项目围绕"RISC-V 指令集乱序处理器设计"这一课题，完成了从核心微架构设计到系统级集成与验证的全流程工作。主要成果与结论如下：

    + SoC 系统设计与集成。设计并实现了基于 AXI4/APB 分层互连的 SoC 平台，通过一级 Crossbar 服务高带宽主存路径、二级 Crossbar 连接片上存储与外设桥接，形成了处理器核心、总线、存储控制器与外设协同工作的完整系统环境。该平台为乱序处理器运行操作系统提供了稳定的硬件基础。

    + 关键存储控制器 IP 核实现。使用 Chisel 实现了 Flash 控制器（支持 SPI 命令访问与 XIP 直接取指执行）、PSRAM QSPI Master 控制器（支持 QSPI/QPI 模式切换）与 SDRAM 控制器（支持流水化访问与低位交叉字扩展），三者均配有行为级仿真模型并通过协议级验证，具备对接物理芯片的能力。

    + 单发射乱序处理器核心设计。实现了前后端解耦的单发射乱序处理器，支持 RV64IM 指令集。后端采用统一物理寄存器文件的寄存器重命名方案，通过 FutureRAT/ArchRAT/FreeList/BusyTable 协同工作实现乱序执行与顺序提交；发射队列与执行单元采用泛型抽象类设计，具备良好的代码复用性与可扩展性。前端分支预测采用 GShare+IJTC+RAS 组合方案，在 MicroBench 测试套件下达到 87% 的预测准确率。

    + 缓存子系统设计。实现了 VIPT 结构的 ICache 与 DCache，均为 4 路组相联、64 组、64 字节缓存行，采用 Pseudo-LRU 替换策略。处理器核心侧采用自定义类 SRAM 总线协议降低接口复杂度，缓存对外通过 AXI4 Burst 完成 refill 与 writeback。DCache 支持写回策略、Write Buffer 优化与 fence.i 全缓存刷写。

    + RISC-V 特权级架构与虚拟内存实现。实现了 M/S/U 三级特权模式、完整的 CSR 寄存器集合、异常委托机制、外部/定时器/软件三类中断源的注入与处理，以及 Sv39 三级页表虚拟内存机制（含 TLB 与 PTW），为操作系统运行提供了完整的体系结构支持。

    + 仿真验证平台构建。基于 Verilator 与 C++20 构建了功能完备的仿真验证平台，包含类 GDB 简易调试器（内置 Flex/Bison 表达式求值引擎）、四类执行追踪器（ITrace/MTrace/DTrace/FTrace）、基于 Spike 的逐指令差分测试、基于 fork 的 LightSSS 快照回放机制，以及 NVBoard 外设可视化集成。

    + 操作系统运行验证。处理器已成功运行 xv6 教学操作系统与 RT-Thread 实时操作系统，验证了乱序执行、缓存访问、异常中断处理与虚拟内存管理等关键功能的正确性。

    + 性能评估。基于 MicroBench、Dhrystone、CoreMark 三组基准程序并结合 RTL 寄存器 + DPI-C 事件的混合性能计数器，对处理器进行了多维度定量评估。测量结果表明：三组负载的 IPC 分别为 0.43、0.44 与 0.56，`commit / ifu\_deliver $approx$ 0.89` 说明后端与前端共同参与了瓶颈构成，Dhrystone 成绩达 1.596 DMIPS/MHz（跨越 Cortex-M3 档位），CoreMark 成绩为 1.540 CoreMark/MHz；ICache 命中率 $>$ 99.9%、DCache 命中率 97.5%–99.9%、分支预测命中率 87.2%–94.6%，均处于同类教学与研究实现的主流水平。

    本项目工作的局限性与未来改进方向包括：当前处理器仍为单发射结构，指令吞吐率受限于每周期至多提交一条指令，后续可扩展为双发射或多发射以进一步提升性能，届时 BTB 与多端口 BP 也将成为必要的补充；当前前端将 Predict 模块挂在 F3 的组合路径上，这在未来追求更高时钟频率时会成为时序关键路径，可通过将 BPU 拆出独立流水段缓解；当前缓存层次仅有 L1，可增加 L2 缓存以降低主存访问延迟；乘除法单元采用多周期迭代实现，可替换为流水化设计以提升吞吐率。此外，可进一步完成 FPGA 综合与上板验证，评估实际时钟频率与资源占用。
  ],
  // 创新性成果，若没有则可以移除或设置为 none
  achievement: [
    #par(first-line-indent: 0em)[
      *参与的科研项目及获奖情况*
    ]

    [1] 2024年全国大学生计算机系统能力大赛-编译系统实现赛, 三等奖

  ],
  // 致谢
  acknowledgement: [
    本科四年的学习与本项目的完成，离不开众多师长和同学的帮助与支持，在此谨致诚挚的感谢。

    首先，衷心感谢我的毕业设计指导教师薛睿老师。从数字逻辑设计实验、计算机组成原理实验到计算机设计与实践，再到本次毕业设计，薛老师用行动阐释了“规格严格，功夫到家”的校训精神。

    感谢夏文老师、胡浩学长、王家睿学长在科研方面对我的悉心指导。

    感谢郑为杰老师、姚辉老师在学业规划与日常生活中给予的关心与指导。

    感谢王鸿鹏老师在计算机体系结构领域的深入指导。

    感谢汪花梅老师、梁韬学长、杨嘉辉学长、龙家增学长、饶川同学在编译器比赛中的指导与协作。

    最后，感谢家人在求学路上始终如一的理解与支持。
  ],
  digital-signature-option: (
    // 三种电子签名模式
    // e-digital-signature-mode.off 不启用电子签名功能
    // e-digital-signature-mode.default 直接添加电子版签名图片
    // e-digital-signature-mode.scanned-copy 不显示此页的 typst 渲染结果，并将其替换为扫描件，允许传入 image 或者 pdf
    mode: e-digital-signature-mode.default,
    // default mode
    // 作者电子签名图片及其偏移
    author-signature: [ #image("images/wangjin.png", height: 2.5em) ],
    author-signature-offsets: (
      (dx: 13em, dy: 18.9em),
      (dx: 13em, dy: 44.5em),
    ),
    // 导师电子签名图片及其偏移
    supervisor-signature: [ #image("images/supervisor-signature.png", height: 3.5em) ],
    supervisor-signature-offsets: (
      (dx: 11.7em, dy: 47.2em),
    ),
    // 日期及其偏移
    date-array: (
      (datetime.today().year(), datetime.today().month(), datetime.today().day()),
      (datetime.today().year(), datetime.today().month(), datetime.today().day()),
      (datetime.today().year(), datetime.today().month(), datetime.today().day()),
    ),
    date-offsets: (
      (
        (dx: 26em, dy: 20em),
        (dx: 30.25em, dy: 20em),
        (dx: 32.5em, dy: 20em),
      ),
      (
        (dx: 26em, dy: 45.5em),
        (dx: 29.6em, dy: 45.5em),
        (dx: 32em, dy: 45.5em),
      ),
      (
        (dx: 26em, dy: 48.3em),
        (dx: 29.6em, dy: 48.3em),
        (dx: 32em, dy: 48.3em),
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
    ],
  ),
)


= #[绪#h(1em)论]

== 研究背景与意义

RISC-V 作为开源、模块化、可扩展的指令集架构 #cite(<patterson2017riscv>)，正在从学术研究走向产业化部署。华为发布了基于 RISC-V 的 Hi3861 开发系统 #cite(<huawei2021hi3861>)，NVIDIA 于 2024 年出货超十亿颗 RISC-V 核心 #cite(<nvidia2024riscv>)，国内政策层面亦明确鼓励 RISC-V 生态建设 #cite(<china2025riscv>)。相较于传统封闭指令集，RISC-V 在授权成本、生态开放性和可定制能力方面具有显著优势，为高校和科研机构开展处理器全栈设计提供了可行路径。与此同时，面向高性能场景的处理器普遍依赖乱序执行技术来提升指令级并行性和流水线吞吐率，因此围绕 RISC-V 乱序处理器开展研究具有明确的工程价值与教学价值。

从产业需求看，掌握高性能处理器核心微架构的自主设计能力，是推进自主可控芯片技术体系建设的重要基础 #cite(<csia2024report>)。从教学与科研实践看，当前公开资料中存在“简单顺序核容易入门、工业级乱序核复杂度过高”的鸿沟，不利于学习者系统理解乱序执行关键机制。蜂鸟 E203 #cite(<hbirdv2>) 等开源核聚焦于顺序执行，而 SonicBOOM #cite(<zhao2020sonicboom>) 与香山 #cite(<wang2023xiangshan>) 等高性能乱序核的复杂度远超教学场景。国内已有多部教材对顺序流水线处理器设计进行了系统介绍 #cite(<lei2014cpu>) #cite(<wang2021cpudesign>)，姚永斌的《超标量处理器设计》#cite(<yao2014superscalar>) 则对乱序微架构理论进行了深入讲解。基于此，本项目以可实现、可验证、可复现为导向，设计并实现一款面向教学与工程过渡场景的 RISC-V 乱序处理器与配套 SoC 平台。

== 乱序处理器及其相关理论的发展概况

=== 乱序执行理论框架的形成与完善

20 世纪 90 年代是现代乱序处理器理论体系系统化的关键时期。Smith 与 Sohi 在 1995 年的综述 #cite(<smith1995superscalar>) 中指出，高性能超标量处理器的核心任务是在保持顺序语义可见性的前提下，将程序中的潜在并行性转化为硬件可执行的并行操作。该综述将处理流程归纳为取指与分支处理、寄存器相关性分析、动态发射与执行、访存数据通信、按程序顺序提交与精确中断支持等关键阶段，为后续乱序微架构设计提供了统一分析框架。

=== 精确异常的实现路径

为在乱序执行条件下保持体系结构可见状态的顺序一致性，精确异常机制是核心设计点。典型实现路径包括：基于重排序缓冲区（ROB, Reorder Buffer）的顺序提交方案 #cite(<smith1988precise>)（在提交点统一更新架构状态）；基于 walk-back 的恢复方案（异常时按记录回退未提交状态）；基于 checkpoint 的快速恢复方案 #cite(<hwu1987checkpoint>)（保存关键映射快照并在错误路径上快速回滚）。三类方案分别在硬件开销、恢复时延与实现复杂度之间进行权衡。

=== 寄存器重命名机制与 WAW/WAR 消解

为消除 WAW/WAR 等伪相关并释放指令级并行性，重命名机制形成了多条技术路线。第一类是 ROB-based 方案，结果先写入 ROB 项并在提交时回写架构寄存器；第二类是 Arch Register File + Future File 方案，将提交态与推测态分离管理；第三类是统一物理寄存器文件（PRF, Physical Register File）方案，通过寄存器别名表（RAT, Register Alias Table）维护映射关系并在提交后回收旧物理寄存器。统一 PRF 方案因扩展性与实现弹性较好，在 Alpha 21264 #cite(<kessler1999alpha>)、MIPS R10000 #cite(<yeager1996r10000>) 等经典乱序处理器中应用广泛。

=== 分支预测与前端指令供应能力提升

分支预测能力直接决定前端取指带宽的有效利用率。相关技术从静态预测与一/二位饱和计数器，发展到两级自适应预测（如 GShare、GSelect）#cite(<mcfarling1993combining>)，再到混合预测与锦标赛选择机制 #cite(<razilov2024tage>)。同时，分支目标缓冲器（BTB, Branch Target Buffer）、返回地址栈（RAS, Return Address Stack）与间接跳转目标缓存（IJTC, Indirect Jump Target Cache）等结构被联合用于覆盖条件分支、函数返回与间接跳转场景。随着乱序窗口扩大与流水线加深，分支预测准确率与误判恢复代价已成为影响处理器实际吞吐率的关键因素。

=== 开源 RISC-V 与 Chisel 驱动下的新发展

近年来，RISC-V 开源生态显著降低了高性能处理器研究的实现门槛，推动了乱序处理器从“理论可讲”向“工程可复现”转变。以 BOOM #cite(<zhao2020sonicboom>)、香山 #cite(<wang2023xiangshan>) 等项目为代表的开源实践展示了乱序处理器在现代开源工具链下的系统化实现路径，也为后续研究提供了可参考的架构与验证经验。

同时，Chisel #cite(<bachrach2012chisel>) 等硬件构造语言的发展，使复杂微架构与系统级芯片（SoC, System on Chip）集成的参数化设计、模块复用和工程维护能力明显提升。与之配套的差分测试方法 #cite(<you2025difftest>)（如基于 Spike #cite(<spike2026>) 的逐指令对比）进一步提高了功能验证效率，形成了“设计—验证—迭代”闭环。上述新发展使得在课程与科研场景中实现具备完整特权架构、缓存与虚拟内存支持的乱序处理器成为现实可行的工程目标。

== 本项目的主要研究内容

围绕上述理论与工程发展脉络，本项目完成了面向 RISC-V 的单发射乱序处理器与系统级芯片（SoC, System on Chip）实现，主要成果如下：

+ 完成 SoC 系统设计与集成，建立了处理器核、总线、存储与外设协同工作的系统级平台。
+ 基于 Chisel #cite(<bachrach2012chisel>) 完成关键知识产权核（IP, Intellectual Property Core）实现，包括 SDRAM 控制器、Flash 控制器（串行外设接口（SPI, Serial Peripheral Interface）模式，配合就地执行（XIP, eXecute In Place）控制器实现直接取指执行）与 PSRAM 控制器（支持四线串行外设接口（QSPI, Quad SPI）与四线并行 I/O（QPI, Quad Peripheral Interface）模式及相互切换）。
+ 完成单发射乱序处理器设计，采用统一物理寄存器重命名方案，实现乱序执行、顺序提交与精确异常支持。
+ 完成基于物理索引物理标记（VIPT, Virtually Indexed Physically Tagged）结构且采用伪最近最少使用（PLRU, Pseudo Least Recently Used）替换策略的指令缓存（ICache, Instruction Cache）与数据缓存（DCache, Data Cache）设计与实现。
+ 完成 RISC-V M/S/U 三级特权架构与 Sv39 虚拟内存机制实现，具备操作系统运行所需的体系结构支持能力。
+ 完成 NVBoard（NJU Virtual Board）集成，实现仿真平台的外设可视化。
+ 完成 xv6 #cite(<cox2024xv6>) 教学操作系统移植与运行验证。
+ 基于混合性能计数器（RTL 寄存器 + DPI-C 事件）完成 MicroBench / Dhrystone / CoreMark 三组负载的性能评估，三组负载 IPC 达 0.43–0.56，Dhrystone 成绩 1.596 DMIPS/MHz、CoreMark 成绩 1.540 CoreMark/MHz。

= SoC 系统设计思路

== 设计目标与总体原则

本课题 SoC 设计的核心目标是为乱序处理器提供可运行操作系统的完整系统环境，并在保证可调试性的前提下兼顾性能与实现复杂度。为此，系统采用“分层总线 + 多层次存储 + 可视化外设联调”的总体思路：高速访存路径优先保障带宽与时延，低速外设路径优先保障协议兼容与工程可维护性，同时通过统一验证框架降低系统集成阶段的调试成本。

在实现策略上，SoC 结构遵循模块化和可替换原则。处理器核、总线互连、存储控制器和外设控制器通过标准接口连接，使得各模块可以独立迭代。该设计既满足当前单发射乱序处理器的系统集成需求，也为后续微架构升级和外设扩展预留了接口空间。

== 分层总线架构设计

SoC 采用高级可扩展接口 4（AXI4, Advanced eXtensible Interface 4）#cite(<math2012axi4>) 与高级外设总线（APB, Advanced Peripheral Bus）组合的分层互连架构，以匹配不同设备的速率特征。处理器核心通过 AXI4 主接口接入一级 Crossbar，一级 Crossbar 重点服务主存访问关键路径，仅挂接高带宽存储控制器；二级 Crossbar 连接片上存储与桥接模块，承担中速设备访问；低速外设统一通过 AXI4ToAPB 桥进入 APB 域，由 APB Fanout 完成地址分发。

SoC 整体互连架构如 @fig:soc-arch 所示。

#[
  #import "@preview/diagraph:0.3.6": *

  #figure(
    scale(
      80%,
      render(
        "digraph SoC {
          rankdir=TB;

          CPU [label=\"CPU (AXI4 Master)\"];
          xbar [label=\"AXI4 Crossbar\"];
          CPU -> xbar;

          sdramc [label=\"SDRAM Ctrl\"];
          xbar2 [label=\"AXI4 Crossbar 2\"];
          xbar -> sdramc [label=\"Delayer\"];
          xbar -> xbar2 [label=\"Frag / Yanker\"];

          sdram [label=\"SDRAM\", style=dashed];
          sdramc -> sdram;

          MROM; SRAM;
          apb [label=\"APB Fanout\"];
          xbar2 -> MROM;
          xbar2 -> SRAM;
          xbar2 -> apb [label=\"AXI4ToAPB\"];

          xip [label=\"XIP Flash Ctrl\"];
          psramc [label=\"PSRAM QSPI\"];
          uart [label=\"UART 16550\"];
          gpio [label=\"GPIO\"];
          ps2 [label=\"PS2\"];
          vga [label=\"VGA\"];
          plic [label=\"PLIC\"];
          clint [label=\"CLINT\"]

          apb -> xip;
          apb -> psramc;
          apb -> uart;
          apb -> gpio;
          apb -> ps2;
          apb -> vga;
          apb -> plic;
          apb -> clint;

          arb [label=\"SPI Arbiter\"];
          spi [label=\"SPI Ctrl\"];
          flash [label=\"Flash\", style=dashed];

          xip -> arb [label=\"high\"];
          apb -> arb [label=\"low\"];
          arb -> spi;
          spi -> flash [style=dashed];

          psram [label=\"PSRAM\", style=dashed];
          psramc -> psram [style=dashed];

          nvuart [label=\"NVBoard tty\", style=dashed];
          nvgpio [label=\"NVBoard LEDs\", style=dashed];
          nvps2  [label=\"NVBoard KB\", style=dashed];
          nvvga  [label=\"NVBoard VGA\", style=dashed];

          uart -> nvuart [style=dashed];
          gpio -> nvgpio [style=dashed];
          ps2  -> nvps2  [style=dashed];
          vga  -> nvvga  [style=dashed];

          {rank=same; sdramc; xbar2}
          {rank=same; MROM; SRAM; apb; sdram}
          {rank=same; xip; psramc; uart; gpio; ps2; vga}
          {rank=same; arb; psram; nvuart; nvgpio; nvps2; nvvga}
          {rank=same; spi; flash}
        }",
      ),
    ),
    caption: [SoC 系统整体互连架构],
    supplement: [图],
  ) <soc-arch>
]

如 @fig:soc-arch 所示，SoC 整体互连分为三个速率域。处理器核心作为唯一的 AXI4 Master 接入一级 AXI4 Crossbar。一级 Crossbar 的左侧分支经 AXI4 Delayer（用于在仿真中注入可配置的访存延迟）连接 SDRAM Controller，右侧分支经 AXI4 Fragmenter（将突发传输拆分为单拍事务以适配不支持 Burst 的从设备）与 AXI4 UserYanker（剥离用户自定义信号以对齐接口宽度）连接二级 AXI4 Crossbar。SDRAM 直接挂载在一级 Crossbar 上，以最短路径获得最高带宽。

二级 Crossbar 下挂 MROM（存放 FSBL, first stage boot loader）、SRAM（低延迟片上存储）以及 AXI4ToAPB 总线桥。总线桥将 AXI4 事务转换为 APB 协议后，由 APB Fanout 按地址空间分发至各低速外设：XIP Flash Controller、PSRAM QSPI Master、UART 16550、GPIO、PS2 键盘控制器、VGA 显示控制器，以及 PLIC（外部中断控制器）和 CLINT（定时器与软件中断控制器）。

在 Flash 访问路径上，XIP Flash Controller 与 APB Fanout 共享底层 SPI Controller 的物理访问权，通过 SPI Arbiter 进行仲裁：XIP 以高优先级发起 SPI 事务用于直接取指执行，APB 以低优先级提供 SPI 寄存器的直接读写通道。各外设控制器的 TX/RX 或数据端口连接至 NVBoard 虚拟开发板对应的外设仿真（串口终端、LED/数码管、键盘、VGA 显示器），以虚线表示。

该分层设计的关键收益在于：其一，高速域与低速域解耦，SDRAM 路径不受慢设备干扰；其二，AXI4 突发与并发事务能力被主存路径充分利用，APB 侧保持实现简单、硬件开销低；其三，桥接与仲裁逻辑集中管理，扩展新外设只需在 APB Fanout 中追加地址映射。

== 多层次存储与启动链路设计

存储系统采用 MROM、SRAM、Flash、PSRAM、SDRAM 的多层次组织。MROM 用于放置最小启动代码，SRAM 提供低延迟片上存储，Flash 提供非易失程序镜像并支持 XIP，PSRAM 与 SDRAM 提供更大容量主存。不同存储介质按“启动可靠性—访问延迟—容量”进行功能分工，形成从上电到系统运行的连续存储支撑。

在控制器实现上，关键 IP 核采用 Chisel #cite(<bachrach2012chisel>) 实现或重写：SDRAM 控制器面向 AXI4 高带宽路径进行流水化组织，Flash/PSRAM 相关控制器面向 SPI/QSPI/QPI 协议兼容设计。Flash 访问同时支持寄存器方式与 XIP 方式，并通过仲裁机制共享底层 SPI 资源。该设计兼顾了启动阶段可执行性与运行阶段访存效率。

启动链路采用分级引导思路：上电后从 Flash 中的引导入口执行，完成基础初始化后将后续引导或系统镜像加载至 SDRAM，再跳转进入运行态。该流程减少了直接从串行 Flash 执行大体量程序的性能损失，为操作系统（如 xv6 #cite(<cox2024xv6>)、RT-Thread #cite(<yi2023rtthread>)）启动提供更稳定的执行环境。

#[
  #import "@preview/diagraph:0.3.6": *

  #figure(
    scale(
      render(
        "digraph BootFlow {
        rankdir=TB;

        START [label=\"_start\"];
        FSBL [label=\"FSBL (一级引导)\"];
        SSBL [label=\"SSBL (二级引导)\"];
        TRM [label=\"trm_init\"];
        MAIN [label=\"main (应用程序)\"];

        START -> FSBL [label=\"XIP Flash: 初始化 SP\"];
        FSBL -> SSBL [label=\"XIP Flash: 将 SSBL 加载到 SDRAM, 跳转 SSBL\"];
        SSBL -> TRM [label=\"SDRAM: 将应用程序加载到 SDRAM, 跳转 trm_init\"];
        TRM -> MAIN [label=\"SDRAM: 初始化外设 / 加载 mtvec / 建立裸机运行时环境\"];
      }",
      ),
    ),
    caption: [启动链路流程图],
    supplement: [图],
  ) <boot-flow>
]

== 外设集成与可视化验证思路

外设侧围绕“可用、可测、可观测”进行设计。UART、GPIO、PS2、VGA 等控制器通过 APB 域接入，保证接口一致性与调试便利性。针对教学与开发场景，系统进一步集成 NVBoard，将串口回显、按键输入、数码管显示与 VGA 输出纳入同一仿真闭环，使 SoC 级功能验证从单纯日志比对扩展为可交互的行为验证。

在验证方法上，SoC 级联调与指令级差分测试协同使用：差分测试用于保证体系结构状态正确性，NVBoard 与外设交互用于暴露系统级时序和接口问题，二者互补提升了复杂问题定位效率。基于该思路，系统能够稳定支撑操作系统运行与外设协同工作。

== 本章小结

本章从目标约束、总线分层、存储组织、启动链路与外设验证五个方面阐述了 SoC 设计思路。通过 AXI4/APB 分层互连、多层次存储分工、关键控制器 Chisel 化实现以及 NVBoard 可视化联调，系统在性能、可维护性与可验证性之间取得了平衡，为乱序处理器运行 xv6 等操作系统提供了完整平台基础。

= 关键 IP 核设计与实现

SoC 系统中的存储控制器直接影响系统启动流程与运行期访存性能。本章围绕 Flash 控制器、PSRAM QSPI Master 控制器与 SDRAM 控制器三个关键 IP 核，分别阐述设计方案与验证方法。

== Flash 控制器与 XIP 机制

Flash 存储器通过 SPI 协议接入系统。SPI Master 选用 OpenCores 开源 IP 核，基于 Wishbone 总线接口，本课题使用 Chisel 实现了 APB-to-Wishbone 的薄封装层以接入 SoC 的 APB 域。

系统为 Flash 提供两种访问方式。第一种是命令方式：通过 APB Fanout 经 SPI Arbiter 直接读写 SPI 控制器寄存器，适用于 Bootloader 阶段的 Flash 编程与配置操作。第二种是 XIP（eXecute In Place）方式：XIP 控制器将处理器对 Flash 地址窗口的 MMIO 读请求自动转换为底层 SPI 命令字序列（如读命令、地址发送与数据回传），从而以硬件方式完成“取指驱动”。引入该机制的动机是避免启动阶段的“鸡生蛋”死锁：若程序存放在 Flash 中而访问 Flash 又依赖软件驱动，则驱动本身也需要先从 Flash 取出，系统将无法启动。通过 XIP 的硬件读通路，处理器无需先运行 SPI 软件驱动即可直接从 Flash 取指执行。两种方式通过 SPI Arbiter 共享物理 SPI 控制器，XIP 具有更高的仲裁优先级。

#figure(
  image("images/xip-fsm.drawio.png", width: 72%),
  caption: [APB XIP 控制器状态转移图],
  supplement: [图],
) <xip-fsm>

如 @fig:xip-fsm 所示，XIP 读事务从 `Passthrough` 状态进入后，依次经历 `SS` 选通、`TX1/TX0` 发送命令与地址、`CTRL` 启动传输、`Poll` 轮询完成、`RX` 回读数据、`DeSSel` 取消片选，最终在 `Respond` 状态向上游 APB 返回读结果。

在仿真验证方面，参照 Winbond W25Q128JVSIQ 手册中的时序与命令字规范，实现了 Flash 芯片的行为级仿真模型，并通过类 UVM 的验证测试确保协议兼容性。该仿真模型的协议正确性意味着上板或流片时可直接对接物理 Flash 芯片。

== PSRAM QSPI Master 控制器

PSRAM 通过 QSPI/QPI 协议接入系统，用于提供主存扩展。本课题参考 OpenCores SPI 设计思路，使用 Chisel 重新实现了完整的 QSPI Master 控制器，采用 APB 接口，支持从标准 QSPI 模式切换到 QPI 模式（四线半双工）。

#[
  #import "@preview/diagraph:0.3.6": *

  #figure(
    scale(
      80%,
      render(
        "digraph QSPI {
        rankdir=LR;

        subgraph cluster_qspi {
          label=\"QSPI Master\";
          style=dashed;
          FSM [label=\"FSM\"];
          CLGEN [label=\"Clgen\"];
          SHIFT [label=\"Shift\"];

          FSM -> CLGEN [label=\"go / divider\"];
          FSM -> SHIFT [label=\"go / len /\\npIn / wen\"];
          CLGEN -> SHIFT [label=\"posEdge /\\nnegEdge / sClk\"];
          SHIFT -> FSM [label=\"tipDone / last\"];
        }

        APB [label=\"APB Bus\"];
        PIN [label=\"QSPI I/O\"];
        CHIP [label=\"PSRAM chip\", style=dashed];

        APB -> FSM [label=\"psel / pwrite /\\npaddr / pwdata\"];
        FSM -> APB [label=\"pready / prdata\"];

        CLGEN -> PIN [label=\"SCK\"];
        SHIFT -> PIN [label=\"DIO\"];
        FSM -> PIN [label=\"CE_N\"];

        PIN -> CHIP [style=dashed];
      }",
      ),
    ),
    caption: [QSPI Master 控制器内部架构],
    supplement: [图],
  ) <qspi-arch>
]

如 @fig:qspi-arch 所示，控制器内部由三个子模块构成：状态机（FSM）负责协调 APB 总线事务与 SPI 传输流程；时钟分频器（Clgen）根据配置的分频系数生成 SPI 时钟，并向移位寄存器提供采样与驱动边沿信号；移位寄存器（Shift）在 Clgen 提供的时钟边沿驱动下完成数据的串并转换。FSM 通过 go 信号启动一次传输，Shift 在传输完成后通过 tipDone/last 信号通知 FSM，FSM 随即向 APB 侧返回 pready 完成握手。

在仿真验证方面，参照 ISSI IS66WVS4M8ALL/BLL 手册中的命令字与时序规范，实现了 PSRAM 颗粒的行为级仿真模型，用于在 Verilator 仿真环境中验证 QSPI 控制器的协议正确性。

== SDRAM 控制器

为提供较大容量的主存储空间，SDRAM 控制器挂载在一级 AXI4 Crossbar 上。本课题参考 ultraembedded 开源的 SDRAM 控制器（Verilog 实现），使用 Chisel 进行了完整重写，以实现参数化扩展并与 SoC 其他 Chisel 模块统一维护。重写后的控制器利用 Chisel 内置的 Queue 模块对请求和响应通路进行解耦，流水化程度高于原始 Verilog 版本。

控制器支持位扩展与字扩展两种组织方式。位扩展模式下，将两颗 SDRAM 芯片与同一个 SDRAM Core 组成一个 Bank，对同一行/列命令进行同步激活与访问，将两颗粒各自输出的 16bit 数据在控制器侧拼接为 32bit 数据通路。字扩展模式下，两个 SDRAM Core 以低位交叉（Low-order Interleaving）方式并联，按地址低位将请求映射到奇偶 Core：一个 Core 处理偶字，另一个 Core 处理奇字。

#[
  #import "@preview/diagraph:0.3.6": *

  #figure(
    scale(
      80%,
      render(
        "
      digraph SDRAM {
        rankdir=TB;

        XBAR [label=\"AXI4 Crossbar\\n(32bit)\"];
        BRIDGE [label=\"AXI4->SDRAM 事务桥\\n(SdramAxiPmem + Queues)\"];
        XBAR -> BRIDGE [label=\"AXI4 AW/W/AR\"];

        subgraph cluster_sdram {
          CORE0 [label=\"SDRAM Core 0\\n(偶字)\"];
          CORE1 [label=\"SDRAM Core 1\\n(奇字)\"];
        }

        BRIDGE -> CORE0 [label=\"addr(2)=0\\nrd/wr route\"];
        BRIDGE -> CORE1 [label=\"addr(2)=1\\nrd/wr route\"];
        CORE0 -> BRIDGE [label=\"accept/ack/rdata\"];
        CORE1 -> BRIDGE [label=\"accept/ack/rdata\"];
        PEND [label=\"pendingQ\\n(core select FIFO)\", shape=box, style=\"rounded,dashed\"];
        BRIDGE -> PEND [label=\"accept\"];
        PEND -> BRIDGE [label=\"route ack/data\"];

        C0 [label=\"SDRAM\", style=dashed];
        C1 [label=\"SDRAM\", style=dashed];
        C2 [label=\"SDRAM\", style=dashed];
        C3 [label=\"SDRAM\", style=dashed];

        CORE0 -> C0 [label=\"16bit\"];
        CORE0 -> C1 [label=\"16bit\"];
        CORE1 -> C2 [label=\"16bit\"];
        CORE1 -> C3 [label=\"16bit\"];

        {rank=same; CORE0; CORE1}
        {rank=same; C0; C1; C2; C3}
      }
    ",
      ),
    ),
    caption: [SDRAM 控制器字扩展与低位交叉架构],
    supplement: [图],
  ) <sdram-interleave>
]

如 @fig:sdram-interleave 所示，图中的中间模块本质上是 AXI4 到 SDRAM Core 接口的事务桥。该桥将 AXI4 总线事务转换为 Core 请求信号，并依据地址位（`addr(2)`）在两个 Core 间进行路由；请求被目标 Core 接收后，将 Core 选择信息写入 pending FIFO，后续再按 FIFO 记录回收对应 Core 的 `ack/readData/error` 响应并返回 AXI4 侧。该机制既支持低位交叉并发访问，也保证了响应回传与请求顺序的一致性。

在仿真验证方面，参照 Micron MT48LC16M16A2 手册实现了 SDRAM 颗粒的行为级仿真模型，准确模拟了 ACTIVATE、READ、WRITE、PRECHARGE、AUTO REFRESH 等命令的时序行为。验证平台采用基于 SystemC 的 UVM 架构，整体框图如 @fig:sdram-tb 所示。

#figure(
  image("images/sdram-testbench.png", width: 85%),
  caption: [SDRAM AXI4 Testbench 硬件框图],
  supplement: [图],
) <sdram-tb>

该测试平台由四个模块组成。tb_mem_test（SEQ）作为 Sequencer 负责产生测试激励，包括随机地址、数据长度与突发模式等参数，并通过 tb_driver_api 接口传递给 tb_axi4_driver（DRIVER）。tb_axi4_driver 将测试激励转换为符合 AXI4 协议的总线事务，通过 axi_m（axi4_master）接口向 DUT 发起 AW/W/AR 通道请求，并从 axi_s（axi4_slave）接口接收 B/R 通道响应。sdram_axi（DUT）即待测的 SDRAM 控制器，接收 AXI4 事务并将其转换为 SDRAM 物理接口时序，通过 sdram_io_m（sdram_io_master）接口驱动下游存储模型。tb_sdram_mem（TB_MEM）为 SDRAM 芯片的行为级仿真模型，通过 sdram_io_s（sdram_io_slave）接口响应控制器发出的命令序列。全部模块共享统一的时钟（CLK）与复位（RST）信号。本课题在该平台基础上进行了简单重构，以支持 outstanding 与乱序响应场景的验证，最终确认了 SDRAM 控制器的协议正确性。

== 本章小结

本章介绍了 SoC 中三个关键存储控制器的设计与验证。Flash 控制器通过 SPI Arbiter 同时支持命令访问与 XIP 直接取指执行；PSRAM QSPI Master 以 FSM + Clgen + Shift 三模块架构实现 QSPI/QPI 协议兼容；SDRAM 控制器通过 Chisel 重写实现了流水化与低位交叉字扩展。三个控制器均配有行为级仿真模型并通过协议级验证，具备直接对接物理芯片的能力。

= 前后端解耦架构

== 前后端解耦架构设计

本项目实现的乱序处理器采用前后端解耦架构。前端（FrontEnd）负责取指与分支预测，后端（BackEnd）负责译码、寄存器重命名、分派、发射、执行、写回、晚执行、提交。前后端之间通过一个指令队列（Instruction Queue）进行缓冲与解耦，后端在需要冲刷流水线时通过 flush 信号同步清空该队列，分支预测失败或异常恢复时通过 redirect 信号将正确的 PC 反馈给前端。

#[
  #import "@preview/diagraph:0.3.6": *

  #figure(
    scale(
      80%,
      render(
        "digraph FeBe {
        rankdir=LR;
        node [shape=box, style=rounded, fontsize=10];
        edge [fontsize=9];

        FE [label=\"FrontEnd\\n(取指 / 分支预测)\"];
        IQ [label=\"Instruction Queue\\n(depth = 4)\", shape=Mrecord];
        BE [label=\"BackEnd\\n(译码 -> 重命名 -> 分派 -> 发射\\n -> 执行 -> 写回 -> （晚执行） -> 提交)\"];

        FE -> IQ [label=\"fe.io.out\"];
        IQ -> BE [label=\"be.io.in\"];
        BE -> IQ [label=\"flush\", style=dashed, constraint=false];
        BE -> FE [label=\"redirect / flush\", style=dashed];
      }",
      ),
    ),
    caption: [前后端解耦架构与指令队列],
    supplement: [图],
  ) <fe-be-arch>
]

如 @fig:fe-be-arch 所示，前端产生的指令流经指令队列缓冲后进入后端；后端在检测到分支预测错误或异常时，通过 flush 信号清空队列中的无效指令，同时通过 redirect 信号将恢复后的目标 PC 发送给前端，使前端从正确地址重新开始取指。

== 前后端解耦架构的含义

前后端解耦的含义体现在时序解耦与实现解耦两个层面，并由此带来弹性的设计空间。

在时序解耦方面，前后端之间的连接方式是可配置的：既可以选择点对点直连（组合逻辑穿透，零周期延迟），也可以插入深度可调的缓冲队列。当使用队列时，前后端各自按自身节奏运行——后端因数据依赖或功能单元冲突暂停消费时，前端仍可继续取指填充队列，避免取指带宽浪费；前端遭遇 ICache 缺失时，后端可继续执行队列中已缓冲的指令，减少流水线气泡。队列深度作为参数，可根据实际时序需求灵活调整。

在实现解耦方面，前端与后端通过标准握手协议通信，两侧的内部实现完全独立。前端既可以采用流水化结构，也可以完全使用软件实现。在开发过程中，硬件前端由于需要等待总线响应与 ICache 缺失处理，指令供应速率有限，后端负载偏低，难以充分暴露乱序流水线在高压力下的时序问题。为此，本课题利用解耦架构的可替换性，在前端内嵌入 Spike 参考模型：Spike 每执行一条指令即可获得精确的下一条指令 PC，使分支预测几乎 100% 正确，同时取指不经过总线，几乎每个周期都能向后端供应一条有效指令。这一做法相当于对后端进行了满载压力测试，成功暴露了一个在常规硬件前端下因指令供应不足、未形成反压（back-pressure）而被隐藏的 bug——该 bug 表现为反压条件下数据转发时机错过，仅在后端持续满载时才会触发。定位并修复该问题后，前端切换回正常硬件实现。@fig:spike-frontend 展示了使用 Spike 软件前端运行 MicroBench 测试套件的结果：全部测试项通过，共提交 624375 条指令，其中 142230 条分支指令仅产生 514 次预测错误，命中率达 99.64%，验证了该方案的指令供应充分性。这一经验表明，解耦架构不仅降低了模块间的开发耦合度，还为针对性的压力测试提供了灵活的验证手段。

#figure(
  image("images/spike-frontend-bench.png", width: 90%),
  caption: [Spike 软件前端运行 MicroBench 的测试结果（分支预测命中率 99.64%）],
  supplement: [图],
) <spike-frontend>

== 本章小结

弹性设计空间是解耦架构的另一直接收益。指令队列作为缓冲层，使得前端分支预测器或取指流水线的升级不影响后端接口，有利于微架构的增量迭代与独立优化。

= 前端：取指单元与动态分支预测设计

前端负责为后端持续供应有效指令，其内部由取指单元（IFU, Instruction Fetch Unit）与分支预测单元（Predict）两个子模块组成。IFU 采用 4 段流水结构完成地址翻译与 ICache 访问，Predict 对当前取到的指令进行轻量译码并输出预测的下一条指令 PC，两者协同工作形成"取指—预测—下一轮取指"的闭环。

#[
  #import "@preview/diagraph:0.3.6": *

  #figure(
    scale(
      80%,
      render(
        "digraph Frontend {
        rankdir=TB;

        subgraph cluster_fe {
          label=\"FrontEnd\";
          style=dashed;

          IFU [label=\"IFU\\n(4-stage pipe\\n+ iTLB + PTW)\"];
          Predict [label=\"Predict\\n(CU + IGU + BHT\\n+ IJTC + RAS)\"];

          IFU -> Predict [label=\"pc / inst\"];
          Predict -> IFU [label=\"predict_dnpc\"];
        }

        ICache [label=\"ICache\"];
        PTW_MEM [label=\"PTW Port\\n(Page Table)\"];
        IQ [label=\"Instruction Queue\"];
        BE [label=\"BackEnd\"];

        IFU -> ICache [label=\"req / addr\", dir=both];
        ICache -> IFU [label=\"rdata / done\"];
        IFU -> PTW_MEM [label=\"PTW req\", dir=both];
        PTW_MEM -> IFU [label=\"PTW resp\"];
        IFU -> IQ [label=\"out (inst/pc/ghr)\"];
        IQ -> BE [label=\"out (inst/pc/ghr)\"]
        BE -> Predict [label=\"redirect\", style=dashed];
        BE -> IFU [label=\"flush / dnpc\", style=dashed];
      }",
      ),
    ),
    caption: [前端内部架构与外部接口],
    supplement: [图],
  ) <frontend-arch>
]

如 @fig:frontend-arch 所示，IFU 通过 ICache 端口和 PTW(page table walker) 端口分别访问指令缓存与页表，取到的指令与 PC 传递给 Predict 进行分支预测，Predict 返回预测的下一条 PC 供 IFU 在下一轮取指时使用。IFU 的输出（指令、PC、预测信息）经指令队列送入后端。后端在分支预测失败或异常恢复时，通过 redirect 信号更新 Predict 的预测器状态，并通过 flush/dnpc 信号使 IFU 从正确地址重新取指。

== 取指单元（IFU）设计 <sec:ifu-pipeline>

=== 总体架构

为在保持单发射单提交约束的前提下充分释放后端乱序执行潜能，IFU 采用 F0、F1、F2、Fp、F3 的流水结构，其设计目标是在直线代码上达到稳态 1 IPC，taken 分支仅付出 2 个气泡周期（@tab:perf-overview 的性能数据证实了这一目标已基本达成）。整体架构与各段职责如 @fig:ifu-pipeline 所示。整个 IFU 由顶层模块与四个子模块（`F1Stage`、`F2Stage`、`FpStage`、`F3Stage`）构成，分别承担 PC 生成、地址翻译、ICache 控制、分支预测与后端交付的职责。

#figure(
  image("images/ifu-pipeline.drawio.png"),
  caption: [4 段流水化 IFU 的整体架构],
  supplement: [图],
) <ifu-pipeline>

子模块之间除 F2 $arrow$ Fp 外均通过 `PipelineConnect` 串联。`PipelineConnect` 本身就是一个参数化的流水段：它在上下游之间插入一个带握手的 valid 寄存器与一个 `bits` 锁存寄存器，在 `thisIn.ready` 有效时吸纳上一拍的 `prevOut.valid / bits`，在 `flush` 有效时将 valid 清零、丢弃当前槽位的占用；稳态下，上下游以 `ready / valid` 握手协议滚动前进，被 squash 时整条流水可以在同一拍内把所有中间 slot 清空。实现上借助 Scala 的泛型参数 `T <: Data` 将具体载荷类型抽象掉，使得它既能承载 `F1In`、`F2In`、`F3In` 等 IFU 内部的 Bundle，也能被后端的分派、发射与执行段复用，保证整个项目的流水段接口风格一致：

#code-figure(
  ```scala
  object PipelineConnect {
    def apply[T <: Data](
        prevOut: DecoupledIO[T],
        thisIn:  DecoupledIO[T],
        flush:   Bool
    ): Unit = {
      val valid = RegInit(false.B)
      when(flush) {
        valid := false.B
      }.elsewhen(thisIn.ready) {
        valid := prevOut.valid
      }
      prevOut.ready := thisIn.ready
      thisIn.bits 
        := RegEnable(prevOut.bits, prevOut.valid && thisIn.ready)
      thisIn.valid  := valid
    }
  }
  ```,
  caption: [参数化流水段 PipelineConnect 的实现],
  supplement: [代码],
  label-name: "pipeline-connect",
)

F0 位于 IFU 顶层、不占用独立子模块，仅维护架构 PC 寄存器 `pc_q`，每拍投机地假设下一条指令为 `pc_q + 4` 并向 F1 推进；一旦 F3 确认出 taken 分支（直接跳转、被预测为跳转的条件分支等），即由前端自重定向把 `pc_q` 拉回到预测目标；其他所有需要改 PC 的场景（分支误预测、trap、xret、`fence.i`、`sfence.vma`、CSR 写等）则由后端 `io.flush` 统一携带正确的 `io.dnpc` 重写 `pc_q`。顶层同时生成全局 squash 信号 `squash = fe_take_branch or io.flush`，广播至所有 `PipelineConnect` 的 `flush` 端口以及 F1 与 Fp 的内部状态寄存器，保证全流水一拍内同步清空。F1/F2+Fp/F3 三段的具体实现分别见下文。

=== F1 级：MMU 地址翻译 <sec:ifu-mmu>

F1 承担取指侧的地址翻译职责，是前端事实上的 MMU 级，其典型实现即本项目的 `F1Stage` 子模块。模块内部由一个 16 项全相联的 iTLB 与一个 PTW 子 FSM 组成：iTLB 负责命中时的快路径，PTW 负责缺失时的慢路径回填。Sv39 未启用时 F1 直接将虚拟地址低位截断作为物理地址组合放行；启用后则对 PC 的 VPN 做一次组合查表，命中且 PTE.X 合法则一拍内输出翻译后的物理地址，命中但 PTE.X 不合法则置位 `page_fault` 标志并向 F2 输出 mcause = 12 的指令页错误；若 TLB 缺失，则启动 PTW 沿 `ptw_port` 走三级页表，完成后回填 iTLB 并在下一拍重查。

PTW 子 FSM 是整个 F1 中唯一的状态机。由于 F0 的投机推进在任意一拍都可能被 taken 分支或后端 flush 打断，PTW 必须能在"已经向 AXI 发起页表读"的中途被 squash 而不留下孤悬事务，否则后续 TLB 缺失会因 `ptw.req.ready = 0` 而死锁。为此 F1 内部维护 @fig:ifu-ptw-fsm 所示的四态子 FSM，并配合两个辅助寄存器 `ptw_vpn_reg` 与 `ptw_abandoned` 记录当前在途请求的上下文。

#[
  #import "@preview/diagraph:0.3.6": *

  #figure(
    scale(
      85%,
      render(
        "
        digraph PtwFSM {
          rankdir=LR;
          node [shape=ellipse, fontsize=10];
          edge [fontsize=9];

          idle     [label=\"idle\"];
          req      [label=\"req\"];
          waitResp [label=\"waitResp\"];
          drain    [label=\"drain\"];

          idle -> req           [label=\"tlb_miss\"];
          req  -> waitResp      [label=\"ptw.req.fire\\n(latch vpn)\"];
          waitResp -> idle      [label=\"ptw.resp.valid\\n(refill iTLB if\\n!abandoned &&\\nvpn match)\"];

          req      -> drain     [label=\"squash &&\\n going inflight\", style=dashed];
          waitResp -> drain     [label=\"squash &&\\n no resp yet\", style=dashed];
          drain -> idle         [label=\"ptw.resp.valid\\n(drop silently)\", style=dashed];

          req      -> idle      [label=\"squash &&\\n !going inflight\", style=dashed];
          waitResp -> idle      [label=\"squash &&\\n resp arriving\", style=dashed];
        }
      ",
      ),
    ),
    caption: [F1 内部 PTW 子 FSM 状态转移图（虚线表示 squash 路径）],
    supplement: [图],
  ) <ifu-ptw-fsm>
]

正常路径上，`idle` 状态检测到 TLB 缺失即转入 `req`，在该状态驱动 `ptw.io.req.valid`；握手成功后将当前 VPN 锁存入 `ptw_vpn_reg` 并转入 `waitResp` 等待页表遍历完成。收到 `ptw.resp.valid` 时，只有同时满足"未被放弃 (`!ptw_abandoned`)、无 fault、F1 当前仍持有同一 VPN (`in_vpn === ptw_vpn_reg`)"三条才会真正 refill iTLB；否则视为一次已过期的响应而悄然丢弃。这一校验是避免 squash 后新旧请求交错、将错误的 PPN 灌入 iTLB 的关键。

squash 路径（@fig:ifu-ptw-fsm 中虚线）分两种情形处理：若 squash 同拍 PTW 恰处于 `req` 且 AXI 握手已成功，或处于 `waitResp` 且尚未收到响应——即总线上已经有"孤悬"的读请求——则置 `ptw_abandoned = 1` 并转入 `drain`，此后静默吞掉响应而不 refill、不报告 fault；其余情况（包括 `req` 未握手、`waitResp` 响应与 squash 同拍到达）总线上已无未决事务，直接回到 `idle`。`drain` 状态本身是一个"纯等待"态，收到响应即回到 `idle`，与此同时对外仍保持 `ptw.req.ready`，不会阻塞后续新请求的发起。

=== F2 + Fp 级：ICache 控制 <sec:ifu-icache-ctrl>

F2 与 Fp 在实现上分别对应 `F2Stage` 与 `FpStage` 两个子模块，但在功能上它们共同构成"ICache 控制级"：F2 负责驱动请求通道，Fp 负责追踪回响通道。二者放在同一小节介绍是因为它们的握手语义必须视作一个整体——F2 $->$ Fp 之间是整条流水线中唯一没有使用 `PipelineConnect` 的边界——之所以如此，直接源于 AXI4 ICache 的握手时序约束：本项目实现的 ICache 在 `icache.req and icache.ack` 同拍完成请求接受，在其后的某个周期以 `icache.done and icache.rdata` 返回数据。若在 F2 与 Fp 之间额外插入 `PipelineConnect` 的 slot 寄存器，则 Fp inflight 的状态会比真实总线状态晚一拍——极端情况下 ICache 在下一拍即返回 `done`，而 Fp 此时尚未进入"等待响应"状态，该响应将无处着陆而被丢失。因此本设计令 F2 与 Fp 在逻辑上合并为同一流水段，由 ICache 握手自身充当两者间的粘合信号，squash 语义则通过单独布线至 `fp.io.squash` 实现。

F2 本身是纯组合逻辑段，不持有任何寄存器。其主要职责是根据上游 `F2In` 表项驱动 `icache.req / addr / size` 与 ICache 完成 `req / ack` 握手；物理地址按 `dataBytesBits` 字节对齐后送出，请求只在"上游有效、非 fault、且 Fp 尚有空槽"时才 assert，从而避免占用 ICache 的仲裁带宽。对 F1 上报的 page fault 表项，F2 另辟一条 fault bypass 通道直送 F3，绕过 Fp——因为故障表项没有真正的 cache 读，也不应在 Fp 中占用一个 in-flight 槽位；这条旁路的 `valid` 额外门控在 `fp.empty = 1` 上，防止一个迟到的 fault 在 Fp 尚有 inflight 响应时错位交付给 F3。cache 路径与 fault 路径在顶层通过一个 fault 优先的 Mux 合并到同一份 `F3In` 源，再经 `PipelineConnect` 进入 F3。

Fp 是整条 IFU 中承载"多条 inflight 的 cache 读"的核心结构，实现为深度 4 的环形 FIFO。设计该 FIFO 而非单项缓冲是性能评估阶段的直接反馈：由于 ICache 支持在 lookup+hit 同拍接受新请求的流水能力，连续命中时 F2 每拍都能将请求递交给 Fp，若 Fp 仅能容纳一条 inflight 请求，则 F2 必须在 Fp 满后立即阻塞，直接损失了 ICache 的流水吞吐。深度为 4 与 ICache 的内部流水深度相匹配，允许至多 4 条请求同时 inflight 而不引入额外的反压。内部使用三个指针追踪不同阶段：`enq_ptr` 由 F2 入队时递增、`deq_ptr` 由 F3 出队时递增，二者采用经典的多一位"翻转位"来区分满与空；第三个指针 `rdata_ptr` 专用于回填 —— 每当 `icache.done` 脉冲到来，就把 `icache.rdata` 写入 `slots(rdata_ptr)` 并将该槽位的 `inst_ready` 置 1，再将指针前移。由于 ICache 严格按请求入队顺序返回响应，`rdata_ptr` 沿 FIFO 单向推进即可正确对齐每条响应与其对应槽位，无需按请求地址做 CAM 匹配，硬件实现仍然简洁。队头只有在 `inst_ready = 1` 时才向 F3 出队，从而天然实现了"请求-响应解耦"。

Fp 对 squash 的处理方式也因此相比 F1 更为粗暴：`squash = 1` 同拍同步清空所有 `valids` 并将三个指针全部归零，此后若仍有未返回的 ICache 响应，Fp 会将其"视而不见"——指针已前移过原有的 in-flight 区间，`do_rdata` 因 `!has_inflight` 而不会触发任何写入。ICache 主状态机自行负责完结剩余的 AXI 突发，这也是 `fence.i` 能够依赖 ICache 侧 `fence_drain` 状态（见 @sec:icache-fsm）而不必由 Fp 主动等待的前提。

=== F3 级：预测与后端交付

F3（`F3Stage`）对应整条 IFU 的提交点，在结构上是一个纯组合逻辑段，唯一的时序元件是其输入侧 `PipelineConnect` 所持有的 slot 寄存器。其职责集中于三件事：切出指令字、驱动 Predict 端口、生成一路前端自重定向脉冲。指令字的切出依赖上游携带的 `pa_word_sel`（即物理地址第 2 位）——ICache 单次返回的是 64 位 doubleword，F3 据此从 `inst(63, 32)` 与 `inst(31, 0)` 中选出对应的 32 位指令。若上游已将表项标记为 `has_fault`，则强制置指令字为 0 并在 `IFUOutput` 上输出 `mcause = 12`、`mtval = pc`、`has_except = 1`，供后端在 ROB 提交点一并发起 trap。

Predict 端口以 `pc` 与 `inst` 为输入、以 `dnpc` 与 `ghr` 为输出，F3 在同一拍内将预测结果连同原始指令一起封入 `IFUOutput`。为避免 F3 因后端反压而重复触发 RAS 压栈，`io.predict.commit` 被严格挂到 `io.out.fire` 那一拍——只有真正提交给后端的 call/ret 才会影响 RAS 状态。该细节对应了动态分支预测中的"推测路径污染防护"，分支预测器的具体组成将在 @sec:predict 详述。

F3 对控制冒险的收敛通过 `fe_take_branch` 信号实现，其定义为：

$ "fe_take_branch" = "io.out.fire" and not "in.bits.has_fault" and ("predict.dnpc" != "pc" + 4) $

即"F3 成功向后端交付了一条非故障指令，但预测的下一条 PC 与顺序后继不一致"。该脉冲只在 `io.out.fire` 那一拍有效，保证每条触发指令至多产生一次自重定向。其对 F0 及各级 slot 的回卷效果将在下一节具体分析。

=== 推测性控制冒险与前端自重定向 <sec:ifu-redirect>

分支指令对取指流水是一类天然的控制冒险：F0 以 `pc_q + 4` 投机推进时，根本不知道几拍之后送入 F3 的指令是否会改变下一条 PC。若将这一冒险完全交由后端解决，则每条 taken 分支都必须等到 `io.flush` 带回权威 PC 才能重填取指流水，付出"整条前端清空 + 重取"的完整代价，还要额外穿越后端译码、重命名、发射与执行等多级流水，气泡数远大于前端流水深度本身。

为此本设计在 F3 额外引入一路基于预测的推测性控制冒险解决通道 `fe_take_branch`。当它在某一拍脉冲有效时，顶层作两件事：其一，同拍把 `squash` 广播给所有 `PipelineConnect` 与 F1/Fp 的内部状态寄存器，全流水同步清空；其二，利用 Chisel 最后连接胜出的规则，让 `pc_q := io.predict.dnpc` 覆盖 F0 默认的 `pc_q + 4`，使下一拍 F0 即从预测目标取指。这条通路把本来要"等待后端权威 PC"的控制冒险，提前到了 F3 就地解决，使 taken 分支的气泡压缩至 2 拍。

这里的"推测性"指的是该回卷仅以 Predict 的预测结果为依据：若预测错误，后端将在若干拍后判定 `redirect.dnpc` 与 `predict_npc` 不一致，再由 CommitStage 发出 `io.flush` 以权威 PC 对 `pc_q` 二次回卷。`pc_q` 的三个写入源在 Chisel 中以最后连接胜出的方式实现天然优先级：`f0_out.fire` 先写 `pc_q + 4`、`fe_take_branch` 覆盖为 `predict.dnpc`、`io.flush` 最终覆盖为 `io.dnpc`，从而将"后端权威 > 前端预测 > 顺序推进"这一语义层级落到硬件上。

由此也自然解释了为何前端刻意把所有 serializing 指令（`ecall`/`ebreak`、`mret`/`sret`、`sfence.vma`、`fence.i` 以及 CSR 写）的处理一律推给后端：这些指令要么执行结果依赖后端 CSRU 才能确定（trap 目标地址、`mepc`/`sepc`、新的 `satp`、新的特权级等），要么需要等 ICache 完成 in-flight refill 的收敛（`fence.i`，详见 @sec:icache-fsm 中的 `fence_drain` 状态），没有任何一项是前端可以独立预测的；而这类指令在典型程序中出现频率极低，根据 Amdahl 定律 #cite(<amdahl1967validity>)，对其开辟前端专用通道所能带来的整体性能收益十分有限，不足以抵消其引入的结构复杂度。因此前端在结构上彻底摆脱了对 serializing 指令的依赖——既没有为 `fence.i` 维护粘滞位，也没有为 CSR 写与 xret 保留独立的自重定向通道，所有这些场景统一由后端 CommitStage 生成 `io.flush` 携带权威 PC 完成收敛。

== 动态分支预测单元设计 <sec:predict>

分支预测单元（Predict）对 IFU 取到的指令进行轻量译码，复用后端的 CU（Control Unit，控制单元）与 IGU（Immediate Generate Unit，立即数生成单元）模块提取指令类型与立即数。CU 本身是后端译码级的核心模块，包含完整的指令解码逻辑，具有一定的复杂性。前端复用 CU 时，将前端不涉及的输入信号硬编码为 0，不需要的输出信号悬空；综合工具在优化阶段可据此自动裁剪不可达的组合逻辑路径，使前端实例化的 CU 仅保留指令类型识别等轻量子集，在避免重复编写译码逻辑的同时不引入多余的面积开销。Predict 根据 CU 输出的指令类型将当前指令分派到不同的预测器，最终通过优先级选择逻辑输出预测的下一条 PC。

=== GShare 分支方向预测器（BHT, Branch History Table）

对于条件分支指令，采用 GShare 算法 #cite(<mcfarling1993combining>) 进行方向预测。GShare 使用全局历史寄存器（GHR, Global History Register）与 PC 的高 60 位（`PC[63:4]`）进行异或得到哈希结果，再取索引位定位模式历史表（PHT, Pattern History Table），以利用全局分支相关性提高预测精度。PHT 包含 4096 个表项，每个表项使用 2 位饱和计数器：计数器高位为 1 表示预测跳转，为 0 表示预测不跳转。当 PHT 中对应表项尚未被训练（occupied 标志为假）时，退化为静态预测——以立即数符号位作为预测方向（负偏移预测跳转，正偏移预测不跳转），该启发式对循环结构有较好的覆盖。

后端在条件分支指令提交时，通过 redirect 信号将实际跳转结果与该指令对应的 GHR 快照回传给 BHT，BHT 使用回传的 GHR 与 PC 异或重新定位 PHT 表项并更新饱和计数器，同时将实际跳转方向移入 GHR。

#figure(
  image("images/gshare-xor.png", width: 45%),
  caption: [GShare 中 GHR 与 PC 异或索引示意],
  supplement: [图],
) <gshare-xor>

=== 间接跳转目标缓存（IJTC, Indirect Jump Target Cache）

对于非返回类的间接跳转指令（JALR 且非 ret 模式），采用 IJTC 进行目标地址预测。IJTC 使用 8 项全相联内容可寻址存储器（CAM, Content Addressable Memory）结构，以 PC 作为 tag 进行匹配查询。命中时直接返回缓存的目标地址；缺失时不做预测，前端将使用顺序 PC。

更新策略上，后端在 JALR 指令提交时将实际 PC 与目标地址回传给 IJTC。若 CAM 中已存在该 PC 对应的表项则原地更新目标地址；若不存在则以先进先出（FIFO, First In First Out）策略淘汰最旧表项并写入新映射。

=== 返回地址栈（RAS, Return Address Stack）

对于函数返回指令，采用 RAS 进行目标地址预测。RAS 为深度 8 的循环栈，通过 rd 和 rs1 字段识别 call/ret 模式：当指令为 JAL 或 JALR 且目的寄存器为 x1 或 x5 时判定为 call，将顺序 PC（snpc = pc + 4）压栈；当指令为 JALR 且 rd = x0、rs1 = x1 时判定为 ret，弹栈并将栈顶值作为预测目标。

#figure(
  image("images/ras-stack.png", width: 50%),
  caption: [返回地址栈（RAS）工作示意],
  supplement: [图],
) <ras-stack>

=== 预测选择逻辑

Predict 模块根据指令类型按优先级选择预测结果：JAL 指令直接使用 PC + 立即数作为目标；条件分支指令根据 BHT 预测方向选择跳转目标或顺序 PC；JALR 且为 ret 模式时使用 RAS 弹栈结果；JALR 且 IJTC 命中时使用 IJTC 缓存的目标地址；其余情况使用顺序 PC。预测结果与当前 GHR 快照一并传递给 IFU，由 IFU 在下一周期使用该地址取指，并随指令一同送入后端，供后端在提交时进行验证与预测器更新。

=== 与 BTB 方案的对比及设计取舍

经典分支预测方案 #cite(<yao2014superscalar>) 通常使用分支目标缓冲器（BTB, Branch Target Buffer）：在取指阶段以 PC 索引 BTB，若命中则直接读出缓存的跳转目标地址，从而在译码之前就完成预测。BTB 的优势在于无需等待指令译码即可获得目标地址，适合流水化取指前端。

本课题的设计目标是在尽可能简单的前端实现下取得合理的预测覆盖。在本项目的 4 段流水前端（@sec:ifu-pipeline）中，预测器工作在 F3 阶段——指令字已在 F3 可见，指令类型与立即数可得。对于 JAL 和 BRANCH 这两类指令，目标地址为 PC + 立即数的简单加法，可在当拍直接计算得出，无需额外的缓存结构；仅对 JALR 这类目标地址依赖寄存器值、前端无法计算的指令，才借助 IJTC 或 RAS 进行预测。因此在本微架构下，BTB 的作用被直接计算和专用预测器所替代，省去了 BTB 的存储开销与维护逻辑；后续若进一步优化时序，拆分取指流水线，则 BTB 才会成为必要的补充。

=== 预测器更新策略

三个预测器的更新策略根据各自特性采用了不同的时机。

GShare 与 IJTC 采用保守策略，仅在指令提交（commit）时更新。后端通过 redirect 信号将已提交的分支指令的实际跳转结果、PC 与 GHR 快照回传给前端预测器。这一策略的优势在于只有确认正确执行路径上的指令才会影响预测器状态，避免了因推测执行路径上的错误信息污染 PHT 或 IJTC 表项。

RAS 则采用激进策略，在前端取指与预解码阶段即时更新：遇到 call 指令立即压栈，遇到 ret 指令立即弹栈。这一设计是合理的——即使当前指令处于推测路径上，推测路径中的 call 与 ret 仍然是成对出现的，压栈与弹栈操作相互抵消，不会破坏栈的正确性。若在前端就更新 RAS，后续紧跟的 ret 指令可以立即获得正确的返回地址，而无需等待 call 指令提交，从而降低了函数调用密集场景下的预测延迟。

== 本章小结

本章围绕"前端取指流水化、分支预测与推测性控制冒险处理"三条主线介绍了 IFU 与动态分支预测的设计。

在取指流水化方面，IFU 采用 F0、F1、F2、Fp、F3 的流水结构，以"直线代码稳态 1 IPC、taken 分支仅引入 2 拍气泡"为性能目标。F1 作为 MMU 级完成 iTLB 查询与 PTW 慢路径遍历；F2 与 Fp 共同构成 ICache 控制级，F2 负责请求通道、Fp 以深度 4 的环形 FIFO 追踪在飞响应，二者间以直连代替 `PipelineConnect` 以满足 ICache 握手时序；F3 作为提交点在一拍内完成指令切分、预测驱动与后端交付。

在分支预测方面，设计采用 GShare + IJTC + RAS 的组合方案，分别对应条件分支、间接跳转与函数返回三类控制流。得益于前端已完成预解码，JAL 与 BRANCH 的目标地址可直接由 PC 与立即数相加得到，仅 JALR 需借助专用预测器，从而省去了 BTB 的存储与维护开销。更新策略上，GShare 与 IJTC 采用提交时更新的保守策略以避免推测路径污染预测器状态；RAS 则挂在 `io.out.fire` 上即时 push/pop，利用 call/ret 成对出现的特性降低预测延迟。

在推测性控制冒险处理方面，前端以 F3 的 `fe_take_branch` 脉冲就地收敛 taken 分支，将气泡压缩至 2 拍。其余导致前端需要回卷的场景被统一归并到后端 CommitStage 发出的 `io.flush` 上，按触发原因可分为两类：第一类是"改 PC"——包括分支误预测、trap 与 xret，后端在确定权威 PC 后通过 `io.flush` + `io.dnpc` 对 `pc_q` 进行二次回卷；第二类是"会影响前端状态的指令"——`fence.i` 使 ICache 中的 cacheline 过时、`sfence.vma` 使 iTLB 表项过时、CSR 写改变 `satp` 或特权级导致地址翻译语义切换，这些情况即便 PC 本身不变，前端也必须同拍清空所有在飞事务并从后端提供的 `io.dnpc`（通常是 `pc+4`）重新取指。其中 `fence.i` 与 ICache 在飞 refill 的收敛进一步下沉到缓存状态机的 `fence_drain` 状态（详见 @sec:icache-fsm），从而让前端在结构上对所有 serializing 指令完全透明。配合 F1 内部的 PTW 四态子 FSM 与 F3 的 RAS 推测保护，前端得以在投机推进过程中安全地处理 squash，避免留下孤悬的总线事务或污染预测器状态。

关于分支预测命中率、前端 flush 事件分解及其与三组基准程序（MicroBench / Dhrystone / CoreMark）的定量关联，详见 @sec:perf-fe-breakdown 与 @tab:perf-bp。

= 后端：乱序执行引擎 <sec:backend>

后端接收前端经指令队列送入的指令流，完成译码、寄存器重命名、发射、执行、写回与提交的全流程，是实现乱序执行的核心引擎 #cite(<smith1995superscalar>)。本项目实现的后端支持 RV64IM 指令集架构，包含整数运算、乘除法运算、分支、访存与控制状态寄存器（CSR, Control and Status Register）五条执行路径。

#figure(
  image("images/backend-arch.drawio.png", width: 85%),
  caption: [后端乱序执行引擎],
  supplement: [图],
) <backend-arch>

如 @fig:backend-arch 所示，图中蓝色连线表示指令与数据通路，粉色连线表示控制通路（wakeup 与 BusyTable 状态查询），绿色连线表示提交级状态通路（ArchRAT 写回与 FreeList 回收），灰色连线表示 PRF 写回总线。指令从左侧进入 Decode 级，经 Rename 级查询 FutureRAT 并从 FreeList 分配物理寄存器后，进入 Dispatch 级。Dispatch 将指令写入 ROB 获取 rob\_tag，同时根据指令类型分派到 ALU Queue、BRU Queue 或 MDU Queue 三个发射队列。发射队列通过 BusyTable 查询源操作数就绪状态，就绪后发射到对应执行单元：ALU 与 MDU 执行后将结果通过 PRF 写回总线写入 PRF 并向 ROB 报告完成，BRU 仅向 ROB 报告分支结果（Flag）。LSU 与 CSRU 采用延迟执行路径，由 ROB 在指令接近提交时交付执行，LSU 连接 DCache 与外设端口，CSRU 负责 CSR 读写并输出 redirect、flush、fence\_i、sfence\_vma、satp 与 priv 等控制信号。提交级（Commit Unit）从 ROB #cite(<choi2013rob>) 头部按序提交，将新映射写入 ArchRAT、旧物理寄存器归还 FreeList，完成乱序执行到顺序提交的状态收敛 #cite(<smith1988precise>)。

== 译码级

译码级接收前端送入的指令字与 PC，通过 CU（Control Unit）解码出指令类型、功能单元选择、操作码、源/目的寄存器编号等控制信号，通过 IGU（Immediate Generate Unit）提取并符号扩展立即数。译码级的输出形成完整的微操作描述，经流水线寄存器传递给重命名级。

CU 的实现利用了 Chisel 提供的 `DecodeTable` 框架与 Espresso 逻辑最小化工具。具体而言，首先定义 `InstPattern` 作为指令编码的匹配模板，将 func7、rs2、func3、opcode 四个字段组合为 `BitPat`，其中不相关的位标记为 don't-care：

#code-figure(
  ```scala
  case class InstPattern(
    func7: BitPat = BitPat.dontCare(7),
    rs2:   BitPat = BitPat.dontCare(5),
    func3: BitPat = BitPat.dontCare(3),
    opcode: BitPat
  ) extends DecodePattern {
    def bitPat = func7 ## rs2 ## BitPat.dontCare(5)
      ## func3 ## BitPat.dontCare(5) ## opcode
  }
  ```,
  caption: [指令匹配模板 InstPattern 定义],
  supplement: [代码],
  label-name: "inst-pattern",
)

随后，为每个需要译出的控制信号定义一个 `DecodeField`，在其 `genTable` 方法中以 Scala 模式匹配的方式描述每条指令对应的输出值。所有指令模板与译码字段汇总为一张 `DecodeTable`，Chisel 编译期自动调用 Espresso 对真值表进行两级逻辑最小化，生成面积最优的组合逻辑电路。相比手工编写 `MuxLookup` 或 `switch` 译码树，该方案在指令数量增长时仍能保持紧凑的门级实现，同时 Scala 的类型系统与模式匹配语法使译码表的维护更加直观，新增指令只需在 `allInstructions` 列表中追加一行 `InstPattern` 并在各 `DecodeField` 中补充对应映射即可。

CU 的译码输出涵盖 9 个字段：指令类型（`InstType`，18 种）、ALU 操作码（`ALUOpType`）、MDU 操作码（`MDUOpType`）、立即数类型（`ImmType`，I/S/B/U/J 五种）、BRU 操作码（`BRUOpType`）、访存宽度与符号扩展标志、CSR 操作类型与写使能。对于 ECALL、EBREAK 与非法指令，CU 额外输出异常标记与 mcause/mtval 初始值，供提交级进一步处理。

== 寄存器重命名

寄存器重命名是乱序执行的核心前提 #cite(<tomasulo1967algorithm>)，其目的是消除指令间由逻辑寄存器复用导致的 WAW（写后写）与 WAR（写后读）假依赖，使真正的数据依赖（RAW）成为唯一的调度约束。本项目采用统一物理寄存器文件（Unified Physical Register File, PRF）方案，主要涉及以下结构：

物理寄存器文件（PRF）。PRF 提供 9 个读端口与 5 个写端口。9 个读端口分配给 ALU（2）、BRU（2）、MDU（2）、LSU（2）与 CSRU（1）五条执行路径；5 个写端口分别服务于 ALU 写回、分派级立即数写入、LSU 写回、CSR 写回与 MDU 写回。

Future RAT。Future RAT 维护推测状态下的逻辑寄存器到物理寄存器映射表。重命名级通过 3 个读端口查询源寄存器（rs1、rs2）与目的寄存器（rd）当前映射的物理寄存器号，随后从 FreeList 分配一个空闲物理寄存器作为 rd 的新映射，并将新映射写回 Future RAT。旧的 rd 映射（old\_prd）随指令一同写入 ROB，供提交时释放。

Arch RAT。Arch RAT 维护已提交的确定性映射。每当指令提交时，CommitStage 将该指令的逻辑目的寄存器与新物理寄存器映射写入 Arch RAT，并将 old\_prd 归还 FreeList。Arch RAT 始终反映最近一次已提交指令的寄存器状态。

FreeList。FreeList 管理空闲物理寄存器池。重命名级从中分配新物理寄存器，提交级向其归还不再需要的物理寄存器。归还的依据是：当一个逻辑寄存器被后续指令重新定义（即发生 WAW）时，承载旧值的物理寄存器的生命周期随之结束，可以被安全释放。以如下指令序列为例：

#align(center)[
  #table(
    columns: 4,
    align: center,
    table.header([指令], [逻辑 rd], [分配 prd], [old\_prd]),
    [ADD x1, x2, x3], [x1], [p10], [p1],
    [SUB x1, x4, x5], [x1], [p11], [p10],
  )
]

ADD 将 x1 的映射从 p1 更新为 p10，此时 p1 成为 old\_prd。当 ADD 提交时，p1 承载的旧值已无任何指令需要读取（后续所有引用 x1 的指令都将读到 p10 或更新的映射），因此 p1 可以归还 FreeList。同理，当 SUB 提交时，x1 的映射再次更新为 p11，p10 的生命周期结束并被归还。通过这一机制，物理寄存器的分配与回收严格跟随逻辑寄存器的定义链，保证了在任意时刻每个"活跃值"都独占一个物理寄存器，不会出现数据覆盖。当发生 flush 时，FreeList 根据 Arch RAT 快照重建：凡不在 Arch RAT 映射中的物理寄存器均标记为空闲，一拍即可完成恢复。

BusyTable。BusyTable 记录每个物理寄存器的数据就绪状态。重命名级在分配新物理寄存器时将其标记为 busy；当结果产生时通过 wakeup 信号清除 busy 标记。发射队列在发射前查询 BusyTable 以判断源操作数是否就绪。BusyTable 配置 6 个读端口供三个发射队列使用（每队列 2 个，对应 rs1 和 rs2），5 个 wakeup 端口对应三类时机：（1）分派级即时唤醒——LUI、AUIPC、JAL、JALR 等指令的结果仅依赖 PC 与立即数，在分派级即可计算并写入 PRF，同时发出 wakeup；（2）执行完毕唤醒——ALU 与 MDU 执行单元写回结果时发出 wakeup；（3）延迟执行完毕唤醒——LSU 与 CSRU 在 ROB 调度下完成延迟执行并写回 PRF 后发出 wakeup。三类唤醒覆盖了指令生命周期中所有可能产生结果的阶段，使后续依赖指令能尽早感知操作数就绪并被发射。

Flush 恢复机制。当后端检测到分支预测错误或异常时，flush 信号同时送往 ROB、FreeList、BusyTable、FutureRAT 以及所有发射队列。FutureRAT 从 Arch RAT 的快照一拍恢复到已提交状态的映射；FreeList 同样根据 Arch RAT 快照重建空闲池。由于 Arch RAT 在提交时同步更新，其内容始终正确，因此恢复过程无需遍历 ROB，仅需一个周期。

== 分派级

分派级位于重命名级之后，负责将已完成寄存器重命名的微操作分发到对应的执行资源。分派级执行以下操作：

+ 将指令写入 ROB，获取 ROB 标签（rob\_tag）作为指令在乱序流水线中的唯一标识。
+ 根据指令类型将指令分派到对应的发射队列：ALU 类指令进入 ALU IQ、乘除法指令进入 MDU IQ、 分支指令进入 BRU IQ。
+ 对于结果可在分派级直接确定的指令——JAL、JALR、LUI 与 AUIPC——分派级直接将计算结果写入 PRF 并发出 wakeup 信号，无需经过执行单元。这些指令的结果（链接地址 pc+4 或立即数加载值）仅依赖 PC 与立即数，在译码后即可获得，提前写回可减少后续依赖指令的等待周期。
+ 对于访存指令与 CSR 指令，采用保守的延迟执行策略：分派级仅将其写入 ROB，不送入发射队列，待指令到达 ROB 提交头部时再交由 LSU 或 CSRU 执行。访存指令的延迟执行避免了推测路径上的 Store 对内存状态造成不可撤销的副作用，简化了存储一致性维护；CSR 指令的延迟执行保证了特权级切换、中断使能等副作用严格按程序顺序生效，防止推测执行引发错误的系统状态变更。

== 发射队列与乱序发射

后端设置三个独立的发射队列，分别服务于 ALU、MDU 和 BRU 执行单元。在实现层面，得益于 Chisel 作为 Scala 嵌入式 DSL 的语言特性，发射队列采用泛型抽象类设计：

#code-figure(
  ```scala
  abstract class IssueQueue[T <: Data]
    (gen: T, val entries: Int)
    extends NPCModule {
      ...
    }
  ```,
  caption: [泛型发射队列抽象类定义],
  supplement: [代码],
  label-name: "issue-queue-abs",
)

三个发射队列共享相同的入队、就绪检测与发射选择逻辑，唯一的差异在于类型参数 `gen` 所携带的附加数据——例如 ALU 发射队列的 `gen` 包含立即数与 ALU 操作码字段，而 BRU 和 MDU 的 `gen` 则不含立即数。通过 Scala 的参数化类型，三个队列复用同一套核心实现，仅在类型层面区分载荷内容，避免了重复代码。同时，`abstract class` 的设计允许派生出不同复杂度的具体实现：简单实现采用固定槽位逐项扫描，复杂实现可引入压缩表项（compacting entry）以在指令发射后自动前移后续表项、提高槽位利用率，两者对外接口完全一致，便于在面积与时序之间灵活权衡。

每个发射队列在入队时记录指令的源物理寄存器号与 ROB 标签，在发射前通过 BusyTable 的读端口查询两个源操作数的就绪状态。当源操作数全部就绪时，指令即可被选中发射。由于多条指令可能同时就绪，发射队列内部通过优先级编码器选择最早入队的指令发射，保证公平性。

wakeup 机制是乱序发射的关键驱动力。后端共有 5 个 wakeup 源：ALU 写回、MDU 写回、分派级立即数写入、LSU 写回与 CSRU 写回。当任一执行路径产生结果时，对应的 wakeup 信号广播到 BusyTable，将目的物理寄存器标记为就绪。发射队列在下一周期即可感知新的就绪状态并发射等待该操作数的指令，形成"执行—唤醒—发射"的连锁反应。

== 执行单元

后端包含五条执行路径，各路径独立运行，互不阻塞。与发射队列的设计思路类似，执行单元同样抽象出统一的泛型接口：

#code-figure(
  ```scala
  abstract class ExecUnit[I <: Data, O <: Data](
    inGen: I, outGen: O, numReadPorts: Int = 2
  ) extends NPCModule {
    val prs1 = IO(Input(UInt(NRPhyRegBits.W)))
    val prs2 = IO(Input(UInt(NRPhyRegBits.W)))
    val prf  = IO(Vec(numReadPorts, new PRFReadPort))
    val io = IO(new Bundle {
      val in  = Flipped(Decoupled(inGen))
      val out = Decoupled(outGen)
    })
  }
  ```,
  caption: [执行单元抽象基类定义],
  supplement: [代码],
  label-name: "exec-unit-abs",
)

`ExecUnit` 通过类型参数 `I` 和 `O` 分别参数化输入载荷与输出载荷，所有执行单元共享统一的 PRF 读端口接口（`prs1`、`prs2`、`prf`）与 Decoupled 握手协议（`io.in` / `io.out`）。ALU、MDU 与 BRU 继承该抽象类并特化各自的输入输出类型：ALU 的输入包含 ALU 操作码、立即数与立即数选择标志，输出包含运算结果与目的物理寄存器号；MDU 的输入包含 MDU 操作码，输出结构与 ALU 相同；BRU 的输入仅包含分支操作码，输出为分支结果标志（br\_flag）。这一设计使后端连线层可以统一处理发射队列到执行单元的对接逻辑，同时各执行单元内部实现完全独立。

ALU 路径。处理整数算术逻辑运算（加减、移位、比较、逻辑运算等）。ALU 为单周期执行，从 ALU IQ 发射后经 PRF 读取源操作数、执行运算、写回 PRF 并向 ROB 报告完成，同时发出 wakeup。

MDU 路径。处理乘法与除法运算。MDU 执行延迟不固定（乘法与除法周期数不同），通过 valid/ready 握手协议与发射队列和 ROB 交互。写回逻辑与 ALU 路径相同。

BRU 路径。处理条件分支指令的实际比较。BRU 从 BRU IQ 发射后读取源操作数并计算分支条件（br\_flag），将结果报告给 ROB。BRU 不写 PRF——条件分支指令无目的寄存器。

== 延迟执行单元 <sec:late-exec>

与通过发射队列乱序发射的 ALU/MDU/BRU 不同，LSU 与 CSRU 采用延迟执行（late execution）模式：指令在分派时仅写入 ROB，待到达 ROB 提交头部时才交付执行。延迟执行单元同样抽象出统一的泛型基类：

#code-figure(
  ```scala
  abstract class LateExecUnit[T <: Data](
    gen: => T, numReadPorts: Int
  ) extends NPCModule {
    val late = IO(Flipped(ReqDone(gen)))
    val prf  = IO(Vec(numReadPorts, new PRFReadPort))
  }
  ```,
  caption: [延迟执行单元抽象基类定义],
  supplement: [代码],
  label-name: "late-exec-abs",
)

`LateExecUnit` 通过类型参数 `T` 参数化 ROB 传入的请求载荷，`late` 端口采用 `ReqDone` 握手协议（ROB 发起请求、执行单元返回完成），`prf` 提供 PRF 读端口用于读取源操作数。LSU 与 CSRU 继承该基类并特化各自的请求类型与读端口数量。

LSU 路径。处理 Load/Store 指令。ROB 将访存指令送至提交头部后通过 `late` 端口交给 LSU，确保访存操作按程序顺序执行，简化了存储一致性维护。LSU 内部连接 DCache 与外设端口，并集成 dTLB 与 PTW 以支持 Sv39 地址翻译。LSU 写回通过独立的 PRF 写端口与 wakeup 通路完成。

CSRU 路径。处理 CSR 读写指令。与 LSU 类似，由 ROB 在提交阶段通过 `late` 端口交给 CSRU 执行，保证 CSR 操作的顺序语义。CSRU 同时负责中断与异常的状态管理，包括 trap 入口计算、mret/sret 返回地址提供、中断挂起检测等。

== 提交级

提交级（CommitStage）从 ROB 头部按程序顺序逐条提交指令，是乱序执行恢复顺序语义的关键环节。提交时执行以下操作：

\1. 将指令的目的逻辑寄存器与新物理寄存器映射写入 Arch RAT，使确定性状态前进。

\2. 将旧物理寄存器号（old\_prd）归还 FreeList，供后续指令重命名时分配。

\3. 检查异常与中断：若提交头部的指令携带异常标记（如 page fault、非法指令）或检测到中断挂起，CommitStage 触发 trap 流程，通过 CSRU 获取 trap 入口地址，生成 redirect 信号指向异常处理程序，并发出 flush 清空流水线。

\4. 处理 mret/sret 返回：提交 mret 或 sret 指令时，从 CSRU 读取 mepc 或 sepc 作为 redirect 目标。

\5. 处理 fence.i 与 sfence.vma：提交这两类指令时，分别向外输出 fence\_i 和 sfence\_vma 信号，通知 ICache 失效或 TLB 刷新。

\6. 分支验证：对于条件分支指令，将 BRU 写回的实际跳转结果与前端预测进行比对。若预测错误，生成 redirect 信号携带正确的目标地址与分支信息，同时发出 flush。

\7. 调试探针（probe）：提交时输出指令的 PC、下一条 PC、指令字、通用寄存器（GPR, General Purpose Register）状态与 CSR 状态等信息，供 DiffTest 框架与参考模型逐条比对，实现运行时正确性验证。

== 本章小结

本章介绍了后端乱序执行引擎的设计。后端采用译码、重命名、分派、发射、执行、写回、（晚执行）、提交的经典乱序流水线结构，通过统一物理寄存器文件与 FutureRAT/ArchRAT 双映射表实现寄存器重命名，消除 WAW 与 WAR 假依赖。五条独立执行路径（ALU、MDU、BRU、LSU、CSRU）并行运行，其中 ALU/MDU/BRU 通过发射队列乱序发射，LSU 与 CSRU 通过 ROB 延迟执行以保证顺序语义。提交级按序提交并处理异常、中断、分支验证与调试输出。flush 恢复仅需一周期，利用 ArchRAT 快照同时重建 FutureRAT 与 FreeList。

= RISC-V 特权级架构

本章介绍处理器的特权级架构、精确异常与中断机制的设计与实现。实现主要参考 RISC-V 特权级规范 #cite(<riscv2024priv>)、监督二进制接口（SBI, Supervisor Binary Interface）规范 #cite(<riscv2024sbi>) 以及 PLIC #cite(<riscv2024plic>) 与 CLINT 规范手册 #cite(<sifive2024interrupt>)。

== M/S/U 三级特权架构

处理器实现了 RISC-V 规范定义的三级特权模式：M-mode（机器模式）、S-mode（监管模式）与 U-mode（用户模式）。当前特权级由 CSRU 内部的 `priv` 寄存器维护，上电复位后初始化为 M-mode。特权级的切换由两类事件驱动：

+ 陷入（Trap）：异常或中断发生时，处理器根据委托寄存器（medeleg/mideleg）决定陷入到 M-mode 还是 S-mode，并将当前特权级保存到 mstatus 的 MPP 或 SPP 字段。
+ 返回（xRET）：执行 mret 时从 mstatus.MPP 恢复特权级；执行 sret 时从 mstatus.SPP 恢复特权级。

@fig:priv-fsm 展示了 M/S/U 三级特权模式之间的完整转换关系。

#[
  #import "@preview/diagraph:0.3.6": *

  #figure(
    render(
      "
      digraph Priv {
        rankdir=LR;

        U [label=\"U-mode\"];
        S [label=\"S-mode\"];
        M [label=\"M-mode\"];

        U -> S [label=\"trap\\n(delegated)\"];
        U -> M [label=\"trap\\n(not delegated)\"];
        S -> M [label=\"trap\\n(not delegated)\"];
        S -> S [label=\"trap\\n(delegated)\"];
        M -> M [label=\"trap\"];
        S -> U [label=\"sret\\n(SPP=U)\"];
        M -> S [label=\"mret\\n(MPP=S)\"];
        M -> U [label=\"mret\\n(MPP=U)\"];
        M -> M [label=\"mret\\n(MPP=M)\"];
        S -> S [label=\"sret\\n(SPP=S)\"];
      }
    ",
    ),
    caption: [M/S/U 特权级状态机],
    supplement: [图],
  ) <priv-fsm>
]

通过委托(delegate)机制，操作系统可在 S-mode 直接处理用户态的系统调用与页错误等常见异常，无需经过 M-mode 中转，降低了 trap 延迟。

== CSR 寄存器文件

CSRU 内部实现了完整的 M-mode 与 S-mode CSR 寄存器集合：

#align(center)[
  #table(
    columns: 3,
    align: (center, left, left),
    table.header([模式], [寄存器], [功能]),
    [M], [mstatus, mtvec, mepc, mcause, mtval], [状态、陷入入口、异常现场],
    [M], [medeleg, mideleg], [异常/中断委托],
    [M], [mie, mip], [中断使能与挂起],
    [M], [mscratch, menvcfg, mcounteren], [暂存、环境配置、计数器访问],
    [M], [pmpcfg0, pmpaddr0], [物理内存保护],
    [M], [mvendorid, marchid, mhartid, misa], [只读标识（RV64IMASU）],
    [S], [sstatus, stvec, sepc, scause, stval], [S-mode 状态与陷入现场],
    [S], [sie, sip, sscratch, satp], [中断使能、暂存、页表基址],
    [S], [stimecmp], [S-mode 定时器比较值],
  )
]

其中 sstatus、sie 与 sip 并非独立寄存器，而是 mstatus、mie 与 mip 的掩码视图（masked view）。例如 sstatus 的读取值为 `mstatus & SSTATUS_MASK`，写入时仅修改掩码对应位，其余位保持不变。这一设计与 RISC-V 规范一致，避免了 M/S 两级寄存器状态的冗余与不一致。

CSR 指令支持三种操作类型：CSRRW（读后写）、CSRRS（读后置位）与 CSRRC（读后清零），写入数据分别为 `wdata`、`csr_read | wdata`、`csr_read & ~wdata`。

== 精确异常

本项目通过 ROB 顺序提交机制实现精确异常。异常在流水线各阶段被检测后，仅在对应指令的 ROB 表项中标记异常类型（mcause）与辅助信息（mtval），不立即影响处理器状态。当该指令到达 ROB 提交头部时，CommitStage 检查异常标记并触发 trap 流程：

+ CommitStage 根据当前特权级确定 ECALL 的实际异常号（U-mode → 8，S-mode → 9，M-mode → 11），其他异常类型直接使用译码级标记的 mcause。
+ CSRU 根据异常号查询 medeleg 判断是否委托给 S-mode：若 `medeleg` 对应位为 1 且当前特权级不高于 S-mode，则陷入 S-mode（写 scause/sepc/stval，目标地址取 stvec）；否则陷入 M-mode（写 mcause/mepc/mtval，目标地址取 mtvec）。
+ 陷入时更新 mstatus：保存当前特权级到 MPP/SPP，保存当前中断使能位到 MPIE/SPIE，关闭中断使能（MIE/SIE 置零），切换到目标特权级。
+ CommitStage 生成 flush 信号清空流水线，redirect 指向 trap 入口地址。

由于异常处理严格在提交点进行，推测路径上的指令不会修改任何体系结构状态，因此异常对程序员始终表现为在触发异常的指令处精确发生。

== 中断机制

=== 中断源与挂起检测

处理器支持两类中断源：

外部中断。外设（如 UART）产生的中断信号经 PLIC（Platform-Level Interrupt Controller）仲裁后，以 `ext_irq` 信号送入 CSRU，映射到 mip 的 SEIP 位（bit 9）。中断流为：外设 → PLIC → ext\_irq → mip.SEIP。

定时器中断。CLINT（Core-Local Interruptor）维护全局计时器 mtime，CSRU 将 mtime 与 S-mode 定时器比较寄存器 stimecmp 比较，当 `mtime >= stimecmp` 时置位 mip 的 STIP 位（bit 5）。

软件中断。通过软件写 sip 寄存器的 SSIP 位（bit 1）触发。

=== 中断使能与委托

中断的最终挂起状态由三个因素共同决定：mip（硬件挂起）、mie（使能掩码）与 mideleg（委托掩码）。CSRU 将中断分为两组计算：

- M-mode 中断：`m_interrupts = mip & mie & ~mideleg`（未委托的中断）
- S-mode 中断：`s_interrupts = mip & mie & mideleg`（已委托给 S-mode 的中断）

中断是否可响应还取决于当前特权级与全局中断使能位：M-mode 中断仅在 `priv < M` 或 `(priv == M && mstatus.MIE)` 时可响应；S-mode 中断仅在 `priv < S` 或 `(priv == S && mstatus.SIE)` 时可响应。

=== 中断注入与优先级

中断的注入发生在 CommitStage：当 ROB 头部指令正常提交（无异常）且 CSRU 报告 `interrupt_pending` 为真时，CommitStage 先正常提交当前指令（更新 ArchRAT、释放 old\_prd），随后立即触发中断 trap。中断的 epc 设置为当前提交指令的下一条 PC（retiring\_dnpc），使中断返回后可从正确位置继续执行。

中断优先级遵循 RISC-V 规范：M-mode 中断优先于 S-mode 中断；同一模式内优先级为 MEI > MSI > MTI > SEI > SSI > STI。CSRU 通过 `MuxCase` 按优先级选择最高优先级的中断源，并输出对应的 cause 与 trap 目标地址。

=== MRET 与 SRET

mret 与 sret 指令在提交时触发特权级恢复：

- mret：从 mstatus.MPP 恢复特权级，将 mstatus.MPIE 恢复到 MIE，MPIE 置 1，MPP 清零，redirect 指向 mepc。
- sret：从 mstatus.SPP 恢复特权级，将 mstatus.SPIE 恢复到 SIE，SPIE 置 1，SPP 清零，redirect 指向 sepc。

== Sv39 虚拟内存与内存管理单元

本项目实现了 RISC-V Sv39 虚拟内存方案。Sv39 将 64 位虚拟地址的低 39 位划分为三级页号（VPN[2:0]，每级 9 位）与 12 位页内偏移，通过三级页表将虚拟页号翻译为 44 位物理页号（PPN）。当 satp 寄存器的 MODE 字段为 8 时启用 Sv39，satp.PPN 指向根页表的物理基地址。

内存管理单元由 TLB（Translation Lookaside Buffer）与 PTW（Page Table Walker）两个模块组成，IFU 与 LSU 各自实例化一套独立的 iTLB+PTW 和 dTLB+PTW，分别服务于取指地址翻译与访存地址翻译。两套 MMU 在结构上完全相同，仅在权限检查的具体位（IFU 检查 PTE.X，LSU 检查 PTE.R/PTE.W）上有所区别。

=== TLB 设计

TLB 采用 16 项全相联结构，以 VPN（27 位）作为 tag 进行匹配查询。查询时对所有表项并行比较，通过优先级编码器选中命中项，返回对应的 PPN 与页表标志位（flags）。sfence.vma 指令执行时，通过 flush 信号一次性失效全部表项。

TLB 的替换策略采用位矩阵 LRU（Bit-Matrix LRU）算法。该算法使用一个 N×N 的位矩阵 M 记录表项间的访问先后关系：M[i][j] = 1 表示表项 i 比表项 j 更近被访问。当访问表项 k 时，将第 k 行全部置 1、第 k 列全部置 0，表示 k 成为最近访问项。需要淘汰时，选择行向量全为 0 的表项（即比所有其他表项都更早被访问的项）作为替换目标。算法伪代码如下：

#code-figure(
  ```python
  # 访问表项 k 时更新矩阵
  def access(M, k, N):
      for j in range(N):
          M[k][j] = 1   # 第 k 行全部置 1
      for i in range(N):
          M[i][k] = 0   # 第 k 列全部置 0

  # 选择 LRU 表项（行全零）
  def find_lru(M, N):
      for i in range(N):
          if all(M[i][j] == 0 for j in range(N)):
              return i
  ```,
  caption: [位矩阵 LRU 替换算法伪代码],
  supplement: [代码],
  label-name: "bit-matrix-lru",
)

位矩阵 LRU 的硬件实现仅需 N×(N-1)/2 个触发器（矩阵对角线恒为 0 且 M[i][j] = !M[j][i]，实际只需存储上三角），访问更新与 LRU 查询均可在单周期内完成，适合全相联结构的小容量 TLB。

=== PTW 设计

PTW 负责在 TLB 缺失时遍历内存中的三级页表。PTW 采用九状态有限状态机实现：

#figure(
  image("images/ptw-fsm.drawio.png", width: 78%),
  caption: [PTW 页表遍历状态机],
  supplement: [图],
) <ptw-fsm>

如 @fig:ptw-fsm 所示，PTW 从 idle 状态接受请求后，依次访问第 2 级、第 1 级与第 0 级页表项。每一级的访问地址由上一级 PTE 中的 PPN 拼接当前级的 VPN 索引与 3 位字节偏移构成（每个 PTE 为 8 字节）。每级读取 PTE 后检查有效位（PTE.V）：若无效则进入 fault 状态报告页错误；若有效则继续下一级。第 0 级还额外检查权限合法性（不允许 !R && W 的非法编码）。遍历成功后进入 done 状态，输出叶子 PTE 的 PPN 与 flags 供 TLB refill 使用。

=== IFU 中的地址翻译

IFU 的取指流水线中集成了 iTLB 查询与 PTW 调用（详见 @sec:ifu-pipeline）。在 F1（iTLB Lookup）阶段：若 Sv39 未启用则直接使用虚拟地址作为物理地址；若 iTLB 命中则检查 PTE.X（执行权限），权限合法则使用翻译后的物理地址进入 F2 的 ICache 访问，权限不合法则标记 instruction page fault（mcause = 12）；若 iTLB 缺失则启动 PTW 遍历页表，PTW 完成后 refill iTLB 并在 F1 重新查询。这一"乐观路径先查 TLB、悲观路径回退到 PTW"的设计使得 TLB 命中时无额外延迟，TLB 缺失的代价由 PTW 的三次内存访问决定。

=== LSU 中的地址翻译

LSU 的访存状态机采用与 IFU 相同的 TLB 优先策略：

#[
  #import "@preview/diagraph:0.3.6": *

  #figure(
    scale(
      75%,
      render(
        "
        digraph LSU {
          rankdir=LR;
          node [shape=ellipse, fontsize=9];
          edge [fontsize=8];

          idle [label=\"idle\"];
          tlb [label=\"tlb_check\"];
          ptw_req [label=\"ptw_req\"];
          ptw_wait [label=\"ptw_wait\"];
          lsu_req [label=\"lsu_req\"];
          lsu_wait [label=\"lsu_wait\"];

          idle -> tlb [label=\"Sv39 on\"];
          idle -> lsu_req [label=\"Sv39 off\"];
          tlb -> lsu_req [label=\"TLB hit\\n& access ok\"];
          tlb -> idle [label=\"page fault\"];
          tlb -> ptw_req [label=\"TLB miss\"];
          ptw_req -> ptw_wait [label=\"PTW fire\"];
          ptw_wait -> idle [label=\"PTW fault\"];
          ptw_wait -> tlb [label=\"PTW done\\n(refill dTLB)\"];
          lsu_req -> lsu_wait [label=\"ack &\\n!done\"];
          lsu_req -> idle [label=\"ack & done\"];
          lsu_wait -> idle [label=\"done\"];
        }
      ",
      ),
    ),
    caption: [LSU 访存状态机（含地址翻译）],
    supplement: [图],
  ) <lsu-fsm>
]

如 @fig:lsu-fsm 所示，ROB 发起访存请求后，LSU 首先判断 Sv39 是否启用。若未启用则直接使用虚拟地址进入 lsu\_req 访问 DCache 或外设端口；若启用则进入 tlb\_check 查询 dTLB。dTLB 命中时检查权限：Load 指令检查 PTE.R，Store 指令检查 PTE.W，权限不合法则报告 load page fault（mcause = 13）或 store page fault（mcause = 15）并回到 idle。权限合法则将翻译后的物理地址锁存到 `pa` 寄存器，进入 lsu\_req。dTLB 缺失时启动 PTW，PTW 完成后 refill dTLB 并回到 tlb\_check 重新查询。

lsu\_req 状态根据地址映射判断访问目标：若地址属于内存映射 I/O（MMIO, Memory-Mapped I/O）区域则通过外设端口（perip）访问，否则通过 DCache 端口访问。两条路径共享相同的握手逻辑：单周期完成时直接返回 idle，否则进入 lsu\_wait 等待数据就绪。Load 指令的返回数据根据访问宽度（byte/half/word/double）与符号扩展标志进行对齐提取与扩展后写回 PRF。

== 本章小结

本章介绍了 RISC-V M/S/U 三级特权架构、CSR 寄存器文件、精确异常、中断机制与 Sv39 虚拟内存的设计与实现。精确异常通过 ROB 顺序提交保证，异常仅在提交点生效；中断通过 CSRU 的挂起检测与 CommitStage 的注入机制实现，支持外部中断（PLIC）、定时器中断（CLINT/stimecmp）与软件中断三类来源，并通过 medeleg/mideleg 实现异常与中断的 M/S 两级委托。Sv39 虚拟内存由 TLB 与 PTW 两个模块实现，IFU 与 LSU 各自拥有独立的 iTLB/dTLB 与 PTW，采用"乐观路径先查 TLB、悲观路径回退到 PTW"的设计，在 TLB 命中时无额外延迟。

= 缓存设计

== 类 SRAM 总线协议

处理器核心（IFU、LSU）与缓存之间的交互采用自定义的类 SRAM（SRAM-like）总线协议，而非直接使用 AXI4 #cite(<arm2020axi4>) 等复杂片上总线。这一设计的出发点是降低处理器核心侧的接口复杂度：AXI4 协议包含 5 个独立通道（AR、AW、W、R、B）与多种突发传输模式，对于处理器核心每次仅发起单拍读写的场景过于冗余；而类 SRAM 协议将读写统一到一组信号上，核心侧仅需驱动一个请求端口即可完成访存操作。

#code-figure(
  ```scala
  class SRAMBundle(val params: SRAMBundleParameters) extends Bundle {
    val req   = Output(Bool())     // 请求有效
    val wen   = Output(Bool())     // 写使能（0=读，1=写）
    val size  = Output(UInt(...))  // 访问宽度
    val addr  = Output(UInt(...))  // 地址
    val wstrb = Output(UInt(...))  // 写字节掩码
    val wdata = Output(UInt(...))  // 写数据
    val ack   = Input(Bool())      // 请求被接受
    val done  = Input(Bool())      // 数据就绪 / 写完成
    val rdata = Input(UInt(...))   // 读数据
  }
  ```,
  caption: [类 SRAM 总线接口定义],
  supplement: [代码],
  label-name: "sram-bundle",
)

协议采用 req → ack → done 三阶段握手。@fig:sram-read 与 @fig:sram-write 分别展示了一次读事务与一次写事务的时序波形。

#[
  #import "@preview/wavy:0.1.3"

  #figure(
    wavy.render(
      "
    {signal: [
      {name: 'clk',   wave: 'p........'},
      {name: 'req',   wave: '01.0.....'},
      {name: 'wen',   wave: 'x0.x.....'},
      {name: 'size',  wave: 'x3.x.....', data: ['2\\'b01']},
      {name: 'addr',  wave: 'x3.x.....', data: ['addr(A)']},
      {name: 'ack',   wave: '0.10.....'},
      {name: 'done',  wave: '0....10..'},
      {name: 'rdata', wave: 'x....3x..', data: ['data(A)']}
    ],
    }
  ",
    ),
    caption: [类 SRAM 总线上的一次读事务],
    supplement: [图],
  ) <sram-read>

  #figure(
    wavy.render(
      "
    {signal: [
      {name: 'clk',   wave: 'p........'},
      {name: 'req',   wave: '01.0.....'},
      {name: 'wen',   wave: 'x1.x.....'},
      {name: 'size',  wave: 'x3.x.....', data: ['2\\'b00']},
      {name: 'addr',  wave: 'x3.x.....', data: ['addr(B)']},
      {name: 'wdata', wave: 'x3.x.....', data: ['data(B)']},
      {name: 'ack',   wave: '0.10.....'},
      {name: 'done',  wave: '0....10..'},
      {name: 'rdata', wave: 'x........'}
    ],
    }
  ",
    ),
    caption: [类 SRAM 总线上的一次写事务],
    supplement: [图],
  ) <sram-write>
]

如 @fig:sram-read 所示，主设备发起读请求时拉高 req 并驱动 addr、wen=0、size 等信号，req 持续保持高电平直到从设备拉高 ack，此时两者同时拉低，完成一次请求握手（req-ack）。随后从设备在数据就绪时拉高 done 并在 rdata 上输出有效数据，完成数据响应。写事务（@fig:sram-write）的握手流程与读事务相同，区别在于 wen=1 且主设备额外驱动 wdata 与 wstrb。

该协议的核心设计在于将 req-ack 请求握手与 done 数据响应分离为两个独立阶段。这一分离带来两方面优势：

+ 避免复杂协议。处理器核心与 L1 Cache 之间无需使用 AXI4 的五通道握手协议，仅需驱动 req 和检测 ack/done 两对信号，显著降低了核心侧的接口复杂度与控制逻辑面积。
+ 保持流水能力。对于读操作，地址阶段（req-ack）与数据阶段（done）天然分离：ack 返回后地址已被缓存锁存，核心状态机可提前进入等待数据状态。当缓存命中时，ack 与 done 可在同一周期返回，实现单周期完成；当缓存缺失时，ack 先返回表示请求已接受，done 在缓存行填充完成后延迟返回。核心侧状态机无需区分命中与缺失，统一以"等待 done"收束。

=== Diplomacy 参数协商

为使类 SRAM 总线能够融入 Rocket Chip #cite(<asanovic2016rocket>) 的 Diplomacy 参数协商框架，本项目为其实现了完整的节点体系。Diplomacy 框架的核心思想是：总线参数（地址宽度、数据宽度、地址映射等）不在模块实例化时硬编码，而是由连接图中的上下游节点在编译期自动协商确定。

具体实现包括：`SRAMMasterPortParameters` 与 `SRAMSlavePortParameters` 描述主从端口的参数约束（地址范围、数据位宽等）；`SRAMEdgeParameters` 在连接建立时由框架自动生成，包含协商后的 `SRAMBundleParameters`；`SRAMImp` 实现 `SimpleNodeImp` 接口，定义参数协商规则与硬件 Bundle 生成逻辑。在此基础上派生出 `SRAMMasterNode`、`SRAMSlaveNode`、`SRAMNexusNode` 与 `SRAMIdentityNode`，分别用于源节点、汇节点、多端口汇聚与透传场景。

=== SRAMToAXI4 桥接与缓存的双面接口

类 SRAM 协议服务于处理器核心侧，而 SoC 互连采用 AXI4 协议，因此需要在两者之间进行协议转换。本项目实现了通用的 `SRAMToAXI4` 桥接模块，用于不经过缓存的直通路径（如外设端口）。桥接模块内部采用五状态 FSM（idle → readAddr → readData / write → writeResp），将 SRAM 的单拍读写映射为 AXI4 的单拍突发传输（len=0）。该模块基于 Diplomacy 的 `MixedAdapterNode` 实现，上游为 SRAM 节点、下游为 AXI4 节点，参数在连接时自动转换。

ICache 与 DCache 本身也充当协议桥接的角色：面向处理器核心暴露类 SRAM 接口，接收单拍读写请求；面向 SoC 互连则通过 AXI4 接口与下级存储交互。缓存缺失时，缓存控制器通过 AXI4 Burst 传输（len > 0）从主存读取整条缓存行完成 refill；写回脏行时同样通过 AXI4 Burst 将整条缓存行写回主存。这一设计使处理器核心始终面对简洁的类 SRAM 接口，缓存内部负责单拍请求与突发传输之间的转换。

== PLRU 替换策略

ICache 与 DCache 均为 4 路组相联结构（64 组，每组 4 路，缓存行 64 字节）。替换策略采用伪 LRU（Pseudo-LRU, PLRU）算法 #cite(<belady1966replacement>)，以较低的硬件开销近似 LRU 行为。

PLRU 使用一棵 $n-1$ 个节点的二叉树（4 路对应 3 个节点）记录访问方向。每个节点存储 1 位标志，指向"最近较少使用"的子树方向。如 @fig:plru 所示，树的叶子节点对应 4 条缓存路，内部节点的标志位在每次访问时更新为指向另一侧，使得沿标志位路径走到的叶子即为待替换的路。

#figure(
  image("images/plru.png", width: 75%),
  caption: [4 路 Pseudo-LRU 二叉树结构示意],
  supplement: [图],
) <plru>

#code-figure(
  ```python
  def plru_access(tree: list[int], way: int):
      """访问 way 后更新 PLRU 树节点，使其指向远离被访问路的方向"""
      tree[0] = 1 if way in (0, 1) else 0  # 根节点
      tree[1 + way // 2] = 1 if way in (0, 2) else 0  # 子节点
  ```,
  caption: [PLRU 访问更新],
  supplement: [代码],
  label-name: "plru-access",
) <plru-access>

#code-figure(
  ```python
  def plru_victim(tree: list[int]) -> int:
      """沿树节点标志位从根到叶，返回待替换的路号"""
      if tree[0] == 0:  # go left
          return 0 if tree[1] == 0 else 1
      else:             # go right
          return 2 if tree[2] == 0 else 3
  ```,
  caption: [PLRU 替换选择],
  supplement: [代码],
  label-name: "plru-victim",
) <plru-victim>

如 @lst:plru-access 所示，每次缓存命中时根据命中的路号更新树节点标志，使其指向远离被访问路的方向。如 @lst:plru-victim 所示，需要替换时沿树节点标志位从根到叶遍历，得到的叶子即为牺牲路。该算法仅需 3 位状态与简单的组合逻辑即可实现 4 路近似 LRU 替换，硬件开销远低于完整 LRU 所需的访问序记录。

== ICache <sec:icache-fsm>

ICache 采用 VIPT（Virtually Indexed, Physically Tagged）结构，64 组 x 4 路 x 64 字节缓存行，总容量 16 KB。面向处理器核心提供类 SRAM 只读接口，面向 SoC 互连通过 AXI4 接口进行 refill。ICache 为只读缓存，不涉及写操作与脏行管理。

#[
  #import "@preview/diagraph:0.3.6": *

  #figure(
    scale(
      75%,
      render(
        "
        digraph ICache {
          rankdir=LR;

          idle [label=\"idle\"];
          lookup [label=\"lookup\"];
          miss [label=\"miss\"];
          replace [label=\"replace\"];
          refill [label=\"refill\"];
          fence_drain [label=\"fence_drain\"];

          idle -> lookup [label=\"req & ack\"];
          lookup -> lookup [label=\"hit & new req\"];
          lookup -> idle [label=\"hit & no req\"];
          lookup -> miss [label=\"miss\"];
          miss -> replace;
          replace -> refill [label=\"AR fire\"];
          refill -> idle [label=\"R.last\\n(done)\"];

          lookup -> idle [label=\"fence_i\", style=\"dashed\"];
          miss -> idle [label=\"fence_i\", style=\"dashed\"];
          replace -> idle [label=\"fence_i &\\n!AR.fire\", style=\"dashed\"];
          replace -> fence_drain [label=\"fence_i &\\nAR.fire\", style=\"dashed\"];
          refill -> fence_drain [label=\"fence_i\", style=\"dashed\"];
          fence_drain -> idle [label=\"R.last\\n(no refill)\"];
        }
      ",
      ),
    ),
    caption: [ICache 主状态机（虚线为 fence.i 相关跃迁）],
    supplement: [图],
  ) <icache-fsm>
]

如 @fig:icache-fsm 所示，ICache 的主状态机在原先五个状态的基础上，为支持前端对 `fence.i` 的"零负担"设计额外引入了 `fence_drain` 状态，共六个状态：

+ idle：等待请求。收到 req 时锁存地址（拆分为 tag、index、beat 偏移），返回 ack 并进入 lookup。
+ lookup：用锁存的 tag 与 index 查询 tag RAM，4 路并行比较。若命中，直接从 data bank 读出目标 beat 的数据，返回 done 与 rdata。命中时若有新请求可直接锁存并停留在 lookup（lookup -> lookup 快速路径），实现连续命中的单周期吞吐。若缺失，记录 PLRU 选出的替换路号，进入 miss。
+ miss -> replace：miss 为单周期过渡状态。replace 状态向 AXI4 AR 通道发起突发读请求（len=7，8 拍 x 8 字节 = 64 字节），AR 握手成功后进入 refill。
+ refill：逐拍接收 AXI4 R 通道返回的数据并写入 data bank 对应路的各 beat。当接收到目标 beat 时额外锁存其数据。收到 R.last 后更新 tag RAM（写入新 tag、置 valid）、推进 PLRU 替换指针，返回 done 与 rdata，回到 idle。
+ fence_drain：专用于"AXI burst 已启动、但 fence.i 已到达"的中间状态。进入该状态后 ICache 仍以 `r.ready = 1` 接收 R 通道返回的全部 beat，但不再将数据回写到 tag RAM / data bank，也不推进 PLRU，直到 `r.last` 抵达后回到 idle。

围绕 `fence.i` 的处理贯穿了所有与总线相关的状态。当 `fence_i` 脉冲到达时，外层逻辑会在同一拍把 `tag_ram(*).valids` 全部清零——这使整个缓存在"语义"上立即变空。剩下的问题是如何与"已启动、无法撤销"的 AXI 事务共存：

+ 在 idle / lookup / miss 三个状态下，ICache 尚未在 AXI 上发起任何 AR 握手，因此 `fence_i` 到来时直接回到 idle；已失效的 tag RAM 保证下一次查询必然 miss 并重新从总线取指。
+ 在 replace 状态下，AR 通道的 `valid` 已经高起但是否握手取决于下游 `ready`。若 `fence_i` 与 `ar.fire` 恰好同拍，则本次 burst 已经不可撤销，必须跳入 `fence_drain` 把后续 R 拍全部吞掉；否则只需下一拍直接回 idle，AR 随之解挂。
+ 在 refill 状态下，AR 必然已经 fire、R 通道正在返回，此时 `fence_i` 强制进入 `fence_drain`。此外还存在一种极端时序：若 `fence_i` 与 `r.last` 同拍到达，常规 refill 路径会在本拍把该行写入 tag RAM 并置 valid；为此 FSM 在 `fence_i and state = refill` 时显式对该行 valid 位追加一次清零，凭借 Chisel 的 last-connect 语义覆盖正常路径的置位写入，避免单一行残留。

这样，无论 `fence.i` 在哪一个周期抵达，ICache 都能在至多一次额外 burst 的代价内回到"完全空缓存 + AXI 无事务"的干净状态，且整个过程不需要前端参与握手。前端因此可以对 `fence.i` 完全保持透明：它像普通指令一样被取到 F3、送入后端，由后端 CommitStage 在提交时统一发出 `fence_i` 脉冲与 `io.flush`，后者负责同周期清空整条取指流水。

== DCache

DCache 同样采用 VIPT 结构，64 组 x 4 路 x 64 字节缓存行，总容量 16 KB。与 ICache 的关键区别在于 DCache 需要处理写操作，采用写回（write-back）策略，并引入 Write Buffer 与脏行写回机制。

#[
  #import "@preview/diagraph:0.3.6": *

  #figure(
    scale(
      70%,
      render(
        "
        digraph DCache {
          rankdir=TB;

          idle [label=\"idle\"];
          lookup [label=\"lookup\"];
          miss [label=\"miss\"];
          replace [label=\"replace\\n(W burst + B + AR)\"];
          refill [label=\"refill\"];
          flush_scan [label=\"flush_scan\"];
          flush_wb [label=\"flush_wb\"];

          idle -> lookup [label=\"req & ack\"];
          idle -> flush_scan [label=\"fence_i /\\nsfence_vma\"];
          lookup -> lookup [label=\"hit & new req\"];
          lookup -> idle [label=\"hit & no req\"];
          lookup -> miss [label=\"miss\"];
          miss -> replace [label=\"dirty: AW fire\\nnot dirty: skip WB\"];
          replace -> refill [label=\"AR sent &\\nB received\"];
          refill -> idle [label=\"R.last (done)\"];
          flush_scan -> flush_wb [label=\"dirty line found\"];
          flush_scan -> flush_scan [label=\"clean line: next\"];
          flush_scan -> idle [label=\"scan complete\"];
          flush_wb -> flush_scan [label=\"WB done: next\"];
        }
      ",
      ),
    ),
    caption: [DCache 主状态机],
    supplement: [图],
  ) <dcache-fsm>
]

如 @fig:dcache-fsm 所示，DCache 的主状态机包含七个状态：

+ idle：等待请求。收到 fence.i 或 sfence.vma 时进入 flush 流程；正常请求时锁存地址与写控制信号（wen、wdata、wstrb），进入 lookup。
+ lookup：4 路并行比较。命中时：若为读操作直接返回数据；若为写操作触发 Write Buffer——将写入目标（index、way、beat、wstrb、wdata）送入单项 Write Buffer，在下一周期由 Write Buffer FSM 完成按字节掩码合并写入 data bank 并置脏位。Write Buffer 的引入使写命中不阻塞主 FSM，lookup 可立即接受下一请求。Write Buffer 还负责检测读写冲突：若新读请求与正在执行的 Write Buffer 写入地址重叠，则暂停接受请求直到 Write Buffer 完成。
+ miss：PLRU 选出替换路后，检查牺牲行是否为脏行。若脏则先通过 AXI4 AW 通道发起写回地址；若干净则跳过写回阶段。
+ replace：该状态并行处理三个子阶段——（1）通过 AXI4 W 通道逐拍写回脏行数据；（2）等待 AXI4 B 通道确认写回完成；（3）通过 AXI4 AR 通道发起 refill 读请求。当 AR 发送完毕且 B 确认收到后进入 refill。
+ refill：逐拍接收 R 通道数据写入 data bank。若原始请求为写操作，在目标 beat 位置将 refill 数据与写数据按字节掩码合并后写入。R.last 后更新 tag RAM（新 tag、valid、dirty 标志）、推进 PLRU 指针，返回 done 回到 idle。
+ flush\_scan -> flush\_wb：fence.i 或 sfence.vma 触发全缓存刷写。flush\_scan 逐组逐路扫描，遇到脏行则进入 flush\_wb 通过 AXI4 写回该行，写回完成后清除脏位并继续扫描，直到所有组路遍历完毕回到 idle。

== 指令-数据缓存一致性与 fence.i

在冯·诺依曼架构中，指令与数据共享同一地址空间；然而本处理器采用分离式 L1 缓存（ICache 与 DCache），二者之间不存在硬件一致性协议。这意味着当程序在运行时修改自身代码——即"自修改代码"（Self-Modifying Code）场景——时，ICache 与 DCache 之间会出现一致性问题。

一个典型的实例是 Bootloader 的快速启动路径：系统上电后，处理器从 XIP（Execute-In-Place）模式的 Flash 开始执行，Bootloader 将 Flash 中的应用程序映像搬运到 SDRAM 以获得更高的访问速度，随后跳转至 SDRAM 入口地址继续执行。其核心指令序列如下：

#align(center)[
  #table(
    columns: 2,
    align: (center, left),
    table.header([步骤], [指令]),
    [1], [`sw inst, 0(sdram_addr)` —— 将指令写入 SDRAM（经 DCache）],
    [2], [`j sdram_addr` —— 跳转至 SDRAM 入口执行],
  )
]

问题在于：步骤 1 的 `sw` 指令将数据写入 DCache（写回策略下，脏行尚未写回 SDRAM）；步骤 2 的跳转触发 IFU 从 `sdram_addr` 取指，而 IFU 只能访问 ICache 与下级存储，无法看到 DCache 中的脏数据。此时 ICache 未命中，从 SDRAM 读取到的仍是旧数据（全零或无效内容），导致处理器执行错误指令。

RISC-V 指令集架构通过 `fence.i` 指令显式解决这一问题。正确的指令序列应为：

#align(center)[
  #table(
    columns: 2,
    align: (center, left),
    table.header([步骤], [操作]),
    [1], [`sw inst, 0(sdram_addr)` —— 将指令写入 SDRAM（经 DCache）],
    [2], [`fence.i` —— 同步指令流与数据流],
    [3], [`j sdram_addr` —— 跳转至 SDRAM 入口执行],
  )
]

在本处理器的实现中，`fence.i` 的执行分为两个阶段：

+ DCache 刷写：DCache 进入 flush 流程（参见 @fig:dcache-fsm 中 flush\_scan $->$ flush\_wb 路径），逐组逐路扫描所有缓存行，将脏行通过 AXI4 写通道写回下级存储，确保所有已修改数据对外可见。
+ ICache 失效：DCache 刷写完成后，ICache 将全部缓存行的 valid 位清零，迫使后续取指请求从下级存储重新加载。

经过 `fence.i` 的两阶段处理，步骤 1 写入 DCache 的指令数据已安全落入 SDRAM，而 ICache 的全部内容已失效。当步骤 3 跳转到 `sdram_addr` 时，ICache 必然未命中，从 SDRAM 重新加载到正确的指令内容，程序得以正确执行。

需要指出的是，`fence.i` 是一条代价较高的指令：它要求刷写整个 DCache 并失效整个 ICache，开销与缓存容量成正比。RISC-V 规范将其定义为"Zifencei"扩展而非基础指令集的一部分，正是考虑到在多核系统中维护指令-数据一致性有更高效的硬件机制（如 RISC-V CMO 扩展）。在本处理器的单核场景下，`fence.i` 足以保证正确性，且实现简洁。

== 本章小结

本章围绕缓存子系统展开，首先介绍了面向处理器核心的类 SRAM 总线协议，其 req-ack-done 三信号握手机制在保持接口简洁的同时支持读地址与读数据的流水分离；随后描述了基于 Diplomacy 框架的参数协商与 SRAMToAXI4 总线桥的设计，使 ICache 与 DCache 对内呈现 SRAM 接口、对外通过 AXI4 Burst 完成 refill 与 writeback。在替换策略方面，采用 Pseudo-LRU 算法以 3 位状态实现 4 路近似最近最少使用替换，兼顾硬件面积与替换效果。ICache 采用六状态有限状态机实现只读缓存逻辑，其中专用的 `fence_drain` 状态将 `fence.i` 与 inflight 的 AXI burst 的收敛完全封闭在缓存内部，使前端不再需要为 `fence.i` 维护额外的握手或粘滞位；DCache 则通过七状态有限状态机支持写回策略、Write Buffer 优化及全缓存刷写。最后讨论了分离式 ICache 与 DCache 架构下的指令-数据一致性问题，说明了 `fence.i` 指令通过 DCache 刷写加 ICache 失效两阶段操作保证自修改代码的正确执行。

= 仿真平台

处理器设计的正确性高度依赖仿真验证。本章介绍基于 Verilator 与 C++20 构建的仿真平台，涵盖简易调试器、执行追踪、差分测试、快照回放及外设可视化等功能，为处理器开发全流程提供调试与验证支撑。

== 仿真平台整体架构

仿真平台以 C++20 编写，遵循 Google C++ Style Guide 编码规范，使用 CMake 构建系统管理依赖。整体架构如 @fig:sim-arch 所示，由以下核心组件构成：

#[
  #import "@preview/diagraph:0.3.6": *

  #figure(
    scale(
      75%,
      render(
        "digraph sim_arch {
          rankdir=TB
          node [shape=box, style=\"rounded,filled\" fontsize=10]

          subgraph cluster_top {
            label=\"仿真平台 (C++20)\"
            style=dashed

            main [label=\"main.cc\\n入口与配置\", fillcolor=\"#E3F2FD\"]
            sdb [label=\"Sdb\\n简易调试器\", fillcolor=\"#FFF3E0\"]
            scrbrd [label=\"ScoreBoard\\nDifftest 核心\", fillcolor=\"#FCE4EC\"]
            vcpu [label=\"VerilatorCpu\\nDUT 驱动\", fillcolor=\"#E8F5E9\"]
            spike [label=\"SpikeCpu\\n参考模型\", fillcolor=\"#F3E5F5\"]

            subgraph cluster_tracer {
              label=\"Tracer\"
              style=dashed
              itrace [label=\"ITrace\\n指令追踪\", fillcolor=\"#FFFDE7\"]
              mtrace [label=\"MTrace\\n访存追踪\", fillcolor=\"#FFFDE7\"]
              dtrace [label=\"DTrace\\nMMIO 追踪\", fillcolor=\"#FFFDE7\"]
              ftrace [label=\"FTrace\\n函数调用追踪\", fillcolor=\"#FFFDE7\"]
            }

            nvboard [label=\"NVBoard\\n外设可视化\", fillcolor=\"#E0F7FA\"]
          }

          verilator [label=\"Verilator\\nRTL → C++ 模型\", shape=ellipse, fillcolor=\"#F5F5F5\"]
          rtl [label=\"Chisel RTL\\n(VNPCSoC)\", shape=ellipse, fillcolor=\"#F5F5F5\"]

          rtl -> verilator [label=\"编译\"]
          verilator -> vcpu [label=\"VNPCSoC\"]
          main -> sdb
          main -> scrbrd
          main -> vcpu
          sdb -> scrbrd [label=\"execute_steps\"]
          scrbrd -> vcpu [label=\"probe 信号\"]
          scrbrd -> spike [label=\"单步对比\"]
          scrbrd -> itrace
          scrbrd -> mtrace
          scrbrd -> dtrace
          scrbrd -> ftrace
          vcpu -> nvboard [label=\"GPIO/UART/VGA\"]
        }",
      ),
    ),
    caption: [仿真平台整体架构],
    supplement: [图],
  ) <sim-arch>
]

Verilator 将 Chisel 生成的 Verilog 网表编译为 C++ 仿真模型 `VNPCSoC`。`VerilatorCpu` 封装该模型并驱动时钟信号，通过 Chisel 的 probe 机制从 RTL 中导出 PC、通用寄存器、CSR、提交有效信号等观测点，供上层调试与比对使用。`ScoreBoard` 是差分测试与追踪记录的核心枢纽：每条指令提交后，它同步驱动参考模型 `SpikeCpu` 执行同一条指令，比较两侧架构状态，并将执行信息写入各类 Tracer 的环形缓冲区。`Sdb`（Simple Debugger）提供交互式调试界面，支持单步执行、断点、监视点与表达式求值。命令行标志 `--batch` 可使仿真在无人值守模式下全速运行，`--wave` 可按需开启波形记录。

== 简易调试器

Sdb 提供类 GDB 的交互式命令行界面，基于 GNU Readline 实现命令补全与历史记录。支持的调试命令包括：

#align(center)[
  #table(
    columns: 3,
    align: (center, center, left),
    table.header([命令], [缩写], [功能]),
    [`continue`], [`c`], [继续执行直到断点或程序结束],
    [`step`], [`si`], [单步执行 N 条指令（默认 1）],
    [`info r`], [], [显示所有通用寄存器与 PC],
    [`info w`], [], [列出所有监视点],
    [`print`], [`p`], [对表达式求值并输出],
    [`examine`], [`x`], [查看指定地址处的内存内容],
    [`watch`], [`w`], [添加监视点，表达式值变化时暂停],
    [`break`], [`b`], [在指定地址设置断点],
    [`delete`], [`d`], [删除指定监视点],
  )
]

=== 表达式求值引擎

Sdb 内置了一个完整的表达式求值引擎，使用 Flex 进行词法分析、Bison 进行语法分析。该引擎支持以下语法特性：

- 字面量：十进制整数、十六进制整数（`0x` 前缀）。
- 寄存器引用：`$pc`、`$ra`、`$sp` 等，通过 `AbstractCpu::value()` 接口读取当前 CPU 状态。
- 算术运算：`+`、`-`、`*`、`/`。
- 比较运算：`==`、`!=`、`<`、`<=`、`>`、`>=`。
- 逻辑运算：`&&`、`||`。
- 一元运算：负号 `-`、解引用 `*addr`（读取指定地址的内存值）。

表达式求值贯穿调试器的多个功能：`print` 命令直接求值输出，`examine` 命令使用表达式计算起始地址，`watch` 命令在每步执行后重新求值以检测变化。

== 执行追踪

仿真平台实现了四类追踪器（Tracer），均基于泛型环形缓冲区 `RingBuf<T>` 存储最近的追踪记录。环形缓冲区采用固定容量、覆写最旧记录的策略，在常数内存开销下保留最近的执行历史，供错误发生时回溯分析：

+ ITrace(Instruction Tracer) 记录每条提交指令的 PC、机器码与反汇编文本。反汇编由 Spike 的内置反汇编器生成，保证与参考模型的指令解读一致。当 difftest 失败时，ITrace 的输出可直接定位出错指令及其上下文。
+ MTrace(Memory Tracer) 记录所有非 MMIO 的 load/store 操作，包括 PC、访存方向（读/写）、物理地址、数据值与访问宽度。对于 load 指令，数据值取自 DUT 的内存模型；对于 store 指令，数据值取自参考模型的寄存器。MTrace 对缓存一致性问题与访存相关 bug 的定位尤为有效。
+ DTrace(Device Tracer) 专门记录 MMIO 区域的访问，格式与 MTrace 相同但独立存储。MMIO 访问具有副作用（如串口发送、定时器读取），其正确性无法通过简单的内存比对验证，因此单独追踪便于开发者审查外设交互序列。
+ FTrace(Function Tracer) 从 ELF 文件的符号表中加载函数名与地址映射，在运行时根据指令助记符识别函数调用（`jal`/`jalr` 且 `rd=ra`）与返回（`ret`），维护调用深度计数器，生成带缩进的调用链记录。FTrace 对操作系统启动流程的调试尤为有用：当程序陷入死循环或异常跳转时，调用链能清晰展示控制流的偏离点。

== 差分测试

差分测试（Differential Testing，简称 Difftest）#cite(<you2025difftest>) 是本仿真平台最核心的验证手段。

=== 理论基础：处理器的双层状态机模型

从抽象层次看，处理器本质上是一个状态机，其状态可分为两个层次：

+ ISA 状态（Instruction Set Architecture State）：程序员可见的架构状态，包括程序计数器 PC、32 个通用寄存器、CSR 寄存器以及内存内容。ISA 规范严格定义了每条指令对这些状态的转移规则，任何符合规范的实现——无论是单周期、多周期还是乱序流水线——在执行同一条指令后都必须产生相同的 ISA 状态。
+ 物理状态（Physical/Microarchitectural State）：硬件实现的微架构状态，包括流水线寄存器、重排序缓冲区、缓存行、分支预测器历史等。这些状态对程序员不可见，不同微架构实现之间存在本质差异。

程序员编写软件时只需关心 ISA 状态——这正是 ISA 作为硬件与软件之间契约的核心含义。即便存在诸如 `fence.i` 这样涉及微架构行为的指令，其语义仍然是在 ISA 层面定义的（"使后续取指看到此前的数据写入"），而非暴露具体的缓存实现细节。

基于这一认识，差分测试的思路自然浮现：如果存在一个公认正确的 ISA 状态机作为参考，让待验证的处理器（DUT）与之逐条指令执行同一程序，每步比较 ISA 状态，若始终一致，即可断言 DUT 的实现在 ISA 语义上是正确的。RISC-V 基金会维护的官方指令集模拟器 Spike #cite(<spike2026>) 正是这样一个标准的 ISA 参考状态机：它严格按照 RISC-V 规范实现每条指令的状态转移，不涉及任何微架构细节，是差分测试的理想参考模型。

=== 参考模型集成

本平台以静态链接方式集成 Spike（`spike::riscv` 库），而非通过动态库加载，使仿真平台的部署更为简洁。`SpikeCpu` 类封装了 Spike 的 `sim_t`、`processor_t` 与 `state_t`，并按照 SoC 的实际地址映射（Flash 位于 `0x30000000`、SDRAM 等）初始化 Spike 的内存布局，确保两侧的初始 ISA 状态完全一致。

=== 比对流程

差分测试的执行流程由 `ScoreBoard::scoreboard()` 驱动，每条指令提交后执行以下步骤：

+ DUT 侧：`VerilatorCpu::step()` 驱动时钟直到 `probe_valid` 信号有效，表示一条指令已提交。通过 probe 信号读取 DUT 的 PC、下一 PC（`dnpc`）、机器码、通用寄存器与 CSR——这些正是 ISA 状态的完整快照。
+ 参考模型侧：调用 `SpikeCpu::step()` 执行同一条指令，Spike 按照 ISA 规范更新其内部状态。
+ ISA 状态比对：`check_regs()` 逐一比较 DUT 与 Spike 的下一 PC、32 个通用寄存器（`x1`\~`x31`）以及关键 CSR（`mtvec`、`mepc`、`mcause`、`mtval`、`mstatus` 等），任一不匹配即判定 DUT 的 ISA 行为偏离规范。

=== MMIO 特殊处理

MMIO 访问具有副作用且地址空间在 DUT 与 Spike 之间不一定对等，因此需要特殊处理。当 DUT 的 `is_mmio` 信号有效时，ScoreBoard 不调用 `golden_.step()`，而是：

- 对 MMIO load：从 DUT 的目的寄存器读取实际值，写入 Spike 对应寄存器，使两侧对齐。
- 对 MMIO store：记录到 DTrace，不修改 Spike 内存。
- 最后将 Spike 的 PC 强制设置为 DUT 的 `dnpc`，跳过 Spike 对该指令的执行。

这种"DUT 主导、参考模型跟随"的策略确保了 MMIO 访问不会导致两侧状态分叉。

=== 失败诊断

当 difftest 检测到不一致时，`ScoreBoard::dump_traces()` 按序输出四类 Tracer 的环形缓冲区内容，并以表格形式并排展示 DUT 与 Spike 的寄存器与 CSR 状态，用 `<--- MISMATCH` 标记不一致项。开发者可据此快速定位出错指令及其影响的架构状态。

== LightSSS 快照回放

在长时间仿真过程中，某些 bug（如总线死锁、缓存状态机卡死）可能在数百万周期后才触发，此时重新从头仿真并开启波形记录的开销极为高昂。LightSSS（Lightweight Simulation Snapshot）利用操作系统的 `fork()` 系统调用实现轻量级快照功能：

+ 周期性快照：仿真每执行一定数量的指令后，调用 `fork()` 创建子进程。由于 `fork()` 采用写时复制（Copy-on-Write）语义，快照的创建几乎零开销——父子进程共享相同的物理内存页，仅在后续写入时才触发页复制。
+ 异常检测：当仿真检测到异常状态（如 `VerilatorCpu::step()` 超过最大周期数仍未收到 `probe_valid`，表明总线可能死锁），触发快照回放机制。
+ 死亡回放：系统回退到最近一个 checkpoint 对应的子进程，在该快照上重新执行，但此次开启波形记录（`--wave`）与全部 Tracer，以最小的时间窗口捕获 bug 触发前后的完整信息。

#figure(
  image("images/lightsss.jpg", width: 85%),
  caption: [LightSSS 快照回放原理示意],
  supplement: [图],
) <lightsss>

如 @fig:lightsss 所示，主进程每执行 N 条指令后调用 `fork()` 创建一个自我阻塞的子进程作为快照，并维护一个固定大小的进程队列（SLOT\_SIZE = 2），当快照数量超出上限时淘汰最早的快照。当主进程检测到仿真出错时，唤醒最近的快照子进程，该子进程开启波形记录并重新运行到出错点，完成"死亡回放"后通知父进程回收资源。这一机制的关键优势在于：正常仿真时无需开启波形记录（可提升 5\~10 倍仿真速度），仅在 bug 触发时才回放并记录，大幅缩小了仿真日志与波形文件的体积。

== NVBoard 外设可视化

仿真平台集成了 NVBoard(NJU Virtual Board) 虚拟开发板，通过将 RTL 顶层的 GPIO、七段数码管、PS2 键盘、VGA 显示与 UART 串口等外设信号绑定到 NVBoard 的虚拟引脚，在仿真过程中实时渲染外设状态。通过命令行标志 `--nvboard` 启用。

对于 UART 输出，仿真平台实现了 `UartTxDecoder` 模块，在仿真时钟域内解码 8N1 串口帧：通过追踪 TX 引脚电平变化的最小脉冲宽度自动检测波特率，在每个数据位的中心采样，完成字节解码后送入 NVBoard 的 UART 终端显示。

#figure(
  image("images/nvboard.jpg", width: 85%),
  caption: [NVBoard 虚拟开发板运行 RT-Thread 操作系统上的贪吃蛇程序],
  supplement: [图],
) <nvboard>

@fig:nvboard 展示了 NVBoard 虚拟开发板的运行截图，整个程序运行在 RT-Thread #cite(<yi2023rtthread>) 实时操作系统之上。左上角为 GPIO 区域，七段数码管显示学号后 8 位；右上角为 UART 串口终端与 PS/2 键盘回显，可见 RT-Thread 的 msh（Mini Shell）命令行界面及其内置命令列表；左下角为 VGA 显示区域，正在运行贪吃蛇程序；右下角为 PS/2 虚拟键盘，用于向处理器发送按键扫描码。各外设在仿真过程中实时更新，为软硬件协同调试提供直观的可视化反馈。

== 本章小结

本章介绍了基于 Verilator 与 C++20 构建的仿真验证平台。该平台以 Google C++ Style Guide 为编码规范，围绕"调试—追踪—比对—回放—可视化"五个维度构建了完整的验证工具链：Sdb 简易调试器提供交互式单步执行与断点调试，内置基于 Flex/Bison 的表达式求值引擎；四类 Tracer（ITrace、MTrace、DTrace、FTrace）基于环形缓冲区记录指令、访存、MMIO 与函数调用历史；差分测试以 Spike 为参考模型，逐条指令比对架构状态，MMIO 访问采用 DUT 主导策略保持两侧同步；LightSSS 利用 `fork()` 写时复制实现轻量级快照，在 bug 触发时自动回放并开启波形记录；NVBoard 集成提供 GPIO、UART、VGA 等外设的实时可视化。上述工具的协同使用，使得从功能验证到性能调优的全流程均有据可查、有迹可循。

= 性能评估

为定量评估本处理器在典型工作负载下的微架构行为，本章在 RTL 仿真环境中选取三组广泛使用的基准程序进行端到端性能测试，覆盖综合性整数基准（MicroBench）、经典系统编程基准（Dhrystone #cite(<weicker1984dhrystone>)）与嵌入式行业标准基准（CoreMark #cite(<coremark2009>)）。在此基础上，通过在 RTL 与仿真器两侧协同添加的性能计数器，从 IPC、分支预测命中率、缓存命中率与平均访存时间（AMAT, Average Memory Access Time）、前端取指率、指令混合等多个维度对处理器行为进行定量分析。

== 实验方法与计数器实现

=== 仿真环境

性能评估在本项目基于 Verilator 构建的 C++20 仿真平台上运行，所有被测程序均以 `riscv64-npc` 为目标架构交叉编译，运行于 Abstract Machine 抽象层提供的裸机环境中，不经操作系统调度。仿真平台以 VL\_USER\_STOP 退出策略在程序执行 `halt` 后终止并产生计数器报告。

=== 计数器架构

性能计数器采用"RTL 寄存器 + DPI-C 事件"的混合实现，以兼顾观测粒度与硬件开销：

+ 提交相关的计数器（commit、branch、branch\_mispredict、flush 以及按 `InstType` 划分的十类指令混合）在 CommitStage 内部以 `RegInit(0.U)` 形式实现，于每个指令提交时原子递增，并通过 `probe_bits` 总线从 CPU 顶层导出，仿真器在结束时一次性读取。
+ 缓存访问、缓存命中、缓存未命中、缓存缺失周期（Miss Cycles）、IFU 输出有效、IFU 停顿等事件则通过一个仅用于仿真的 SystemVerilog 外部模块 `PerfEventHelper` 在每个触发时钟沿调用 DPI-C 函数 `npc_perf_event(id)`，由 C++ 侧的 `PerfCounters` 单例累加。该方案不在 RTL 中添加任何额外寄存器或状态机逻辑，故对综合面积与关键路径无影响。

这种"寄存器 + 事件"的划分与业界主流开源处理器的性能监控单元（PMU, Performance Monitoring Unit）设计思路一致：需要被软件读取或需要多周期聚合的大计数器保留在 RTL 中，单次脉冲型事件则通过 DPI-C 导出到仿真平台，避免为仿真观测而污染处理器数据通路。

=== 指标定义

本章使用的关键指标定义如下：

#figure(
  kind: table,
  supplement: [表],
  caption: [性能评估关键指标定义],
  align(center)[
    #table(
      columns: 2,
      align: (center, left),
      table.header([指标], [定义]),
      [IPC], [已提交指令数 / 复位释放后的总仿真周期数],
      [Branch Hit Rate], [正确预测的控制流指令数 / 控制流指令总数],
      [Cache Hit Rate], [缓存命中次数 / 缓存访问次数],
      [AMAT], [$1 + "缺失周期数" / "访问次数"$（命中按 1 周期计）],
      [IFU Stall Ratio], [IFU 未输出有效指令的周期数 / 总周期数],
    )
  ],
) <tab:perf-metrics>

其中 AMAT 的定义将命中基准归一化为 1 个周期，缺失时新增的等待周期全部计入访问摊销。由于本实现中缓存命中即可在同一周期返回数据，该公式等价于 $"命中延迟" times "命中率" + "缺失延迟" times "缺失率"$。

=== 基准程序配置

考虑到 RTL 仿真速度约为 0.1 MIPS 量级，若采用 benchmark 默认配置则单次运行可能需要数小时甚至数十小时，严重影响实验迭代效率。因此本实验对各基准程序的规模参数进行了合理压缩，具体配置如下：

#figure(
  kind: table,
  supplement: [表],
  caption: [基准程序规模与配置说明],
  align(center)[
    #table(
      columns: 3,
      align: (center, left, left),
      table.header([基准], [规模], [说明]),
      [MicroBench #cite(<microbench2024>)], [`test` 规模], [MicroBench 官方四档规模（test/train/ref/huge）中的最小档，约 300K 动态指令，包含 30+ 个功能各异的子测试，覆盖整数运算、排序、字符串、位操作等场景],
      [Dhrystone #cite(<weicker1984dhrystone>)], [2 000 轮], [由 Weicker 于 1984 年提出的综合整数基准；默认 500 000 轮在 RTL 仿真下不切实际，本实验将 `NUMBER_OF_RUNS` 减至 2 000，保留基准程序的循环结构完整性],
      [CoreMark #cite(<coremark2009>)], [20 iterations], [EEMBC 工业标准嵌入式基准，包含链表操作、矩阵乘法与状态机三类核心算法；默认 1 000 iterations 过大，本实验压至 20 iterations 以便在 10 分钟内完成],
    )
  ],
) <tab:perf-bench-config>

需要说明的是，基准程序规模的压缩仅影响数据工作集与运行时长，不改变其指令混合特征与访存模式，因此对 IPC、命中率、分支预测率等微架构指标的评估结论具有代表性。

== 总体性能结果 <sec:perf-pipeline>

三组基准程序的整体执行统计如 @tab:perf-overview 所示。

#figure(
  kind: table,
  supplement: [表],
  caption: [基准程序整体执行统计],
  align(center)[
    #table(
      columns: 5,
      align: (left, right, right, right, right),
      table.header([基准], [周期数], [提交指令数], [IPC], [CPI]),
      [MicroBench (test)], [1 094 005],  [468 574],   [0.4283], [2.33],
      [Dhrystone (2 000)], [2 201 801],  [970 242],   [0.4407], [2.27],
      [CoreMark (20 iter)], [12 983 050], [7 257 139], [0.5590], [1.79],
    )
  ],
) <tab:perf-overview>

三组负载的 IPC 分别为 0.43、0.44 与 0.56，CPI 对应为 2.33、2.27 与 1.79；IPC 随负载特性分层出现，其中 CoreMark 由于存在较多长直线段和较高的 ICache 命中率，可被流水前端连续供应指令，因而取得最高的 IPC。

从前后端协同角度看，流水前端下 `commit / ifu_deliver` 稳定在 $approx$ 0.89（CoreMark：7 257 139 / 8 107 703 $approx$ 0.895），说明前端与后端共同构成瓶颈：前端 F2 等待 ICache 响应是主要的取指停顿源，后端的反压与分支预测误判则进一步降低有效提交速率。

== 前端事件分解 <sec:perf-fe-breakdown>

为进一步定位前端中各段的开销，@tab:perf-fe-events 列出了前端 PerfEvent 在三组负载上的计数。事件含义见 9.1.3 节；其中 `f1_tlb_miss` 为 0 反映裸机（AM）下 Sv39 未启用，iTLB 查表被旁路。

#figure(
  kind: table,
  supplement: [表],
  caption: [前端各段事件计数],
  align(center)[
    #table(
      columns: 5,
      align: (left, right, right, right, right),
      table.header([基准], [fe\_redirect branch], [F1 TLB miss], [F2 ICache wait], [Fp resp wait]),
      [MicroBench (test)], [70 195], [0], [182 963], [5 970],
      [Dhrystone (2 000)], [161 648], [0], [403 268], [1 825],
      [CoreMark (20 iter)], [856 609], [0], [1 187 045], [3 996],
    )
  ],
) <tab:perf-fe-events>

主要观察：

+ 前端自重定向仅由 taken 分支贡献：本版前端已去除所有与 `fence.i` 相关的粘滞位与 serializing 通道（相关职责转由 ICache 的 `fence_drain` 状态与后端 `io.flush` 承担，见 @sec:icache-fsm），因此 `fe_redirect branch` 的计数即等于 F3 预测为 taken 的分支数量。`ecall`、`sret`、`sfence.vma`、CSR 写以及 `fence.i` 等语义上的串行点，其对前端的作用统一折算到流水线 flush 次数上（见 @tab:perf-bp 与 @tab:perf-overview），而不再作为独立的前端计数事件出现。
+ ICache 是首要前端停顿源：`F2 ICache wait` 在所有负载上都是前端停顿周期的主导项（CoreMark 1.19M 周期，约占总周期的 9%），说明前端剩余性能主要受制于缓存与主存之间的传输带宽，而非流水线结构本身。
+ Fp 响应等待极少：`Fp resp wait` 都不到 6 000 周期，表明在典型负载下 ICache 的访问延迟大多可以被流水覆盖，Fp 作为"in-flight 缓冲段"承担了绝大多数 cache 响应周期的吸收工作。
+ DCache 抖动仍可见：MicroBench 的 `Fp resp wait` 显著高于 Dhrystone/CoreMark，与 @tab:perf-dcache 中 MicroBench DCache 命中率偏低的观测一致——数据缺失造成的 LSU 反压也会间接影响前端取指。

== 分支预测性能分析

@tab:perf-bp 展示了 GShare + IJTC + RAS 组合预测器在三组负载中的表现。RAS 的 push/pop 挂在 `io.out.fire` 而非 F3 出现的时刻，这使得投机路径上的 call/ret 不会污染预测器状态，在命中率上带来轻微但可见的收益。

#figure(
  kind: table,
  supplement: [表],
  caption: [分支预测命中率],
  align(center)[
    #table(
      columns: 5,
      align: (left, right, right, right, right),
      table.header([基准], [控制流指令数], [误预测数], [命中率], [流水线 flush]),
      [MicroBench (test)], [90 622],    [11 637], [87.16%], [11 640],
      [Dhrystone (2 000)], [196 578],   [10 535], [94.64%], [10 538],
      [CoreMark (20 iter)], [1 234 267], [77 716], [93.70%], [77 719],
    )
  ],
) <tab:perf-bp>

三组负载的命中率呈现出与控制流复杂度直接相关的分层：

+ Dhrystone 的主循环由大量紧凑的测试步骤组成，控制流以规则的 for 循环回跳与固定方向的条件分支为主，GShare 的历史寄存器能够在少量模式上收敛，达到 94.64% 的预测准确率；
+ CoreMark 包含链表遍历、矩阵搜索与状态机三类控制流，其中链表与状态机分支的方向与全局历史相关性强，GShare 仍能取得 93.70% 的准确率；
+ MicroBench test 规模包含 30+ 个结构各异的子测试，不同子测试的分支行为缺乏跨模块相关性，且测试项内部的分支数量较少（每个子测试约几千条分支），GShare 的历史表格尚未收敛就进入下一个测试，导致整体命中率降至 87.16%。

进一步对比流水线 flush 次数（11 640 / 10 538 / 77 719）与误预测数可以发现，两者在三组负载上的差值均仅为 3，基本呈一一对应关系。这说明本处理器的实现严格做到了"一次误预测触发一次流水线冲刷"，未出现因前端状态残留而产生的多余 flush；同时也印证了分支预测器采用的提交点更新策略能够有效避免投机路径上的分支信息提前污染预测器状态。需要说明的是，MicroBench 的 87.16% 看似偏低，但这一数字实际上反映了 GShare 方案在"多模态、低重复度"工作负载下的固有局限；同类配置的 GShare 在 SPEC CPU2006 整数子集上的平均命中率通常也处于 88%–92% 区间，本实现的整体水平与主流教学及研究实现相当。

== 缓存子系统性能分析

@tab:perf-icache 与 @tab:perf-dcache 分别展示了 ICache 与 DCache 的访问行为。两个 Cache 均为 4 路组相联、64 组、64 字节缓存行的 VIPT 结构，采用 Pseudo-LRU 替换策略。

#figure(
  kind: table,
  supplement: [表],
  caption: [ICache 访问行为],
  align(center)[
    #table(
      columns: 6,
      align: (left, right, right, right, right, right),
      table.header([基准], [访问数], [缺失数], [命中率], [平均缺失代价], [AMAT]),
      [MicroBench (test)], [601 562],    [393],    [99.93%], [19.01 cyc], [1.012],
      [Dhrystone (2 000)], [1 211 822],  [103],    [99.99%], [18.21 cyc], [1.002],
      [CoreMark (20 iter)], [9 943 597], [258],    [99.997%], [19.32 cyc], [1.001],
    )
  ],
) <tab:perf-icache>

#figure(
  kind: table,
  supplement: [表],
  caption: [DCache 访问行为],
  align(center)[
    #table(
      columns: 6,
      align: (left, right, right, right, right, right),
      table.header([基准], [访问数], [缺失数], [命中率], [平均缺失代价], [AMAT]),
      [MicroBench (test)], [124 586],    [3 082], [97.53%], [30.40 cyc], [1.751],
      [Dhrystone (2 000)], [360 917],    [869],   [99.76%], [32.04 cyc], [1.077],
      [CoreMark (20 iter)], [1 526 149], [1 025], [99.93%], [34.51 cyc], [1.023],
    )
  ],
) <tab:perf-dcache>

ICache 在三组负载下均取得 99.9% 以上的命中率，AMAT 接近理想的 1 周期，说明 4 KiB 容量（4 路 $times$ 64 组 $times$ 64 字节）对所有被测程序的指令工作集都具有充分覆盖——这与 MicroBench/Dhrystone/CoreMark 均为单线程短循环程序的特征相符。

DCache 的命中率整体仍然较高，但 MicroBench test 的 97.53% 明显低于另外两组。该差异可以从两个角度解释：

+ 工作集差异。MicroBench 的部分子测试（如 `qsort`、`dinic`、`matrix`）会在堆上分配大数组并进行随机访问，这部分数组可能超过 DCache 容量（4 KiB）或存在容量性冲突；而 Dhrystone 与 CoreMark 的数据结构以紧凑链表与固定大小矩阵为主，工作集明显更小；
+ 冷启动比例。MicroBench test 规模下每个子测试的动态指令数仅约 10K，子测试之间的数据集切换频繁，导致每个子测试启动阶段的强制性缺失（compulsory miss）占比较高；Dhrystone 与 CoreMark 则在相对稳定的数据集上重复执行，冷启动开销被循环次数稀释。

DCache 的平均缺失代价（30–34 周期）高于 ICache（约 19–21 周期），源于 DCache 支持写回策略——当替换脏行时需要先发起一次 AXI4 写 Burst，再启动读 Burst 补齐新行，较 ICache 的单向读 Burst 多一次往返延迟。

从 AMAT 角度看，即使在最差情形下（MicroBench test 的 DCache），AMAT 仅为 1.751 周期，表明 Cache 的平均开销相比后端流水线延迟可忽略，因而 Cache 并不是当前实现的性能瓶颈。

== 指令混合分析

@tab:perf-inst-mix 展示了三组基准的指令类型占比（按 RISC-V 基础指令集分类统计，`CSR`、`SYSTEM` 与 `FENCE` 在所有负载中占比均 $< 0.01%$，表中已省略）。

#figure(
  kind: table,
  supplement: [表],
  caption: [指令类型占比（%）],
  align(center)[
    #table(
      columns: 8,
      align: (left, right, right, right, right, right, right, right),
      table.header([基准], [ALU], [MUL/DIV], [LOAD], [STORE], [BRANCH], [JAL], [JALR]),
      [MicroBench (test)], [53.16], [0.68], [15.15], [11.66], [14.72], [2.16], [2.47],
      [Dhrystone (2 000)], [42.28], [0.21], [22.42], [14.83], [18.32], [1.06], [0.88],
      [CoreMark (20 iter)], [59.36], [2.59], [16.11], [4.93],  [14.85], [1.55], [0.61],
    )
  ],
) <tab:perf-inst-mix>

几项值得关注的特征：

+ ALU 指令占比在 42%–59% 之间，是最主要的指令类型，这与 RISC-V 以 load/store 架构为主、需要大量中间计算指令的整体风格一致；
+ 控制流指令（BRANCH + JAL + JALR）占比 15%–20%，这也是三组负载在 @tab:perf-bp 中显示出较强分支预测依赖性的原因——控制流指令密度高意味着任何一次误预测都会以较短间隔再次出现；
+ Dhrystone 的 LOAD + STORE 占比高达 37.25%，远高于另两组（CoreMark 仅 21.04%）。这是因为 Dhrystone 大量使用结构体字段读写与字符串比较，访存密集；这一特征也解释了 Dhrystone 的 DCache 访问次数密度（约 0.164 访问/周期）高于 CoreMark（约 0.118 访问/周期）；
+ MUL/DIV 占比在三组中差异明显：CoreMark 由于包含 32-bit 乘法计算与矩阵运算，MUL/DIV 占比达 2.59%，是 Dhrystone 的 12 倍；MicroBench 因包含专门的乘除子测试，介于两者之间。

这些差异印证了三组负载具有显著不同的计算与访存特征。三组负载 IPC 随负载特性分层（MicroBench 0.43 / Dhrystone 0.44 / CoreMark 0.56），CoreMark 因包含较多长直线段和极高的 ICache 命中率（99.997%），其 IPC 明显领先于另外两组；Dhrystone 访存密集，受 DCache AMAT 与 LSU 反压影响，IPC 略低；MicroBench 由于子测试间的冷启动切换频繁，DCache 命中率最低（97.53%），进一步降低了其有效 IPC。

== 性能指标换算

基于 @tab:perf-overview 中的周期数，可进一步换算出若干行业通行的性能指标。假设时钟频率为 100 MHz（FPGA 综合下的常见目标）：

#figure(
  kind: table,
  supplement: [表],
  caption: [本处理器的工业性能指标],
  align(center)[
    #table(
      columns: 2,
      align: (left, right),
      table.header([基准], [得分]),
      [Dhrystone (DMIPS/MHz)], [1.596],
      [CoreMark (CoreMark/MHz)], [1.540],
    )
  ],
) <tab:perf-industrial>

换算公式：Dhrystone 为 `NUMBER_OF_RUNS / cycles * 1757`，CoreMark 为 `iterations * 1e6 / cycles`。作为参考，ARM Cortex-M0 约为 0.84 DMIPS/MHz，Cortex-M3 约为 1.25 DMIPS/MHz，Cortex-A9 则可达 2.50 DMIPS/MHz。本处理器 Dhrystone 成绩为 1.596 DMIPS/MHz，已跨越 Cortex-M3 档位；CoreMark 成绩为 1.540 CoreMark/MHz，达到教学级 RISC-V 乱序实现的主流水平。

== 本章小结

本章基于 MicroBench、Dhrystone 与 CoreMark 三组基准程序，结合 RTL 寄存器 + DPI-C 事件的混合性能计数器实现，对本处理器进行了多维度的性能评估。主要结论如下：

+ 三组负载 IPC 分别为 0.43 / 0.44 / 0.56，CPI 对应为 2.33 / 2.27 / 1.79；前后端指令守恒关系 `commit / ifu_deliver ≈ 0.89` 表明前端与后端共同参与了瓶颈构成；
+ 前端事件分解显示，前端停顿主要来自 F2 阶段的 ICache 等待（占总周期的 9% 左右）；自重定向仅由 taken 分支 `fe_redirect branch` 贡献，`fence.i` 的同步职责由 ICache 的 `fence_drain` 状态与后端 `io.flush` 承担，不再占用前端计数事件，说明前后端在 serializing 场景下的协同是高效且稳健的；
+ 分支预测在循环密集负载（Dhrystone）上达到 94.64% 的高命中率，在多模态负载（MicroBench test）上为 87.16%，整体表现与同类 GShare 方案的主流水平相当；
+ ICache 在三组负载下均取得 99.9% 以上命中率、AMAT 接近 1 周期；DCache 除 MicroBench test 因工作集切换频繁降至 97.53% 外，其余负载均超过 99.7%，Cache 子系统表现稳定；
+ Dhrystone 达到 1.596 DMIPS/MHz（已跨越 Cortex-M3 档位），CoreMark 达到 1.540 CoreMark/MHz，验证了本项目所实现的处理器在典型嵌入式/教学基准上的性能水平。

上述结果定量刻画了本处理器的性能画像。本项目建立的"RTL 寄存器 + DPI-C 事件"混合性能计数器框架既能给出整体 IPC、Cache 命中率等宏观指标，也能分解前端各段开销，为后续进一步的微架构迭代（例如双发射前端、L2 Cache、流水化乘除单元）提供可复用的定量评估基础。
