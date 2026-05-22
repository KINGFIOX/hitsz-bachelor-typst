#import "../../../common/theme/type.typ": 字体, 字号
#import "../../../common/config/constants.typ": current-date
#import "../../../common/utils/states.typ": thesis-info-state

#let cover-primary(
  title-cn: "",
  title-en: "",
  author: "",
  student-id: "",
  supervisor: "",
  profession: "",
  college: "",
  reply-date: "",
  institute: "",
  year: current-date.year(),
  month: current-date.month(),
  day: current-date.day(),
) = {
  align(center)[

    #v(50pt)

    #text(size: 字号.小一, font: 字体.宋体, weight: "bold")[*本科毕业论文（设计）*]

    #v(32pt)

    #text(size: 字号.二号, font: 字体.黑体)[#title-cn]

    #v(36pt)

    #par(justify: false)[
      #text(size: 字号.小二, font: 字体.宋体, weight: "bold")[#title-en]
    ]

    #v(62pt)

    #align(center)[
      #text(size: 字号.小二, font: 字体.宋体, weight: "bold")[
        #author
      ]
    ]

    #v(128pt)

    #align(center)[
      #text(size: 字号.小二, font: 字体.楷体, weight: "bold")[#institute]

      #text(size: 字号.小二, font: 字体.宋体, weight: "bold")[
        #[#year]年#[#month]月
      ]
    ]
  ]
}

#let cover-secondary(
  title-cn: "",
  author: "",
  student-id: "",
  supervisor: "",
  profession: "",
  college: "",
  institute: "",
  year: current-date.year(),
  month: current-date.month(),
  day: current-date.day(),
) = {
  align(center)[

    // Word 模板第一行：左侧勾选框组靠页面左边距，「密级：公开」靠
    // 页面右边距，整行 12pt 宋体（与正文 Normal 样式 sz=24 一致）。
    // 用两端对齐的 grid 撑满内容宽度，不再加额外内边距，避免左右两
    // 端被向内挤压。
    //
    // Word 中复选框分别用 Wingdings 2 的 □ 与 Segoe UI Symbol 的 ☑，
    // 项目内未捆绑这两套字体（且开启了 TYPST_IGNORE_SYSTEM_FONTS），
    // 直接渲染 Unicode 字符会回退到 SimSun 的极小字形。这里改用 Typst
    // 基本图元手绘正方形和对勾，保证视觉上与 Word 渲染一致。
    #let _check-box(checked: false) = {
      let s = 9pt
      let sw = 0.6pt
      box(
        width: s,
        height: s,
        baseline: 1pt,
      )[
        #place(top + left, rect(width: 100%, height: 100%, stroke: sw, inset: 0pt))
        #if checked {
          place(
            top + left,
            curve(
              stroke: (paint: black, thickness: 0.9pt, cap: "round", join: "round"),
              curve.move((s * 0.18, s * 0.52)),
              curve.line((s * 0.42, s * 0.78)),
              curve.line((s * 0.85, s * 0.22)),
            ),
          )
        }
      ]
    }

    #grid(
      columns: (1fr, 1fr),
      align(left)[
        #text(size: 字号.小四, font: 字体.宋体)[#_check-box(checked: true)毕业论文 #h(1em) #_check-box(checked: false)毕业设计]
      ],
      align(right)[
        #text(size: 字号.小四, font: 字体.宋体)[密级：公开]
      ],
    )

    // Word 模板第二页布局，从顶端依次为：
    //   1. 「☑毕业论文 □毕业设计   密级：公开」一行
    //   2. v(42pt)
    //   3. 「本科毕业论文（设计）」小二号宋体加粗
    //   4. v(43pt)
    //   5. 论文中文标题，二号黑体
    //   6. v(180pt)
    //   7. 信息表（本科生 / 学号 / …）
    #v(42pt)

    #text(size: 字号.小二, font: 字体.宋体, weight: "bold")[*本科毕业论文（设计）*]

    #v(43pt)

    #text(size: 字号.二号, font: 字体.黑体)[#title-cn]

    #v(180pt)

    // 信息表列宽对齐 Word 模板（document.xml -> tblGrid）：
    //   col1（标签）= 1806 dxa = 90.3pt
    //   col2（冒号）= 301  dxa = 15.05pt
    //   col3（取值）= 4180 dxa = 209pt
    //   合计 314.35pt，整张表在页面内水平居中。
    #let key-width = 90.3pt
    #let colon-width = 15.05pt
    #let value-width = 209pt

    // 模拟 Word jc="distribute" 的字符分散对齐：在 key-width 宽度内
    // 将 count 个汉字均匀分布，使首字左缘贴齐列左侧、末字右缘贴齐列右侧
    // （冒号紧跟其后，与 Word 模板一致）。Typst `tracking` 表示字符间距，
    // 因此视觉总宽 = count*1em + (count-1)*tracking = key-width。
    #let distributed-label(content, count) = {
      text(tracking: (key-width - count * 1em) / (count - 1))[#content]
    }

    #let cover-info-key(content) = {
      text(size: 字号.四号, font: 字体.黑体)[#content]
    }

    #let cover-info-colon(content) = {
      align(left)[
        #text(size: 字号.四号, font: 字体.宋体)[#content]
      ]
    }

    #let cover-info-value(content) = {
      align(left)[
        #text(size: 字号.四号, font: 字体.宋体)[#content]
      ]
    }

    #grid(
      columns: (key-width, colon-width, value-width),
      rows: (字号.四号, 字号.四号),
      row-gutter: 15.4pt,
      cover-info-key(distributed-label([本科生], 3)),
      cover-info-colon[：],
      cover-info-value(author),

      cover-info-key(distributed-label([学号], 2)),
      cover-info-colon[：],
      cover-info-value(student-id),

      cover-info-key(distributed-label([指导教师], 4)),
      cover-info-colon[：],
      cover-info-value(supervisor),

      cover-info-key(distributed-label([专业], 2)),
      cover-info-colon[：],
      cover-info-value(profession),

      cover-info-key(distributed-label([学院], 2)),
      cover-info-colon[：],
      cover-info-value(college),

      cover-info-key(distributed-label([答辩日期], 4)),
      cover-info-colon[：],
      cover-info-value([#[#year]年#[#month]月]),

      cover-info-key(distributed-label([学校], 2)),
      cover-info-colon[：],
      cover-info-value(institute),
    )
  ]
}

#let cover() = {
  context {
    let thesis-info = thesis-info-state.get()
    cover-primary(
      title-cn: thesis-info.at("title-cn"),
      title-en: thesis-info.at("title-en"),
      author: thesis-info.at("author"),
      student-id: thesis-info.at("student-id"),
      supervisor: thesis-info.at("supervisor"),
      profession: thesis-info.at("profession"),
      college: thesis-info.at("college"),
      institute: thesis-info.at("institute"),
      year: thesis-info.at("year"),
      month: thesis-info.at("month"),
      day: thesis-info.at("day"),
    )

    pagebreak()

    cover-secondary(
      title-cn: thesis-info.at("title-cn"),
      author: thesis-info.at("author"),
      student-id: thesis-info.at("student-id"),
      supervisor: thesis-info.at("supervisor"),
      profession: thesis-info.at("profession"),
      college: thesis-info.at("college"),
      institute: thesis-info.at("institute"),
      year: thesis-info.at("year"),
      month: thesis-info.at("month"),
      day: thesis-info.at("day"),
    )
  }
}
