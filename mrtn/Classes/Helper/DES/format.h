/*
*����˵����
*	���ļ�˵�������ַ�����ʽ����ĺ�����
*	
*��Ȩ��
*	������Ŀ��		���ҳ�
*	��д���ڣ�		2001.11.17
*	�޸����ڣ�		2001.12.03
*/
#ifndef D_FORMAT
#define	D_FORMAT

#include <string.h>
#include "ctype.h"

#include "define.h"

extern	char	*RTrim(char *s);
/*
	���β���ո�

	�������:
		s	Դ�ַ���

	�������:
		��

	����ֵΪĿ���ַ���ָ��
*/
extern	char	*LTrim(char *s);
/*
	����ײ��ո�

	�������:
		s	Դ�ַ���

	�������:
		��

	����ֵΪĿ���ַ���ָ��
*/
extern	char	*AllTrim(char *s);
/*
	�����β�ո�

	�������:
		s	Դ�ַ���

	�������:
		��

	����ֵΪĿ���ַ���ָ��
*/
extern	char	*MTrim(char *s);
/*
	ȥ���м������ո�

	�������:
		s	Դ�ַ���

	�������:
		��

	����ֵΪĿ���ַ���ָ��
*/
extern	char	*LowerString(char *s);
/*
	���ַ�����ȫ����ĸΪСд

	�������:
		s	Դ�ַ���

	�������:
		��

	����ֵΪĿ���ַ���ָ��
*/
extern	char	*UpperString(char *s);
/*
	���ַ�����ȫ����ĸΪ��д

	�������:
		s	Դ�ַ���

	�������:
		��

	����ֵΪĿ���ַ���ָ��
*/
extern	char	*SubString(char *src,char *dst,int start,int len);
/*
	ȡ���ַ���

	�������:
		src		Դ�ַ���
		start		��ʼλ��
		len		����

	�������:
		dst		Ŀ�Ļ�����

	����ֵΪĿ���ַ�������
*/
extern	char	*ReverseString(char *s);
/*
	�����ַ����е���ĸ

	�������:
		s	Դ�ַ���

	�������:
		��

	����ֵΪĿ���ַ���ָ��
*/
extern	int	DBCCaseToSBCCase(BYTE *src,BYTE *dst,int size);
/*
	���תȫ��

	�������:
		src		Դ�ַ���
		size		Ŀ�Ļ�������С

	�������:
		dst		Ŀ�Ļ�����

	����ֵΪĿ���ַ�������
*/
extern	int	SBCCaseToDBCCase(BYTE *src,BYTE *dst,int size);
/*
	ȫ��ת���

	�������:
		src		Դ�ַ���
		size		Ŀ�Ļ�������С

	�������:
		dst		Ŀ�Ļ�����

	����ֵΪĿ���ַ�������
*/

#define	PACK 		168 	/*	16�ֽڵ�ʮ��������ѹ��Ϊ8�ֽ�	*/
#define	UNPACK 		816 	/*	ѹ����ʮ������չ��Ϊ16�ֽ�	*/
#define CHAR_TO_HEX	0xa0 	/*	�ַ���תΪʮ�������� 		*/
#define	HEX_TO_CHAR	0x0a 	/*	ʮ��������ת��Ϊ�ַ���		*/

extern	int	FormatData(BYTE *source,BYTE *target,int len,int op);
/*
	��ʽ������
	
	�������:
		source	Դ����
		len	Դ���ݳ��ȡ�
		op	ȡ�����ĸ����ݲ�����

	�������:
		target	Ŀ������

	����ֵ��ʾĿ�����ݵĳ��ȡ�
*/

extern	char	*UpperAmount(char *amount);
/*
	�����ת���ɴ�д��ʾ����

	�������:
		amount		�ַ���ʽ���

	�������:
		��

	����ֵΪ��д�ַ���ָ��
*/

extern int GetNumberInfo( char *pacInBuff, int  iInBuffLen, \
                         int  iNumber,    char cDiv,        \
                        char *pacOutBuff,int  *iOutBuffLen );
/*
 * ��  ��: �õ���n�����ݿ���Ϣ,iNumber��1��ʼ,
 *         �����һ���ָ���֮��û�ж����򷵻�-1;���ж������з���0
 *
 *         "11,22,33,44",ȡ��һ�����ݿ�"11",ȡ���ĸ����ݿ�"44"
 *
 *         ����Ϊ["\0"]��ʱ��ȡ��һ�����ݿ鷵��ֵΪ-1,pacOutBuffΪ��
 *         ����Ϊ[1234]ʱ��ȡȡ��һ�����ݿ鷵��ֵΪ0, pacOutBuffΪ[1234]
 *
 * ��  ��:
 *         pacInBuff        - I      �����ַ���
 *         iInBuffLen       - I      �����ַ�������������
 *         iNumber          - I      ��Ҫ���ҵ����������
 *         cDiv             - I      �ָ���
 *         pacOutBuff       - O      ���������
 *         iOutBuffLen      - I      �������������
 * ��  ֵ:
 *      0:ȡ��������
 *     -1:û��ȡ������
 *     -2:���ַ���ָ��ΪNULLʱ��
 *        iNumber<1
*/

extern char *DelReturn(char *s,char *d);
/* ���ַ����еĻس�ȥ��*/

extern void   Substitute(char   *pInput,   char   *pOutput,   char   *pSrc,   char   *pDst);
/*�ַ����滻����*/

#endif
