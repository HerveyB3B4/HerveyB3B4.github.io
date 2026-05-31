#import "tufted-lib/tufted.typ" as tufted

#let template = tufted.tufted-web.with(
  header-links: (
    "/": "Home",
    "/Blog/": "Blog",
    "/Links/": "Links",
    "/About/": "About",
  ),

  website-title: "HerveyB3B4",
  author: "HerveyB3B4",
  description: "HerveyB3B4 的个人主页",
  website-url: "https://herveyb3b4.github.io/",
  lang: "zh",
  feed-dir: ("/Blog/",),

  header-elements: (
    [HerveyB3B4],
    [],
  ),
  footer-elements: (
    "© 2026 HerveyB3B4. All rights reserved. · ",
    [#link("https://github.com/HerveyB3B4")[GitHub] · #link("mailto:herveyb3b4@gmail.com")[Email] · Powered by #link("https://github.com/Yousa-Mirage/Tufted-Blog-Template")[Tufted-Blog-Template]],
  ),
)
