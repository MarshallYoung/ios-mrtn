/*
*文件说明：
*	定义各类常量定义
*版权：
*	北京项目组		李忠诚
*	编写日期：		2001.11.17
*	修改日期：		2001.11.18
*/
#ifndef	D_DEFINE
#define	D_DEFINE

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <strings.h>
#include <memory.h>
#include <errno.h>

#ifndef	FALSE	
#define	FALSE		0
#endif

#ifndef	TRUE
#define	TRUE		1
#endif
#ifndef BIT64
#define BIT64   
#endif

#define INTEGER     1
#define DOUBLE      2
#define STRING      3
#define BOOL        4
#define LONG        5

#define KEY_CR				0x0d
#define ESC_KEY				0x1b
#define KEY_SPACE   		0x20

#define BACKSPACE       	0x08
#define DELETE          	0x7f

#define KEY_CONFIRM 		KEY_CR
#define KEY_QUIT    		KEY_F(3)

#define	MAX_PATH			256
#define	BUFFER_SIZE			102400
#define	LINE_SIZE			104800

#define	CONFIRM				0
#define	QUIT				99999

#define	NOTFOUND			-1
#define	FOUND				0

#define EQUAL    			0
#define UNEQUAL    			1

#define	ECHOTEST			4
#define	LOCALMACHINE		0

#define	EBCDIC				0
#define ASCII				1
#define BINARY				8
#define BCD					16

#define EBCDIC_TO_ASCII     0xea
#define ASCII_TO_EBCDIC     0xae
#define FORMAT_TO_ASCII     0xfa
#define ASCII_TO_FORMAT     0xaf

#define	E_UNKNOW_TXT		0

#define	E_FILE_NOTFOUND		-1001
#define E_FILE_OPEN			-1002
#define	E_FILE_READ			-1003
#define	E_FILE_WRITE		-1004
#define	E_FILE_END			-1005
#define	E_CFG_FILE			-1006
#define	E_SORT_FILE			-1007

#define	E_SHM_ERROR			-1100
#define	E_SEM_ERROR			-1101
#define	E_MSG_ERROR			-1102
#define	E_PIPE_ERROR		-1103
#define	E_ADD_MAC			-1104
#define	E_CHK_MAC			-1106

#define	E_BAD_MMAP			-1202
#define	E_BAD_LOC			-1203

#define	E_DAEMON_INIT		-1401	
#define	E_PROGRAM_INIT		-1402
#define	E_KEEPALIVE			-1403

#define	E_BAD_MENU			-1501

#define	E_BAD_PATH			-1701	
#define E_BAD_FILE			-1702

#define	E_BAD_DATE			-1801
#define	E_BAD_TIME			-1802

#define	E_INIT_STAT			-1899
#define	E_BAD_TYPE			-1900
#define	E_BAD_FORMAT		-1901
#define	E_BAD_KEY			-1902
#define	E_BAD_FIELD			-1903
#define	E_BAD_SETFIELD		-1904
#define	E_BAD_GETFIELD		-1905
#define	E_BAD_FIELDINIT		-1906
#define	E_BAD_FIELDFIND	 	-1907
#define	E_BAD_FIELDCHECK	-1908
#define	E_BAD_CHARCHECK		-1909
#define	E_BAD_CHAR			-1910

#define	E_BAD_EXP			-2001
#define	E_BAD_TOKEN			-2002
#define	E_BAD_RELATE		-2003
#define	E_BAD_OPERATOR		-2004
#define	E_NO_TOKEN			-2005

#define	E_LOCK_TEST			-2101
#define	E_LOCK_FILE			-2102

#define	E_PRINT_OPEN		-2201
#define	E_PRINT_CTRL		-2202
#define	E_PRINT_READ		-2203
#define	E_PRINT_WRITE		-2204

#define	E_KEYPAD_OPEN		-2301
#define	E_KEYPAD_READ		-2302
#define	E_KEYPAD_WRITE		-2304
#define	E_KEYPAD_CTRL		-2305

#define	E_CARD_READER_OPEN	-2401
#define	E_CARD_READER_READ	-2402
#define	E_CARD_READER_WRITE	-2403
#define	E_CARD_READER_CTRL	-2404

#define	E_KEY_NOTFOUND		-2501
#define	E_BAD_VERSION		-2502
#define	E_BAD_GROUP			-2503
#define E_BAD_INDEX			-2504
#define	E_KEY_INVALID		-2505

#define	E_SM_SUPPORT		-2600
#define	E_HSM_OPER			-2601
#define	E_HSM_COMM			-2602
#define	E_HSM_INIT			-2603
#define	E_BAD_ALG			-2604
#define E_BAD_CARDNO		-2605

#define	E_SNA_INIT			-2900	
#define	E_SNA_OPEN			-2901
#define	E_SNA_ALLOC			-2902
#define	E_SNA_READ			-2903
#define E_SNA_CTRL			-2904
#define E_SNA_WRITE			-2905
#define E_SNA_DISCARD		-2906
#define E_SNA_CLOSE			-2907
#define	E_SNA_SEND			-2908
#define	E_SNA_RECEIVE		-2909

#define	E_SOCKET_CREAT		-3000
#define	E_SOCKET_BIND		-3001
#define	E_SOCKET_LISTEN		-3002
#define	E_SOCKET_ACCEPT		-3003
#define	E_SOCKET_CONNECT	-3004
#define	E_SOCKET_MODE		-3005
#define	E_SOCKET_STAT		-3006
#define	E_SOCKET_SEND		-3007
#define	E_SOCKET_RECEIVE	-3008
#define	E_BAD_HOST			-3009
#define	E_BAD_PORT			-3010
#define E_SSL_CONNECT       -3011
#define E_SSL_SEND          -3012
#define E_SSL_RECEIVE       -3013
#define E_SSL_SHUTDOWN      -3014


#define	E_SPIPE_CREAT		-3100
#define	E_SPIPE_OPEN		-3101
#define	E_SPIPE_BIND		-3102
#define	E_SPIPE_LISTEN		-3103
#define	E_SPIPE_ACCEPT		-3104
#define	E_SPIPE_CONNECT		-3105
#define	E_SPIPE_MODE		-3106
#define	E_SPIPE_STAT		-3107
#define	E_SPIPE_SEND		-3108
#define	E_SPIPE_RECEIVE		-3109

#define	E_BAD_8583			-4000
#define	E_BAD_BIT			-4001

#define	E_BAD_SDA			-4100	
#define	E_BAD_PCB			-4200
#define	E_OUT_PCB			-4201
#define	E_PCB_EXIST			-4202
#define	E_PCB_CLASS			-4203
#define	E_PCB_STATUS		-4204

#define	E_UNSUPPORT_TXT		-4302

#define	E_NO_ICC			-4401
#define	E_READ_ICC			-4402
#define	E_UP_ICC			-4403
#define	E_DOWN_ICC			-4404
#define	E_DETECT_ICC		-4405
#define	E_INIT_ICC			-4406
#define	E_EXCHANGE_ICC		-4407

#define	E_ICC_CARD			-4450
#define	E_ICC_PROTOCOL		-4451
#define	E_ICC_AID			-4452
#define	E_ICC_EXCHANGE		-4453
#define	E_ICC_SELECT		-4454

#define	E_BALANCE			-5001

#define	E_MQM_OPEN			-5101
#define	E_MQM_CLOSE			-5102
#define	E_MQ_OPEN			-5103
#define	E_MQ_CLOSE			-5104
#define	E_MQ_READ			-5105
#define	E_MQ_WRITE			-5106

#define	E_OUT_MEMORY		-9901
#define E_OUT_SOCKET		-9902

#define	E_STACK_OVERFLOW	-9910
#define	E_BUFFER_OVERFLOW	-9911

#define	E_WINSIZE_OVERFLOW	-9920

#define EF_NULL           -1300                /* 参数为空错误    */
#define EF_INPUT          -1301                /* 参数不一致错误  */
#define EF_NSPACE         -1302                /* FML空间不足     */
#define EF_NEXIST         -1303                /* 查找的域不存在  */
#define EF_FORMAT         -1304                /* FML格式错       */
#define EF_TYPEERR        -1305                /* 数据类型错      */


#define	E_LICENSE_FILE		-1306

#define EX_LOADFILE       -1307                /*导入XML文件失败      */
#define EX_GETCHRNODE     -1308                /*得到XML子节点失败    */
#define EX_GETNODEPROP    -1309                /*得到XML节点属性值失败*/
#define EX_NOTGETNODE     -1310                /*没有找到要查找的节点 */
#define EX_GETCHRCNT      -1311                /*取子节点个数失败     */
#define E_GETMODULEPARA   -1312                /*取组件参数失败       */
#define EX_GETPROPCNT     -1313                /*得到XML节点属性个数失败*/
#define EX_GETPROPNAME    -1314                /*得到XML节点属性名称失败*/


typedef	unsigned char	BYTE;
typedef	unsigned int	WORD;
typedef	unsigned int	DWORD;


typedef unsigned char   FBUFFER;


#endif

