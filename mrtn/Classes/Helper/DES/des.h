/*
*����˵����
*   ���ļ�ΪDES��3DES���ܺ�����
*   
*��Ȩ��
*   ������Ŀ��      ���ҳ� 
*   ��д���ڣ�      2002.04.17
*   �޸����ڣ�      2002.04.18
*/
#ifndef D_SOFT_DES
#define D_SOFT_DES

#include "define.h"
#include "format.h"

#define ENCRYPT     1       /*      ����        */
#define DECRYPT     0       /*      ����        */

extern void SoftDES(BYTE *binsource, BYTE *binkey,int mode, BYTE *bindest);
/*  
    DES���ܺ���,��������Ϊ64bit��������     

    �������:
        binsource   64bitԴ����
        binkey      64bit��Կ
        mode        ȡֵDECRYPT/ENCRYPT
        bindest     64bitĿ������

    �������:
        ��

    ����ֵΪ���ʾ�ɹ�,����ֵС�����ʾ����
*/

extern void SoftDESASC(char *source,char *key,int mode,char *dest);
/*  
    DES���ܺ���,��������ΪASCIIʮ�������ַ���   

    �������:
        source  16�ֽ�Դ����
        key     16�ֽ���Կ
        mode    ȡֵDECRYPT/ENCRYPT
        dest    16�ֽ�Ŀ������

    �������:
        ��

    ����ֵΪ���ʾ�ɹ�,����ֵС�����ʾ����
*/


extern void Soft3DES(BYTE *binsource, BYTE *binkey,int mode, BYTE *bindest);
/*  
    3DES���ܺ���,��������Ϊ64bit��������        

    �������:
        binsource   64bitԴ����
        binkey      64bit��Կ
        mode        ȡֵDECRYPT/ENCRYPT
        bindest     64bitĿ������

    �������:
        ��

    ����ֵΪ���ʾ�ɹ�,����ֵС�����ʾ����
*/

extern void Soft3DESASC(char *source,char *key,int mode,char *dest);
/*  
    3DES���ܺ���,��������ΪASCIIʮ�������ַ���  

    �������:
        source  16�ֽ�Դ����
        key     16�ֽ���Կ
        mode    ȡֵDECRYPT/ENCRYPT
        dest    16�ֽ�Ŀ������

    �������:
        ��

    ����ֵΪ���ʾ�ɹ�,����ֵС�����ʾ����
*/

#endif
