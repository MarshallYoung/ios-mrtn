/*
*函数说明：
*   本文件为DES和3DES加密函数。
*   
*版权：
*   北京项目组      李忠诚 
*   编写日期：      2002.04.17
*   修改日期：      2002.04.18
*/
#ifndef D_SOFT_DES
#define D_SOFT_DES

#include "define.h"
#include "format.h"

#define ENCRYPT     1       /*      加密        */
#define DECRYPT     0       /*      解密        */

extern void SoftDES(BYTE *binsource, BYTE *binkey,int mode, BYTE *bindest);
/*  
    DES加密函数,参数类型为64bit二进制数     

    输入参数:
        binsource   64bit源数据
        binkey      64bit密钥
        mode        取值DECRYPT/ENCRYPT
        bindest     64bit目标数据

    输出参数:
        无

    返回值为零表示成功,返回值小于零表示出错
*/

extern void SoftDESASC(char *source,char *key,int mode,char *dest);
/*  
    DES加密函数,参数类型为ASCII十六进制字符串   

    输入参数:
        source  16字节源数据
        key     16字节密钥
        mode    取值DECRYPT/ENCRYPT
        dest    16字节目标数据

    输出参数:
        无

    返回值为零表示成功,返回值小于零表示出错
*/


extern void Soft3DES(BYTE *binsource, BYTE *binkey,int mode, BYTE *bindest);
/*  
    3DES加密函数,参数类型为64bit二进制数        

    输入参数:
        binsource   64bit源数据
        binkey      64bit密钥
        mode        取值DECRYPT/ENCRYPT
        bindest     64bit目标数据

    输出参数:
        无

    返回值为零表示成功,返回值小于零表示出错
*/

extern void Soft3DESASC(char *source,char *key,int mode,char *dest);
/*  
    3DES加密函数,参数类型为ASCII十六进制字符串  

    输入参数:
        source  16字节源数据
        key     16字节密钥
        mode    取值DECRYPT/ENCRYPT
        dest    16字节目标数据

    输出参数:
        无

    返回值为零表示成功,返回值小于零表示出错
*/

#endif
