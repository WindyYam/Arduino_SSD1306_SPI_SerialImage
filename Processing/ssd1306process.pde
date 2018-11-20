import processing.serial.*;
import gifAnimation.*;
Serial port;
PImage img;
PImage[] allFrames;
final int WIDTH = 128;
final int HEIGHT = 64;
byte[] bimg = new byte[WIDTH*HEIGHT/8];
int threshold = 120;   //二值化的阈值，需要手动调整
int interval = 60;     //动画帧间隔时间，单位毫秒
void setup() {
  //for jpg bmp etc
  /*img = loadImage("d:\\new.bmp");
  allFrames = new PImage[1];
  allFrames[0] = img;*/
  
  //for animation gif
  allFrames = Gif.getPImages(this, "d:\\german.gif");
  
  for(int i=0;i<allFrames.length; i++){
    img = allFrames[i];
    img.resize(WIDTH, HEIGHT);
    img.loadPixels();
  }
  println(Serial.list());
  // get the first available port (use EITHER this OR the specific port code below)
  // get a specific serial port (use EITHER this OR the first-available code above)
  String portName = "COM3";
  // open the serial port
  port = new Serial(this, portName, 1000000);
  
  /*for(int i=0;i<WIDTH;i++){
    for(int j=0;j<HEIGHT;j++){
      color pix = img.pixels[i+j*WIDTH];
      float red = red(pix), green = green(pix), blue = blue(pix);
      float intensity = sqrt(red*red + blue*blue +green*green);
      if(intensity > 127){
        bimg[i+j/8*WIDTH] = (byte)(bimg[i+j/8*WIDTH] | (1<<(j%8)));
      }else{
        bimg[i+j/8*WIDTH] = (byte)(bimg[i+j/8*WIDTH] & ~(1<<(j%8)));
      }
    }
  }
  
  port.write(0xDE);
  port.write(bimg);*/
}

void draw() {
  for(int n=0;n<allFrames.length;n++){
    img = allFrames[n];
    for(int i=0;i<WIDTH;i++){
      for(int j=0;j<HEIGHT;j++){
        color pix = img.pixels[i+j*WIDTH];
        float red = red(pix), green = green(pix), blue = blue(pix);
        float intensity = (red*0.3f + blue*0.11f +green*0.59f);
        if(intensity > threshold){
          bimg[i+j/8*WIDTH] = (byte)(bimg[i+j/8*WIDTH] | (1<<(j%8)));
        }else{
          bimg[i+j/8*WIDTH] = (byte)(bimg[i+j/8*WIDTH] & ~(1<<(j%8)));
        }
      }
    }
    
    port.write(0xDE);
    port.write(bimg);
    delay(interval);
  }
}