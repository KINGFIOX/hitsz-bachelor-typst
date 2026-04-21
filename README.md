# 哈尔滨工业大学本科论文 Typst 模板（本地版）

这是我基于 `universal-hit-thesis` fork 的本地版本，当前目标是：

- 仅支持本地编辑与本地构建
- 入口文档固定为 `main/bachelor.typ`
- 统一使用 `nix build` 生成 PDF

## 项目说明

本仓库用于本科毕业论文（设计）排版，重点在于“可复现构建 + 可控字体环境”：

- 构建系统基于 Nix Flake
- 中文/英文字体通过独立字体 flake 提供，不依赖本机系统字体目录
- 编译流程已适配 `typst` 在 Nix 环境下的构建行为

## 使用方式

### 1) 编辑论文内容

直接修改：

- `main/bachelor.typ`

如需改样式或模板结构，可按需修改：

- `common/`
- `harbin/`

### 2) 编译 PDF

在仓库根目录执行：

```sh
nix build
```

构建成功后，PDF 位于：

- `result/bachelor.pdf`

## 字体方案

字体来自单独维护的 flake：

- [`KINGFIOX/win10-fonts`](https://github.com/KINGFIOX/win10-fonts/tree/main)

在当前项目中通过 `flake.nix` 引用并传递给 Typst，用于保证字体行为一致。

## 与 Word 模板的一致性校对

我已使用 AI 工具对以下 Word 模板与本 Typst 模板进行逐项核对与修正：

- `毕业论文（设计）WORD模板.dotx`

核对重点包括但不限于：

- 字号、字体与章节样式
- 标题层级与页面元素
- 封面字段布局与符号细节
- 参考文献样式行为（基于当前 Typst CSL 能力范围）

## 参考文献说明

本仓库使用定制 CSL：

- `main/gb-t-7714-2015-numeric-hit.csl`

当前规则：

- 仅纯电子资源（网页/软件/数据集等）显示 URL 与访问日期
- 默认不输出 DOI
- 学位论文条目建议在 `refs.bib` 中显式填写 `publisher` / `publisher-place`，避免依赖 `school` 字段映射差异

## 已知限制

- 当前文档流程定位为“本地构建优先”，未提供 Typst Web App 使用说明
- Typst 对 CSL 的支持存在边界，极少数条目类型可能仍需手工微调
- 不同操作系统在字体回退和渲染细节上仍可能有细微差异（本仓库主要按 Windows 字体体系适配）（我也不知道我是按照什么适配的）
