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

// LaTeX 模板 (hithesisbook.cls，harbin bachelor 分支) 页面几何：
//   text width  = 150 mm（与 a4 210 mm 减去左右各 30 mm 一致）
//   top         = 36.5 mm（LaTeX 语义：首行基线 ≈ top + \topskip(=12pt)）
//   bottom      = 28.8 mm
//   left/right  = 30 mm
//
// Typst 与 LaTeX 的"上边距"语义不同：Typst 默认 top-edge=cap-height，
// 即 margin.top 对齐的是首行 cap-height 顶端，而 LaTeX 的 top 对齐的是
// "首行基线之上 \topskip(=12pt) 的位置"。实测同学论文 (yjj/thesis.pdf)
// 首行 yMin = 105.82pt = 37.32mm，对应 Typst 中需要 margin.top ≈ 38mm。
// 因此 page-margins.top 取 38mm 而非 36.5mm，以使首行视觉位置对齐 LaTeX。
#let page-margins = (
  top: 38mm,
  bottom: 28.8mm,
  left: 30mm,
  right: 30mm,
)

#let distance-to-the-edges = (
  header: 3cm,
  footer: 2.3cm,
)

// LaTeX 模板正文 baselineskip：\@setfontsize\normalsize{12bp}{20.50394bp}
//   即 12pt 字号下，行盒到行盒（baseline-to-baseline）距离 = 20.50394pt
//   Word 模板文档网格行距 = 412 twips = 20.6pt（仅作历史参考，不再使用）
#let main-text-line-spacing-multiplier = 20.50394 / 12 // ≈ 1.7087
#let single-line-spacing = 20.50394pt
