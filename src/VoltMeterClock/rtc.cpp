#include "rtc.h"

RTClock::RTClock() {
  
}

void RTClock::setup() {
  Wire.begin();
  delay(500);
}

DateTime RTClock::readRTC() {
  return rtc.now();
}

void RTClock::adjustHour(bool increment) {
  DateTime now = rtc.now();

  int hour = now.hour();
  
  if (increment) {
    if (hour >= 23)
      hour = 0;
    else
      hour++;
  }
  else {
    if (hour <= 0)
      hour = 23;
    else
      hour--;
  }

  ds3231.setHour(hour);
}

void RTClock::adjustMinute(bool increment) {
  DateTime now = rtc.now();

  int minute = now.minute();
  
  if (increment) {
    if (minute >= 59)
      minute = 0;
    else
      minute++;
  }
  else {
    if (minute <= 0)
      minute = 59;
    else
      minute--;
  }

  Serial.print("minute = ");
  Serial.println(minute, DEC);
  
  ds3231.setMinute(minute);
}

void RTClock::adjustSecond(bool increment) {
  DateTime now = rtc.now();

  int second = now.second();
  
  if (increment)
    second++;
  else
    second--;
  
  if (second < 0)
    second = 59;
  else if (second > 59)
    second = 0;

  ds3231.setSecond(second);
}
