

void drawGround()  {
  if(P != null){
    translate(0, 120, -width/2);
    
    try{     
      
    strokeWeight(4);
    line(0, 0, 0, G.x*200, G.y*200, G.z*200);
    stroke(#FF0000);
    line(0,0,0, L.x*200, L.y*200, L.z*200);
    stroke(1);
    strokeWeight(1);
    pushMatrix();
    translate(G.x*500, G.y*500, G.z*500);
    sphere(150);
    popMatrix();
  
    }
    catch(Exception e){}

  }
}