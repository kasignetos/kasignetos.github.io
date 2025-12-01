#let alert(body, fill: red) = {
  set text(white)
  set align(center)
  rect(
    fill: fill,
    inset: 8pt,
    radius: 4pt,
    [*⚠️:\ #body*],
  )
}

#import "../../../static/templates/template.typ": *
#show: theme

= 欢迎来到我的博客
#alert[这是用Typst编写的内容！]
