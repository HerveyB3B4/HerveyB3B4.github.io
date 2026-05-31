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
  description: "HerveyB3B4's personal blog, sharing knowledge and insights on technology, programming, and more.",
  website-url: "https://herveyb3b4.github.io/",
  lang: "zh",
  feed-dir: ("/Blog/",),

  header-elements: (
    [HerveyB3B4],
    [Learn, Build, Share.],
  ),
  footer-elements: (
    [© 2026 HerveyB3B4. All rights reserved.],
    [Powered by #link("https://github.com/Yousa-Mirage/Tufted-Blog-Template")[Tufted-Blog-Template]],
  ),
)
