/*
#include "shared.h"
#include "SMachine.h"
#include "rtc.h"

SMachine::SMachine() {
  
}

void SMachine::stateInit() {
  Serial.println("stateInit");
}

void SMachine::stateWait() {
  Serial.println("stateWait");  
}

void SMachine::stateSetMin() {
  Serial.println("stateSetMin");

  if (plusPressed)
    rtc.adjustMinute(true);
  else if (minusPressed)
    rtc.adjustMinute(false);
}

bool SMachine::transInitWait() {
  return true;  
}

bool SMachine::transWaitSetMin() {
  if (minutePressed)
    return true;
  else
    return false;
}

bool SMachine::transSetMinWait() {
  if (!minutePressed)
    return true;
  else
    return false;  
}

void SMachine::initStateMachine() {
  sMach = StateMachine();
  
  sInit = sMach.addState((void*)&stateInit);
  sWait = sMach.addState((void*)&stateWait);
  sSetMin = sMach.addState((void*)&stateSetMin);

  sInit->addTransition((void*)&transInitWait,sWait);
  sWait->addTransition((void*)&transWaitSetMin,sSetMin);
  sSetMin->addTransition((void*)&transSetMinWait,sWait);  
}

void SMachine::run() {
  sMach.run();
}

*/
