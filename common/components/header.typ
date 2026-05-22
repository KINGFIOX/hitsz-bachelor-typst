#import "../theme/type.typ": 字体, 字号
#import "../config/constants.typ": distance-to-the-edges, page-margins
#import "../utils/states.typ": default-header-text-state

#let use-hit-header(header-text: none, content) = context {
  let default-header-text = default-header-text-state.get()

  let internal-header-text = if header-text == none {
    default-header-text
  } else {
    header-text
  }

  // LaTeX hithesisbook.cls 中页眉双线的精确尺寸（line 446-451）：
  //   \vskip 1.190132pt   % 文字基线下到粗线之间的空隙
  //   \hrule height 2.276208pt    % 粗线
  //   \vskip 0.75pt       % 粗线与细线之间的空隙
  //   \hrule height 0.75pt        % 细线
  let header-body = [
    #set align(center)
    #text(font: 字体.宋体, size: 字号.小五)[
      #block(below: 1.19pt)[
        #internal-header-text
      ]
    ]
    #line(length: 100%, stroke: 2.276pt)
    #v(0.75pt, weak: true)
    #line(length: 100%, stroke: 0.75pt)
  ]

  context {
    let header-body-size = measure(header-body)
    let header-ascent = page-margins.top - distance-to-the-edges.header - header-body-size.height
    set page(
      header: {
        [
          #header-body
        ]
      },
      // 实测同学论文 thesis.pdf 页眉文字 yMin=86.68pt(=30.59mm)，
      // header-ascent=11.25pt 时 Typst 输出页眉 yMin≈86.68pt（实测对齐）。
      header-ascent: 11.25pt,
      // header-ascent: header-ascent,
    )
    content
  }
}
