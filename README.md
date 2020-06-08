# 一些书籍的源码

* [tlpi-book](./unpv13e)

    《Unix 系统编程手册》

    对 sockets/ 下的一些文件进行修改，使得可以通过编译。

    编译步骤，先进入 lib/ 执行 make，然后进入主目录执行 make

* [unpv13e](./unpv13e)

    《Unix 网络编程卷1-套接字联网 API》

    注意看 README 文件，不支持 BSD4 的编译选项要跳过。


    1. 提示没有 if_dl.h 文件，请去网上复制文件内容，创建并放到 /usr/include/net/ 中；
    1. 提示缺少某个宏 MAX_RA，请去定义其为 1024（#define MAX_RA 1024）；
    1. 提示 size 类型错误，将其类型由 ssize_t 改为 socklen_t 。


* [深入理解 Linux 程序设计源码](https://github.com/hanxinle/understanding-unix-linux-programming)

* [大话计算机随书附赠的资料](https://github.com/hanxinle/bigtalk_about_computer)

* [编译原理之美 - 手把手教你实现一个编译器(宫文学) - src](https://github.com/RichardGong/PlayWithCompiler)

* [Head First Java](./Head-First-Java)
