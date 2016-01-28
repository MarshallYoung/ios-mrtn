/*
*函数说明：
*	本文件说明部分字符串格式处理的函数。
*	
*版权：
*	北京项目组		李忠诚
*	编写日期：		2001.11.17
*	修改日期：		2001.12.03
*/
#ifndef D_FORMAT
#define	D_FORMAT

#include <string.h>
#include "ctype.h"

#include "define.h"

extern	char	*RTrim(char *s);
/*
	清除尾部空格

	输入参数:
		s	源字符串

	输出参数:
		无

	返回值为目的字符串指针
*/
extern	char	*LTrim(char *s);
/*
	清除首部空格

	输入参数:
		s	源字符串

	输出参数:
		无

	返回值为目的字符串指针
*/
extern	char	*AllTrim(char *s);
/*
	清除首尾空格

	输入参数:
		s	源字符串

	输出参数:
		无

	返回值为目的字符串指针
*/
extern	char	*MTrim(char *s);
/*
	去除中间连续空格

	输入参数:
		s	源字符串

	输出参数:
		无

	返回值为目的字符串指针
*/
extern	char	*LowerString(char *s);
/*
	变字符串中全部字母为小写

	输入参数:
		s	源字符串

	输出参数:
		无

	返回值为目的字符串指针
*/
extern	char	*UpperString(char *s);
/*
	变字符串中全部字母为大写

	输入参数:
		s	源字符串

	输出参数:
		无

	返回值为目的字符串指针
*/
extern	char	*SubString(char *src,char *dst,int start,int len);
/*
	取子字符串

	输入参数:
		src		源字符串
		start		起始位置
		len		长度

	输出参数:
		dst		目的缓冲区

	返回值为目的字符串长度
*/
extern	char	*ReverseString(char *s);
/*
	反排字符串中的字母

	输入参数:
		s	源字符串

	输出参数:
		无

	返回值为目的字符串指针
*/
extern	int	DBCCaseToSBCCase(BYTE *src,BYTE *dst,int size);
/*
	半角转全角

	输入参数:
		src		源字符串
		size		目的缓冲区大小

	输出参数:
		dst		目的缓冲区

	返回值为目的字符串长度
*/
extern	int	SBCCaseToDBCCase(BYTE *src,BYTE *dst,int size);
/*
	全角转半角

	输入参数:
		src		源字符串
		size		目的缓冲区大小

	输出参数:
		dst		目的缓冲区

	返回值为目的字符串长度
*/

#define	PACK 		168 	/*	16字节的十六进制数压缩为8字节	*/
#define	UNPACK 		816 	/*	压缩的十六进制展开为16字节	*/
#define CHAR_TO_HEX	0xa0 	/*	字符型转为十六进制数 		*/
#define	HEX_TO_CHAR	0x0a 	/*	十六进制数转化为字符串		*/

extern	int	FormatData(BYTE *source,BYTE *target,int len,int op);
/*
	格式化数据
	
	输入参数:
		source	源数据
		len	源数据长度。
		op	取以上四个数据操作。

	输出参数:
		target	目的数据

	返回值表示目标数据的长度。
*/

extern	char	*UpperAmount(char *amount);
/*
	将金额转换成大写表示方法

	输入参数:
		amount		字符形式金额

	输出参数:
		无

	返回值为大写字符串指针
*/

extern int GetNumberInfo( char *pacInBuff, int  iInBuffLen, \
                         int  iNumber,    char cDiv,        \
                        char *pacOutBuff,int  *iOutBuffLen );
/*
 * 功  能: 得到第n个数据块信息,iNumber从1开始,
 *         若最后一个分隔符之后没有东西则返回-1;若有东西则有返回0
 *
 *         "11,22,33,44",取第一个数据块"11",取第四个数据块"44"
 *
 *         输入为["\0"]的时候取第一个数据块返回值为-1,pacOutBuff为空
 *         输入为[1234]时候取取第一个数据块返回值为0, pacOutBuff为[1234]
 *
 * 参  数:
 *         pacInBuff        - I      输入字符串
 *         iInBuffLen       - I      输入字符串缓冲区长度
 *         iNumber          - I      需要查找的数据项序号
 *         cDiv             - I      分隔符
 *         pacOutBuff       - O      输出缓冲区
 *         iOutBuffLen      - I      输出缓冲区长度
 * 返  值:
 *      0:取到数据了
 *     -1:没有取到数据
 *     -2:当字符串指针为NULL时候
 *        iNumber<1
*/

extern char *DelReturn(char *s,char *d);
/* 将字符串中的回车去掉*/

extern void   Substitute(char   *pInput,   char   *pOutput,   char   *pSrc,   char   *pDst);
/*字符串替换函数*/

#endif
