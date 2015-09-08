# CentOS Startup

CentOS初始化脚本，主要适合新安装的系统

## 初始化配置

执行base.sh
- 添加自定义的环境变量配置
- 初始化vim配置
- 个性化命令

全局配置common.sh
- `path_cnf` 为后续安装的命令指定保存环境变量的路径
- `src_dir` 安装应用程序的源目录

## 添加工具集
- 在.bashrc中引入tool.sh `source tool.sh`
- 创建与tool.sh中的`conf`目录

快捷指令
- `fcd [nickname]` 快速进入某个目录
- `fcdadd <nickname> <distination>` 为某个目的路径添加快捷方式
- `pathadd <path>` 增加环境变量 (需要 bash.sh中的 set path 部分)

## 应用安装

可在 install/common.sh 中指定安装路径和下载路径

## Nginx
- `src_url`指定安装包来源
- `dir_prefix`指定安装路径
- 执行 `install/nginx.sh`

## Mysql
- `src_url`指定安装包来源
- `dir_base` 指定安装路径
- `dir_data` 指定数据文件路径
- 执行 `install/mysql.sh`

## PHP
- `srcurl_php` 执行PHP安装包来源
- `dir_prefix` 指定PHP安装路径
- `srcurl_libmcrypt` `srcurl_mhash` `srcurl_mcrypt` 为依赖包来源，一般可不变
- 执行 `install/php.sh`
- 完成后会添加`php-fpm`的启动服务，但请先在`dir_prefix/etc`中修改相关配置


