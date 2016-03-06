class Hall{
  float hallHeight = 50;
  float hallWidth = 60;
  float hallDepth = 75;
  
  boolean door;
  boolean controlPanel;
  float doorPos;
  float doorWidth;
  
  Hall() {
    door = false;
    controlPanel = false;
    doorWidth = hallWidth/2;
    doorPos = 0;
  }
  
  void drawHall() {
    //floor
    pushMatrix();
    translate(0, hallHeight/2, 0);
    horizontalSurface();
    popMatrix();
    
    //hall divider
    pushMatrix();
    fill(150, 150, 150);
    translate(0, hallHeight/2, -(hallDepth/2));
    box(hallWidth, 1.2, 8);
    popMatrix();
    
    pushMatrix();
    fill(150, 150, 150);
    translate(0, -(hallHeight/2) + 1, -(hallDepth/2));
    box(hallWidth, 1.2, 8);
    popMatrix();
    
    //ceiling
    pushMatrix();
    translate(0, -(hallHeight/2), 0);
    horizontalSurface();
    popMatrix();
    
    //lights
    pushMatrix();
    translate(0, -(hallHeight/2), -(hallDepth/4));
    light();
    popMatrix();
    
    pushMatrix();
    translate(0, -(hallHeight/2), (hallDepth/4));
    light();
    popMatrix();
    
    //right wall
    pushMatrix();
    translate(hallWidth/2, 0, 0);
    wall(true);
    popMatrix();
    
    //left wall
    pushMatrix();
    translate(-(hallWidth/2), 0, 0);
    //rotate(radians(180), 0, 1, 0);
    wall(false);
    popMatrix();
    
    //door
    if(door) {
      pushMatrix();
      translate(0, 0, -(hallDepth/2));
      door();
      popMatrix();
    }
    
  }
  
  void horizontalSurface() {
    pushMatrix();
    fill(125, 125, 125);
    ambient(50, 50, 50);
    specular(155, 155, 155);
    shininess(15.0);
    box(hallWidth, 1, hallDepth+2);
    popMatrix();
  }
  
  void wall(boolean right) {
    //sides of the window
    pushMatrix();
    fill(250, 250, 250);
    ambient(50, 50, 50);
    specular(155, 155, 155);
    shininess(15.0);
    translate(0, 0, hallDepth/4 + hallDepth/8);
    box(1.2, hallHeight/2  + 1, hallDepth/4);
    popMatrix();
    
    pushMatrix();
    translate(0, 0, -(hallDepth/4 + hallDepth/8));
    box(1.2, hallHeight/2 + 1, hallDepth/4);
    popMatrix();
    
    pushMatrix();
    translate(0, -(hallHeight/4), 0);
    box(1.2, 1, hallDepth/2);
    popMatrix();
    
    pushMatrix();
    translate(0, hallHeight/4, 0);
    box(1.2, 1, hallDepth/2);
    popMatrix();
    
    
    //above window
    pushMatrix();
    fill(125, 125, 125);
    translate(0, -(hallHeight/4 + hallHeight/8), 0);
    box(1, hallHeight/4, hallDepth);
    popMatrix();
    
    //below window
    pushMatrix();
    translate(0, (hallHeight/4 + hallHeight/8), 0);
    box(1, hallHeight/4, hallDepth);
    popMatrix();
    
    //pillar
    pushMatrix();
    translate(0, 0, -(hallDepth/2));
    if(!right) {
      rotate(radians(180), 0, 1, 0);
    }
    pillar();
    popMatrix();
    
    
    
    
  }
  
  void pillar() {
    //long part of the pillar
    pushMatrix();
    fill(150, 150, 150);
    ambient(50, 50, 50);
    specular(155, 155, 155);
    shininess(15.0);
    box(8, hallHeight, 8);
    popMatrix();
    
    //the angles
    pushMatrix();
    translate(-3, hallHeight/2, 0);
    rotate(radians(30), 0, 0, 1);
    box(8, 12, 8);
    popMatrix();
    
    pushMatrix();
    translate(-3, -(hallHeight/2), 0);
    rotate(-radians(30), 0, 0, 1);
    box(8, 12, 8);
    popMatrix();
    
  }
  
  //makes the lights in the ceiling
  void light() {
    pushMatrix();
    pushStyle();
    fill(255, 255, 255);
    ambient(100, 100, 100);
    specular(155, 155, 155);
    shininess(15.0);
    emissive(150);
    scale(1, .3, 1);
    sphereDetail(40);
    sphere(5);
    popStyle();
    popMatrix();
  }
  
  void openDoor() {
    if(doorPos < hallWidth/4) {
      doorPos++;
      doorWidth--;
    }
  }
  
  void closeDoor() {
    if(doorPos > 0) {
      doorPos--;
      doorWidth++;
    }
  }
  
  void door() {
    //left door
    pushMatrix();
    fill(50, 50, 50);
    ambient(50, 50, 50);
    specular(155, 155, 155);
    shininess(15.0);
    translate(-(hallWidth/4 + doorPos), 0, 0);
    box((doorWidth)-.25, hallHeight, 1);
    popMatrix();
    
    //right door
    pushMatrix();
    translate(hallWidth/4 + doorPos, 0, 0);
    box((doorWidth)-.25, hallHeight, 1);
    popMatrix();
    
    //divider between the doors
    pushMatrix();
    fill(100, 100, 100);
    ambient(10, 10, 10);
    specular(10, 10, 10);
    shininess(5);
    translate(-(hallWidth/4 + doorPos) + (doorWidth/2), hallHeight/8, 0);
    box(1, 3*(hallHeight/4), 1.5);
    popMatrix();
    
    //walls around the door
    pushMatrix();
    fill(100, 100, 100);
    ambient(50, 50, 50);
    specular(50,50,50);
    shininess(15.0);
    translate(0, -(hallHeight/4 + hallHeight/8), 0);
    box(hallWidth, hallHeight/4, 3);
    popMatrix();
    
    pushMatrix();
    translate(-(hallHeight/4 + 2*(hallHeight/8)), 0, 0);
    box(hallWidth/8, hallHeight,3);
    popMatrix();
    
    pushMatrix();
    translate((hallHeight/4 + 2*(hallHeight/8)), 0, 0);
    box(hallWidth/8, hallHeight,3);
    popMatrix();
    
    //control panel
    if(controlPanel) {
      pushMatrix();
      translate(-hallWidth/3, (hallHeight/3), 15);
      controlPanel();
      popMatrix();
    }

    
    
    
    
  }
  
  void controlPanel() {
    
    pushMatrix();
    fill(15, 15, 15);
    //ambient(50, 50, 50);
   // specular(155, 155, 155);
    shininess(15.0);
    box(3, hallHeight/2.5, 5);
    popMatrix();
    
    pushMatrix();
    fill(225, 225, 225);
    //ambient(50, 50, 50);
   // specular(155, 155, 155);
    shininess(15.0);
    translate(2.5, -6.75, 0);
    rotate(radians(90), 0, 0, 1);
    cylinder( 1, 2, 32);
    popMatrix();
    
    pushMatrix();
    //fill(255, 0, 0);
    //ambient(50, 50, 50);
   // specular(155, 155, 155);
    shininess(15.0);
    translate(2, -6.75, 0);
    rotate(radians(90), 0, 0, 1);
    cylinder( 2, 1, 32);
    popMatrix();
  }
}