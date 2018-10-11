@echo off
::提示
echo "提交代码开始..."
::执行命令
git pull
git add .
git commit -m 'BAT自动提交...'
git push -u origin master
echo "提交代码结束..."
pause