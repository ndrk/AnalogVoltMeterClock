#ifndef MEMORY_H
#define MEMORY_H

#include <EEPROM.h>

#define SETTINGS_ADDR 0

struct Settings {
  byte LEDSequenceNumber;
  uint32_t LEDColor;
};

static Settings settings;

void readSettings() {
  EEPROM.get(SETTINGS_ADDR, settings);
  return;
}

void writeSettings() {
  EEPROM.put(SETTINGS_ADDR, settings);
}

void clearSettings() {
  Settings settings = {
    0,
    0x0000FF
  };

  writeSettings();
}

void setLEDSequenceSetting(byte seq) {
  settings.LEDSequenceNumber = seq;
  writeSettings();  
}

void setLEDColorSetting(uint32_t color) {
  settings.LEDColor = color;
  writeSettings();  
}

#endif
