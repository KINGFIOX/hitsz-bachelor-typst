#let 字号 = (
  一英寸: 72pt,
  大特号: 63pt,
  特号: 54pt,
  初号: 42pt,
  小初: 36pt,
  一号: 26pt,
  小一: 24pt,
  二号: 22pt,
  小二: 18pt,
  三号: 16pt,
  小三: 15pt,
  四号: 14pt,
  小四: 12pt,
  五号: 10.5pt,
  小五: 9pt,
  六号: 7.5pt,
  小六: 6.5pt,
  七号: 5.5pt,
  八号: 5pt,
)

// 与同学的 LaTeX 模板 (hithesisbook.cls + ctexbook[fontset=fandol]) 对齐：
//   - Latin main : TeX Gyre Termes (URW Nimbus Roman, Times-clone, 开源)
//   - Latin mono : TeX Gyre Cursor (URW Nimbus Mono, Courier-clone, 开源)
//   - CJK 宋体   : FandolSong (开源)
//   - CJK 黑体   : FandolHei  (开源)
//   - CJK 楷体   : FandolKai  (开源)
// Typst 在西文字体缺字时会自动 fallback 到列表中后续的 CJK 字体；
// 反过来 CJK 字体里出现的西文标点也会优先用主字体的对应字形。
#let 字体 = (
  宋体: ("TeX Gyre Termes", "FandolSong"),
  黑体: ("TeX Gyre Termes", "FandolHei"),
  楷体: ("TeX Gyre Termes", "FandolKai"),
  代码: ("TeX Gyre Cursor", "FandolSong"),
)
