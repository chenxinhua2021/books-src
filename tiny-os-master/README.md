# tiny-os
## 环境准备

### Bochs

在Mac上使用以下命令安装:

```shell
brew install bochs
```

### 配置

每个章节下的bios配置部分应视bochs的具体版本而定，可自行修改：

```html
# 对应真实机器的bios
romimage: file=/usr/local/Cellar/bochs/2.6.9_2/share/bochs/BIOS-bochs-latest
# 对应真实机器的VGA bios
vgaromimage: file=/usr/local/Cellar/bochs/2.6.9_2/share/bochs/VGABIOS-lgpl-latest
```

## 说明

每个章节下的代码均可以独立运行，在对应的目录下执行以下命令即可启动：

```shell
./build.sh
```

即可启动执行。完毕之后可执行以下命令清理环境：

```shell
./clean.sh
```

## 运行

### 第三章

![结果](images/chapter_3_result.png)

### 第四章

![结果](images/chapter_4_result.png)

有以下几点需要注意:

1. 书中的源码boot.inc的DESC_LIMIT_VIDEO2定义可能有误，应修改为:

   ```assembly
   DESC_LIMIT_VIDEO2 equ 00000000000000000000000000001011b
   ```

   原因是保护模式的基地址是0xb8000，所以最后8位应该是b，而不是0，这样才能正确显示字母'P'。

   第164页的图4-11同样有问题，第4个GDT表项(显存)的base应该等于0xb8000，因为如果是图中的0xc00b8000，那么对应的物理内存地址是3072MB处，明显不合理。

2. Mac上的nasm并不支持数字中间以下划线分割的写法，会出现编译错误。

3. 第161页代码4-3的21行为:

   ```assembly
   times 60 dq 0
   ```

   Apple版本的nasm这样写会报错，原因是不能把int型的0赋给dq。稍加变通即可:

   ```assembly
   times 120 dd 0
   ```

### 第五章

#### 内存检测

这里对书中源码进行了改造，只使用e820一种方式，检测失败时会在第一行显示字符串: 'failed'，成功将在第二行显示: 'done'，如下图:

![内存检测结果](images/chapter_5_detect_memory.png)

内存检测的结果通过命令: `x /4wx 0xb00`查看，如下图:

![检测结果](images/chapter_5_memory_size.png)

结果正是我们设置的内存大小: 32MB，无误。

#### 内存分页

![内存分页结果](images/chapter_5_page_memory.png)

这一节注意要和前面的保护模式、内存检测部分结合起来。

#### 加载内核

由于此时没有可以用于打印的手段，所以正确性需要到下一章节验证。此部分需要使用Linux交叉编译器中的ld命令才可以正常链接，Mac自带的无法使用，Mac上的安装参考:

[11-kernel-crosscompiler](https://github.com/cfenollosa/os-tutorial/tree/master/11-kernel-crosscompiler)

### 第六章

#### 打印字符串

![打印字符](images/chapter_6_put_str.png)

这里是打印字符和打印字符串两者结合的效果，这里遇到了一个奇怪的问题，如果在main.c中存在除main之外的其它函数，那么实验结果将不正确，原因未知。

#### 打印数字

![打印数字](images/chapter_6_put_int.png)

### 第七章

#### ASM

![汇编中断实现](images/chapter_7_with_asm.png)

#### 改进

![改进](images/chapter_7_improve.png)

#### Timer

![timer](images/chapter_7_timer.png)

实验中的中断号与书中不同。

### 第八章

#### Assert

![Assert](images/chapter_8_assert.png)

注意, 在64位Linux系统上编译时有几点需要注意:

- GCC加上参数:

  ```bash
  -m32 -fno-stack-protector
  ```

- LD增加参数:

  ```bash
  -m elf_i386
  ```

- 在Ubuntu上使用apt安装的bximage版本较老, 创建镜像的命令为:

  ```bash
  bximage -hd -mode=flat -size=10 -q disk.img
  ```


#### 内存池

![内存池](images/chapter_8_memory_pool.png)

#### 内存分配

![内存分配](images/chapter_8_malloc.png)

注：上一节中内存池初始化代码有一个bug：用户内存池其实地址应该是0xc009a1e0，已在此节修正。

### 第九章

#### 线程启动

![线程启动](images/chapter_9_thread_start.png)

#### 线程调度

![线程调度](images/chapter_9_thread_schedule.png)

这部分两次上下文切换的过程较难理解，整理成如下的时序图:

![时序图](images/thread_schedule_graph.png)

注意:

- 如果被调度线程是第一次执行，那么转到线程对应的函数
- 如果不是第一次被调度，那么走时序图的下半部分，原因是switch_to中保存的起始地址其实是此函数的返回地址
- 虚线流程由第二次调度触发

### 第十章

#### 锁

![锁](images/chapter_10_with_lock.png)

