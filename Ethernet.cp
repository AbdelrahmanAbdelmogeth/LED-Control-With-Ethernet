#line 1 "F:/Embedded Systems Diploma/Books/MikroC PIC/Ethernet/Ethernet.c"
#line 16 "F:/Embedded Systems Diploma/Books/MikroC PIC/Ethernet/Ethernet.c"
const char HTTPheader[] = "HTTP/1.1 200 OK\nContent-type:";
const char HTTPMimeTypeHTML[] = "text/html\n\n";
const char HTTPMimeTypeScript[] = "text/plain\n\n";



char StrtPage[] =
#line 30 "F:/Embedded Systems Diploma/Books/MikroC PIC/Ethernet/Ethernet.c"
"<html><body><form name=\"input\" method=\"get\"><table align=center width=500 bgcolor=Red border=4><tr><td align=center colspan=2><font size=7 color=white face=\"verdana\"><b>LED CONTROL</b></font></td></tr><tr><td align=center bgcolor=Blue><input name=\"TA\" type=\"submit\" value=\"TOGGLE LED A\"></td><td align=center bgcolor=Green> <input name=\"TB\" type=\"submit\" value=\"TOGGLE LED B\"></td></tr></table></form></body></html>";



sfr sbit SPI_Ethernet_Rst at RC0_bit;
sfr sbit SPI_Ethernet_CS at RC1_bit;
sfr sbit SPI_Ethernet_Rst_Direction at TRISC0_bit;
sfr sbit SPI_Ethernet_CS_Direction at TRISC1_bit;



unsigned char MACAddr[6] = {0x00, 0x14, 0xA5, 0x76, 0x19, 0x3f} ;
unsigned char IPAddr[4] = {192,168,1,15};
unsigned char getRequest[10];
typedef struct
{
 unsigned canCloseTCP:1;
 unsigned isBroadcast:1;
}TethPktFlags;




unsigned int SPI_Ethernet_UserTCP(unsigned char *remoteHost,
 unsigned int remotePort, unsigned int localPort,
 unsigned int reqLength, TethPktFlags* flags)
{
 unsigned int Len;
 for(len=0; len<10; len++)getRequest[len]=SPI_Ethernet_getByte();
 getRequest[len]=0;
 if(memcmp(getRequest,"GET /",5))return(0);
 if(!memcmp(getRequest+6,"TA",2))RD0_bit = ~ RD0_bit;
 else if(!memcmp(getRequest+6,"TB",2))RD1_bit = ~ RD1_bit;
 if(localPort != 80)return(0);
 Len = SPI_Ethernet_putConstString(HTTPheader);
 Len += SPI_Ethernet_putConstString(HTTPMimeTypeHTML);
 Len += SPI_Ethernet_putString(StrtPage);
 return Len;
}



unsigned int SPI_Ethernet_UserUDP(unsigned char *remoteHost,
 unsigned int remotePort, unsigned int destPort,
 unsigned int reqLength, TEthPktFlags *flags)
{
 return(0);
}



void main()
{
 ANSELC = 0;
 ANSELD = 0;
 TRISD = 0;
 PORTD = 0;
 SPI1_Init();
 SPI_Ethernet_Init(MACAddr, IPAddr, 0x01);
 while(1)
 {
 SPI_Ethernet_doPacket();
 }
}
