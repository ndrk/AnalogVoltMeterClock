#ifndef RTC_H
#define RTC_H

#include <DS3231.h>
#include <Wire.h>

class RTClock {
  public:
    RTClock();
    void setup();
    DateTime readRTC();
    void adjustHour(bool increment);
    void adjustMinute(bool increment);
    void adjustSecond(bool increment);
    
  private:
    RTClib rtc;
    DS3231 ds3231;
};

#endif
