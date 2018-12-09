#include <Adafruit_NeoPixel.h>

#define SHINE    255  
#define PIXEL_COUNT 10  

int delayval = 100;   
                      
int index_i = 0;     
int index_j = 0;     

int red[4][5] = {
  {0, 0, 0, 0, 0},
  {0, 0, 0, 0, 0},
  {0, 0, 0, 0, 0},
  {0, 0, 0, 0, 0}
};

int green[4][5] = {
  {255, 255, 255, 255, 255},
  {255, 255, 255, 255, 255},
  {255, 255, 255, 255, 255},
  {255, 255, 255, 255, 255}
};

int blue[4][5] = {
  {0, 0, 0, 0, 0},
  {0, 0, 0, 0, 0},
  {0, 0, 0, 0, 0},
  {0, 0, 0, 0, 0}
};

// Parameter 1 = number of pixels in strip,  neopixel stick has 8
// Parameter 2 = pin number (most are valid)
// Parameter 3 = pixel type flags, add together as needed:
//   NEO_RGB     Pixels are wired for RGB bitstream
//   NEO_GRB     Pixels are wired for GRB bitstream, correct for neopixel stick
//   NEO_KHZ400  400 KHz bitstream (e.g. FLORA pixels)
//   NEO_KHZ800  800 KHz bitstream (e.g. High Density LED strip), correct for neopixel stick
Adafruit_NeoPixel strip1 = Adafruit_NeoPixel(PIXEL_COUNT, 5, NEO_GRB + NEO_RGB);
Adafruit_NeoPixel strip2 = Adafruit_NeoPixel(PIXEL_COUNT, 6, NEO_GRB + NEO_RGB);
Adafruit_NeoPixel strip3 = Adafruit_NeoPixel(PIXEL_COUNT, 9, NEO_GRB + NEO_RGB);
Adafruit_NeoPixel strip4 = Adafruit_NeoPixel(PIXEL_COUNT, 10, NEO_GRB + NEO_RGB);


void color_all_pixels(uint32_t c) {
  for (uint16_t i = 0; i < PIXEL_COUNT; i++) {
    strip1.setPixelColor(i, c);
    strip1.show();
    strip2.setPixelColor(i, c);
    strip2.show();
    strip3.setPixelColor(i, c);
    strip3.show();
    strip4.setPixelColor(i, c);
    strip4.show();
  }
}

void start_LEDs() {
  color_all_pixels(strip1.Color(0, 0, 255));
}


void setup() {

  // initialize serial:
  Serial.begin(9600);

  strip1.setBrightness(SHINE);
  strip1.begin();
  strip1.show();
  strip2.setBrightness(SHINE);
  strip2.begin();
  strip2.show();
  strip3.setBrightness(SHINE);
  strip3.begin();
  strip3.show();
  strip4.setBrightness(SHINE);
  strip4.begin();
  strip4.show();

  start_LEDs();
}

void loop() {

  while (Serial.available() > 0) {

    index_i = Serial.parseInt();
    index_j = Serial.parseInt();
    int red1 = Serial.parseInt();
    int green1 = Serial.parseInt();
    int blue1 = Serial.parseInt();

    if (Serial.read() == '\n') {
      red[index_i][index_j] = red1;
      green[index_i][index_j] = green1;
      blue[index_i][index_j]  = blue1;
    }
  }

  for (int k = 0; k < PIXEL_COUNT; k++) {

    strip1.setPixelColor(k, strip1.Color(red[0][k], green[0][k], blue[0][k])); //
    strip1.show();
    //delay(delayval);

    strip2.setPixelColor(k, strip2.Color(red[1][k], green[1][k], blue[1][k])); //
    strip2.show();
    //delay(delayval);

    strip3.setPixelColor(k, strip3.Color(red[2][k], green[2][k], blue[2][k])); //
    strip3.show();
    //delay(delayval);

    strip4.setPixelColor(k, strip4.Color(red[3][k], green[3][k], blue[3][k])); //
    strip4.show();
    //delay(delayval);
  }


}
