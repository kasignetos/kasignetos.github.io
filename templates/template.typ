// 自用函数
#let skew(angle, vscale: 1, body) = {
  let (a, b, c, d) = (1, vscale * calc.tan(angle), 0, vscale)
  let E = (a + d) / 2
  let F = (a - d) / 2
  let G = (b + c) / 2
  let H = (c - b) / 2
  let Q = calc.sqrt(E * E + H * H)
  let R = calc.sqrt(F * F + G * G)
  let sx = Q + R
  let sy = Q - R
  let a1 = calc.atan2(F, G)
  let a2 = calc.atan2(E, H)
  let theta = (a2 - a1) / 2
  let phi = (a2 + a1) / 2
  
  set rotate(origin: bottom + center)
  set scale(origin: bottom + center)
  
  rotate(phi, scale(x: sx * 100%, y: sy * 100%, rotate(theta, body)))
}

#let fake-italic(body) = skew(-12deg, body)

#let shadowed(body) = box(place(skew(-50deg, vscale: 0.8, text(fill: luma(200), body))) + place(body))

#let picture(
  route: none,
  caption: none,
  width: 80%,
  height: auto
) = {
  align(center+top)[
    #figure(
      image(
        route,
        width: width,
        height: height
      ),
      caption: caption
    )
  ]
}

#let closure(
  theme-color: blue,
  size: 12pt,
  lang: "zh",
  region: "cn",
  segment: ("key": "text"),
  segment-title: []
) = {
  set text(
    size : size,
    lang : lang,
    region : region,
  )
  block(
    fill: theme-color.lighten(90%),
    stroke: theme-color,
    width: 100%,
    inset: 14pt,
    radius: 6pt
  )[
    #if segment-title != [] and segment-title != "" {
      if type(segment-title) == str {
        set par(spacing: 0em)
        text(
          size: 20pt, weight: "bold", fill: theme-color
        )[#segment-title]
      } else {
        segment-title
      }
    }
    #for (key, value) in segment {
      block(
        fill: theme-color.lighten(66%),
        stroke: none,
        width: 100%,
        inset: (y: 6pt),
        outset: 3.2%,
        radius: 0pt,
        below: 1.2%
      )[
        #text(fill: theme-color.darken(50%))[*#key*]
      ]
      set par(spacing: 1em)
      value
    }
  ]
}

#let uline(body) = underline(body, offset: 0.3em)
#let dline(body) = underline(body, offset: -0.3em, evade: false, extent: 0.2em)

#let title(
  alignment: top+left,
  size: 40pt,
  fill: black,
  attr: "bold",
  body
) = {
  align(alignment)[
    #set par(first-line-indent: 0em)
    #text(size: size, weight: attr, fill: fill)[
      #body
    ]
  ]
}

#let speaking(author: "一位东方的长者", theme-color: rgb("#000000"), content) = quote(
  block: true,
  attribution: author
)[
  #block(
    fill: theme-color.lighten(80%)
  )[
    #set text(fill: theme-color)
    #fake-italic()[*#content*]
  ]
]

// 页面规则
#let theme(body) = {
  set page(
    height: auto,
    fill: none,
    margin: (x: 0.5em, y: 0.5em)
  )

  set text(
    font: (
      "Huiwen-mincho",
      "Gentium"
    ),
    size: 8pt
  )

  show raw: set text(
    font: "Google Sans Code"
  )

  show math.equation: set text(
    font: "Libertinus Math"
  )

  show math.text: set text(
    font: "Libertinus Math"
  )

  body
}
