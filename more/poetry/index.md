---
title: 诗词
layout: page
comments: false
---

<h3 style="text-align: center;">诗词歌赋，吾之所爱。</h3>


<blockquote id="jinrishici" class="blockquote-center">
<h1 align="center" id="jinrishici-title" >诗名</h1>
<h5 align="center" id="jinrishici-dynasty-author" >作者</h5>
<h3 align="center" id="jinrishici-content">诗句</h3>
</blockquote>

> 解释

<p align="left" id="jinrishici-translate"></p>

> 标签

<p align="left" id="jinrishici-match-tags"></p>

> 来源

[今日诗词](https://www.jinrishici.com/)  


<!-- <style type="text/css">
#jinrishici-title,#jinrishici-dynasty-author,#jinrishici-content{
    font-family: KaiTi, 'Segoe UI', 'Lucida Grande', Helvetica, Arial, 'Microsoft YaHei', FreeSans, Arimo, 'Droid Sans','wenquanyi micro hei','Hiragino Sans GB', 'Hiragino Sans GB W3', sans-serif;
 }
</style> -->

<!-- 今日诗词 文档https://www.jinrishici.com/doc/#return-->
<script src="https://sdk.jinrishici.com/v2/browser/jinrishici.js" charset="utf-8"></script>
<script type="text/javascript">
  jinrishici.load(function(result) {
    // 自己的处理逻辑
    console.log(result)
    console.log('今日诗词：'+result.toString())
    var content = result.data.content;
    var author = result.data.origin.author;
    var dynasty = result.data.origin.dynasty;
    var title = result.data.origin.title
    var jrscStr = content + " —— " + "["+dynasty+"]"+ author + "《"+title+"》";

    var o_title = result.data.origin.title;
    var o_content = result.data.origin.content;
    var o_author = result.data.origin.author;
    var o_dynasty = result.data.origin.dynasty;
    var o_dynasty_author = "["+o_dynasty+"] "+ o_author;
    var o_translate = result.data.origin.translate;
    var o_match_tags = result.data.matchTags;

    document.getElementById('jinrishici-title').innerText = (null == o_title) ? "无" : o_title;
    document.getElementById('jinrishici-dynasty-author').innerText = (null == o_dynasty_author) ? "无" : o_dynasty_author;
    document.getElementById('jinrishici-content').innerText = (null == o_content) ? "无" : o_content.toString().replace(/\,/g,'\n');
    document.getElementById('jinrishici-translate').innerText = (null == o_translate) ? "无" : o_translate.toString().replace(/\,/g,'\n');
    // .replace(/\。/g,'。\n').replace(/？/g,'？\n').replace(/！/g,'！\n').replace(/；/g,'；\n').replace(/\。\,/g,'\n');
    document.getElementById('jinrishici-match-tags').innerText = (null == o_match_tags) ? "无" : o_match_tags;


    if(null == content || null == jrscStr || '今日诗词' == content){
        document.getElementById('jrsc').style.visibility="hidden";//隐藏
    }else{
      　document.getElementById('jrsc').style.visibility="visible";//显示
        document.getElementById('jrsc-content').innerText = content;
        document.getElementById('jrsc-author').innerText = "["+dynasty+"]"+ author + "《"+title+"》";
    }


     //    document.getElementById('jinrishici-block').style.visibility="hidden";//隐藏
     //  　document.getElementById('jinrishici-block').style.visibility="visible";//显示    
     //    $("#jinrishici").html('jrscStr');
     //    var jrsc = document.getElementById('jinrishici');
     //    jrsc.value = jrscStr;
     //    var s =document.getElementsByName("jinrishici-class");
     //    s[1].value=jrscStr;

});
</script>