/*
* Handles the event of a key being pressed
*/

void keyPressed() {
  if(myPortSt == null){
    if (key == BACKSPACE) {
      if (letters.length() > 0) {
        letters = letters.substring(0, letters.length()-1);
      }
    } 
    else if(key == ENTER) {
      myPortSt = letters;
      try{
        myPort = new Serial(this, "COM" + letters, 9600);
      }
      catch(Exception e){
        myPortSt = null;
        letters = "Serial port not found!";
      }
 
    }
    else if (textWidth(letters+key) < width) {
      letters = letters + key;
    }
  }
}