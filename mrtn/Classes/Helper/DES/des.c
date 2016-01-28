/*
*函数说明：
*   本文件为DES和3DES加密函数。
*   
*版权：
*   北京项目组      李忠诚 
*   编写日期：      2002.04.17
*   修改日期：      2002.04.18
*/
#include "des.h"

static char p1[64] = 
{
    57, 49 ,41 ,33 ,25 ,17 , 9 , 1 ,59 ,51 ,43 ,35 ,27 ,19 ,11 , 3 ,
    61 ,53 ,45 ,37 ,29 ,21 ,13 , 5 ,63 ,55 ,47 ,39 ,31 ,23 ,15 , 7 ,
    56 ,48 ,40 ,32 ,24 ,16 , 8 , 0 ,58 ,50 ,42 ,34 ,26 ,18 ,10 , 2 ,
    60 ,52 ,44 ,36 ,28 ,20 ,12 , 4 ,62 ,54 ,46 ,38 ,30 ,22 ,14 , 6
};
static char p2[56] = 
{
    56 ,48 ,40 ,32 ,24 ,16 , 8 , 0 ,57 ,49 ,41 ,33 ,25 ,17 , 
    9 , 1 ,58 ,50 ,42 ,34 ,26 ,18 ,10 , 2 ,59 ,51 ,43 ,35 ,
    62 ,54 ,46 ,38 ,30 ,22 ,14 , 6 ,61 ,53 ,45 ,37 ,29 ,21 ,
    13 , 5 ,60 ,52 ,44 ,36 ,28 ,20 ,12 , 4 ,27 ,19 ,11 , 3
};
static char p3[48] = 
{
    31 , 0 , 1 , 2 , 3 , 4 , 3 , 4 , 5 , 6 , 7 , 8 , 
    7 , 8 , 9 ,10 ,11 ,12 ,11 ,12 ,13 ,14 ,15 ,16 ,
    15 ,16 ,17 ,18 ,19 ,20 ,19 ,20 ,21 ,22 ,23 ,24 ,
    23 ,24 ,25 ,26 ,27 ,28 ,27 ,28 ,29 ,30 ,31 , 0
};
static char p4[48] = 
{
    13 ,16 ,10 ,23 , 0 , 4 , 2 ,27 ,14 , 5 ,20 , 9 ,
    22 ,18 ,11 , 3 ,25 , 7 ,15 , 6 ,26 ,19 ,12 , 1 ,
    40 ,51 ,30 ,36 ,46 ,54 ,29 ,39 ,50 ,44 ,32 ,47 ,
    43 ,48 ,38 ,55 ,33 ,52 ,45 ,41 ,49 ,35 ,28 ,31
};
static char p5[32] = 
{
    15 , 6 ,19 ,20 ,28 ,11 ,27 , 16 , 
    0 ,14 ,22 ,25 , 4 ,17 , 30 , 9 , 
    1 , 7 ,23 ,13 ,31 , 26 , 2 , 8 ,
    18 ,12 ,29 , 5 ,21 ,10 , 3 ,24
};
static char s1[4][16] = 
{
    14, 4,13, 1, 2,15,11, 8, 3,10, 6,12, 5, 9, 0, 7,
     0,15, 7, 4,14, 2,13, 1,10, 6,12,11, 9, 5, 3, 8,
     4, 1,14, 8,13, 6, 2,11,15,12, 9, 7, 3,10, 5, 0,
    15,12, 8, 2, 4, 9, 1, 7, 5,11, 3,14,10, 0, 6,13
};
static char s2[4][16] = 
{
    15, 1, 8,14, 6,11, 3, 4, 9, 7, 2,13,12, 0, 5,10,
     3,13, 4, 7,15, 2, 8,14,12, 0, 1,10, 6, 9,11, 5,
     0,14, 7,11,10, 4,13, 1, 5, 8,12, 6, 9, 3, 2,15,
    13, 8,10, 1, 3,15, 4, 2,11, 6, 7,12, 0, 5,14, 9
};
static char s3[4][16] = 
{
    10, 0, 9,14, 6, 3,15, 5, 1,13,12, 7,11, 4, 2, 8,
    13, 7, 0, 9, 3, 4, 6,10, 2, 8, 5,14,12,11,15, 1,
    13, 6, 4, 9, 8,15, 3, 0,11, 1, 2,12, 5,10,14, 7,
     1,10,13, 0, 6, 9, 8, 7, 4,15,14, 3,11, 5, 2,12
};
static char s4[4][16] = 
{
     7,13,14, 3, 0, 6, 9,10, 1, 2, 8, 5,11,12, 4,15,
    13, 8,11, 5, 6,15, 0, 3, 4, 7, 2,12, 1,10,14, 9,
    10, 6, 9, 0,12,11, 7,13,15, 1, 3,14, 5, 2, 8, 4,
     3,15, 0, 6,10, 1,13, 8, 9, 4, 5,11,12, 7, 2,14
};
static char s5[4][16] = 
{
     2,12, 4, 1, 7,10,11, 6, 8, 5, 3,15,13, 0,14, 9,
    14,11, 2,12, 4, 7,13, 1, 5, 0,15,10, 3, 9, 8, 6,
     4, 2, 1,11,10,13, 7, 8,15, 9,12, 5, 6, 3, 0,14,
    11, 8,12, 7, 1,14, 2,13, 6,15, 0, 9,10, 4, 5, 3
};
static char s6[4][16] = 
{
    12, 1,10,15, 9, 2, 6, 8, 0,13, 3, 4,14, 7, 5,11,
    10,15, 4, 2, 7,12, 9, 5, 6, 1,13,14, 0,11, 3, 8,
     9,14,15, 5, 2, 8,12, 3, 7, 0, 4,10, 1,13,11, 6,
     4, 3, 2,12, 9, 5,15,10,11,14, 1, 7, 6, 0, 8,13
};
static char s7[4][16] = 
{
     4,11, 2,14,15, 0, 8,13, 3,12, 9, 7, 5,10, 6, 1,
    13, 0,11, 7, 4, 9, 1,10,14, 3, 5,12, 2,15, 8, 6,
     1, 4,11,13,12, 3, 7,14,10,15, 6, 8, 0, 5, 9, 2,
     6,11,13, 8, 1, 4,10, 7, 9, 5, 0,15,14, 2, 3,12
};
static char s8[4][16] = 
{
    13, 2, 8, 4, 6,15,11, 1,10, 9, 3,14, 5, 0,12, 7,
     1,15,13, 8,10, 3, 7, 4,12, 5, 6,11, 0,14, 9, 2,
     7,11, 4, 1, 9,12,14, 2, 0, 6,10,13,15, 3, 5, 8,
     2, 1,14, 7, 4,10, 8,13,15,12, 9, 0, 3, 5, 6,11
};
static char shift[16] = 
{
    1,1,2,2,2,2,2,2,1,2,2,2,2,2,2,1
};
static char binary[64] = 
{
    0,0,0,0,0,0,0,1,0,0,1,0,0,0,1,1,
    0,1,0,0,0,1,0,1,0,1,1,0,0,1,1,1,
    1,0,0,0,1,0,0,1,1,0,1,0,1,0,1,1,
    1,1,0,0,1,1,0,1,1,1,1,0,1,1,1,1
};

void SoftDES(BYTE *binsource, BYTE *binkey,int mode, BYTE *bindest)
{
    BYTE    bufout[64],kwork[56],worka[48];
    BYTE    kn[48],buffer[64],key[64];
    BYTE    nbrofshift,temp1,temp2;
    BYTE    i,j,k,iter;
    int     valindex;

    for (i=0; i<8; i++)
    {
        key[8*i] = ((j = *(binkey+i))/128)%2;
        key[8*i+1] = (j/64)%2;
        key[8*i+2] = (j/32)%2;
        key[8*i+3] = (j/16)%2;
        key[8*i+4] = (j/8)%2;
        key[8*i+5] = (j/4)%2;
        key[8*i+6] = (j/2)%2;
        key[8*i+7] = j%2;
    }

    for (i=0; i<8; i++)
    {
        buffer[8*i] = ((j = *(binsource+i))/128)%2;
        buffer[8*i+1] = (j/64)%2;
        buffer[8*i+2] = (j/32)%2;
        buffer[8*i+3] = (j/16)%2;
        buffer[8*i+4] = (j/8)%2;
        buffer[8*i+5] = (j/4)%2;
        buffer[8*i+6] = (j/2)%2;
        buffer[8*i+7] = j%2;
    }

    for(i=0;i<64;i++) bufout[i]=buffer[p1[i]];
    for(i=0;i<56;i++) kwork[i]=key[p2[i]];

    for (iter=1; iter<17; iter++)
    {
        for (i=0; i<32; i++) buffer[i] = bufout[32+i];
        for(i=0;i<48;i++) worka[i]=buffer[p3[i]];

        if ( mode == ENCRYPT ) 
        {
            nbrofshift = shift[iter-1];
            for (i=0; i<nbrofshift; i++)
            {
                temp1 = kwork[0];
                temp2 = kwork[28];
                for (j = 0; j < 27; j++)
                {
                    kwork[j] = kwork[j+1];
                    kwork[j+28] = kwork[j+29];
                }
                kwork[27] = temp1;
                kwork[55] = temp2;
            }
        }
        else if (iter > 1)
        {
            nbrofshift = shift[17-iter];
            for (i=0; i<nbrofshift; i++)
            {
                temp1 = kwork[27];
                temp2 = kwork[55];
                for (j = 27; j > 0; j--)
                {
                    kwork[j] = kwork[j-1];
                    kwork[j+28] = kwork[j+27];
                }
                kwork[0] = temp1; 
                kwork[28] = temp2;
            }
        }
         
        for(i=0;i<48;i++) kn[i]=kwork[p4[i]];
        for (i=0; i<48; i++) worka[i] = worka[i]^kn[i];

        valindex = s1[2*worka[ 0]+worka[ 5]]
                [2*(2*(2*worka[ 1]+worka[ 2])+
                               worka[ 3])+worka[ 4]];

        valindex = valindex*4;
        kn[ 0] = binary[0+valindex];
        kn[ 1] = binary[1+valindex];
        kn[ 2] = binary[2+valindex];
        kn[ 3] = binary[3+valindex];
        valindex = s2[2*worka[ 6]+worka[11]]
                [2*(2*(2*worka[ 7]+worka[ 8])+
                       worka[ 9])+worka[10]];

        valindex = valindex*4;
        kn[ 4] = binary[0+valindex];
        kn[ 5] = binary[1+valindex];
        kn[ 6] = binary[2+valindex];
        kn[ 7] = binary[3+valindex];
        valindex = s3[2*worka[12]+worka[17]]
                [2*(2*(2*worka[13]+worka[14])+
                       worka[15])+worka[16]];

        valindex = valindex*4;
        kn[ 8] = binary[0+valindex];
        kn[ 9] = binary[1+valindex];
        kn[10] = binary[2+valindex];
        kn[11] = binary[3+valindex];
        valindex = s4[2*worka[18]+worka[23]]
                [2*(2*(2*worka[19]+worka[20])+
                       worka[21])+worka[22]];

        valindex = valindex*4;
        kn[12] = binary[0+valindex];
        kn[13] = binary[1+valindex];
        kn[14] = binary[2+valindex];
        kn[15] = binary[3+valindex];

        valindex = s5[2*worka[24]+worka[29]]
                       [2*(2*(2*worka[25]+worka[26])+
                               worka[27])+worka[28]];

        valindex = valindex*4;
        kn[16] = binary[0+valindex];
        kn[17] = binary[1+valindex];
        kn[18] = binary[2+valindex];
        kn[19] = binary[3+valindex];
        valindex = s6[2*worka[30]+worka[35]]
                [2*(2*(2*worka[31]+worka[32])+
                       worka[33])+worka[34]];

        valindex = valindex*4;
        kn[20] = binary[0+valindex];
        kn[21] = binary[1+valindex];
        kn[22] = binary[2+valindex];
        kn[23] = binary[3+valindex];
        valindex = s7[2*worka[36]+worka[41]]
                [2*(2*(2*worka[37]+worka[38])+
                        worka[39])+worka[40]];

        valindex = valindex*4;
        kn[24] = binary[0+valindex];
        kn[25] = binary[1+valindex];
        kn[26] = binary[2+valindex];
        kn[27] = binary[3+valindex];
        valindex = s8[2*worka[42]+worka[47]]
                [2*(2*(2*worka[43]+worka[44])+
                       worka[45])+worka[46]];

        valindex = valindex*4;
        kn[28] = binary[0+valindex];
        kn[29] = binary[1+valindex];
        kn[30] = binary[2+valindex];
        kn[31] = binary[3+valindex];

        for(i=0;i<32;i++) worka[i]=kn[p5[i]];

        for (i=0; i<32; i++)
        {
            bufout[i+32] = bufout[i]^worka[i];
            bufout[i] = buffer[i];
        }
    } 

    for (i=0; i< 32; i++)
    {
        j = bufout[i];
        bufout[i] = bufout[32+i];
        bufout[32+i] = j;
    }

    for(i=0;i<64;i++)  buffer[p1[i]]=bufout[i];

    j = 0;
    for (i=0; i<8; i++)
    {
        *(bindest+i) = 0x00;
        for (k=0; k<7; k++) *(bindest+i) = ((*(bindest+i))+buffer[j+k])*2;
        *(bindest+i) = *(bindest+i)+buffer[j+7];
        j+=8;
    } 
}

void SoftDESASC(char *source,char *key,int mode,char *dest)
{
    BYTE    binkey[16],binsource[16],bindest[16],tmp[16];

    FormatData((BYTE *)key,tmp,16,CHAR_TO_HEX);
    FormatData(tmp,binkey,16,PACK);
    FormatData((BYTE *)source,tmp,16,CHAR_TO_HEX);
    FormatData(tmp,binsource,16,PACK);

    SoftDES(binsource,binkey,mode,bindest);

    FormatData((BYTE *)bindest,tmp,8,UNPACK);
    FormatData(tmp,(BYTE *)dest,16,HEX_TO_CHAR);
}

void Soft3DES(BYTE *binsource,BYTE *binkey,int mode,BYTE *bindest)
{
    BYTE    tmp[8];

    SoftDES(binsource,binkey,mode,bindest);
    SoftDES(bindest,binkey+8,!mode,tmp);
    SoftDES(tmp,binkey,mode,bindest);
}
void Soft3DESASC(char *source,char *key,int mode,char *dest)
{
    char    tmp[16];

    SoftDESASC(source,key,mode,dest);
    SoftDESASC(dest,key+16,!mode,tmp);
    SoftDESASC(tmp,key,mode,dest);
}
