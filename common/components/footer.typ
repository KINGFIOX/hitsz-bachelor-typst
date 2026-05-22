#import "../theme/type.typ": 字体, 字号
#import "../config/constants.typ": distance-to-the-edges, page-margins

#let use-footer-preface(content) = {
  context {
    let footer-body = context [
      #align(center)[
        #set text(size: 字号.小五, font: 字体.宋体)
        #counter(page).display("- I -")
      ]
    ]

    let footer-body-size = measure(footer-body)
    let footer-ascent = page-margins.bottom - distance-to-the-edges.footer - footer-body-size.height

    set page(
      footer: footer-body,
      // Typst footer-descent 实测语义：body-bottom 到 footer 顶端的距离。
      // 实测 LaTeX yMin=767.95pt - body_bottom(760.23pt) = 7.72pt → footer-descent=7.7pt
      footer-descent: 7.7pt,
    )

    content
  }
}

#let use-footer-main(content) = {
  context {
    let footer-body = context [
      #align(center)[
        #set text(size: 字号.小五, font: 字体.宋体)
        #counter(page).display("- 1 -")
      ]
    ]

    let footer-body-size = measure(footer-body)
    let footer-ascent = page-margins.bottom - distance-to-the-edges.footer - footer-body-size.height

    set page(
      footer: footer-body,
      // Typst footer-descent 实测语义：body-bottom 到 footer 顶端的距离。
      // 实测 LaTeX 页码 yMin=767.95pt - body_bottom(760.23pt) = 7.72pt → footer-descent=7.7pt
      footer-descent: 7.7pt,
      // footer-descent: footer-ascent,
    )

    content
  }
}
