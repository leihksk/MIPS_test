# Verilog HDL 实现单周期MIPS流水线处理器
---
本项目使用Icarus Verilog（iverilog）仿真与输出VCD波形文件+GTKwave显示波形  
完成了单周期MIPS 5级流水线处理器的复现  
实现了解决控制冲突，使用阻塞和重定向解决数据冲突以解决多阶段流水线产生的冲突  
实现10条指令：lw,sw,beq,addi,j,add,sub,and,or,slt  

四个流水线寄存器中，取指令阶段到译码阶段的流水线寄存器直接写在datapath_p.v中，其余译码阶段——执行阶段，执行阶段——存储器阶段，存储器阶段——写回阶段的三个流水线寄存器中，将控制单元产生的控制信号与数据路径中的数据信息分开，前者在ctrl.v，后者datapath_p.v中调用  
冲突单元模块由控制信号与数据信息产生阻塞信号stall与数据选择信号forward  

---
## 测试流程
Linux系统下，在程序文件夹打开终端，输入指令：  
（需先安装Icarus Verilog与GTKwave,  Linux终端中逐条执行并等待下载安装完成：  
sudo pacman -S iverilog  
sudo pacman -S gtkwave  ）  
iverilog testbench.v  
./a.out  
gtkwave wave.vcd  
执行./a.out后也可以在文件夹中打开wave.vcd文件  

---
## 组件

### testbench.v
测试程序，时钟信号与重置信号输入

### top.v
顶层模块

### dmemp.v
数据存储器

### imem.v
指令存储器，从memfile.dat文件读取16进制指令

### adder.v
加法器模块

### alu_p.v
算术逻辑单元模块

### comparator.v
比较器模块

### ctrl.v
控制单元模块

### datapath_p.v
数据路径模块

### e_m.v
执行阶段到存储器模块的流水线寄存器

### execute.v
执行阶段模块

### flopr
可复位触发器

### flopenr
带使能端的可复位触发器

### floprc
带清零功能的可复位触发器

### flopenrc
带使能端和清零功能的可复位触发器

### fu_ex.v
产生执行阶段的阻塞信号

### fu_id.v
产生译码阶段的阻塞信号

### hazard.v
冲突单元

### id_e.v
译码阶段到执行阶段的流水线寄存器

### m_w.v
存储器阶段到写回阶段的流水线寄存器

### memfile.dat
16进制的18条测试指令

### MIPS.v
组合指令分析与数据路径

### mux2.v
2：1复用器

### mux3.v
3输入复用器

### regfile.v
寄存器文件

### signnext.v
符号扩展模块

### sl2.v
左移单元

### wave.vcd
输出的波形文件
