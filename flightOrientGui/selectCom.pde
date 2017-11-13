/**
* Prompts the user type in a com port
* for communication with the arduino
*/

void selectCom(){
  text("Select COM port" , width/2, 30);
  float cursorPosition = width/2+ (textWidth(letters))/2;
  if(millis() - timer > 500){
    line(cursorPosition, height/2 + 50, cursorPosition, height/2 - 50);
    if(millis() - timer > 1000){
      timer = millis();
    }
  }
  text(letters, width/2, height/2);
}