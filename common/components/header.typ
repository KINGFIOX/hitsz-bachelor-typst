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

  let header-body = [
    #set align(center)
    #text(font: 字体.宋体, size: 字号.小五)[
      #block(below: 2.2pt + 2.5pt)[
        #internal-header-text
      ]
    ]
    #line(length: 100%, stroke: 2.2pt)
    #v(2.2pt, weak: true)
    #line(length: 100%, stroke: 0.6pt)
  ]

  context {
    let header-body-size = measure(header-body)
    // 页眉文字目标 y 位置 = 86.5 pt（与 docx 测得的 86.49 pt 对齐）。
    //
    // 由 constants.typ 把 `page-margins.top` 设到 105.65 pt (3.73 cm) ——
    // 即 docx 实测 effective body top (103.35 pt) 加 2.3 pt 字体度量补偿。
    // 这里再用 `header-ascent = 4.5 pt` 把页眉从正文区顶向上抬起 4.5 pt，
    // 既给页眉底沿与正文之间留出 4.5 pt 的舒适留白（解决用户反馈的
    // 「页眉贴正文」问题），又使页眉文字 y 仍落在 docx 同款位置：
    //   header_text_top_y = page-margins.top - header-ascent - 14.65 pt
    //                     = 105.65 - 4.5 - 14.65 = 86.5 pt
    // 14.65 pt 是 header_body 文本下沿到块底之间（两条横线 + v(2.2pt) +
    // block.below 2.2pt + 2.5pt）的实测内填充。
    let _ = (header-body-size, distance-to-the-edges)
    let header-ascent = 4.5pt
    set page(
      header: header-body,
      header-ascent: header-ascent,
    )
    content
  }
}
