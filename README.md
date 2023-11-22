@Date: 2023.11
@Author: Kaifeng Li, Zhenzhao Yuan, Zhi Wang
## About
Experiment

## Src
- 字符速率：clk_AD ≈ 108.5kHz --> clk_character_rate ≈ 108.5kHz
- 比特传输速率：clk_serialAD ≈ 976.6kHz --> clk_bitTransferRate ≈ 976.6kHz
- FSK调制器的驱动时钟：clk2 = 15.625MHz --> FSK_clk = 15.625MHz
- 三个计数器变量：k --> serialSignalCount_ctr （负责计算接收到的串行信号的数目）
- flag --> serialConversion_flag （在clk_serialAD的低电平时打开串并转换，在高电平时关闭串并转换，保证在一个clk_receive的周期内只有一次的输出）
- j --> pulseCount_ctr （用于计算收到的脉冲的数目，用以后面的判断来决定收到的是0还是1）