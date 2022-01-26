#ifndef SMACHINE_H
#define SMACHINE_H

#include <StateMachine.h>

/*
class SMachine {
  public:
    SMachine();
    
    void initStateMachine();

    void stateInit();
    void stateWait();
    void stateSetMin();

    bool transInitWait();
    bool transWaitSetMin();
    bool transSetMinWait();

    void run();

  private:
    StateMachine sMach;
    State* sInit;
    State* sWait;
    State* sSetMin;
    
};
*/

StateMachine sMach;
State* sInit;
State* sWait;
State* sSetMin;
State* sSetHour;
State* sAdjustHMin;
State* sAdjustHMax;
State* sAdjustMMin;
State* sAdjustMMax;
State* sAdjustSMin;
State* sAdjustSMax;
State* sIncrementLED;
State* sDecrementLED;


void stateInit() {
  Serial.println("stateInit");
}

void stateWait() {
  if (sMach.executeOnce) {
    Serial.println("stateWait");  
    calibrateMeters = true;
  }
}

void stateSetMin() {
  if (sMach.executeOnce) {
    Serial.println("stateSetMin");
  }
  
  if (plusPressed)
    rtc.adjustMinute(true);
  else if (minusPressed)
    rtc.adjustMinute(false);
}

void stateSetHour() {
  if (sMach.executeOnce) {
    Serial.println("stateSetHour");
  }
  
  if (plusPressed)
    rtc.adjustHour(true);
  else if (minusPressed)
    rtc.adjustHour(false);
}

void stateAdjustHMin() {
  if (sMach.executeOnce) {
    while(twoPressed) {
      updateButtons();
      delay(10);
    }
  }

  calibrateMeters = true;
  analogWrite(hourPin, map(0, 0, 24, settings.HMinOffset, 255-settings.HMaxOffset));

  if (plusPressed)
    updateHMinOffset(1);
  else if (minusPressed)
    updateHMinOffset(-1);
}

void stateAdjustHMax() {
  if (sMach.executeOnce) {
    while(twoPressed) {
      updateButtons();
      delay(10);
    }
  }

  analogWrite(hourPin, map(24, 0, 24, settings.HMinOffset, 255-settings.HMaxOffset));

  if (plusPressed)
    updateHMaxOffset(1);
  else if (minusPressed)
    updateHMaxOffset(-1);
}

void stateAdjustMMin() {
  if (sMach.executeOnce) {
    while(twoPressed) {
      updateButtons();
      delay(10);
    }
  }

  analogWrite(minutePin, map(0, 0, 60, settings.MMinOffset, 255-settings.MMaxOffset));

  if (plusPressed)
    updateMMinOffset(1);
  else if (minusPressed)
    updateMMinOffset(-1);
}

void stateAdjustMMax() {
  if (sMach.executeOnce) {
    while(twoPressed) {
      updateButtons();
      delay(10);
    }
  }

  analogWrite(minutePin, map(60, 0, 60, settings.MMinOffset, 255-settings.MMaxOffset));

  if (plusPressed)
    updateMMaxOffset(1);
  else if (minusPressed)
    updateMMaxOffset(-1);
}

void stateAdjustSMin() {
  if (sMach.executeOnce) {
    while(twoPressed) {
      updateButtons();
      delay(10);
    }
  }

  analogWrite(secondPin, map(0, 0, 60, settings.SMinOffset, 255-settings.SMaxOffset));

  if (plusPressed)
    updateSMinOffset(1);
  else if (minusPressed)
    updateSMinOffset(-1);
}

void stateAdjustSMax() {
  if (sMach.executeOnce) {
    while(twoPressed) {
      updateButtons();
      delay(10);
    }
  }

  analogWrite(secondPin, map(60, 0, 60, settings.SMinOffset, 255-settings.SMaxOffset));

  if (plusPressed)
    updateSMaxOffset(1);
  else if (minusPressed)
    updateSMaxOffset(-1);
}

void stateIncrementLED() {
  if (sMach.executeOnce) {
    // Send increment LED sequence to LED controller
  }
}

void stateDecrementLED() {
  if (sMach.executeOnce) {
    // Send deccrement LED sequence to LED controller
  }
}

bool trans_Init_Wait() {
  return true;  
}

bool trans_Wait_SetMin() {
  if (minutePressed)
    return true;
  else
    return false;
}

bool trans_Wait_SetHour() {
  if (hourPressed)
    return true;
  else
    return false;
}

bool trans_SetMin_Wait() {
  if (!minutePressed)
    return true;
  else
    return false;  
}

bool trans_SetHour_Wait() {
  if (!hourPressed)
    return true;
  else
    return false;  
}

bool trans_Wait_AdjustHMin() {
  if (twoLongPressed)
    return true;
  else
    return false;
}

bool trans_AdjustHMin_AdjustHMax() {
  if (twoPressed)
    return true;
  else
    return false;
}

bool trans_AdjustHMax_AdjustMMin() {
  if (twoPressed)
    return true;
  else
    return false;
}

bool trans_AdjustMMin_AdjustMMax() {
  if (twoPressed)
    return true;
  else
    return false;
}

bool trans_AdjustMMax_AdjustSMin() {
  if (twoPressed)
    return true;
  else
    return false;
}

bool trans_AdjustSMin_AdjustSMax() {
  if (twoPressed)
    return true;
  else
    return false;
}

bool trans_AdjustSMax_Wait() {
  if (twoPressed)
    return true;
  else
    return false;
}

bool trans_Wait_IncrementLED() {
  if (plusPressed)
    return true;
  else
    return false;  
}

bool trans_IncrementLED_Wait() {
  if (!plusPressed)
    return true;
  else
    return false;  
}

bool trans_Wait_DecrementLED() {
  if (minusPressed)
    return true;
  else
    return false;  
}

bool trans_DecrementLED_Wait() {
  if (!minusPressed)
    return true;
  else
    return false;  
}

void initStateMachine() {
  sMach = StateMachine();
  
  sInit = sMach.addState(&stateInit);
  sWait = sMach.addState(&stateWait);
  sSetMin = sMach.addState(&stateSetMin);
  sSetHour = sMach.addState(&stateSetHour);
  sAdjustHMin = sMach.addState(&stateAdjustHMin);
  sAdjustHMax = sMach.addState(&stateAdjustHMax);
  sAdjustMMin = sMach.addState(&stateAdjustMMin);
  sAdjustMMax = sMach.addState(&stateAdjustMMax);
  sAdjustSMin = sMach.addState(&stateAdjustSMin);
  sAdjustSMax = sMach.addState(&stateAdjustSMax);
  sIncrementLED = sMach.addState(&stateIncrementLED);
  sDecrementLED = sMach.addState(&stateDecrementLED);
  
  sInit->addTransition(&trans_Init_Wait,sWait);
  sWait->addTransition(&trans_Wait_SetMin,sSetMin);
  sWait->addTransition(&trans_Wait_SetHour,sSetHour);
  sWait->addTransition(&trans_Wait_AdjustHMin,sAdjustHMin);
  sWait->addTransition(&trans_Wait_IncrementLED,sIncrementLED);
  sWait->addTransition(&trans_Wait_DecrementLED,sDecrementLED);
  sWait->addTransition(&trans_AdjustHMin_AdjustHMax,sAdjustHMax);
  sWait->addTransition(&trans_AdjustHMax_AdjustMMin,sAdjustMMin);
  sWait->addTransition(&trans_AdjustMMin_AdjustMMax,sAdjustMMax);
  sWait->addTransition(&trans_AdjustMMax_AdjustSMin,sAdjustSMin);
  sWait->addTransition(&trans_AdjustSMin_AdjustSMax,sAdjustSMax);
  sWait->addTransition(&trans_AdjustSMax_Wait,sWait);
  sSetMin->addTransition(&trans_SetMin_Wait,sWait);
  sSetHour->addTransition(&trans_SetHour_Wait,sWait);
  sIncrementLED->addTransition(&trans_IncrementLED_Wait,sWait);
  sDecrementLED->addTransition(&trans_DecrementLED_Wait,sWait);
}

void runStateMachine() {
  sMach.run();
}



#endif
