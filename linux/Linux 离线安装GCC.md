1. [Linux 安装GCC讲解(在线和无网离线)](https://www.cnblogs.com/xuliangxing/p/7132018.html)  
2. [linux 离线安装gcc](https://blog.csdn.net/hjbcww/article/details/72761066)  
首先按照这个文章下载需要的 rpm包，但是不要用 rpm 命令一个一个安装，使用第二个文章里的 `rpm -Uvh *.rpm --nodeps --force`进行安装，再 `gcc -v`验证一下安装成功:

```
[root@hostname]# rpm -Uvh *.rpm --nodeps --force
warning: cloog-ppl-0.15.7-1.2.el6.x86_64.rpm: Header V3 RSA/SHA256 Signature, key ID c105b9de: NOKEY
Preparing...                ########################################### [100%]
   1:glibc-common           ########################################### [  8%]
   2:glibc                  ########################################### [ 15%]
   3:mpfr                   ########################################### [ 23%]
   4:cpp                    ########################################### [ 31%]
   5:ppl                    ########################################### [ 38%]
   6:cloog-ppl              ########################################### [ 46%]
   7:libstdc++-devel        ########################################### [ 54%]
   8:kernel-headers         ########################################### [ 62%]
   9:glibc-headers          ########################################### [ 69%]
  10:glibc-devel            ########################################### [ 77%]
  11:gcc                    ########################################### [ 85%]
  12:gcc-c++                ########################################### [ 92%]
  13:glibc                  warning: /etc/localtime created as /etc/localtime.rpmnew
########################################### [100%]

---

[root@sd-a539-a8be gcc]# gcc -v
Using built-in specs.
Target: x86_64-redhat-linux
Configured with: ../configure --prefix=/usr --mandir=/usr/share/man --infodir=/usr/share/info --with-bugurl=http://bugzilla.redhat.com/bugzilla --enable-bootstrap --enable-shared --enable-threads=posix --enable-checking=release --with-system-zlib --enable-__cxa_atexit --disable-libunwind-exceptions --enable-gnu-unique-object --enable-languages=c,c++,objc,obj-c++,java,fortran,ada --enable-java-awt=gtk --disable-dssi --with-java-home=/usr/lib/jvm/java-1.5.0-gcj-1.5.0.0/jre --enable-libgcj-multifile --enable-java-maintainer-mode --with-ecj-jar=/usr/share/java/eclipse-ecj.jar --disable-libjava-multilib --with-ppl --with-cloog --with-tune=generic --with-arch_32=i686 --build=x86_64-redhat-linux
Thread model: posix
gcc version 4.4.7 20120313 (Red Hat 4.4.7-4) (GCC) 

```


下载GCC所有需要的依赖包，逐个安装，可以从网站 http://www.rpmfind.net/linux/rpm2html/search.php 搜索下载，下面是所需要安装的GCC依赖列表

> 安装gcc编译环境依赖(真实版本可能有所不同，这无关紧要)：  
安装gcc模块依赖：cloog-ppl、cpp、glibc-devel、libgomp、libgomp.so.1  
安装cloog-ppl模块依赖：libppl.so.7、libppl_c.so.2  
安装libppl.so.7、libppl_c.so.2模块依赖：无  
安装cpp模块依赖：libmpcfr.so.1  
安装libmpcfr.so.1模块依赖：无  
安装glibc-devel模块依赖：glibc-headers  
安装glibc-headers模块依赖：kernel-headers  
安装kernel-headers模块依赖：无  
安装libgomp、libgomp.so.1模块依赖：无  

> 安装顺序：  
rpm -ivh ppl-0.10.2-11.el6.x86_64.rpm                          #ppl(libppl.so.7、libppl_c.so.2)  
rpm -ivh cloog-ppl-0.15.7-1.2.el6.x86_64.rpm                   #cloog-ppl  
rpm -ivh mpfr-2.4.1-6.el6.x86_64.rpm                           #libmpcfr.so.1  
rpm -ivh cpp-4.4.7-17.el6.x86_64.rpm                           #cpp  
rpm -ivh kernel-headers-2.6.32-642.el6.x86_64.rpm              #kernel-headers  
rpm -ivh glibc-headers-2.12-1.192.el6.x86_64.rpm               #glibc-headers  
rpm -ivh glibc-devel-2.12-1.192.el6.x86_64.rpm                 #glibc-devel  
rpm -ivh libgomp-4.4.7-17.el6.x86_64.rpm                       #libgomp(libgomp、libgomp.so.1)  
rpm -ivh gcc-4.4.7-17.el6.x86_64.rpm                           #gcc  
至此安装成功  
