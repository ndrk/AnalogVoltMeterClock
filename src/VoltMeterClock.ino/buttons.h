#ifndef BUTTONS_H
#define BUTTONS_H

#include "InputDebounce.h"
#include "shared.h"

#define BUTTON_DEBOUNCE_DELAY   20   // [ms]

InputDebounce buttonH;
InputDebounce buttonM;
InputDebounce buttonPlus;
InputDebounce buttonMinus;
InputDebounce buttonOne;
InputDebounce buttonTwo;


void buttonTest_pressedCallback(uint8_t pinIn)
{
  switch(pinIn) {
    case H_Button:
      hourPressed = true;
      Serial.println("hourPressed=true"); 
      break;
    case M_Button:
      minutePressed = true;
      Serial.println("minutePressed=true");
      break; 
    case Plus_Button:
      plusPressed = true;
      Serial.println("Plus");
      break;
    case Minus_Button:
      minusPressed = true;
      Serial.println("Minus");
      break;
    case One_Button:
      break;
    case Two_Button:
      twoPressed = true;
      break;
      
  }
}

void buttonTest_releasedCallback(uint8_t pinIn)
{
  switch(pinIn) {
    case H_Button:
      hourPressed = false;
      Serial.println("hourPressed=false");
      break;
     case M_Button:
      minutePressed = false;
      Serial.println("minutePressed=false");
      break;
    case Plus_Button:
      plusPressed = false;
      break;
    case Minus_Button:
      minusPressed = false;
      break;
    case One_Button:
      break;
    case Two_Button:
      twoPressed = false;
      twoLongPressed = false;
      break;
  }
}

void buttonTest_pressedDurationCallback(uint8_t pinIn, unsigned long duration)
{
  switch (pinIn) {
    case Two_Button:
      twoLongPressed = true;
      break;
  }
  // handle still pressed state
  //Serial.print("HIGH (pin: ");
  //Serial.print(pinIn);
  //Serial.print(") still pressed, duration ");
  //Serial.print(duration);
  //Serial.println("ms");
}

void buttonTest_releasedDurationCallback(uint8_t pinIn, unsigned long duration)
{
  // handle released state
  //Serial.print("LOW (pin: ");
  //Serial.print(pinIn);
  //Serial.print("), duration ");
  //Serial.print(duration);
  //Serial.println("ms");
}

void setupButtons()
{
  // init serial
  //Serial.begin(57600);
  
  Serial.println("Test InputDebounce library, using callback functions");
  
  // register callback functions (shared, used by all buttons)
  buttonH.registerCallbacks(buttonTest_pressedCallback, buttonTest_releasedCallback, buttonTest_pressedDurationCallback, buttonTest_releasedDurationCallback);
  buttonM.registerCallbacks(buttonTest_pressedCallback, buttonTest_releasedCallback, buttonTest_pressedDurationCallback, buttonTest_releasedDurationCallback);
  buttonPlus.registerCallbacks(buttonTest_pressedCallback, buttonTest_releasedCallback, buttonTest_pressedDurationCallback, buttonTest_releasedDurationCallback);
  buttonMinus.registerCallbacks(buttonTest_pressedCallback, buttonTest_releasedCallback, buttonTest_pressedDurationCallback, buttonTest_releasedDurationCallback);
  buttonOne.registerCallbacks(buttonTest_pressedCallback, buttonTest_releasedCallback, buttonTest_pressedDurationCallback, buttonTest_releasedDurationCallback);
  buttonTwo.registerCallbacks(buttonTest_pressedCallback, buttonTest_releasedCallback, buttonTest_pressedDurationCallback, buttonTest_releasedDurationCallback);
  
  // setup input buttons (debounced)
  buttonH.setup(H_Button, BUTTON_DEBOUNCE_DELAY, InputDebounce::PIM_INT_PULL_UP_RES, 1); // single-shot pressed-on time duration callback
  buttonM.setup(M_Button, BUTTON_DEBOUNCE_DELAY, InputDebounce::PIM_INT_PULL_UP_RES, 1); // single-shot pressed-on time duration callback
  buttonPlus.setup(Plus_Button, BUTTON_DEBOUNCE_DELAY, InputDebounce::PIM_INT_PULL_UP_RES, 1);
  buttonMinus.setup(Minus_Button, BUTTON_DEBOUNCE_DELAY, InputDebounce::PIM_INT_PULL_UP_RES, 1); 
  buttonOne.setup(One_Button, BUTTON_DEBOUNCE_DELAY, InputDebounce::PIM_INT_PULL_UP_RES, 1); // single-shot pressed-on time duration callback
  buttonTwo.setup(Two_Button, BUTTON_DEBOUNCE_DELAY, InputDebounce::PIM_INT_PULL_UP_RES, 1); // single-shot pressed-on time duration callback
}

void updateButtons() {
  unsigned long now = millis();
  buttonH.process(now);
  buttonM.process(now);
  buttonPlus.process(now);
  buttonMinus.process(now);
  buttonOne.process(now);
  buttonTwo.process(now);
}

#endif
