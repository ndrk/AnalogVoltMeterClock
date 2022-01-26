#include <WS2812FX.h>
#include "memory.h"

#define LED_COUNT 3
#define LED_PIN 11

#define TIMER_MS 100

// Parameter 1 = number of pixels in strip
// Parameter 2 = Arduino pin number (most are valid)
// Parameter 3 = pixel type flags, add together as needed:
//   NEO_KHZ800  800 KHz bitstream (most NeoPixel products w/WS2812 LEDs)
//   NEO_KHZ400  400 KHz (classic 'v1' (not v2) FLORA pixels, WS2811 drivers)
//   NEO_GRB     Pixels are wired for GRB bitstream (most NeoPixel products)
//   NEO_RGB     Pixels are wired for RGB bitstream (v1 FLORA pixels, not v2)
//   NEO_RGBW    Pixels are wired for RGBW bitstream (NeoPixel RGBW products)
WS2812FX ws2812fx = WS2812FX(LED_COUNT, LED_PIN, NEO_GRB + NEO_KHZ800,1,1);

unsigned long last_change = 0;
unsigned long now = 0;
char incomingChar;

uint8_t sequence[7][2] = {
  {FX_MODE_STATIC,0},
  {FX_MODE_BLINK,1000},
  {FX_MODE_BREATH,5000},
  {FX_MODE_COLOR_WIPE_RANDOM,1000},
  {FX_MODE_RANDOM_COLOR,2000},
  {FX_MODE_RAINBOW,5000},
  {FX_MODE_FADE,5000}
};

int seqNum = 0;
uint32_t colorNum = RED;

void setup() {
  readSettings();
  ws2812fx.init();
  ws2812fx.setBrightness(20);
  ws2812fx.setSpeed(5000);
  ws2812fx.setColor(settings.LEDColor);
  seqNum = settings.LEDSequenceNumber;
  ws2812fx.start();
  Serial.begin(57600);
  ws2812fx.setSpeed(sequence[seqNum][1]);
  ws2812fx.setMode(sequence[seqNum][0]);
  Serial.println(ws2812fx.getModeName(ws2812fx.getMode()));
}

void loop() {
  char inString[10];

  now = millis();

  ws2812fx.service();

  if (Serial.available()) {
    Serial.println("Data waiting...");
    bool gotCommand = false;
    char inChar;
    byte j = 0;
    
    while (!gotCommand) {
      if (Serial.available()) {
        inChar = Serial.read();
        inString[j] = inChar;
  
        if (inChar == 'x') {
          inString[j] = '\0';
          gotCommand = true;
          Serial.print("Got command: "); Serial.println(inString);
        }
        j += 1;
      }
    }

    if (inString[0] == '+') {
      Serial.println("Increment...");
      seqNum = (seqNum + 1) % 7;
      ws2812fx.setSpeed(sequence[seqNum][1]);
      ws2812fx.setMode(sequence[seqNum][0]);
      Serial.println(ws2812fx.getModeName(ws2812fx.getMode()));
    }
    else if (inString[0] == '-') {
      Serial.println("Deccrement...");
      seqNum = (seqNum - 1 + 7) % 7;
      ws2812fx.setSpeed(sequence[seqNum][1]);
      ws2812fx.setMode(sequence[seqNum][0]);
      Serial.println(ws2812fx.getModeName(ws2812fx.getMode()));
    }
    else if (inString[0] == 'n') {
      seqNum = atoi(&inString[1]);
      Serial.print("Sequence: "); Serial.println(seqNum, DEC);
      ws2812fx.setSpeed(sequence[seqNum][1]);
      ws2812fx.setMode(sequence[seqNum][0]);
      Serial.println(ws2812fx.getModeName(ws2812fx.getMode()));
    }
    else if (inString[0] == 'c') {
      colorNum = atol(&inString[1]);
      Serial.print("Color: "); Serial.println(colorNum);
      ws2812fx.setColor(colorNum);
    }

    setLEDSequenceSetting(ws2812fx.getMode());
    setLEDColorSetting(ws2812fx.getColor());
    writeSettings();
  }
  
  if(now - last_change > TIMER_MS) {
    //seqNum = ++seqNum % 7;
    //ws2812fx.setMode((ws2812fx.getMode() + 1) % ws2812fx.getModeCount());
    //ws2812fx.setMode(sequence[seqNum]);
    //Serial.println(incomingByte, DEC);
    //ws2812fx.setMode(sequence[incomingByte]);
    //Serial.println(ws2812fx.getModeName(ws2812fx.getMode()));
    last_change = now;
  }
}
