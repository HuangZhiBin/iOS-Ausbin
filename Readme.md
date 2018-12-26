# Ausbin框架
### 基于数据驱动的iOS开源框架
Ausbin框架是基于数据驱动的iOS开源框架，其原理类似于前端的VUE/react框架。
> Ausbin is an iOS open-source framework based on Data-driven project, just like frontend frameworks, like VUE/react etc.

![](http://wxtopik.oss-cn-shanghai.aliyuncs.com/app/images/ausbin.png)

**目录 (Table of Contents)**

[TOC]

### iOS开发使用数据驱动框架的原因
- 在iOS的开发过程中，我们将ViewController（以下简称vc）区分不同的功能页面
- vc的代码包括了view的创建和刷新，数据的访问，以及vc间的跳转，业务繁杂
- 为了快速完成业务，将所有view、model、跳转的操作写在vc里面，随着业务的深入，代码的维护成本越来越高
- MVC解决了业务分层的需要，但存在的缺点较为明显，view与model之间的操作过于直接，导致业务混杂
- 前端的VUE/react框架提供了基于数据驱动的框架思想，分离了model和view，引入了

### 多语言代码高亮 Codes

#### 行内代码 Inline code

执行命令：`npm install marked`

#### 缩进风格

即缩进四个空格，也做为实现类似`<pre>`预格式化文本(Preformatted Text)的功能。

<?php
echo "Hello world!";
?>

预格式化文本：

| First Header  | Second Header |
| ------------- | ------------- |
| Content Cell  | Content Cell  |
| Content Cell  | Content Cell  |

#### JS代码

```javascript
function test(){
console.log("Hello world!");
}

(function(){
var box = function(){
return box.fn.init();
};

box.prototype = box.fn = {
init : function(){
console.log('box.init()');

return this;
},

add : function(str){
alert("add", str);

return this;
},

remove : function(str){
alert("remove", str);

return this;
}
};

box.fn.init.prototype = box.fn;

window.box =box;
})();

var testBox = box();
testBox.add("jQuery").remove("jQuery");
```

#### HTML代码 HTML codes

```html
<!DOCTYPE html>
<html>
<head>
<mate charest="utf-8" />
<title>Hello world!</title>
</head>
<body>
<h1>Hello world!</h1>
</body>
</html>
```

### 图片 Images

> Follow your heart.

![](https://pandao.github.io/editor.md/examples/images/8.jpg)


### 绘制表格 Tables

| 项目        | 价格   |  数量  |
| --------   | -----:  | :----:  |
| 计算机      | $1600   |   5     |
| 手机        |   $12   |   12   |
| 管线        |    $1    |  234  |

First Header  | Second Header
------------- | -------------
Content Cell  | Content Cell
Content Cell  | Content Cell

| First Header  | Second Header |
| ------------- | ------------- |
| Content Cell  | Content Cell  |
| Content Cell  | Content Cell  |

| Function name | Description                    |
| ------------- | ------------------------------ |
| `help()`      | Display the help window.       |
| `destroy()`   | **Destroy your computer!**     |

| Left-Aligned  | Center Aligned  | Right Aligned |
| :------------ |:---------------:| -----:|
| col 3 is      | some wordy text | $1600 |
| col 2 is      | centered        |   $12 |
| zebra stripes | are neat        |    $1 |

| Item      | Value |
| --------- | -----:|
| Computer  | $1600 |
| Phone     |   $12 |
| Pipe      |    $1 |


