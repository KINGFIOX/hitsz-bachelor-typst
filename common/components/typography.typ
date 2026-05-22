#import "../theme/type.typ": 字体, 字号
#import "@local/numbly:0.1.0": numbly

#let indent = h(2em)

// 假段落，附着于 heading 之后可以实现首行缩进
#let empty-par = par[#box()]
#let fake-par = context empty-par + v(-measure(empty-par + empty-par).height)


// LaTeX 模板（hithesisbook.cls，harbin bachelor 分支）的标题段前/段后规范
// （单位为 bp/pt，与 baseline-skip 同源）：
//   一级标题（章, 小二 18pt）: beforeskip 28.34646pt, afterskip 28.74646pt
//   二级标题（节, 小三 15pt）: beforeskip / afterskip 19.84252pt
//   三级标题（小节, 四号 14pt）: beforeskip / afterskip 17.00787pt
//   四级标题（小小节, 小四 12pt）: beforeskip / afterskip 8.50394pt
//
// 在 Typst 中，block(above:, below:) 是"行盒外"空白（默认 top-edge=cap-height,
// bottom-edge=baseline），而 LaTeX 的 beforeskip/afterskip 已包含字体上下伸高度。
// 因此实际可视间距 ≈ 设置值 − (上下伸约 5pt)。要得到 LaTeX 同款视觉，
// 需要在 LaTeX 数值基础上额外补上约 5pt 才能匹配同学论文 thesis.pdf 的间距。
//
// 一级标题特例：章标题始终在新页顶部出现，block.above 会被 Typst 在页边界处
// 自动抑制（同 CSS 的 vertical margin collapse），这里使用 block(inset.top: above)
// 把 LaTeX 的 beforeskip 等价空白内嵌到标题块的 padding 中。由于 inset 是直接
// 占位，不需要再补偿字体上下伸；above 直接采用 LaTeX beforeskip 的值即可。

#let heading-level-1-style(
  it,
  // chapter beforeskip ≈ 28.35pt，inset 模式直接使用即可（不需补 5pt）
  above: 28.35pt,
  // chapter afterskip ≈ 28.75pt，block.below 模式需 + 5pt 字体上下伸补偿
  below: 33.75pt,
) = {
  set align(center)
  set text(font: 字体.黑体, size: 字号.小二, weight: "regular")
  // 章标题始终在新页顶部出现，block.above 会被 Typst 在页边界处抑制。
  // 这里通过 block(inset: (top: above)) 把 LaTeX 的 beforeskip 等价空白
  // 内嵌到标题块的 padding 中，从而既不被页边界抑制，也不会触发额外分页。
  set block(inset: (top: above), below: below)
  it
}

#let heading-level-1(
  it,
  below: auto,
  above: auto,
) = {
  show: heading-level-1-style.with(below: below, above: above)
  pagebreak(weak: true)
  it
}

#let array-at = (arr, index) => {
  arr.at(calc.min(index, arr.len()) - 1)
}

#let use-heading-preface(
  content,
  heading-above: (28.35pt,),
  heading-below: (33.75pt,),
) = {
  show heading.where(level: 1): heading-level-1.with(above: array-at(heading-above, 1), below: array-at(
    heading-below,
    1,
  ))

  content
}

#let use-heading-main(
  content,
  // chapter inset.top 用 LaTeX beforeskip 28.35pt（不补字体上下伸）；
  // section / subsection / subsubsection 是 block.above，需要在 LaTeX
  // before/afterskip (19.84 / 17.01 / 8.50) 基础上再 + 5pt 补偿字体上下伸
  heading-above: (28.35pt, 24.85pt, 22.0pt, 13.5pt),
  // chapter block.below 用 LaTeX afterskip 28.75 + 5pt = 33.75pt；其余三级同 above
  heading-below: (33.75pt, 24.85pt, 22.0pt, 13.5pt),
) = {
  set heading(numbering: numbly(
    "第{1:1}章   ",
    "{1}.{2}   ",
    "{1}.{2}.{3}   ",
    "{1}.{2}.{3}.{4}   ",
    "{1}.{2}.{3}.{4}.{5}   ",
  ))

  show heading.where(level: 1): heading-level-1.with(above: array-at(heading-above, 1), below: array-at(
    heading-below,
    1,
  ))
  show heading.where(level: 2): it => {
    set text(font: 字体.黑体, size: 字号.小三, weight: "regular")
    block(
      above: array-at(heading-above, 2),
      below: array-at(heading-below, 2),
      sticky: true,
      it,
    )
  }
  show heading.where(level: 3): it => {
    set text(font: 字体.黑体, size: 字号.四号, weight: "regular")
    block(
      above: array-at(heading-above, 3),
      below: array-at(heading-below, 3),
      sticky: true,
      it,
    )
  }
  show heading: it => {
    if it.level > 3 {
      set text(font: 字体.黑体, size: 字号.小四, weight: "regular")
      block(
        above: array-at(heading-above, it.level),
        below: array-at(heading-below, it.level),
        sticky: true,
        it,
      )
    } else {
      it
    }
  }
  content
}

#let use-heading-end(
  content,
  heading-above: (28.35pt,),
  heading-below: (33.75pt,),
) = {
  show heading.where(level: 1): heading-level-1.with(above: array-at(heading-above, 1), below: array-at(
    heading-below,
    1,
  ))

  content
}

#let u_ = context {
  box(width: 1fr, stroke: (bottom: underline.stroke), baseline: underline.offset - .25em, outset: (y: 0.25em))
}

// 占满全宽度的居中下划线：[___a̲b̲c̲___]
#let u(body) = context {
  layout(size => {
    let single_line_height = measure(text("A")).height
    let (height,) = measure(
      width: size.width,
      body,
    )
    // 多行则只有最后一行有下划线
    if height < single_line_height * 1.5 {
      u_
      body
      u_
    } else {
      body
      u_
    }
  })
}
