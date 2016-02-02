/*
*����˵����
*	���ļ�˵�������ַ�����ʽ����ĺ�����
*	
*��Ȩ��
*	������Ŀ��		���ҳ�
*	��д���ڣ�		2001.11.17
*	�޸����ڣ�		2001.12.03
*/
#include "format.h"

char	*gSBCCaseString = 
{ 
	" 0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ+-=_(),.{}[]:;'\"<>/?#$%^&*|\\`~" 
};

char	*gDBCCaseString = 
{
	 "����������������������������������������������������������£ãģţƣǣȣɣʣˣ̣ͣΣϣУѣңӣԣգ֣ףأ٣ڣ������ߣ������������ۣݣ������������������磥�䣦�����ܣ࡫"
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
	char	*strnum[]={"��","Ҽ","��","��","��","��","½","��","��","��"};
	char	*dot1[]={"","ʰ","��","Ǫ"};
	char	*dot2[]={"��","��"};
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
						strcat(value,"��");
						if ((k-len)>8) continue;
						else	break;
					}
					if (k%4==0 && zerocnt!=0)
					{
						if (zerocnt-(k-len)<3) 
							strcat(value,"��");
					}
				}
			}
			if (*(buffer+i)!='.') strcat(value,"��");
			zerocnt=0;
		}

		if (*(buffer+i)=='.') 
		{
			if (flag==TRUE)  
			strcat(value,"Ԫ");
			if (dotcnt!=0)	return	NULL;
			else	dotcnt++;
			continue;
		}

		
		flag=TRUE;	/*	��ʼ����	*/
		strcat(value,strnum[*(buffer+i)-'0']);
		if (dotcnt!=0)
		{
			if (dotcnt++>2)	return	NULL;
			strcat(value,dot2[dotcnt-2]);
		}
		else	
		{
			if (len%8==0 && len!=0) strcat(value,"��");
			else if (len%4==0 && len!=0) strcat(value,"��");
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

	/* �ж� */
	if( iOutBuffLen == NULL || pacOutBuff == NULL )
	{
		return( -2 );
	}

	/* ��֤ */
	strcpy( pacOutBuff,"" );
	*iOutBuffLen = -1;

	/* �ж� */
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

					/* ���û��һ���ָ����ŵ����� */
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
				if( i+1 == iInBuffLen && j+1==iNumber ) /*�Ѿ������ַ�����β��,���Ҹպ�����Ҫ��ֵ*/
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
	
	//   ָ�������ַ������ζ�ָ��. 
    pi = pInput;
	//   ָ������ַ������ζ�ָ��.
    po = pOutput;
	//   ���㱻�滻�����滻���ĳ���. 
    nSrcLen = (int)strlen(pSrc);
    nDstLen = (int)strlen(pDst);
	
	if(pSrc == NULL) 
	{
		strcpy(po,   pi); 
		return;
	}
	//   ����piָ���ַ����е�һ�γ����滻����λ��,������ָ��(�Ҳ����򷵻�null).       
	p   =   strstr(pi,   pSrc); 
	if(p) 
	{ 
		//   �ҵ�. 
		while(p) 
		{ 
			//   ���㱻�滻��ǰ���ַ����ĳ���. 
			nLen   =   (int)(p   -   pi); 
			//   ���Ƶ�����ַ���. 
			memcpy(po,   pi,   nLen); 
			memcpy(po   +   nLen,   pDst,   nDstLen); 
			//   �������滻��. 
			pi   =   p   +   nSrcLen; 
			//   ����ָ���������ָ��λ��. 
			po   =   po   +   nLen   +   nDstLen; 
			//   ��������. 
			p   =   strstr(pi,   pSrc); 
		} 
		//   ����ʣ���ַ���. 
		strcpy(po,   pi); 
	} 
	else 
	{ 
		//   û���ҵ���ԭ������. 
		strcpy(po,   pi); 
	} 

	return;
} 