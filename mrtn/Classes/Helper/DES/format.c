/*
*函数说明：
*	本文件说明部分字符串格式处理的函数。
*	
*版权：
*	北京项目组		李忠诚
*	编写日期：		2001.11.17
*	修改日期：		2001.12.03
*/
#include "format.h"

char	*gSBCCaseString = 
{ 
	" 0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ+-=_(),.{}[]:;'\"<>/?#$%^&*|\\`~" 
};

char	*gDBCCaseString = 
{
	 "　０１２３４５６７８９ａｂｃｄｅｆｇｈｉｊｋｌｍｎｏｐｑｒｓｔｕｖｗｘｙｚＡＢＣＤＥＦＧＨＩＪＫＬＭＮＯＰＱＲＳＴＵＶＷＸＹＺ＋－＝＿（），．｛｝［］：；＇＂＜＞／？＃＄％︿＆＊｜＼｀～"
};

char	*LTrim(char *s)
{
	static	char	*cp;

	cp=s;
	while ((*cp=='\n'||*cp==' '||*cp=='\r'||*cp=='\t') && cp<s+strlen(s)-1) cp++;

	strcpy(s,cp);

	return	s;
}
char	*RTrim(char *s)
{
	static	char	*cp;

	cp=s+strlen(s)-1;

	while(cp>=s && (*cp==' '||*cp=='\t'||*cp=='\r'||*cp=='\n'))  *cp--='\0';

	return	s;
}
char	*MTrim(char *s)
{
	static	char	*dp,*sp;
	int	flag;
	
	sp=dp=s;
	flag=FALSE;

	while (sp < s+strlen(s))
	{
		while ((*sp=='\n'||*sp==' '||*sp=='\r'||*sp=='\t')) sp++;
		*dp++=*sp;
		sp++;
	}
	*dp=0;

	return	s;
}
char	*AllTrim(char *s)
{
	LTrim(s);

	RTrim(s);

	return(s);
}
char	*LowerString(char *s)
{
	static	char	*cp;

	cp=s;
	while ( cp < s+strlen(s) ) 
	{
		if (isalpha(*cp)) *cp=tolower(*cp);
		cp++;
	}

	return	s;
}
char	*UpperString(char *s)
{
	static	char	*cp;

	cp=s;

	while (cp<s+strlen(s)) 
	{
		if (isalpha(*cp)) *cp=toupper(*cp);
		cp++;
	}

	return	s;
}
char	*SubString(char *src,char *dst,int start,int len)
{
	memcpy(dst,src+start,len);
	*(dst+len)=0;

	return	dst;
}
char	*ReverseString(char *s)
{
	static	char	buffer[BUFFER_SIZE];
	int	i,len;

	memset(buffer,0,sizeof(buffer));

	len=(int)strlen(s);

	for(i=0;i<len;i++) buffer[i]=s[(len-1)-i];

	strcpy(s,buffer);

	return	s;
}
int	SBCCaseToDBCCase(BYTE *src,BYTE *dst,int size)
{
	int	i,k,len,found;

	len=0;

	for(i=0;i<strlen((char *)src);i++)
	{
		found=FALSE;

		if (src[i]>=(unsigned char)0xa1)
		{
			if (len+2>size)	return	len;
			memcpy(dst+len,&src[i],1);
			len+=2;
			i++;
			continue;
		}

		for(k=0;found==FALSE && k<strlen(gSBCCaseString);k++)
		{
			if (gDBCCaseString[k]==src[i])
			{
				found=TRUE;
				break;
			}
		}

		if (found==TRUE)
		{
			if (len+2>size)	return	len;
			memcpy(dst+len,&gDBCCaseString[k*2],2);
			len+=2;
		}
		else
		{
			if (len+1>size)	return	len;
			memcpy(dst+len,&src[i],1);
			len++;
		}
	}
	
	return	len;
}
int	DBCCaseToSBCCase(BYTE *src,BYTE *dst,int size)
{
	int	i,k,len,found;

	len=0;

	for(i=0;i<strlen((char *)src);i++)
	{
		found=FALSE;

		if (src[i]<(unsigned char)0xa1)
		{
			if (len+1>size)	return	len;
			memcpy(dst+len,&src[i],1);
			len++;
		}

		for(k=0;found==FALSE && k<strlen(gDBCCaseString);k+=2)
		{
			if (memcmp(&src[i],&gDBCCaseString[k],2)==0)
			{
				found=TRUE;
				break;
			}
		}

		if (found==TRUE)
		{
			if (len+1>size)	return	len;
			memcpy(dst+len,&gSBCCaseString[k/2],1);
			len++;
		}
		else
		{
			if (len+2>size)	return	len;
			memcpy(dst+len,&src[i],2);
			len+=2;
		}

		i++;
		if (len>=size)	break;
	}

	return	len;
}
int	FormatData(BYTE *source,BYTE *target,int len,int op)
{
	int	i,dlen = 0;

	switch ( op ) 
	{
		case PACK :
			for (i=0;i<(len+1)/2;i++) 
				target[i]=source[i*2+1] | (source[i*2]<<4);
			dlen=(len+1)/2;
			break ;
		case UNPACK :
			for (i=0;i<len;i++) 
			{
				target[i*2]=(source[i]>>4) & 0x0f ;
				target[i*2+1]=source[i] & 0x0f ;
			}
			dlen=len*2;
			break ;
		case HEX_TO_CHAR :
			for (i=0;i<len;i++) 
			{
				if (source[i]>=0x0a && source[i]<=0x0f) 
					target[i]=source[i]-0x0a+'A' ;
				else if (source[i]<=0x09) 
					target[i]=source[i]+'0' ;
			}
			dlen=len;
			break ;
		case CHAR_TO_HEX :
			for (i=0;i<len;i++) 
			{
				if (source[i]>='0' && source[i]<='9') 
					target[i]=source[i]-'0' ;
				else if (source[i] >= 'a' && source[i]<='f') 
					target[i]=source[i]-'a'+0x0a ;
				else if (source[i] >= 'A' && source[i]<='F') 
					target[i]=source[i]-'A'+0x0a ;
			}
			dlen=len;
			break ;
	}

	return dlen;
}
char	*UpperAmount(char  *amount)
{
	char	*strnum[]={"零","壹","贰","叁","肆","伍","陆","柒","捌","玖"};
	char	*dot1[]={"","拾","佰","仟"};
	char	*dot2[]={"角","分"};
	char	*sp,buffer[BUFFER_SIZE];
	int	i,k,len,dotcnt=0,zerocnt=0,flag=FALSE;
	static	char	value[BUFFER_SIZE];
	
	memset(value,0,sizeof(value));

	strcpy(buffer,amount);

	AllTrim(buffer);
	
	sp=strchr(buffer,'.');
	if (sp==NULL)	strcat(buffer,".");

	sp=strchr(buffer,'.');
	len=(int)(sp-buffer);

	for(i=0;*(buffer+i)!=0;i++)
	{
		len--;

		if (!isdigit(*(buffer+i)) && *(buffer+i)!='.')	return NULL;

		if (*(buffer+i)=='0') 
		{
			if (flag==TRUE)	zerocnt++;
			if (dotcnt!=0)	dotcnt++;
			continue;
		}

		if (zerocnt!=0)
		{
			for(k=zerocnt+len;k>len;k--)
			{
				if (k%4==0 && k!=0)
				{
					if (k%8==0) 
					{
						zerocnt=0;
						strcat(value,"亿");
						if ((k-len)>8) continue;
						else	break;
					}
					if (k%4==0 && zerocnt!=0)
					{
						if (zerocnt-(k-len)<3) 
							strcat(value,"万");
					}
				}
			}
			if (*(buffer+i)!='.') strcat(value,"零");
			zerocnt=0;
		}

		if (*(buffer+i)=='.') 
		{
			if (flag==TRUE)  
			strcat(value,"元");
			if (dotcnt!=0)	return	NULL;
			else	dotcnt++;
			continue;
		}

		
		flag=TRUE;	/*	开始计数	*/
		strcat(value,strnum[*(buffer+i)-'0']);
		if (dotcnt!=0)
		{
			if (dotcnt++>2)	return	NULL;
			strcat(value,dot2[dotcnt-2]);
		}
		else	
		{
			if (len%8==0 && len!=0) strcat(value,"亿");
			else if (len%4==0 && len!=0) strcat(value,"万");
			else strcat(value,dot1[len%4]);
		}
	}

	if (flag==FALSE)	return	NULL;

	return	value;
}
int GetNumberInfo( char *pacInBuff, int  iInBuffLen,
int  iNumber,    char cDiv,
char *pacOutBuff,int  *iOutBuffLen )
{
	int  i,j,m,iReturn,n;
	char acBuf[1000+1];

	/* 判断 */
	if( iOutBuffLen == NULL || pacOutBuff == NULL )
	{
		return( -2 );
	}

	/* 保证 */
	strcpy( pacOutBuff,"" );
	*iOutBuffLen = -1;

	/* 判断 */
	if( pacInBuff == NULL )
	{
		return( -2 );
	}
	if( iNumber < 1 || iInBuffLen < 0 )
	{
		return( -2 );
	}

	memset( acBuf,0,sizeof(acBuf) );

	m = 0;
	j = 0;
	n = 0;

	for( i=0;i<iInBuffLen;i++ )
	{
		if(  pacInBuff[i] == cDiv || i == iInBuffLen-1  )
		{
			if( pacInBuff[i] == cDiv )
			{
				n = 1;
			}
			j++;
			if( j == iNumber )
			{
				if( i == iInBuffLen-1 )
				{
					acBuf[m++] = pacInBuff[i];
				}
				*iOutBuffLen = m;
				memcpy( pacOutBuff,acBuf,m );
				if( n == 1)
				{
					if(  acBuf[m-2]<=0x80 && acBuf[m-1] == cDiv )
					{
						*iOutBuffLen--;
						pacOutBuff[m-1] = 0;
					}
					*iOutBuffLen--;
					return( 0 );
				}
				else
				{
					*iOutBuffLen = 0;
					memset( acBuf,0,sizeof(acBuf) );

					/* 针对没有一个分隔符号的数据 */
					if( j == 1 && iNumber == 1 )
					{
						memcpy( pacOutBuff,pacInBuff,iInBuffLen );
						*iOutBuffLen = iInBuffLen;
						return( 0 );
					}

					return( -1 );
				}
			}
			else
			{
				memset( acBuf,0,sizeof(acBuf) );
				m = 0;
			}
		}
		else
		{
			if ( pacInBuff[i] <= 0x80 )
			{
				acBuf[m++] = pacInBuff[i];
			}
			else
			{
				acBuf[m++] = pacInBuff[i];
				i++;
				acBuf[m++] = pacInBuff[i];
				if( i+1 == iInBuffLen && j+1==iNumber ) /*已经跳到字符串结尾了,并且刚好是需要的值*/
				{
					*iOutBuffLen = m;
					memcpy( pacOutBuff,acBuf,m );
					return 0;
				}
			}
		}
	}

	return( -1 );

}

char *DelReturn(char *s,char *d)
{
	char *p = NULL;
	
	p = s;
	
	while(*p!='\0')
	{
		if(*p == 0X0A || *p == 0X0D)
		{
			p++;
		}
		else
		{
			*d++ = *p++;
		}
	}
	
	return d;
}

void   Substitute(char   *pInput,   char   *pOutput,   char   *pSrc,   char   *pDst) 
{ 
	char         *pi,   *po,   *p; 
	int           nSrcLen,   nDstLen,   nLen; 
	
	//   指向输入字符串的游动指针. 
    pi = pInput;
	//   指向输出字符串的游动指针.
    po = pOutput;
	//   计算被替换串和替换串的长度. 
    nSrcLen = (int)strlen(pSrc);
    nDstLen = (int)strlen(pDst);
	
	if(pSrc == NULL) 
	{
		strcpy(po,   pi); 
		return;
	}
	//   查找pi指向字符串中第一次出现替换串的位置,并返回指针(找不到则返回null).       
	p   =   strstr(pi,   pSrc); 
	if(p) 
	{ 
		//   找到. 
		while(p) 
		{ 
			//   计算被替换串前边字符串的长度. 
			nLen   =   (int)(p   -   pi); 
			//   复制到输出字符串. 
			memcpy(po,   pi,   nLen); 
			memcpy(po   +   nLen,   pDst,   nDstLen); 
			//   跳过被替换串. 
			pi   =   p   +   nSrcLen; 
			//   调整指向输出串的指针位置. 
			po   =   po   +   nLen   +   nDstLen; 
			//   继续查找. 
			p   =   strstr(pi,   pSrc); 
		} 
		//   复制剩余字符串. 
		strcpy(po,   pi); 
	} 
	else 
	{ 
		//   没有找到则原样复制. 
		strcpy(po,   pi); 
	} 

	return;
} 