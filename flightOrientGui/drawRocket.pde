/*
* Draws the rocket in the middle of the screen
*/

void drawRocket(){
    translate(width/2, height/2 - 120, 0);
    strokeWeight(1);
    stroke(0);
    beginShape();
      //Draw the nose cone
      vertex(0, 0, -width/2);
      vertex(-20, 60, -width/2);
      vertex(20, 60, -width/2);
      
      //Draw the body
      vertex(-20, 60, -width/2);
      vertex(-20, 240, -width/2);
      vertex(20, 240, -width/2);
      vertex(20, 60, -width/2);
  endShape();
  beginShape();
      //Draw right fin
      vertex(20, 235, -width/2);
      vertex(40, 235, -width/2);
      vertex(20, 180, -width/2);
   endShape();
   beginShape();
      //Draw left fin
      vertex(-20, 235, -width/2);
      vertex(-40, 235, -width/2);
      vertex(-20, 180, -width/2);
   endShape();
  
}