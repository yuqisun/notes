在机器中表示一个浮点数时需要给出指数，这个指数用整数形式表示，这个整数叫做阶码，阶码指明了小数点在数据中的位置。
对于任意一个二进制数N，可用N=S×2^P表示，其中S为尾数，P为阶码，2为阶码的底，P、S都用二进制数表示，S表示N的全部有效数字，P指明小数点的位置。
当阶码为固定值时，数的这种表示法称为定点表示，这样的数称为“定点数”；当阶码为可变时，数的这种表示法称为浮点表示，这样的数称为“浮点数”。

#### 范围
float 和 double 的范围是由指数的位数来决定的。
float的指数位有8位，而double的指数位有11位，分布如下：
> float： 1bit（符号位）8bits（指数位） 23bits（尾数位）  
> double：1bit（符号位）11bits（指数位）52bits（尾数位）

于是，float的指数范围为-126~+127(2^7)，而double的指数范围为-1022~+1023(2^10)，并且指数位是按补码的形式来划分的。
由于隐匿一位偏移导致偏移量整体-1，其中负指数决定了浮点数所能表达的绝对值最小的非零数；而正指数决定了浮点数所能表达的绝对值最大的数，也即决定了浮点数的取值范围。

float的范围为-2^127 ~ +2^127，也即-3.40E+38 ~ +3.40E+38；double的范围为-2^1023 ~ +2^1023，也即-1.79E+308 ~ +1.79E+308。

#### 精度  
float 和 double 的精度是由尾数的位数来决定的。
浮点数在内存中是按科学计数法来存储的，其整数部分始终是一个隐含着的 “1”，由于它是不变的，故不能对精度造成影响。  
> float：2^23 = 8388608，二进制转换成十进制，一共七位，这意味着最多能有7位有效数字，但绝对能保证的为6位，也即float的精度为6 ~ 7位有效数字
> 
> double：2^52 = 4503599627370496，一共16位，同理，double的精度为15 ~ 16位

#### 引用
* [IEEE 754格式是什么?](https://www.zhihu.com/question/21711083)

