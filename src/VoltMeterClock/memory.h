#ifndef MEMORY_H
#define MEMORY_H

#include <EEPROM.h>
#include "meters.h"

#define SETTINGS_ADDR 0

struct Settings {
  byte HMinOffset;
  byte HMaxOffset;
  byte MMinOffset;
  byte MMaxOffset;
  byte SMinOffset;
  byte SMaxOffset;
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
    0,0,0,0,0,0 // HMS Offsets
  };

  writeSettings();
}

void updateHMinOffset(int change) {
  if (change > 0) {
    if (settings.HMinOffset < PWM_MAX)
      ++settings.HMinOffset;
  }
  else if (change < 0) {
    if (settings.HMinOffset > PWM_MIN)
      --settings.HMinOffset;
  }
  
  writeSettings();
}

void updateHMaxOffset(int change) {
  if (change > 0) {
    if (settings.HMaxOffset < PWM_MAX)
      ++settings.HMaxOffset;
  }
  else if (change < 0) {
    if (settings.HMaxOffset > PWM_MIN)
      --settings.HMaxOffset;
  }
  
  writeSettings();
}

void updateMMinOffset(int change) {
  if (change > 0) {
    if (settings.MMinOffset < PWM_MAX)
      ++settings.MMinOffset;
  }
  else if (change < 0) {
    if (settings.MMinOffset > PWM_MIN)
      --settings.MMinOffset;
  }
  
  writeSettings();
}

void updateMMaxOffset(int change) {
  if (change > 0) {
    if (settings.MMaxOffset < PWM_MAX)
      ++settings.MMaxOffset;
  }
  else if (change < 0) {
    if (settings.MMaxOffset > PWM_MIN)
      --settings.MMaxOffset;
  }
  
  writeSettings();
}

void updateSMinOffset(int change) {
  if (change > 0) {
    if (settings.SMinOffset < PWM_MAX)
      ++settings.SMinOffset;
  }
  else if (change < 0) {
    if (settings.SMinOffset > PWM_MIN)
      --settings.SMinOffset;
  }
  
  writeSettings();
}

void updateSMaxOffset(int change) {
  if (change > 0) {
    if (settings.SMaxOffset < PWM_MAX)
      ++settings.SMaxOffset;
  }
  else if (change < 0) {
    if (settings.SMaxOffset > PWM_MIN)
      --settings.SMaxOffset;
  }
  
  writeSettings();
}

#endif
