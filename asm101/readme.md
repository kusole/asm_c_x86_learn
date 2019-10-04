# 通过c语言学习汇编
## 一般步骤
1、编写简单的C语言

2、编译 CC -c file.c -o file.o

- 只使用 -c 编译
- 使用优化参数和不使用优化参数编译
  
3、反编译目标文件 objdum -d file.o

4、使用LLDB(或GDB)调试运行

5、阅读与学习

- CSSAPP - <<深入理解计算机系统>>
- Intel 64 and IA 32 Architectures Software Developer's Manual
- LLDB文档（LLVM）或 GDB/GCC 文档
- 其他网络资料

## 简单的C语言
### 1、代码
```c
long calc_area(long width, long height) {
    return width * height;
}
```
### 2、编译
```c
cc -o area_price.s -S area_price.c #汇编文件
cc -o area_price.o -c area_price.c #目标文件
```
### 3、反汇编
```c
#objdump -d area_price.o
area_price.o:     file format elf64-x86-64
Disassembly of section .text:
0000000000000000 <calc_area>:
   0:   55                      push   %rbp
   1:   48 89 e5                mov    %rsp,%rbp
   4:   48 89 7d f8             mov    %rdi,-0x8(%rbp)
   8:   48 89 75 f0             mov    %rsi,-0x10(%rbp)
   c:   48 8b 45 f8             mov    -0x8(%rbp),%rax
  10:   48 0f af 45 f0          imul   -0x10(%rbp),%rax
  15:   5d                      pop    %rbp
  16:   c3                      retq   
```
### 4、直接汇编
```c
#cat area_price.s 
        .file   "area_price.c"
        .text
        .globl  calc_area
        .type   calc_area, @function
calc_area:
.LFB0:
        .cfi_startproc
        pushq   %rbp
        .cfi_def_cfa_offset 16
        .cfi_offset 6, -16
        movq    %rsp, %rbp
        .cfi_def_cfa_register 6
        movq    %rdi, -8(%rbp)
        movq    %rsi, -16(%rbp)
        movq    -8(%rbp), %rax
        imulq   -16(%rbp), %rax
        popq    %rbp
        .cfi_def_cfa 7, 8
        ret
        .cfi_endproc
.LFE0:
        .size   calc_area, .-calc_area
        .ident  "GCC: (GNU) 4.8.5 20150623 (Red Hat 4.8.5-36)"
        .section        .note.GNU-stack,"",@progbits
```
### 5、优化参数汇编 -O1
```c
#cc -o area_price.s -O1 -S area_price.c #汇编文件
#cat area_price.s
        .file   "area_price.c"
        .text
        .globl  calc_area
        .type   calc_area, @function
calc_area:
.LFB0:
        .cfi_startproc
        movq    %rdi, %rax
        imulq   %rsi, %rax
        ret
        .cfi_endproc
.LFE0:
        .size   calc_area, .-calc_area
        .ident  "GCC: (GNU) 4.8.5 20150623 (Red Hat 4.8.5-36)"
        .section        .note.GNU-stack,"",@progbits
```

## 寄存器
从 ax 到 eax 到 rax

ax: 16位

eax: 32位

rax: 64位

### 常用寄存器
- 1F eflags (分支，比较，测试，跳转)
- 2I rdi, rsi (组记单词: diss)
- 3P rbp, rip, rsp
- 4X rax, rbx, rcx, rdx (abcd)
- r8r15 r8,r9,r10,r11,r12,r13,r14,r15
- 6S CS,DS,ES,SS,FS,GS（64位一般不用）

### 惯用法
1、rax Accumulator for operands and result data (用于返回值)

2、rbx Pointer to data in the DS segment

3、rcx Counter for string and loop operations

4、rdx I/0 pointer

5、rsi source pointer for string operations. (src index)

6、rdi destination for string operations. (dest index)

7、rbp pointer to data on the stack

8、rsp Stack pointer

9、rip PC



