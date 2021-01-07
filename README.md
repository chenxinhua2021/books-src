# 一些书籍的源码

* [tlpi-book](./tlpi-book)

    《Unix 系统编程手册》

    对 sockets/ 下的一些文件进行修改，使得可以通过编译。

    编译步骤，先进入 lib/ 执行 make，然后进入主目录执行 make

* [unpv13e](./unpv13e)

    《Unix 网络编程卷1-套接字联网 API》

    注意看 README 文件，不支持 BSD4 的编译选项要跳过。


    1. 提示没有 if_dl.h 文件，请去网上复制文件内容，创建并放到 /usr/include/net/ 中；
    1. 提示缺少某个宏 MAX_RA，请去定义其为 1024（#define MAX_RA 1024）；
    1. 提示 size 类型错误，将其类型由 ssize_t 改为 socklen_t 。

* [孟宁-命令行工具（C语言版）-软件工程实践](./software_practice_in_c_by_mengning)

* [深入理解 Linux 程序设计源码](https://github.com/hanxinle/understanding-unix-linux-programming)

* [大话计算机随书附赠的资料](https://github.com/hanxinle/bigtalk_about_computer)

* [编译原理之美 - 手把手教你实现一个编译器(宫文学) - src](https://github.com/RichardGong/PlayWithCompiler)

* [Head First Java](./Head-First-Java)

* [慢雾安全提供的资料](https://github.com/slowmist)

* [Antlr4 语法](https://github.com/antlr/grammars-v4)

* [红色警戒1 代码](https://github.com/electronicarts/CnC_Remastered_Collection)

* [深入理解计算机系统的导读（关注博客）](https://www.cnblogs.com/figure9/archive/2010/04/10/1708942.html)

* [clasp](https://github.com/clasp-developers/clasp)

* [I hate regex](https://ihateregex.io/)-[GitHub](https://github.com/geongeorge/i-hate-regex) 

* 公众号：高性能服务器开发 上面有些很好的资料

* [milo yip 的 json 库教程](https://github.com/miloyip/json-tutorial)

* [cpp template 2nd 翻译](https://github.com/Walton1128/CPP-Templates-2nd--)

* [深度学习21天-随书资料](https://github.com/zhaoyongke/Caffe21Days)

* [caffe windows](https://github.com/HolidayXue/CaffeMerge)

* [boost_cook_book-src](./boost_cookbook_2013)
* [自制编程语言（Japan）-src](./make_your_own_language)
* [自制编程语言-基于C语言（郑钢）](./stepByStep)

《操作系统真象还原》（郑钢）代码的 3 个版本，代码应该一致，上传者直接上传了自己运行程序的版本，包括运行不通过时自己的调试。运行不通过去 Github 上找其它 repo 学习。

* [操作系统真象还原-src-1/3](./os_truth_src)
* [操作系统真象还原-src-2/3](./OS_lab-master)
* [操作系统真象还原-src-3/3](./tiny-os-master)

* [Windows 程序设计（第5版）](./Windows-programming-5th)
* [30天自制操作系统-src](./30天自制操作系统)
* [多核和 GPU 编程课程资料（源码、课后答案、勘误） ](./multi_cores_gpu_programming)
* [VC++ 数字图像处理第二版（何斌）](./hebin_digital_image_processing_vc)
* [程序设计语言-实践之路-src）](./code_original)
* [Fortran95 程序设计随书资料](./fortran95)
* [逆向工程核心原理](./ReverseProject)

* [算法的乐趣-src](./code_for_algo_book)
* [IntelliJ 使用教程](https://github.com/judasn/IntelliJ-IDEA-Tutorial)
* [Unix 系统编程——通信、并发与线程](./usp)