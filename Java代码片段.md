[TOC]

##### 费波纳茨数列(递归经典案例)

```
/**
 * 费波纳茨数列
 * 一列数的规则如下: 1、1、2、3、5、8、13、21、34 ，求第30位数是多少
 * 使用递归实现 
 * */
public static int recursionCount(int n) {
	if (n <= 2) {
		return 1;
	} else {
		return recursionCount(n - 1) + recursionCount(n - 2);
	}
}
```

##### 读取配置文件属性

```
/** 读取配置文件 */
public static String getProperties(String key) throws IOException{
	Properties properties = new Properties();
	FileInputStream in = new FileInputStream(System.getProperty("user.dir")+"\\src\\"+"conf.properties");
	properties.load(in);
	String proStr = (String) properties.get(key);
	return proStr;
}
```

##### 获取指定文件夹下的文件列表

```
/**
* @param fileName   要输出列表的文件夹
 * @throws IOException
 */
public static void getDirName(String fileDirName) throws IOException{
	File file = new File(fileName);
	File[] listFiles = file.listFiles();
	for (File dir : listFiles) {
		if (dir.isDirectory()) { // 该路径下的所有文件夹
			System.err.println(dir.getName());
		}
	}
}
```

##### BigDecimal API

目的：java中去掉BigDecimal后无用的零

现象：mysql中A表中的B字段的类型是decimal类型，小数位数是三位，某一条数据的值是0.3，在java中查询出来的结果是0.300，这样显示在页面中不太好看，用户希望看到是0.3。

解决办法：

可以使用 stripTrailingZeros().toPlainString()来解决



idxSplit.getIssueVal().setScale(2, BigDecimal.ROUND_DOWN).stripTrailingZeros().toPlainString()