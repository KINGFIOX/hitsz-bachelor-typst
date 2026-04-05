#import "../theme/type.typ": 字体, 字号
#import "@preview/numbly:0.1.0": numbly

#let indent = h(2em)

// 假段落，附着于 heading 之后可以实现首行缩进
#let empty-par = par[#box()]
#let fake-par = context empty-par + v(-measure(empty-par + empty-par).height)


// Word 模板标题间距 (基于文档网格行距 20.6pt):
//   一级标题: 段前 1.0 行 = 20.6pt, 段后 0.8 行 = 16.48pt
//   二级标题: 段前/后 0.5 行 = 10.3pt
//   三级标题: 段前/后 0.5 行 = 10.3pt

#let heading-level-1-style(
  it,
  above: 1.144em,
  below: 0.916em,
  ) = {
  set align(center)
  set text(font: 字体.黑体, size: 字号.小二, weight: "regular")
  set block(inset: (top: above, bottom: below))
  it
}

#let heading-level-1(
  it,
  below: auto,
  above: auto,
  ) = {
  // [#below]
  show: heading-level-1-style.with(below: below, above: above)
  pagebreak(weak: true)
  it
}

#let array-at = (arr, index) => {
  arr.at(calc.min(index, arr.len()) - 1)
}

#let use-heading-preface(
  content,
  heading-above: (1.144em, ),
  heading-below: (0.916em, ),
  ) = {

  show heading.where(level: 1): heading-level-1.with(above: array-at(heading-above, 1), below: array-at(heading-below, 1))

  content
}

#let use-heading-main(
  content,
  heading-above: (1.144em, 0.687em, 0.736em, 0.858em, ),
  heading-below: (0.916em, 0.687em, 0.736em, 0.858em, ),
  ) = {

  set heading(numbering: numbly(
    "第{1:1}章   ",
    "{1}.{2}   ",
    "{1}.{2}.{3}   ",
    "{1}.{2}.{3}.{4}   ",
    "{1}.{2}.{3}.{4}.{5}   ",
  ))

  show heading.where(level: 1): heading-level-1.with(above: array-at(heading-above, 1), below: array-at(heading-below, 1))
  show heading.where(level: 2): it => {
    set text(font: 字体.黑体, size: 字号.小三, weight: "regular")
    set block(above: array-at(heading-above, 2), below: array-at(heading-below, 2))
    it
  }
  show heading.where(level: 3): it => {
    set text(font: 字体.黑体, size: 字号.四号, weight: "regular")
    set block(above: array-at(heading-above, 3), below: array-at(heading-below, 3))
    it
  }
  show heading: it => {
      if it.level > 3 {
        set text(font: 字体.黑体, size: 字号.小四, weight: "regular")
        set block(above: array-at(heading-above, it.level), below: array-at(heading-below, it.level))
        it
      } else {
        it
      }
  }
  content
}

#let use-heading-end(
  content,
  heading-above: (1.144em, ),
  heading-below: (0.916em, ),
  ) = {

  show heading.where(level: 1): heading-level-1.with(above: array-at(heading-above, 1), below: array-at(heading-below, 1))

  content
}

#let u_ = context {
 box(width: 1fr, stroke: (bottom: underline.stroke), baseline: underline.offset -.25em, outset: (y:0.25em))
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
