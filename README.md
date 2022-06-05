# Dwdarcity

💡 **「关于」**

我是70后中学信息教师， 我热爱教育事业，为了更好的掌握信息技术前言知识，我不断学习充实自己。

## 平台简介

💡 Dwdarcity 是一套全部开源的在线教育商城源码，毫无保留给个人及企业免费使用。

- 🧑‍🤝‍🧑前端采用 [Vue](https://gitee.com/link?target=https%3A%2F%2Fcn.vuejs.org%2F)、[ElementUI](https://gitee.com/link?target=https%3A%2F%2Felement.eleme.cn%2F)。
- 👭后端采用 Python 语言 Django 框架以及强大的 [Django REST Framework](https://gitee.com/link?target=https%3A%2F%2Fpypi.org%2Fproject%2Fdjangorestframework)。
- 👫权限认证使用[Django REST Framework SimpleJWT](https://gitee.com/link?target=https%3A%2F%2Fpypi.org%2Fproject%2Fdjangorestframework-simplejwt)，支持多终端认证系统。
- 👬语言：前端98% 哈萨克语。
- 💏特别鸣谢：[D2Admin](https://gitee.com/link?target=https%3A%2F%2Fgithub.com%2Fd2-projects%2Fd2-admin) 、[Vue-Element-Admin](https://gitee.com/link?target=https%3A%2F%2Fgithub.com%2FPanJiaChen%2Fvue-element-admin)。
- 💡 特别感谢[jetbrains](https://gitee.com/link?target=https%3A%2F%2Fwww.jetbrains.com%2F) 为本开源项目提供免费的 IntelliJ IDEA 授权。

## 在线体验

👩‍👧‍👦演示地址：暂无

- 账号：admin
- 密码：123

👩‍👦‍👦文档地址：暂无

## 交流

- Python语言学习交流：993673962 <a target="_blank" href="https://qm.qq.com/cgi-bin/qm/qr?k=hiBVo7Bs9TEoga_nsZ7oZuwKK6CjpOnA&jump_from=webapi"><img border="0" src="C:\Users\dwdar\Desktop\README\README.assets\group.png" alt="Python学习交流群1" title="Python学习交流群1"></a>
- 二维码
- ![](C:\Users\dwdar\Desktop\README\README.assets\1654084114074.png)

## 源码地址

gitee地址(主推)：https://gitee.com/dwdar/dwdarcity.git

github地址：...

## 内置功能

1. 👨‍⚕️展示课程：展示课程信息给用户。
2. 🧑‍⚕️用户管理：用户信息管理模块（注册、登录、个人中心)
3. 👩‍⚕️购物车：将视频教程作为商品存入购物车。
4. 🧑‍🎓购买课程： 用户可以选购课程。
5. 👨‍🎓订单管理：用户可以查看自己的购物订单。
6. 👨‍🎓订单管理：记录并展示用户学习情况，显示购置课程信息。
7. 🧑‍🔧播放视频：用户可以观看自己购置的视频课程。
8. 🧑‍🔧优惠券：管理员可以在后台给用户分发优惠券，用户可以使用优惠券。
9. 🗓️积分功能：用户可以使用积分。
10. 🗓️促销活动：运营人员可以需要组织限时优惠、满减、折扣等优惠活动吸引消费者消费。
10. 🗓️操作日志：系统正常操作日志记录和查询；系统异常信息日志记录和查询。

## 视频简介 🔌


## 准备工作

```
Python >= 3.8.0 (推荐3.8+版本)
nodejs >= 14.0 (推荐最新)
Mysql >= 5.7.0 (可选，默认数据库sqlite3，推荐8.0版本)
Redis(最新版)
```

## 前端♝

```
# 克隆项目
git clone https://gitee.com/dwdar/dwdarcity.git

# 进入项目目录
cd dwdarcity_pc

# 安装依赖
npm install --registry=https://registry.npm.taobao.org
# 启动服务
npm run dev
# 浏览器访问 http://127.0.0.1:8080
# 构建生产环境
# npm run build
```

## 后端💈

```
1. 进入项目目录 cd dwdarcity_api
3. 在 env.py 中配置数据库信息
	mysql数据库版本建议：8.0
	mysql数据库字符集：utf8mb4
	mysql 测试数据位于: docs/dwdarcity.sql
4. 安装依赖环境
	pip3 install -i docs/requirments.txt 
5. 执行迁移命令：
	python3 manage.py makemigrations
	python3 manage.py migrate
8. 启动项目
	python3 manage.py runserver 0.0.0.0:8000
```

### 访问项目

- 管理后台访问地址：http://127.0.0.1:8000/admin/  (默认为此地址，如有修改请按照配置文件)
- 账号：`admin` 密码：`123`
- 站点访问地址: http://127.0.0.1:8080/

### docker-compose 运行

```
...
```

## 演示图
...
