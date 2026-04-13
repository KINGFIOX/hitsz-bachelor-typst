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
    extra-kinds: (),
    extra-prefixes: (:),
  ),

  // 参考文献配置
  bibliography: bibliography.with("refs.bib", full: true, style: "gb-t-7714-2015-numeric-hit.csl"),

  abstract-cn: [
    随着开源指令集架构 RISC-V 的快速发展，基于开源生态开展高性能处理器研究已成为体系结构领域的重要方向。乱序执行通过动态调度与寄存器重命名提升指令级并行性，是现代处理器获得高性能的关键机制。本文围绕“RISC-V 指令集乱序处理器设计”，完成了从核心微架构到系统软件支撑的整体实现与验证。

    在微架构设计方面，本文实现了前后端解耦的单发射乱序处理器，采用统一物理寄存器的寄存器重命名方案，支持乱序执行与顺序提交，并通过重排序机制实现精确异常；前端分支预测采用 GShare+IJTC+RAS 组合方案。存储层次方面，实现了基于 PIPT 结构且采用 PLRU 替换策略的 ICache 与 DCache，以降低访存开销并兼顾地址转换场景下的访问效率。体系结构支持方面，实现了 M/S/U 三级特权架构、Sv39 虚拟内存机制与中断处理机制，为操作系统运行提供了完整硬件基础。

    为保证设计正确性，本文基于 Chisel、Verilator 与 C++20 构建验证平台，结合差分测试与调试追踪工具对关键模块进行系统验证。实验结果表明，所实现处理器在乱序执行、缓存访问、异常中断处理与虚拟内存管理等关键功能上均满足设计预期，并已成功运行 xv6 教学操作系统。本文工作为 RISC-V 乱序处理器的教学与工程实践提供了可复现的实现路径与系统级参考。
  ],
  keywords-cn: ("RISC-V", "乱序执行", "Chisel", "SoC", "差分测试"),

  abstract-en: [
    TODO:
  ],
  keywords-en: ("RISC-V", "Out-of-Order Execution", "Chisel", "SoC", "Difftest"),

  // 结论
  conclusion: [
    TODO:
  ],
  // 创新性成果，若没有则可以移除或设置为 none
  achievement: [
    #par(first-line-indent: 0em)[
      *参与的科研项目及获奖情况*
    ]

  ],
  // 致谢
  acknowledgement: [
    TODO:
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
      (datetime.today().year(), datetime.today().month(), datetime.today().day()),
      (datetime.today().year(), datetime.today().month(), datetime.today().day()),
      (datetime.today().year(), datetime.today().month(), datetime.today().day()),
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
    ],
  ),
)


= #[绪#h(1em)论]

== 研究背景与意义

RISC-V 作为开源、模块化、可扩展的指令集架构，正在从学术研究走向产业化部署。相较于传统封闭指令集，RISC-V 在授权成本、生态开放性和可定制能力方面具有显著优势，为高校和科研机构开展处理器全栈设计提供了可行路径。与此同时，面向高性能场景的处理器普遍依赖乱序执行技术来提升指令级并行性和流水线吞吐率，因此围绕 RISC-V 乱序处理器开展研究具有明确的工程价值与教学价值。

从产业需求看，掌握高性能处理器核心微架构的自主设计能力，是推进自主可控芯片技术体系建设的重要基础。从教学与科研实践看，当前公开资料中存在“简单顺序核容易入门、工业级乱序核复杂度过高”的鸿沟，不利于学习者系统理解乱序执行关键机制。基于此，本文以可实现、可验证、可复现为导向，设计并实现一款面向教学与工程过渡场景的 RISC-V 乱序处理器与配套 SoC 平台。

== 乱序处理器及其相关理论的发展概况

=== 乱序执行理论框架的形成与完善

20 世纪 90 年代是现代乱序处理器理论体系系统化的关键时期。Smith 与 Sohi 在 1995 年的综述中指出，高性能超标量处理器的核心任务是在保持顺序语义可见性的前提下，将程序中的潜在并行性转化为硬件可执行的并行操作。该综述将处理流程归纳为取指与分支处理、寄存器相关性分析、动态发射与执行、访存数据通信、按程序顺序提交与精确中断支持等关键阶段，为后续乱序微架构设计提供了统一分析框架。

=== 精确异常的实现路径

为在乱序执行条件下保持体系结构可见状态的顺序一致性，精确异常机制是核心设计点。典型实现路径包括：基于 ROB 的顺序提交方案（在提交点统一更新架构状态）；基于 walk-back 的恢复方案（异常时按记录回退未提交状态）；基于 checkpoint 的快速恢复方案（保存关键映射快照并在错误路径上快速回滚）。三类方案分别在硬件开销、恢复时延与实现复杂度之间进行权衡。

=== 寄存器重命名机制与 WAW/WAR 消解

为消除 WAW/WAR 等伪相关并释放指令级并行性，重命名机制形成了多条技术路线。第一类是 ROB-based 方案，结果先写入 ROB 项并在提交时回写架构寄存器；第二类是 Arch Register File + Future File 方案，将提交态与推测态分离管理；第三类是统一物理寄存器文件（PRF）方案，通过 RAT 维护映射关系并在提交后回收旧物理寄存器。统一 PRF 方案因扩展性与实现弹性较好，在现代乱序处理器中应用广泛。

=== 分支预测与前端指令供应能力提升

分支预测能力直接决定前端取指带宽的有效利用率。相关技术从静态预测与一/二位饱和计数器，发展到两级自适应预测（如 GShare、GSelect），再到混合预测与锦标赛选择机制。同时，BTB、RAS 与间接跳转目标缓存等结构被联合用于覆盖条件分支、函数返回与间接跳转场景。随着乱序窗口扩大与流水线加深，分支预测准确率与误判恢复代价已成为影响处理器实际吞吐率的关键因素。

=== 开源 RISC-V 与 Chisel 驱动下的新发展

近年来，RISC-V 开源生态显著降低了高性能处理器研究的实现门槛，推动了乱序处理器从“理论可讲”向“工程可复现”转变。以 BOOM、香山等项目为代表的开源实践展示了乱序处理器在现代开源工具链下的系统化实现路径，也为后续研究提供了可参考的架构与验证经验。

同时，Chisel 等硬件构造语言的发展，使复杂微架构与 SoC 集成的参数化设计、模块复用和工程维护能力明显提升。与之配套的差分测试方法（如基于 Spike 的逐指令对比）进一步提高了功能验证效率，形成了“设计—验证—迭代”闭环。上述新发展使得在课程与科研场景中实现具备完整特权架构、缓存与虚拟内存支持的乱序处理器成为现实可行的工程目标。

== 本文的主要研究内容

围绕上述理论与工程发展脉络，本文完成了面向 RISC-V 的单发射乱序处理器与 SoC 系统实现，主要成果如下：

\1. 完成 SoC 系统设计与集成，建立了处理器核、总线、存储与外设协同工作的系统级平台。

\2. 基于 Chisel 完成关键 IP 核实现，包括 SDRAM 控制器、Flash 控制器（SPI 模式，配合 XIP 控制器实现直接取指执行）与 PSRAM 控制器（支持 QSPI 与 QPI 模式及相互切换）。

\3. 完成单发射乱序处理器设计，采用统一物理寄存器重命名方案，实现乱序执行、顺序提交与精确异常支持。

\4. 完成基于 PIPT 结构且采用 PLRU 替换策略的 ICache 与 DCache 设计与实现。

\5. 完成 RISC-V M/S/U 三级特权架构与 Sv39 虚拟内存机制实现，具备操作系统运行所需的体系结构支持能力。

\6. 完成 NVBoard（NJU Virtual Board）集成，实现外设可视化联调与系统级交互验证。

\7. 完成 xv6 教学操作系统移植与运行验证。

= SoC 系统设计思路

== 设计目标与总体原则

本课题 SoC 设计的核心目标是为乱序处理器提供可运行操作系统的完整系统环境，并在保证可调试性的前提下兼顾性能与实现复杂度。为此，系统采用“分层总线 + 多层次存储 + 可视化外设联调”的总体思路：高速访存路径优先保障带宽与时延，低速外设路径优先保障协议兼容与工程可维护性，同时通过统一验证框架降低系统集成阶段的调试成本。

在实现策略上，SoC 结构遵循模块化和可替换原则。处理器核、总线互连、存储控制器和外设控制器通过标准接口连接，使得各模块可以独立迭代。该设计既满足当前单发射乱序处理器的系统集成需求，也为后续微架构升级和外设扩展预留了接口空间。

== 分层总线架构设计

SoC 采用 AXI4 与 APB 组合的分层互连架构，以匹配不同设备的速率特征。处理器核心通过 AXI4 主接口接入一级 Crossbar，一级 Crossbar 重点服务主存访问关键路径，仅挂接高带宽存储控制器；二级 Crossbar 连接片上存储与桥接模块，承担中速设备访问；低速外设统一通过 AXI4ToAPB 桥进入 APB 域，由 APB Fanout 完成地址分发。

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

在控制器实现上，关键 IP 核采用 Chisel 实现或重写：SDRAM 控制器面向 AXI4 高带宽路径进行流水化组织，Flash/PSRAM 相关控制器面向 SPI/QSPI/QPI 协议兼容设计。Flash 访问同时支持寄存器方式与 XIP 方式，并通过仲裁机制共享底层 SPI 资源。该设计兼顾了启动阶段可执行性与运行阶段访存效率。

启动链路采用分级引导思路：上电后从 Flash 中的引导入口执行，完成基础初始化后将后续引导或系统镜像加载至 SDRAM，再跳转进入运行态。该流程减少了直接从串行 Flash 执行大体量程序的性能损失，为操作系统启动提供更稳定的执行环境。

== 外设集成与可视化验证思路

外设侧围绕“可用、可测、可观测”进行设计。UART、GPIO、PS2、VGA 等控制器通过 APB 域接入，保证接口一致性与调试便利性。针对教学与开发场景，系统进一步集成 NVBoard，将串口回显、按键输入、数码管显示与 VGA 输出纳入同一仿真闭环，使 SoC 级功能验证从单纯日志比对扩展为可交互的行为验证。

在验证方法上，SoC 级联调与指令级差分测试协同使用：差分测试用于保证体系结构状态正确性，NVBoard 与外设交互用于暴露系统级时序和接口问题，二者互补提升了复杂问题定位效率。基于该思路，系统能够稳定支撑操作系统运行与外设协同工作。

== 本章小结

本章从目标约束、总线分层、存储组织、启动链路与外设验证五个方面阐述了 SoC 设计思路。通过 AXI4/APB 分层互连、多层次存储分工、关键控制器 Chisel 化实现以及 NVBoard 可视化联调，系统在性能、可维护性与可验证性之间取得了平衡，为乱序处理器运行 xv6 等操作系统提供了完整平台基础。

= 关键 IP 核设计与实现

SoC 系统中的存储控制器直接影响系统启动流程与运行期访存性能。本章围绕 Flash 控制器、PSRAM QSPI Master 控制器与 SDRAM 控制器三个关键 IP 核，分别阐述设计方案与验证方法。

== Flash 控制器与 XIP 机制

Flash 存储器通过 SPI 协议接入系统。SPI Master 选用 OpenCores 开源 IP 核，基于 Wishbone 总线接口，本课题使用 Chisel 实现了 APB-to-Wishbone 的薄封装层以接入 SoC 的 APB 域。

系统为 Flash 提供两种访问方式。第一种是命令方式：通过 APB Fanout 经 SPI Arbiter 直接读写 SPI 控制器寄存器，适用于 Bootloader 阶段的 Flash 编程与配置操作。第二种是 XIP（eXecute In Place）方式：XIP 控制器将 Flash 地址空间映射到处理器的统一地址空间，自动将 CPU 的存储器读请求转换为 SPI 读命令，使处理器可直接从 Flash 取指执行。两种方式通过 SPI Arbiter 共享物理 SPI 控制器，XIP 具有更高的仲裁优先级。

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

控制器支持位扩展与字扩展。位扩展模式下，单颗粒提供 16bit 数据宽度，双颗粒拼接为 32bit。字扩展模式下，两个 SDRAM Core 以低位交叉（Low-order Interleaving）方式并联，分别映射到地址的奇偶字。

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
        CTRL [label=\"AXI4 交叉开关\"];
        XBAR -> CTRL [label=\"32bit\"];

        subgraph cluster_sdram {
          CORE0 [label=\"SDRAM Core 0\\n(偶字)\"];
          CORE1 [label=\"SDRAM Core 1\\n(奇字)\"];
        }

        CTRL -> CORE0 [label=\"32bit\"];
        CTRL -> CORE1 [label=\"32bit\"];

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

如 @fig:sdram-interleave 所示，AXI4 交叉开关将连续地址的访问分发到不同 Core，使两颗粒可并行处理不同地址的请求，提高访存并发度。

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

本文实现的乱序处理器采用前后端解耦架构。前端（FrontEnd）负责取指与分支预测，后端（BackEnd）负责译码、寄存器重命名、分派、发射、执行、写回、晚执行、提交。前后端之间通过一个指令队列（Instruction Queue）进行缓冲与解耦，后端在需要冲刷流水线时通过 flush 信号同步清空该队列，分支预测失败或异常恢复时通过 redirect 信号将正确的 PC 反馈给前端。

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

在实现解耦方面，前端与后端通过标准握手协议通信，两侧的内部实现完全独立。前端既可以采用流水化结构，也可以采用状态机驱动，甚至可以完全使用软件实现。在开发过程中，硬件前端由于需要等待总线响应与 ICache 缺失处理，指令供应速率有限，后端负载偏低，难以充分暴露乱序流水线在高压力下的时序问题。为此，本课题利用解耦架构的可替换性，在前端内嵌入 Spike 参考模型：Spike 每执行一条指令即可获得精确的下一条指令 PC，使分支预测几乎 100% 正确，同时取指不经过总线，几乎每个周期都能向后端供应一条有效指令。这一做法相当于对后端进行了满载压力测试，成功暴露了一个在常规硬件前端下因指令供应不足、未形成反压（back-pressure）而被隐藏的 bug——该 bug 表现为反压条件下数据转发时机错过，仅在后端持续满载时才会触发。定位并修复该问题后，前端切换回正常硬件实现。@fig:spike-frontend 展示了使用 Spike 软件前端运行 MicroBench 测试套件的结果：全部测试项通过，共提交 624375 条指令，其中 142230 条分支指令仅产生 514 次预测错误，命中率达 99.64%，验证了该方案的指令供应充分性。这一经验表明，解耦架构不仅降低了模块间的开发耦合度，还为针对性的压力测试提供了灵活的验证手段。

#figure(
  image("images/spike-frontend-bench.png", width: 90%),
  caption: [Spike 软件前端运行 MicroBench 的测试结果（分支预测命中率 99.64%）],
  supplement: [图],
) <spike-frontend>

== 本章小结

弹性设计空间是解耦架构的另一直接收益。指令队列作为缓冲层，使得前端分支预测器的升级（如从取指状态机切换到取指流水线）不影响后端接口，有利于微架构的增量迭代与独立优化。

= 前端：取指单元与动态分支预测设计

前端负责为后端持续供应有效指令，其内部由取指单元（IFU）与分支预测单元（Predict）两个子模块组成。IFU 通过状态机驱动完成地址翻译与 ICache 访问，Predict 对当前取到的指令进行轻量译码并输出预测的下一条指令 PC，两者协同工作形成"取指—预测—下一轮取指"的闭环。

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

          IFU [label=\"IFU\\n(FSM + iTLB + PTW)\"];
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

== 取指单元（IFU）状态机设计

IFU 采用七状态有限状态机驱动取指流程，以适配地址翻译与 ICache 访问中的不定长延迟。

#[
  #import "@preview/diagraph:0.3.6": *

  #figure(
    scale(
      80%,
      render(
        "digraph IFU_FSM {
        rankdir=LR;

        idle [label=\"idle\"];
        tlb_check [label=\"tlb_check\"];
        ptw_req [label=\"ptw_req\"];
        ptw_wait [label=\"ptw_wait\"];
        addr_req [label=\"addr_req\"];
        data_wait [label=\"data_wait\"];
        output_wait [label=\"output_wait\"];

        idle -> tlb_check;
        tlb_check -> addr_req [label=\"TLB hit\\n(or bare mode)\"];
        tlb_check -> ptw_req [label=\"TLB miss\"];
        tlb_check -> output_wait [label=\"page fault\"];
        ptw_req -> ptw_wait [label=\"PTW fire\"];
        ptw_wait -> tlb_check [label=\"PTW done\\n(refill TLB)\"];
        ptw_wait -> output_wait [label=\"PTW fault\"];
        addr_req -> data_wait [label=\"ICache ack\\n(not done)\"];
        addr_req -> output_wait [label=\"ICache ack\\n& done\"];
        data_wait -> output_wait [label=\"ICache done\"];
        output_wait -> tlb_check [label=\"out.fire\\n(pc := predict_dnpc)\"];
      }",
      ),
    ),
    caption: [IFU 取指状态机],
    supplement: [图],
  ) <ifu-fsm>
]

如 @fig:ifu-fsm 所示，上电后状态机从 idle 无条件进入 tlb_check。在 tlb_check 状态，若 Sv39 未启用则直接使用物理地址进入 addr_req；若 Sv39 已启用且 iTLB 命中，则检查页表项的执行权限位（PTE.X），权限合法则进入 addr_req，否则标记 page fault 进入 output_wait；若 iTLB 缺失，则进入 ptw_req 启动页表遍历。PTW 完成后回填 iTLB 并回到 tlb_check 重新查询；若 PTW 检测到页错误，则直接进入 output_wait 报告异常。

addr_req 状态向 ICache 发起访问请求。若 ICache 单周期命中（ack 且 done 同时有效），直接进入 output_wait；否则进入 data_wait 等待缓存行填充完成。在 output_wait 状态，IFU 将取到的指令、PC 与预测信息置于输出端口，等待下游握手。当 out.fire 有效时，PC 寄存器更新为 Predict 输出的预测地址，状态机回到 tlb_check 开始下一轮取指。flush 信号可在任意状态强制将状态机复位至 tlb_check 并加载后端提供的恢复 PC。

== 动态分支预测单元设计

分支预测单元（Predict）对 IFU 取到的指令进行轻量译码，复用后端的 CU（Control Unit，控制单元）与 IGU（Immediate Generate Unit，立即数生成单元）模块提取指令类型与立即数。CU 本身是后端译码级的核心模块，包含完整的指令解码逻辑，具有一定的复杂性。前端复用 CU 时，将前端不涉及的输入信号硬编码为 0，不需要的输出信号悬空；综合工具在优化阶段可据此自动裁剪不可达的组合逻辑路径，使前端实例化的 CU 仅保留指令类型识别等轻量子集，在避免重复编写译码逻辑的同时不引入多余的面积开销。Predict 根据 CU 输出的指令类型将当前指令分派到不同的预测器，最终通过优先级选择逻辑输出预测的下一条 PC。

=== GShare 分支方向预测器（BHT）

对于条件分支指令，采用 GShare 算法进行方向预测。GShare 通过全局历史寄存器（GHR）与 PC 的异或结果索引模式历史表（PHT），利用全局分支相关性提高预测精度。PHT 包含 4096 个表项，每个表项使用 2 位饱和计数器：计数器高位为 1 表示预测跳转，为 0 表示预测不跳转。当 PHT 中对应表项尚未被训练（occupied 标志为假）时，退化为静态预测——以立即数符号位作为预测方向（负偏移预测跳转，正偏移预测不跳转），该启发式对循环结构有较好的覆盖。

后端在条件分支指令提交时，通过 redirect 信号将实际跳转结果与该指令对应的 GHR 快照回传给 BHT，BHT 使用回传的 GHR 与 PC 异或重新定位 PHT 表项并更新饱和计数器，同时将实际跳转方向移入 GHR。

=== 间接跳转目标缓存（IJTC）

对于非返回类的间接跳转指令（JALR 且非 ret 模式），采用 IJTC 进行目标地址预测。IJTC 使用 8 项全相联 CAM 结构，以 PC 作为 tag 进行匹配查询。命中时直接返回缓存的目标地址；缺失时不做预测，前端将使用顺序 PC。

更新策略上，后端在 JALR 指令提交时将实际 PC 与目标地址回传给 IJTC。若 CAM 中已存在该 PC 对应的表项则原地更新目标地址；若不存在则以 FIFO 策略淘汰最旧表项并写入新映射。

=== 返回地址栈（RAS）

对于函数返回指令，采用 RAS 进行目标地址预测。RAS 为深度 8 的循环栈，通过 rd 和 rs1 字段识别 call/ret 模式：当指令为 JAL 或 JALR 且目的寄存器为 x1 或 x5 时判定为 call，将顺序 PC（snpc = pc + 4）压栈；当指令为 JALR 且 rd = x0、rs1 = x1 时判定为 ret，弹栈并将栈顶值作为预测目标。

=== 预测选择逻辑

Predict 模块根据指令类型按优先级选择预测结果：JAL 指令直接使用 PC + 立即数作为目标；条件分支指令根据 BHT 预测方向选择跳转目标或顺序 PC；JALR 且为 ret 模式时使用 RAS 弹栈结果；JALR 且 IJTC 命中时使用 IJTC 缓存的目标地址；其余情况使用顺序 PC。预测结果与当前 GHR 快照一并传递给 IFU，由 IFU 在下一周期使用该地址取指，并随指令一同送入后端，供后端在提交时进行验证与预测器更新。

=== 与 BTB 方案的对比及设计取舍

经典分支预测方案通常使用分支目标缓冲器（BTB, Branch Target Buffer）：在取指阶段以 PC 索引 BTB，若命中则直接读出缓存的跳转目标地址，从而在译码之前就完成预测。BTB 的优势在于无需等待指令译码即可获得目标地址，适合流水化取指前端。

本课题的设计目标是在尽可能简单的前端实现下取得合理的预测覆盖。由于前端采用状态机而非流水线结构，每条指令在 output_wait 阶段已完成取指与预解码，指令类型和立即数均可获得。对于 JAL 和 BRANCH 这两类指令，目标地址为 PC + 立即数的简单加法，可在当拍直接计算得出，无需额外的缓存结构；仅对 JALR 这类目标地址依赖寄存器值、前端无法计算的指令，才借助 IJTC 或 RAS 进行预测。因此在当前微架构下，BTB 的作用被直接计算和专用预测器所替代，省去了 BTB 的存储开销与维护逻辑。若后续前端演进为流水化结构，BTB 将成为必要的补充。

=== 预测器更新策略

三个预测器的更新策略根据各自特性采用了不同的时机。

GShare 与 IJTC 采用保守策略，仅在指令提交（commit）时更新。后端通过 redirect 信号将已提交的分支指令的实际跳转结果、PC 与 GHR 快照回传给前端预测器。这一策略的优势在于只有确认正确执行路径上的指令才会影响预测器状态，避免了因推测执行路径上的错误信息污染 PHT 或 IJTC 表项。

RAS 则采用激进策略，在前端取指与预解码阶段即时更新：遇到 call 指令立即压栈，遇到 ret 指令立即弹栈。这一设计是合理的——即使当前指令处于推测路径上，推测路径中的 call 与 ret 仍然是成对出现的，压栈与弹栈操作相互抵消，不会破坏栈的正确性。若在前端就更新 RAS，后续紧跟的 ret 指令可以立即获得正确的返回地址，而无需等待 call 指令提交，从而降低了函数调用密集场景下的预测延迟。

== 本章小结

本章介绍了前端的取指单元与动态分支预测设计。IFU 采用七状态 FSM 适配 Sv39 地址翻译与 ICache 不定长延迟；分支预测采用 GShare + IJTC + RAS 组合方案，分别覆盖条件分支、间接跳转与函数返回三类控制流场景。在目标地址获取上，利用前端已完成预解码的特点对 JAL 与 BRANCH 直接计算目标地址，仅对 JALR 依赖专用预测器，省去了 BTB 开销。在更新策略上，GShare 与 IJTC 保守地在指令提交时更新以避免推测污染，RAS 则激进地在前端即时更新以利用 call/ret 配对特性降低预测延迟。在 MicroBench 测试套件 test 数据规模下（如 @fig:microbench-test 所示），处理器共提交 653614 条指令，其中 156330 条分支指令产生 20263 次预测错误，分支预测命中率达到 87.0%，验证了 GShare + IJTC + RAS 组合方案在实际工作负载下的有效性。

#figure(
  image("images/microbench-test.png", width: 63%),
  caption: [MicroBench test 数据规模下的分支预测统计（命中率 87.0%）],
  supplement: [图],
) <microbench-test>

= 后端：乱序执行引擎

后端接收前端经指令队列送入的指令流，完成译码、寄存器重命名、发射、执行、写回与提交的全流程，是实现乱序执行的核心引擎。本文实现的后端支持 RV64IM 指令集架构，包含整数运算、乘除法运算、分支、访存与 CSR 五条执行路径。

#figure(
  image("images/backend-arch.png", width: 85%),
  caption: [后端乱序执行引擎（由 Nano Banana2 模型根据手绘草图与 Chisel 源码辅助生成）],
  supplement: [图],
) <backend-arch>

如 @fig:backend-arch 所示，图中蓝色连线表示指令与数据通路，粉色连线表示控制通路（wakeup 与 BusyTable 状态查询），绿色连线表示提交级状态通路（ArchRAT 写回与 FreeList 回收），灰色连线表示 PRF 写回总线。指令从左侧进入 Decode 级，经 Rename 级查询 FutureRAT 并从 FreeList 分配物理寄存器后，进入 Dispatch 级。Dispatch 将指令写入 ROB 获取 rob\_tag，同时根据指令类型分派到 ALU Queue、BRU Queue 或 MDU Queue 三个发射队列。发射队列通过 BusyTable 查询源操作数就绪状态，就绪后发射到对应执行单元：ALU 与 MDU 执行后将结果通过 PRF 写回总线写入 PRF 并向 ROB 报告完成，BRU 仅向 ROB 报告分支结果（Flag）。LSU 与 CSRU 采用延迟执行路径，由 ROB 在指令接近提交时交付执行，LSU 连接 DCache 与外设端口，CSRU 负责 CSR 读写并输出 redirect、flush、fence\_i、sfence\_vma、satp 与 priv 等控制信号。提交级（Commit Unit）从 ROB 头部按序提交，将新映射写入 ArchRAT、旧物理寄存器归还 FreeList，完成乱序执行到顺序提交的状态收敛。

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

寄存器重命名是乱序执行的核心前提，其目的是消除指令间由逻辑寄存器复用导致的 WAW（写后写）与 WAR（写后读）假依赖，使真正的数据依赖（RAW）成为唯一的调度约束。本文采用统一物理寄存器文件（Unified Physical Register File, PRF）方案，主要涉及以下结构：

*物理寄存器文件（PRF）*。PRF 提供 9 个读端口与 5 个写端口。9 个读端口分配给 ALU（2）、BRU（2）、MDU（2）、LSU（2）与 CSRU（1）五条执行路径；5 个写端口分别服务于 ALU 写回、分派级立即数写入、LSU 写回、CSR 写回与 MDU 写回。

*Future RAT*。Future RAT 维护推测状态下的逻辑寄存器到物理寄存器映射表。重命名级通过 3 个读端口查询源寄存器（rs1、rs2）与目的寄存器（rd）当前映射的物理寄存器号，随后从 FreeList 分配一个空闲物理寄存器作为 rd 的新映射，并将新映射写回 Future RAT。旧的 rd 映射（old\_prd）随指令一同写入 ROB，供提交时释放。

*Arch RAT*。Arch RAT 维护已提交的确定性映射。每当指令提交时，CommitStage 将该指令的逻辑目的寄存器与新物理寄存器映射写入 Arch RAT，并将 old\_prd 归还 FreeList。Arch RAT 始终反映最近一次已提交指令的寄存器状态。

*FreeList*。FreeList 管理空闲物理寄存器池。重命名级从中分配新物理寄存器，提交级向其归还不再需要的物理寄存器。归还的依据是：当一个逻辑寄存器被后续指令重新定义（即发生 WAW）时，承载旧值的物理寄存器的生命周期随之结束，可以被安全释放。以如下指令序列为例：

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

*BusyTable*。BusyTable 记录每个物理寄存器的数据就绪状态。重命名级在分配新物理寄存器时将其标记为 busy；当结果产生时通过 wakeup 信号清除 busy 标记。发射队列在发射前查询 BusyTable 以判断源操作数是否就绪。BusyTable 配置 6 个读端口供三个发射队列使用（每队列 2 个，对应 rs1 和 rs2），5 个 wakeup 端口对应三类时机：（1）分派级即时唤醒——LUI、AUIPC、JAL、JALR 等指令的结果仅依赖 PC 与立即数，在分派级即可计算并写入 PRF，同时发出 wakeup；（2）执行完毕唤醒——ALU 与 MDU 执行单元写回结果时发出 wakeup；（3）延迟执行完毕唤醒——LSU 与 CSRU 在 ROB 调度下完成延迟执行并写回 PRF 后发出 wakeup。三类唤醒覆盖了指令生命周期中所有可能产生结果的阶段，使后续依赖指令能尽早感知操作数就绪并被发射。

*Flush 恢复机制*。当后端检测到分支预测错误或异常时，flush 信号同时送往 ROB、FreeList、BusyTable、FutureRAT 以及所有发射队列。FutureRAT 从 Arch RAT 的快照一拍恢复到已提交状态的映射；FreeList 同样根据 Arch RAT 快照重建空闲池。由于 Arch RAT 在提交时同步更新，其内容始终正确，因此恢复过程无需遍历 ROB，仅需一个周期。

== 分派级

分派级位于重命名级之后，负责将已完成寄存器重命名的微操作分发到对应的执行资源。分派级执行以下操作：

\1. 将指令写入 ROB，获取 ROB 标签（rob\_tag）作为指令在乱序流水线中的唯一标识。

\2. 根据指令类型将指令分派到对应的发射队列：ALU 类指令进入 ALU IQ、乘除法指令进入 MDU IQ、 分支指令进入 BRU IQ。

\3. 对于结果可在分派级直接确定的指令——JAL、JALR、LUI 与 AUIPC——分派级直接将计算结果写入 PRF 并发出 wakeup 信号，无需经过执行单元。这些指令的结果（链接地址 pc+4 或立即数加载值）仅依赖 PC 与立即数，在译码后即可获得，提前写回可减少后续依赖指令的等待周期。

\4. 对于访存指令与 CSR 指令，采用保守的延迟执行策略：分派级仅将其写入 ROB，不送入发射队列，待指令到达 ROB 提交头部时再交由 LSU 或 CSRU 执行。访存指令的延迟执行避免了推测路径上的 Store 对内存状态造成不可撤销的副作用，简化了存储一致性维护；CSR 指令的延迟执行保证了特权级切换、中断使能等副作用严格按程序顺序生效，防止推测执行引发错误的系统状态变更。

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

*ALU 路径*。处理整数算术逻辑运算（加减、移位、比较、逻辑运算等）。ALU 为单周期执行，从 ALU IQ 发射后经 PRF 读取源操作数、执行运算、写回 PRF 并向 ROB 报告完成，同时发出 wakeup。

*MDU 路径*。处理乘法与除法运算。MDU 执行延迟不固定（乘法与除法周期数不同），通过 valid/ready 握手协议与发射队列和 ROB 交互。写回逻辑与 ALU 路径相同。

*BRU 路径*。处理条件分支指令的实际比较。BRU 从 BRU IQ 发射后读取源操作数并计算分支条件（br\_flag），将结果报告给 ROB。BRU 不写 PRF——条件分支指令无目的寄存器。

== 延迟执行单元

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

*LSU 路径*。处理 Load/Store 指令。ROB 将访存指令送至提交头部后通过 `late` 端口交给 LSU，确保访存操作按程序顺序执行，简化了存储一致性维护。LSU 内部连接 DCache 与外设端口，并集成 dTLB 与 PTW 以支持 Sv39 地址翻译。LSU 写回通过独立的 PRF 写端口与 wakeup 通路完成。

*CSRU 路径*。处理 CSR 读写指令。与 LSU 类似，由 ROB 在提交阶段通过 `late` 端口交给 CSRU 执行，保证 CSR 操作的顺序语义。CSRU 同时负责中断与异常的状态管理，包括 trap 入口计算、mret/sret 返回地址提供、中断挂起检测等。

== 提交级

提交级（CommitStage）从 ROB 头部按程序顺序逐条提交指令，是乱序执行恢复顺序语义的关键环节。提交时执行以下操作：

\1. 将指令的目的逻辑寄存器与新物理寄存器映射写入 Arch RAT，使确定性状态前进。

\2. 将旧物理寄存器号（old\_prd）归还 FreeList，供后续指令重命名时分配。

\3. 检查异常与中断：若提交头部的指令携带异常标记（如 page fault、非法指令）或检测到中断挂起，CommitStage 触发 trap 流程，通过 CSRU 获取 trap 入口地址，生成 redirect 信号指向异常处理程序，并发出 flush 清空流水线。

\4. 处理 mret/sret 返回：提交 mret 或 sret 指令时，从 CSRU 读取 mepc 或 sepc 作为 redirect 目标。

\5. 处理 fence.i 与 sfence.vma：提交这两类指令时，分别向外输出 fence\_i 和 sfence\_vma 信号，通知 ICache 失效或 TLB 刷新。

\6. 分支验证：对于条件分支指令，将 BRU 写回的实际跳转结果与前端预测进行比对。若预测错误，生成 redirect 信号携带正确的目标地址与分支信息，同时发出 flush。

\7. 调试探针（probe）：提交时输出指令的 PC、下一条 PC、指令字、GPR 状态与 CSR 状态等信息，供 DiffTest 框架与参考模型逐条比对，实现运行时正确性验证。

== 本章小结

本章介绍了后端乱序执行引擎的设计。后端采用译码—重命名—分派—发射—执行—写回—提交的经典乱序流水线结构，通过统一物理寄存器文件与 FutureRAT/ArchRAT 双映射表实现寄存器重命名，消除 WAW 与 WAR 假依赖。五条独立执行路径（ALU、MDU、BRU、LSU、CSRU）并行运行，其中 ALU/MDU/BRU 通过发射队列乱序发射，LSU 与 CSRU 通过 ROB 延迟执行以保证顺序语义。提交级按序提交并处理异常、中断、分支验证与调试输出。flush 恢复仅需一周期，利用 ArchRAT 快照同时重建 FutureRAT 与 FreeList。

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
  #import "@preview/algo:0.3.6": algo, code, comment, d, i

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
      breakable: true,
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
