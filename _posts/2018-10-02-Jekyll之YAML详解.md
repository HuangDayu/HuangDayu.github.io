---
layout: post
title: Jekyll之YAML详解
date: 2018-10-02 22:22:22
category: 
- 关于博客
tags:
- Jekyll
---

```md
---
layout: 布局（模板文件需要放在 _layouts 目录下 page/about/post）
title:标题
type:分类 X
date: 时间
link: 标题直接调整链接（http url）
category: （categories）
    - 分类1
    - 分类2
    - 分类3
photos:
    - 照片URL1
    - 照片URL2
    - 照片URL3
tags:
    - 标签1
    - 标签2
    - [标签3, 标签4]
description: 子标题 (去掉则首页显示全部内容)
comments: 是否允许评论true或者false，无该选项则是允许评论
image: 照片URL  X
permalink: 指定博客的URL地址 
published: 是否公开发表
sticky: 是否置顶 X
notshow: true 头信息使 post 在首页隐藏 X
updated: 设置更新时间 separated_meta设置为true则启用
---
```
[Jekyllrb](https://jekyllrb.com/)  
[Jekyllcn](http://jekyllcn.com/docs/frontmatter/)  
