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
//   top         = 36.5 mm
//   bottom      = 28.8 mm
//   left/right  = 30 mm
#let page-margins = (
  top: 36.5mm,
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
