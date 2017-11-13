import processing.serial.*;
import java.util.ArrayList;

/**
* The com port the arduino is on
*/
Serial myPort;

/**
* The string name of the com port
*/
String myPortSt;


/**
* The leters that have been typed in
*/

String letters = "";

/**
* For a blinking curser
*/

long timer;

/**
* Gravity vector
*/

PVector G;

/**
* Magnetic feild vector
*/

PVector B;


/*
* Vector for finding the orientation of
* the ground relative to the rocket
*/

PVector P;

/*
* Vector for finding the orientation of
* the north relative to the rocket
*/
PVector L;


void setup(){
  size(1400, 700, P3D);
  timer = millis();
  textAlign(CENTER);
  background(#044f6f);
  fill(#ffffff);
}

void draw(){
  background(#044f6f);
  fill(#ffffff); 
  textSize(32);
  if(myPortSt == null) {
    selectCom();
  } 
  if(myPortSt != null){
    drawRocket();
    drawGround();
  }
  
}

/*
* For reading and sorting data from the 
* com port
*/
void serialEvent(Serial myPort){
    
    String result = myPort.readStringUntil('\n');
    
    if(result != null){
      result = trim(result);
      // When the arduino connects, it sometimes spits out a random
      // char value, we are going to get rid of it
      if(result.charAt(0) != '-'){
        if(result.charAt(0) < '0' || result.charAt(0) > '9'){
          result = result.substring(1, result.length());
        }
      }
      float[] numbers;
      numbers = float(split(result, ','));
      //Check for bad data, it happens sometimes
      if(numbers.length == 6){
        G = new PVector(numbers[0], numbers[1], -numbers[2]);
        B = new PVector(numbers[3], numbers[4], numbers[5]);      
        
        //Vector math to find a vector pointing toward magnetic north
        P = G.cross(B);
        L = P.cross(G);
        G.normalize();
        B.normalize();
        L.normalize();   
      }
    }
}