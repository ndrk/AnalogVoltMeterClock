#ifndef SHARED_H
#define SHARED_H

#include "rtc.h"

static const int hourPin   = 3;
static const int minutePin = 5;
static const int secondPin = 6;

static const int H_Button = 8;
static const int M_Button = 9;
static const int Plus_Button = 10;
static const int Minus_Button = 11;
static const int One_Button = 12;
static const int Two_Button = 13;

static const int SerialRxPin = 2;
static const int SerialTxPin = 3;

static bool hourPressed = false;
static bool minutePressed = false;
static bool plusPressed = false;
static bool minusPressed = false;
static bool twoPressed = false;
static bool twoLongPressed = false;

static bool calibrateMeters = false;

static RTClock rtc;


#endif
