//-------------------------
// C Code for Blinking LED
//-------------------------
extern "C"
{
  void start();
  void led(byte);
  void myDelay(byte);
}
//----------------------------------------------------
void setup()
{
  start();
}
//----------------------------------------------------
void loop()
{
  dot();
  dot();
  dot();
  myDelay(1);
  line();
  line();
  line();
  myDelay(1);
  dot();
  dot();
  dot();
  myDelay(2);
}

void dot()
{
  led(1);
  myDelay(0);
  led(0);
  myDelay(0);
}

void line()
{
  led(1);
  myDelay(2);
  led(0);
  myDelay(0);
}







