import processing.io.GPIO;
class button {
  boolean unlocked = true;
  int pin;
  button(int pin) {
    this.pin=pin;
    GPIO.pinMode(pin, GPIO.INPUT);
  }
  boolean isPressed() {
if (GPIO.digitalRead(this.pin)==GPIO.HIGH&&this.unlocked) {
      this.unlocked = false;
      return true;
    } else if (GPIO.digitalRead(this.pin)==GPIO.LOW) {
      this.unlocked = true;
    }
    return false;
  }
}
class LED {
  int pin;
  boolean isOn = true;
  LED(int pin) {
    this.pin=pin;
    GPIO.pinMode(pin, GPIO.OUTPUT);
  }
  void light() {
    if (isOn) {
      GPIO.digitalWrite(pin, GPIO.HIGH);
    } else {
      GPIO.digitalWrite(pin, GPIO.LOW);
    }
  }
  void setOn() {
    isOn = true;
  }
  void setOff() {
    isOn = false;
  }
}
void initHardware() {
  buttons.add(new button(25));
  buttons.add(new button(12));
  buttons.add(new button(16));
  buttons.add(new button(20));
  buttons.add(new button(21));
  LEDs.add(new LED(5));
  LEDs.add(new LED(6));
  LEDs.add(new LED(13));
  LEDs.add(new LED(19));
  LEDs.add(new LED(26));
}
void hardwareCheck() {
  int n[] = {0, -1};
  for (int i = 0; i < buttons.size(); i++) {
    if (buttons.get(i).isPressed()) {
      n[0]++;
      n[1] = i;
    }
  }
  if (n[0]==1) {
    chooseOrganism(n[1]);
    LEDs.get(n[1]).setOff():
  }
  for (int i = 0; i < LEDs.size(); i++) {
    LEDs.get(i).light();
  }
}
ArrayList<button> buttons = new ArrayList<button>();
ArrayList<LED> LEDs = new ArrayList<LED>();
