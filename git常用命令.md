1.克隆github上的仓库
	git clone git@github.com:HaniLucky/documents.git
	
2.更新代码
	git pull                             			 +++++++将远程仓库的代码更新到本地 
	
3.上传代码
	git add .                          			 +++++++将当前版本库的所有代码添加到缓存区
	git commit -m '提交代码的注释'	    	 +++++++ 添加注释                         
	git push -u origin master            	 +++++++将本地代码更新到远程仓库  
	
4.其余的常用命令
	git log 							++++++++ 查看提交日志                     
	git status						++++++++ 查看本地仓库状态      
	
5.中文件文件名提交时乱码
	git config --global core.quotepath false
	git config core.quotepath false
	
6.删除文件
	git rm 我的文件
	git rm -r 我的文件夹/
		此处-r表示递归所有子目录，如果你要删除的，是空的文件夹，此处可以不用带上-r。
		提交代码
	git commit -m"我的修改"
	git push -u origin master