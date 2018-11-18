# Arduino_SSD1306_SPI_SerialImage
play animation frames via serial

Route
Vcc - 3.3v
Gnd - Gnd
D0/SCL - 13
D1/SDA - 11
RES - 10
DC - 9
CS - 8

This Arduino sketch play the animation frames via serial. The processing code read a gif file and transmit to Arduino by serial interface.
In order to achieve a decent framerate the baud rate should not less than 250000, in our setup it's 500000

Processing code requires gifAnimation lib(should be put into core/library)

_____________________________________________________________________________

SSD1306 OLED12864串口播放动画

连线
Vcc - 3.3v
Gnd - Gnd
D0/SCL - 13
D1/SDA - 11
RES - 10
DC - 9
CS - 8

本Arduino程序通过串口数据播放动画. Processing程序读取gif数据并且通过串口传输到Arduino上.
为了获得一个正常的播放速度，串口波特率不得小于250000, 本例中使用的为500000

Processing 代码需要使用 gifAnimation 库(必须放进Processing目录 core/library)