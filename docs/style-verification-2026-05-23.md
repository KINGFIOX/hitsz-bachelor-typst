# 样式对齐印证报告（2026-05-23）

> 目标：用**渲染后的几何度量**印证 Typst 论文 PDF 与 Word 论文 PDF
> （`崔智勇.pdf`）的样式数据是否对齐。结论：**大部分对齐，但发现两处可
> 量化的偏差，需要修复**。

## 1. 印证方法

| 方法 | 工具 | 用途 |
|---|---|---|
| `pdfinfo` | poppler-utils | 验证纸张、页数 |
| `pdftoppm` | poppler-utils | 渲为同 DPI PNG |
| `magick -compose difference` | imagemagick | 像素级 diff 叠加，定位错位区域 |
| `pdftotext -bbox-layout` | poppler-utils | 提取每行 `(xMin, yMin, xMax, yMax)`，得到行基线坐标、行高、栏宽 |
| 解析 docx XML | xmllint | 拉出 `pgMar / docGrid / pPr.spacing` 等真实样式参数 |

样本页（一一对应）：

| Section | Typst 页 | Docx 页 |
|---|---|---|
| 封面正 | 1 | 1 |
| 封面副 | 2 | 2 |
| 摘要 | 3 | 3 |
| Abstract | 4 | 4 |
| 目录起 | 6 | 5 |
| 第 1 章首页 | 10 | 7 |
| 任意正文页 | 15 | 15 |

## 2. 已经印证对齐的项（误差 ≤ 1 pt）

| 项 | docx 来源 | docx 值 | Typst 值 | 验证手段 |
|---|---|---|---|---|
| 纸张 | sectPr -> pgSz | A4 (595.32×841.92 pt) | A4 (595.276×841.89 pt) | `pdfinfo` |
| 上边距 | pgMar `top=1616` | 80.80 pt (2.85 cm) | 80.80 pt | `constants.typ` |
| 下边距 | pgMar `bottom=1616` | 80.80 pt | 80.80 pt | `constants.typ` |
| 左/右边距 | pgMar `left/right=1701` | 85.05 pt (3.00 cm) | 85.04 pt | bbox `xMin ≈ 85.0`, `xMax ≈ 510.3` |
| 文档网格行距 | docGrid `linePitch=412` | 20.60 pt | 20.60 pt | bbox 行间均值 ≈ 20.6 ± 0.5 pt |
| 默认中文字体 | docDefaults `eastAsia="宋体"` | SimSun | 宋体（type.typ）| 字体加载 |
| 默认西文字体 | docDefaults `ascii="Times New Roman"` | Times New Roman | Times New Roman | 字体加载 |
| 章首页页码 footer 位置 | pgMar `footer=1304` | 65.20 pt (2.30 cm) | 65 ± 5 pt | bbox 页码 y ≈ 767–772 |
| 正文行宽（左右栏） | — | x = 85.05 – 510.27 pt | x = 85.0 – 510.2 pt | bbox |
| 正文首行缩进 | — | x = 110.3 pt（2 em） | x = 109.0 pt | bbox 首行 vs 续行 |
| 正文字号 | 默认 `sz=24` | 12 pt（小四） | 12 pt | bbox 行高 12 pt |

## 3. 发现的偏差（需要修复）

### 3.1 页眉位置偏高 27 pt ❌→✅ 已修复

| | Typst（修前）| Typst（修后）| Docx | Δ（修后）|
|---|---|---|---|---|
| 页眉文字 yMin | 59.45 pt | **86.45 pt** | **86.49 pt** | **0.04 pt** |

- Docx 用 `pgMar.header=1701 twip = 3.00 cm`（页眉文字顶部距页面顶 3 cm），
  同时 `pgMar.top=1616 twip = 2.85 cm`，因此 Word 里页眉文字实际伸进了正文区
  上沿 0.15 cm。
- 修复：在 `common/components/header.typ` 把 `header-ascent` 从 `6.7pt`
  调到 `-20.3pt`（基线 6.7 pt − 测得的 27 pt 偏差）。Typst 接受负值，含义
  是"允许页眉伸进正文区"，与 Word 的"页眉跨过 pgMar.top"行为一致。

### 3.2 章节大标题缺 1 行网格前置间距 ❌→✅ 已修复

| 页 | Typst（修前）| Typst（修后）| Docx | Δ（修后）|
|---|---|---|---|---|
| 摘要页（"摘 要"） | 104.69 pt | **124.89 pt** | **124.84 pt** | **0.05 pt** |
| 第 1 章首页（"第 1 章 绪论"） | 104.69 pt | **124.89 pt** | **124.84 pt** | **0.05 pt** |

- Docx 在 styleId=`-0`（"非章节标题-摘要结论参考文献"）和 `1`（"heading 1"）的
  pPr 上加了 `w:spacing w:beforeLines="100"`/`w:before="412"` —— 即 412 twip
  = **20.6 pt = 一个文档网格行高**。
- 修复：在 `common/components/typography.typ` 把
  `heading-level-1-style.above` 默认值从 `27pt` 提到 `47.2pt`
  （`heading-above[0]` 三处默认值同步），章节首页与所有 H1（章、摘要、目录、
  结论、参考文献、致谢…）整体向下平移 20 pt，与 docx 完全对齐。

## 4. 可视化证据

`/tmp/verify/diff-*.png`（imagemagick difference + negate）：内容相同的
像素呈白色，错位呈灰色或带文字幻影。已生成：

- `diff-cover-p1.png`、`diff-cover-p2.png`
- `diff-abstract-zh.png`、`diff-abstract-en.png`
- `diff-toc.png`
- `diff-chapter1.png`

`side-*.png` 是同一对的左右对照版。

## 5. 已应用的修复

### 5.1 初版（v1，2026-05-23 03:25）

| # | 位置 | 改动 | 效果 |
|---|---|---|---|
| 1 | `common/components/header.typ` | `header-ascent: 6.7pt` → `-20.3pt` | 页眉文字 y 移到 86.45 |
| 2 | `common/components/typography.typ` | level-1 `above` `27pt` → `47.2pt` | 章节标题 y 移到 124.89 |
| 3 | `harbin/bachelor/conf.typ` | 删除摘要的自定义 tracking/spacing | 字符密度与 docx 一致 |

### 5.2 修订版（v2，2026-05-23 03:35）— **正文与页眉重叠 bug 修复**

v1 把 `header-ascent` 调成负值后，页眉文字虽然落到了正确位置，但 Typst
**不会自动把正文下推让位给页眉**（这是 Word 的隐式行为，Typst 没有），
导致正文延续页（无章节标题）的第一行排在 y=80.8 pt，而页眉在 y=86 pt，
正文行**反盖在页眉之上**。

修复思路：把 page-margins.top 直接设到 docx 实测的 **effective body
top**（103.35 pt = 3.65 cm），让正文从 docx 同款 y 开始；然后用正向
`header-ascent` 把页眉放回上边距内；最后把章节标题的 `above` 缩回去
抵消多出来的 22.5 pt。

### 5.3 修订版（v3，2026-05-23 03:45）— **页眉与正文 gap 拓宽**

v2 用 `header-ascent: 2.2pt`，所以页眉细横线与正文首字之间的可见
gap 仅 ~2 pt，视觉上"贴边"不舒服。

经验关系：**gap = header-ascent**。要拓宽 gap 而不让页眉/章节标题
偏移，需要把 page-margins.top 与 header-ascent **同步加 ΔT**，并把
heading-level-1 `above` 减去同样的 ΔT。此次取 ΔT = 2.3 pt。

| # | 位置 | v2 → v3 |
|---|---|---|
| 1 | `common/config/constants.typ` | `page-margins.top: 3.65cm` → `3.73cm`（+2.3 pt） |
| 2 | `common/components/header.typ` | `header-ascent: 2.2pt` → `4.5pt`（+2.3 pt） |
| 3 | `common/components/typography.typ` | level-1 `above`：`24.6pt` → `22.3pt`（−2.3 pt，4 处） |

公式（实测推导，v3 数值）：
- `header_text_top_y = page-margins.top - header-ascent - 14.65 pt`
  = `105.65 - 4.5 - 14.65 ≈ 86.5 pt`
  （14.65 pt = 页眉文本下沿到块底之间的内填充实测值）
- `chapter_title_top_y = page-margins.top + above - 3.11 pt`
  = `105.65 + 22.3 - 3.11 ≈ 124.84 pt`
  （3.11 pt = 块上沿到字符 cap 之间的字体度量偏移实测值）
- `body_first_line_yMin = page-margins.top - 2.3 pt(cap-height 偏移)`
  = `103.35 pt`（与 docx 同名值完全相符）
- `visible_gap = header-ascent = 4.5 pt`（v2 的两倍多，肉眼可感受到留白）

### 5.4 最终对齐验证

| | Typst | Docx | Δ |
|---|---|---|---|
| 页眉文字 yMin | 86.60 | 86.49 | +0.11 pt ✓ |
| 章节标题 yMin（H1）| 124.94 | 124.84 | +0.10 pt ✓ |
| 正文延续页首行 yMin | 103.33 | 103.35 | −0.02 pt ✓ |
| 页眉与首行可见 gap | 4.5 pt | ≈4.5 pt | ≈ 0 ✓ |

修复前后的 diff 叠加见 `/tmp/verify/v2-diff-*.png` 与 `/tmp/verify/v3-side-*.png`：
页眉横线、章节大标题、小节标题、摘要字符密度都已对齐，剩余的灰色"幻影"
只来自两份论文实际内容不同。

## 6. 已知但**主动不对齐**的项

| 项 | docx 行为 | Typst 行为 | 不对齐理由 |
|---|---|---|---|
| 英文摘要换行规则 | `w:wordWrap w:val="0"`，按任意字符断行（`corresponden/ce`、`learnin/g` 会被切开） | 按空格/连字符断行（正常英文排版） | docx 行为对英文阅读体验不友好；用户决定保留 Typst 默认 |
| 英文摘要 word spacing | Word 默认值 | Typst 默认值 | 两个引擎默认值略有不同，但用户决定不动 |

## 7. 复现命令

```bash
nix develop --command bash -c '
  typst compile --root . --package-path "$TYPST_PACKAGE_PATH" main/bachelor.typ /tmp/verify/typst.pdf
  for tp_dp in "3 3 abs" "10 7 ch1" "15 15 body"; do
    set -- $tp_dp; tp=$1; dp=$2; lbl=$3
    pdftotext -bbox-layout -f $tp -l $tp /tmp/verify/typst.pdf /tmp/verify/t-$lbl.html
    pdftotext -bbox-layout -f $dp -l $dp 崔智勇.pdf /tmp/verify/d-$lbl.html
  done
'
```

之后用 python re/statistics 抽出每行 `yMin/yMax/xMin/xMax` 即可得到上表
的所有数字。
