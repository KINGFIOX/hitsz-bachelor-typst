#let special-chapter-titles-default-value = (
  摘要: text(spacing: 1em)[摘 要],
  摘要-en: [Abstract (In Chinese)],
  Abstract: [Abstract],
  Abstract-en: [Abstract (In English)],
  目录: text(spacing: 1em)[目 录],
  目录-en: [Contents],
  结论: text(spacing: 1em)[结 论],
  结论-en: [Conclusions],
  参考文献: [参考文献],
  参考文献-en: [References],
  致谢: text(spacing: 1em)[致 谢],
  致谢-en: [Acknowledgements],
)

#let current-date = datetime.today()

#let thesis-info-default-value = (
  title-cn: "",
  title-en: "",
  author: "▢▢▢",
  supervisor: "▢▢▢ 教授",
  profession: "▢▢▢ 专业",
  college: "▢▢▢ 学院",
  institute: "哈尔滨工业大学",
  year: current-date.year(),
  month: current-date.month(),
  day: current-date.day(),
)

#let e-digital-signature-mode = (
  "off": "digital-signature-mode.off",
  "default": "digital-signature-mode.default",
  "scanned-copy": "digital-signature-mode.scanned-copy",
)

#let digital-signature-option-default-value = (
  mode: e-digital-signature-mode.default,
  // default mode
  author-signature: [ ],
  author-signature-offsets: (),
  supervisor-signature: [ ],
  supervisor-signature-offsets: (),
  date-array: (),
  date-offsets: (),
  show-declaration-of-originality-page-number: true,
  // scanned-copy mode
  scanned-copy: [ ],
)

// 对齐 Word 模板：sectPr -> pgMar top=1616 right=1701 bottom=1616 left=1701
// header=1701 footer=1304（单位 twip，÷20 得 pt，÷567 得 cm）：
//   top    = 1616 twip = 80.80 pt ≈ 2.85 cm   （pgMar.top）
//   bottom = 1616 twip ≈ 2.85 cm
//   left   = 1701 twip ≈ 3.00 cm
//   right  = 1701 twip ≈ 3.00 cm
//   header = 1701 twip = 85.05 pt ≈ 3.00 cm   （页眉顶 → 页面顶）
//   footer = 1304 twip = 65.20 pt ≈ 2.30 cm   （页脚 → 页面底）
//
// 注意 Word 里 pgMar.header (3.00 cm) > pgMar.top (2.85 cm)，即页眉位置
// 实际**落在 body 区域**内。Word 渲染时会自动把 body 内容下推到 header
// 下方腾出位置，所以同学论文 PDF 实测「正文延续页首行 y = 103.35 pt ≈
// 3.65 cm」，比 pgMar.top 多出约 0.8 cm。
//
// Typst 的 `page.margin.top` 是"正文区顶端"的硬边界、不会被页眉推动，
// 因此这里 `top` 直接取 docx 实测的 effective body top；再额外补 2.3 pt
// 以抵消「正文第一行 yMin = top − cap-height ≈ top − 2.3pt」的字体度量
// 偏移，使 Typst 正文延续页首行 yMin 与 docx 实测的 103.35 pt 完全对齐。
//
// 与此同时，`page-margins.top` 比页眉底沿多预留的距离（= header-ascent）
// 就是页眉与正文之间的可见间隙；当前取 4.5 pt，使下方那条 0.6 pt 细线
// 与首行汉字之间有舒适的留白（避免「贴边」感）。
#let page-margins = (
  top: 3.73cm,
  bottom: 2.85cm,
  left: 3cm,
  right: 3cm,
)

#let distance-to-the-edges = (
  header: 3cm,
  footer: 2.3cm,
)

// Word 模板文档网格行距 = 412 twips = 20.6pt
#let main-text-line-spacing-multiplier = 1.25
#let single-line-spacing = 20.6pt
