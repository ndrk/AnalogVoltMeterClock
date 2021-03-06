#include <SoftwareSerial.h>


SoftwareSerial mySerial(SerialRxPin, SerialTxPin); // RX, TX


void SetupLEDSerial() {
  mySerial.begin(38400);
}

void IncrementLED() {
  mySerial.write("+x");
}

void DecrementLED() {
  mySerial.write("-x");
}


/*
#include <WS2812FX.h>

#define LED_COUNT 3
#define LED_PIN 7


WS2812FX ws2812fx = WS2812FX(LED_COUNT, LED_PIN, NEO_GRB + NEO_KHZ800,1,1);

void setupLEDs() {
  ws2812fx.init();
  ws2812fx.setBrightness(100);
  ws2812fx.setSpeed(200);
  ws2812fx.setMode(FX_MODE_RAINBOW_CYCLE);
  ws2812fx.start();
}

void updateLEDs() {
  ws2812fx.service();
}*/
