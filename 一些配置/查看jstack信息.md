# 查看jstack信息

1. top  查看占用最高的  java  PID

   ```c
    PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
    1847 root      20   0 6852m 2.0g 6908 S 49.2 12.7   4009:08 java
    1253 root      10 -10  162m  43m 5652 S  0.7  0.3 250:37.33 AliYunDun
    9000 root      20   0 3747m 923m 6916 S  0.7  5.7 197:13.12 java
   12499 root      20   0 3851m 1.0g 6956 S  0.7  6.4  80:09.51 java
   17522 root      20   0 3696m 927m 6952 S  0.7  5.8 121:06.43 java
    1814 nobody    20   0 29160 6704 2236 S  0.3  0.0   8:35.38 nginx
   
   ```

2. lsof -p PID  查看改程序全路径

   ```c
   [root@iZbp16wgquf8g51238liksZ ~]# lsof -p 1847
   COMMAND  PID USER   FD   TYPE             DEVICE SIZE/OFF    NODE NAME
   java    1847 root  cwd    DIR              252,1     4096       2 /
   java    1847 root  rtd    DIR              252,1     4096       2 /
   java    1847 root  txt    REG              252,1     7734 1053964 /usr/local/jdk1.8.0_171/jre/bin/java
   java    1847 root  mem    REG              252,1    98365 1057193 /usr/local/tomcat-8082/webapps/ROOT/WEB-INF/lib/curvesapi-1.04.jar
   java    1847 root  mem    REG              252,1    99987 1057199 /usr/local/tomcat-8082/webapps/ROOT/WEB-INF/lib/jackson-datatype-jsr310-2.9.6.jar
   
   ```

3. ps -mp 1847(PID) -o THREAD,tid,time           -m:显示所有线程     -p:pid进程使用cpu的时间      -o:该参数后面是用户自定义格式--查看哪个线程占用较多cpu

   ```c
   USER     %CPU PRI SCNT WCHAN  USER SYSTEM   TID     TIME
   root     18.8   -    - -         -      -     - 2-18:51:03
   root      0.0  19    - futex_    -      -  1847 00:00:00
   root      0.0  19    - ep_pol    -      -  2238 00:00:34
   root      0.0  19    - futex_    -      -  2239 00:00:00
   root      0.0  19    - futex_    -      -  2240 00:00:00
   root      0.1  19    - futex_    -      -  2241 00:26:17
   root      0.1  19    - futex_    -      -  2242 00:26:06
   root      0.1  19    - futex_    -      -  2243 00:26:08
   root     18.2  19    - futex_    -      -  2244 2-16:39:15
   root      0.0  19    - futex_    -      -  2245 00:00:01
   
   ```

   或者：top -Hp PID        下面的pid是该进程下各线程的id==TID

   ```c
   [root@iZbp16wgquf8g51238liksZ ~]# top -Hp 1874
   top - 11:45:24 up 14 days, 18:37,  1 user,  load average: 0.87, 0.89, 0.90
   Tasks:  55 total,   0 running,  55 sleeping,   0 stopped,   0 zombie
   Cpu(s): 41.7%us, 25.5%sy,  0.0%ni, 32.7%id,  0.0%wa,  0.0%hi,  0.0%si,  0.0%st
   Mem:  16467184k total, 16287272k used,   179912k free,    66836k buffers
   Swap:        0k total,        0k used,        0k free,   368256k cached
   
     PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
    2289 root      20   0 6830m 2.0g 6900 S 63.9 12.5   3838:48 java
    2319 root      20   0 6830m 2.0g 6900 S  0.3 12.5  26:24.26 java
    2320 root      20   0 6830m 2.0g 6900 S  0.3 12.5  26:29.19 java
    1874 root      20   0 6830m 2.0g 6900 S  0.0 12.5   0:00.00 java
    1880 root      20   0 6830m 2.0g 6900 S  0.0 12.5   0:01.14 java
    1894 root      20   0 6830m 2.0g 6900 S  0.0 12.5  14:20.28 java
   ```

4. 查看占用cpu较多的线程id-TID      2244
   需要将tid转换为16进制           printf "%x\n" tid====printf "%x\n" 2244---->8c4

5. 查看jstack  ==  jstack 1847(PID) | grep 8c4(pid) -A60

