#import "../../common/theme/type.typ": 字体, 字号
#import "../../common/components/typography.typ": use-heading-end, use-heading-main, use-heading-preface
#import "../../common/components/header.typ": use-hit-header
#import "../../common/components/footer.typ": use-footer-main, use-footer-preface
#import "config/constants.typ": special-chapter-titles-additional, thesis-info-additional
#import "../../common/config/constants.typ": current-date, main-text-line-spacing-multiplier, single-line-spacing
#import "../../common/utils/states.typ": special-chapter-titles-state
#import "../../common/utils/states.typ": (
  bibliography-state, default-header-text-state, digital-signature-option-state, thesis-info-state,
)
#import "@local/cuti:0.4.0": show-cn-fakebold
#import "@local/i-figured:0.2.4": reset-counters, show-equation, show-figure
#import "@local/lovelace:0.2.0": setup-lovelace
#import "pages/cover.typ": cover
#import "../../common/pages/abstract.typ": abstract-cn as abstract-cn-page, abstract-en as abstract-en-page
#import "../../common/pages/outline.typ": outline-page
#import "../../common/pages/conclusion.typ": conclusion as conclusion-page
#import "../../common/pages/bibliography.typ": bibliography-page
#import "../../common/pages/acknowledgement.typ": acknowledgement as acknowledgement-page
#import "../../common/pages/achievement.typ": achievement as achievement-page
#import "pages/declaration-of-originality.typ": declaration-of-originality

#let preface(content) = {
  [#metadata("") <preface-start>]

  context {
    let header-text = default-header-text-state.get()
    show: use-hit-header.with(header-text: header-text)
    show: use-footer-preface

    show: use-heading-preface

    set page(numbering: "I")
    counter(page).update(1)

    content
  }
}

#let main(
  content,
  figure-options: (:),
) = {
  [#metadata("") <main-start>]

  figure-options = (
    figure-options
      + (
        extra-kinds: (),
        extra-prefixes: (:),
      )
  )

  set page(numbering: "1")

  show: use-heading-main
  show: use-footer-main

  show heading: reset-counters.with(extra-kinds: ("algorithm",) + figure-options.extra-kinds)
  show figure: show-figure.with(
    numbering: "1-1",
    // i-figured wraps figures and re-attaches a new label that is
    // prepended with a kind-specific prefix:
    //   - table -> "tbl:"
    //   - raw   -> "lst:"
    //   - <fallback, e.g. image, custom kinds> -> "fig:"
    // So author labels should be written *without* the kind prefix
    // (e.g. `<foo>` instead of `<tab:foo>`), and references should use
    // the i-figured prefix (`@tbl:foo`, `@fig:foo`, `@lst:foo`).
    // This is the only way cross-references end up using i-figured's
    // chapter-prefixed numbering (e.g. "表 10-4") instead of Typst's
    // built-in flat figure counter (e.g. "表 4").
    extra-prefixes: ("algorithm": "algo:") + figure-options.extra-prefixes,
  )
  show figure.where(kind: table): set figure.caption(position: bottom)
  show figure.where(kind: "algorithm"): set figure.caption(position: top)
  show figure: set text(size: 字号.五号)

  show raw.where(block: false): box.with(
    fill: rgb("#fafafa"),
    inset: (x: 3pt, y: 0pt),
    outset: (y: 3pt),
    radius: 2pt,
  )

  show raw.where(block: false): text.with(
    font: 字体.代码,
    size: 10.5pt,
  )
  show raw.where(block: true): block.with(
    fill: rgb("#fafafa"),
    inset: 8pt,
    radius: 4pt,
    width: 100%,
  )
  show raw.where(block: true): text.with(
    font: 字体.代码,
    size: 10.5pt,
  )

  show math.equation: show-equation.with(numbering: "(1-1)")

  show: setup-lovelace

  show ref: it => {
    let eq = math.equation
    let el = it.element
    if el != none and el.func() == eq {
      // Override equation references.
      numbering(
        el.numbering,
        ..counter(eq).at(el.location()),
      )
    } else {
      // Other references as usual.
      it
    }
  }

  counter(page).update(1)

  content
}


#let ending(content) = {
  [#metadata("") <ending-start>]

  show: use-heading-end

  set heading(numbering: none)

  content
}

#let ending-content(conclusion: none, achievement: none, acknowledgement: none) = {
  if conclusion != none {
    conclusion-page[
      #conclusion
    ]

    pagebreak()
  }

  bibliography-page()

  pagebreak()

  if achievement != none {
    achievement-page[
      #achievement
    ]
    pagebreak()
  }

  declaration-of-originality()

  pagebreak()

  if acknowledgement != none {
    acknowledgement-page[
      #acknowledgement
    ]
  }
}

#let doc(
  content,
  thesis-info: (:),
  abstract-cn: none,
  keywords-cn: (),
  abstract-en: none,
  keywords-en: (),
  figure-options: (:),
  bibliography: none,
  conclusion: none,
  achievement: none,
  acknowledgement: none,
  digital-signature-option: (:),
) = {
  set document(
    title: thesis-info.at("title-cn"),
    author: thesis-info.author,
  )

  thesis-info-state.update(current => {
    current + thesis-info-additional + thesis-info
  })

  bibliography-state.update(current => bibliography)

  default-header-text-state.update(current => "哈尔滨工业大学本科毕业论文（设计）")

  special-chapter-titles-state.update(current => current + special-chapter-titles-additional)

  digital-signature-option-state.update(current => current + digital-signature-option)

  set page(
    paper: "a4",
    margin: (top: 3.8cm, left: 3cm, right: 3cm, bottom: 2.85cm),
  )

  show: show-cn-fakebold

  set text(lang: "zh", region: "cn")

  cover()

  // Word 模板: 正文 1.25 倍行距，文档网格行距 20.6pt（baseline-to-baseline）。
  // Typst 中 baseline_distance ≈ 自然行盒高度 + leading；自然行盒由
  // top-edge / bottom-edge 决定，默认是 cap-height → baseline，
  // 经实测在小四混排（Times New Roman + SimSun）下约为 8.2pt（≈ 0.683em），
  // 因此 leading ≈ 20.6pt - 8.2pt ≈ 12.4pt ≈ 1.033em。
  // 纯英文（Times New Roman）下自然行盒略小，约为 7.9pt，需要 leading ≈ 12.7pt ≈ 1.058em。
  let leading = 1.033em
  let spacing = leading
  set par(
    first-line-indent: (
      amount: 2em,
      all: true,
    ),
    leading: leading,
    justify: true,
    spacing: spacing,
  )

  set text(font: 字体.宋体, size: 字号.小四)

  show: preface

  if abstract-cn != none {
    abstract-cn-page(keywords: keywords-cn, par-leading: 1.033em, par-spacing: 1.033em, text-tracking: 0.72pt)[
      #abstract-cn
    ]
  }

  if abstract-en != none {
    abstract-en-page(
      keywords: keywords-en,
      par-leading: 1.058em,
      par-spacing: 1.058em,
      text-tracking: 0.2pt,
      text-spacing: 4.76pt,
    )[
      #abstract-en
    ]
  }

  outline-page(par-leading: 1.033em)

  figure-options = (
    figure-options
      + (
        extra-kinds: (),
        extra-prefixes: (:),
      )
  )

  show: main.with(figure-options: figure-options)

  content

  show: ending

  ending-content(
    conclusion: conclusion,
    achievement: achievement,
    acknowledgement: acknowledgement,
  )
}
