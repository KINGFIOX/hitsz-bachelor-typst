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
  //   \vskip 1.190132pt   % LaTeX: 从字身盒底部 (含 depth) 到粗线的空隙
  //   \hrule height 2.276208pt    % 粗线
  //   \vskip 0.75pt       % 粗线与细线之间的空隙
  //   \hrule height 0.75pt        % 细线
  //
  // Typst 的 block(below) 是从字形实际下边缘算起，FandolSong 有较深的下伸，
  // 所以原值 1.19pt 会让中文字底紧贴粗线。补齐 LaTeX 字身 depth ≈ 3pt，
  // 实测 4.5pt 时空隙与同学 PDF 视觉一致。
  let header-body = [
    #set align(center)
    #text(font: 字体.宋体, size: 字号.小五)[
      #block(below: 4.5pt)[
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
      // 实测同学论文 thesis.pdf 页眉文字 yMin=86.68pt(=30.59mm)。
      // 注：把 block(below) 从 1.19pt 提到 4.5pt 后，header 内容变高
      // 把文字往上顶了 2.67pt，所以这里同步把 ascent 从 11.25 缩到 8.58
      // 让文字 yMin 回到 86.68pt。
      header-ascent: 8.58pt,
      // header-ascent: header-ascent,
    )
    content
  }
}
