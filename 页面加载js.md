#### 通用的页面加载js有四种方式： 

 **1.window.onload = function(){}; —-js** 
 **2.$(window).load(function(){});——Jquery** 
 **3.$(document).ready(function(){});–Jquery** 
 **4.$(function(){});———————Jquery** 
 其中1和2为同一种，3和4为同一种 
 1、2表示：页面全部加载完成（引用文件，图片）在加载内部函数，且只能执行一个（当文件由多个onload或者load，只加载最后一个）。 
 3、4在window.onload执行前执行的，在DOM加载完毕后，页面全部内容（如图片等）完全加载完毕**前**被执行。而window.onload会在页面资源全部加载完毕后才会执行。

PS： 
 DOM文档加载步骤：  
 **1.解析HTML结构**  
 **2.加载外部的脚本和样式文件**  
 **3.解析并执行脚本代码**  
 **4.执行$(function(){})内对应代码**  
 **5.加载图片等二进制资源**  
 **6.页面加载完毕，执行window.onload**