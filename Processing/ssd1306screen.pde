import java.awt.*;
import processing.serial.*;

PImage screenshot;
PImage img;
Serial port;
final int WIDTH = 128;
final int HEIGHT = 64;
byte[] bimg = new byte[WIDTH*HEIGHT/8];
int threshold = 160;
int interval = 16;
void setup() {
  size(1280, 720);
  println(Serial.list());
  String portName = "COM3";
  // open the serial port
  port = new Serial(this, portName, 2000000);
}

void draw() {
    screenshot();
    //image(screenshot,0,0);
    if (screenshot != null){
    img = screenshot;
    img.resize(WIDTH, HEIGHT);
    img.loadPixels();
    for (int i=0; i<WIDTH; i++) {
      for (int j=0; j<HEIGHT; j++) {
        color pix = img.pixels[i+j*WIDTH];
        float red = red(pix), green = green(pix), blue = blue(pix);
        float intensity = sqrt(red*red + blue*blue +green*green);
        if (intensity > threshold) {
          bimg[i+j/8*WIDTH] = (byte)(bimg[i+j/8*WIDTH] | (1<<(j%8)));
        } else {
          bimg[i+j/8*WIDTH] = (byte)(bimg[i+j/8*WIDTH] & ~(1<<(j%8)));
        }
      }
    }
  
  
    port.write(0xDE);
    port.write(bimg);
    delay(interval);
  }
}

void screenshot() {
  try {
    screenshot = new PImage(new Robot().createScreenCapture(new Rectangle(0, 0, displayWidth, displayHeight)));
  } 
  catch (AWTException e) {
  }
}