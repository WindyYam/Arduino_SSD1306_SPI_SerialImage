//作者：微风小杨
// Vcc - 3.3v
// Gnd - Gnd
// D0/SCL - 13
// D1/SDA - 11
// RES - 10
// DC - 9
// CS - 8

#define OLED_DC 9
#define OLED_CS 8
#define OLED_RESET 10

#include "my_SSD1306.h"
#include <SPI.h>
SSD1306 oled(OLED_DC, OLED_RESET, OLED_CS);
byte* buf;
void setup()   {
  Serial.begin(1000000);
  Serial.println(F("OLED Start"));
  SPI.begin();

  oled.ssd1306_init(SSD1306_SWITCHCAPVCC);
  oled.display(); // show splashscreen
  delay(1000);

  buf = oled.getBuffer();
}

void loop()
{
  while(Serial.available()<=0);
  byte sync = Serial.read();
  if(sync == 0xDE){
    for(int i=0;i<128*64/8;i++){
      while(Serial.available()<=0);
      buf[i] = Serial.read();
    }
    oled.display();
  }
}
