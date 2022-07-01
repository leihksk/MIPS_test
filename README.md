# Verilog HDL 实现MIPS流水线处理器
---
本项目使用Icarus Verilog（iverilog）仿真与输出VCD波形文件+GTKwave显示波形  
复现MIPS5级流水线处理器  
实现了解决控制冲突，使用阻塞和重定向解决数据冲突以解决多阶段流水线产生的冲突  
实现10条指令：lw,sw,beq,addi,j,add,sub,and,or,slt  

四个流水线寄存器中，取指令阶段到译码阶段的流水线寄存器在datapath_p.v中。译码——执行，执行——存储器，存储器——写回的三个流水线寄存器包含在ctrl.v中，控制单元产生的控制信号与数据路径中的数据信息分开，控制信号在ctrl.v产生，数据信息在datapath_p.v中操作  
冲突单元模块由控制信号与数据信息产生阻塞信号stall与数据选择信号forward  

---
## 测试流程
安装Icarus Verilog与GTKwave, 执行命令：  
	`$ sudo pacman -S iverilog`  
	`$ sudo pacman -S gtkwave`   

执行命令：   
	`$ iverilog testbench.v`   
	`$ ./a.out`   
执行仿真，执行./a.out后可以执行`finish`结束仿真  

执行命令：   
	`$ gtkwave wave.vcd`   
打开wave.vcd查看波形  

---
## 组件

### testbench.v
测试程序，时钟信号与重置信号输入

### top.v
顶层模块，处理器的根模块，用以例化的所有模块   
top模块的结构如下：   
![top模块](https://raw.githubusercontent.com/leihksk/MIPS_test/main/doc/picture/top.png)   

### dmemp.v
数据存储器，从文件读取指令数据，输入读取或写入地址a，写入指令wd，写入使能端we，读取数据rd

### imem.v
指令存储器，从文件读取16进制指令，输入读取地址a，输出读取指令rd   

### adder.v
加法器模块，输出信号y为输入信号a，b的算数和   

### alu_p.v
算术逻辑单元模块，输入数据信号a，b，控制信号alucontrol，根据控制信号1，2位决定执行逻辑与/逻辑或/算数和/小于则置位运算以得出输出数据信号aluout，根据控制信号第3位决定输入数据信号b是否取反   
实现的算数逻辑单元的结构如下：  
![alu模块](https://raw.githubusercontent.com/leihksk/MIPS_test/main/doc/picture/alu.png)   

### comparator.v
比较器模块，输出信号eq为输入信号a，b的相等判断的结果

### ctrl.v
控制单元模块，输入数据信号op，funct产生输出的控制信号regwrite,memtoreg,memwrite,alucontrol,alusrc,regdst,branch。该模块中译码——执行，执行——存储器，存储器——写回的三个流水线寄存器用以传播该模块产生的控制信号   
实现的控制单元结构如下：  
![ctrl模块](https://raw.githubusercontent.com/leihksk/MIPS_test/main/doc/picture/ctrl.png)  

### datapath_p.v
数据路径模块，输入信号instr，readdataM分别自指令存储器和数据存储器读取，输出pc，aluout，writedata到顶层模块以读写数据，输出控制信号op，funct，zero，flushE到ctrl生成控制信号。包含了5个阶段的数据处理，各阶段间传播数据信号的流水线寄存器，冲突处理单元   
实现的数据路径结构如下：  
![datapath模块](https://raw.githubusercontent.com/leihksk/MIPS_test/main/doc/picture/datapath.png)  

### execute
执行阶段模块，输入控制信号alusrcE,regdst,alucontrolE，从流水线寄存器输入数据信号rd1E,rd2E，rdE,rtE,signE，冲突单元输入冲突控制信号forwardaE,forwardbE,冲突数据信号aluoutM,resultW，输出writedataE,writeregE,aluoutE到流水线寄存器
execute阶段模块结构如下：   
![execute模块](https://raw.githubusercontent.com/leihksk/MIPS_test/main/doc/picture/execute.png)  

### flopr
可复位触发器，默认位宽8,输入信号d，随时钟赋值给输出信号q，复位信号为真则q为0

### flopenr
带使能端的可复位触发器，默认位宽8,输入信号d，en，随时钟信号，复位信号为真则q为0;复位信号不为真，使能端en为真则将d的值赋值给输出信号q

### floprc
带清零功能的可复位触发器，默认位宽8,输入信号d，flush，随时钟赋值给输出信号q，复位信号为真则q为0，flush为真则q为0

### flopenrc
带使能端和清零功能的可复位触发器，默认位宽8,输入信号d，flush，en，随时钟信号，复位信号为真则q为0，flush为真则q为0，使能端en为真则将d的值赋值给输出信号q

### fu_ex.v
产生执行阶段的阻塞信号，输出信号forwardAE由输入信号regwriteW,regwriteM,writeregW,rsE,writeregM决定;输出信号forwardBE由regwriteW,regwriteM,writeregW,rtE,writeregM决定   
执行阶段的冲突处理模块结构如下： 
![fu_ex模块](https://raw.githubusercontent.com/leihksk/MIPS_test/main/doc/picture/fu_ex.png)  

### fu_id.v
产生译码阶段的阻塞信号，输入信号rsD,rtD,writeregM,regwriteM。若rsD与writeregM相等，同时rsD，regwriteM不为0,输出信号forwardAD为真;若rtD与writeregM相等，同时rtD，regwriteM不为0,输出信号forwardBD为真   
译码阶段的冲突处理模块结构如下： 
![fu_id模块](https://raw.githubusercontent.com/leihksk/MIPS_test/main/doc/picture/fu_id.png)  

### hazard.v
冲突单元模块，输入信号regwriteM,regwriteW,regwriteE,rsE,rtE,rsD,rtD,writeregE,writeregM,writeregW,memtoregE,memtoregM,branchD，输出解决冲突的控制信号forwardAD,forwardBD,forwardAE,forwardBE，阻塞信号stallF,stallD,flushE   
实现的冲突单元模块结构如下：  
![hazard模块](https://raw.githubusercontent.com/leihksk/MIPS_test/main/doc/picture/hazard.png)  

### e_m.v
数据路径中执行阶段到存储器模块的流水线寄存器，传递数据信号aluout，writedata，writereg

### id_e.v
数据路径中译码阶段到执行阶段的流水线寄存器，flushE控制清零，传递数据信号rd1,rd2,rd，rt，td，signimm

### m_w.v
数据路径中存储器阶段到写回阶段的流水线寄存器，传递数据信号readdata，aluout，writereg

### memfile.dat
16进制的18条测试指令

### MIPS.v
实例化控制单元与数据路径，输出取指令地址，执行从指令存储器读取的指令，输出将写入数据存储器的控制信号，数据信息与写入地址   
mips模块结构如下：   
![mips模块](https://raw.githubusercontent.com/leihksk/MIPS_test/main/doc/picture/mips.png)  

### mux2.v
2：1复用器，由输入信号s决定将输入信号d0或d1赋值给输出信号y

### mux3.v
3输入复用器，由输入信号forward决定将输入信号rd或resultW或alusrcW赋值给输出信号muxresult

### regfile.v
寄存器文件，输入读数据地址ra1,ra2，写数据地址wa3,写数据信号wd3,写数据使能端we3，输出数据信号rd1,rd2,初始为00000000

### signnext.v
符号扩展模块，将16位输入信号a的值赋值给32位输出信号y的对应位，将a的最高位赋值给y的其余位

### sl2.v
逻辑左移单元，输出信号y为输入信号a逻辑左移2位的结果


