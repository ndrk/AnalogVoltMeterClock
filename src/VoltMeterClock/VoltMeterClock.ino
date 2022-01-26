#include "shared.h"
#include "rtc.h"
#include "memory.h"
#include "meters.h"
#include "buttons.h"
#include "SMachine.h"
#include "leds.h"
#include <TaskScheduler.h>

void tMetersCallback();
void tButtonsCallback();
//void tLEDsCallback();
void tStateMachineCallback();

#define TASK_MS_METERS 1000
Task tMeters(TASK_MS_METERS, TASK_FOREVER, &tMetersCallback);

#define TASK_MS_BUTTONS 100
#define TASK_HZ_BUTTONS 1000/TASK_MS_BUTTONS
Task tButtons(TASK_MS_BUTTONS, TASK_FOREVER, &tButtonsCallback);

//#define TASK_MS_LEDs 10
//#define TASK_HZ_LEDs 1000/TASK_MS_LEDs 
//Task tLEDs(TASK_MS_LEDs, TASK_FOREVER, &tLEDsCallback);

#define TASK_MS_SMACH 100
#define TASK_HZ_SMACH 1000/TASK_MS_SMACH
Task tStateMachine(TASK_MS_SMACH, TASK_FOREVER, &tStateMachineCallback);

Scheduler runner;


static int ticks = 0;

static int Hour   = 0;
static int Minute = 0;
static int Second = 0;

static int previousMeters = 0;
static int previousButtons = 0;
static int countButtons = 0;
static int totalTimeButtons = 0;
//static int previousLEDs = 0;
//static int countLEDs = 0;
//static int totalTimeLEDs = 0;
static int previousStateMachine = 0;
static int countStateMachine = 0;
static int totalTimeStateMachine = 0;


void tMetersCallback() {
  int timeMillis = millis();

  Serial.print("Meters: ");
  Serial.println(timeMillis-previousMeters);
    
  previousMeters = timeMillis;
  
  DateTime now = rtc.readRTC();

  Hour = now.hour();
  Minute = now.minute();
  Second = now.second();

  if (!calibrateMeters) {
    analogWrite(hourPin,   map(Hour,    0, 24, settings.HMinOffset, 255-settings.HMaxOffset));
    analogWrite(minutePin, map(Minute,  0, 60, settings.MMinOffset, 255-settings.MMaxOffset));
    analogWrite(secondPin, map(Second,  0, 60, settings.SMinOffset, 255-settings.SMaxOffset));
  }    
  
/*  Serial.print(Hour, DEC);
  Serial.print(":");
  Serial.print(Minute, DEC);
  Serial.print(":");
  Serial.print(Second, DEC);
  Serial.print("\n"); */
}

void tButtonsCallback() {
  int timeMillis = millis();
  totalTimeButtons += timeMillis-previousButtons;
  ++countButtons;

  if (countButtons == TASK_HZ_BUTTONS) {
    totalTimeButtons = totalTimeButtons / TASK_HZ_BUTTONS;
    Serial.print("Buttons: ");
    Serial.println(totalTimeButtons);
    countButtons = 0;
    totalTimeButtons = 0;
  }
  
  previousButtons = timeMillis;

  updateButtons();
}

/*
void tLEDsCallback() {
  int timeMillis = millis();
  totalTimeLEDs += timeMillis-previousLEDs;
  ++countLEDs;

  if (countLEDs == TASK_HZ_LEDs) {
    totalTimeLEDs = totalTimeLEDs / TASK_HZ_LEDs;
    Serial.print("LEDs: ");
    Serial.println(totalTimeLEDs);
    countLEDs = 0;
    totalTimeLEDs = 0;
  }
  
  previousLEDs = timeMillis;

  updateLEDs();
}
*/

void tStateMachineCallback() {
  int timeMillis = millis();
  totalTimeStateMachine += timeMillis-previousStateMachine;
  ++countStateMachine;

  if (countStateMachine == TASK_HZ_SMACH) {
    totalTimeStateMachine = totalTimeStateMachine / TASK_HZ_SMACH;
    Serial.print("StateMachine: ");
    Serial.println(totalTimeStateMachine);
    countStateMachine = 0;
    totalTimeStateMachine = 0;
  }

  previousStateMachine = timeMillis;

  runStateMachine();
}

void setup() {
  //clearSettings();
  readSettings();
  
  pinMode(hourPin,   OUTPUT);
  pinMode(minutePin, OUTPUT);
  pinMode(secondPin, OUTPUT);

  Serial.begin(57600);
  setupButtons();
  //setupLEDs();
  SetupLEDSerial;
  rtc.setup();
  initStateMachine();

  runner.init();
  runner.addTask(tMeters);
  runner.addTask(tButtons);
  //runner.addTask(tLEDs);
  runner.addTask(tStateMachine);
  tMeters.enable();
  tButtons.enable();
  //tLEDs.enable();
  tStateMachine.enable();
  
  Serial.println("Starting...");
}

void loop() {
  runner.execute();
}
