@echo off
echo "提交代码开始..."
git pull
git add .
git commit -m 'bat脚本提交..'
git push -u origin master
echo "提交代码结束..."
pause