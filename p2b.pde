// 3D Scene Example
// Lanah Marie Jose

//This animation consists of R2D2 going down a hallway, "hacking into" a control panel, opening a door,
//and going through the door.
//
//The object replicated using instancing is the entire hallway. Each section is one instance of the "hall" class.
//
//The moving objects are R2D2 and the sliding doors. R2 moves down the hallway and slides his feeet
//when he tilts (translation). He rotates his head, his probe, his arms, and his whole body.
//
//This animation loops for the sake of making rewatching easier, not for artistic taste

import processing.opengl.*;

R2D2 main;                                   //R2
Hall[] halls;                                //Array of hallways (this is the repeated object)

float r2Zpos, r2Xpos;                        //R2's z and x positions
boolean headTurningRight, headTurningLeft;   //Whether R2's head is turning right or left
boolean r2TurningLeft, r2TurningRight;       //Whether R2 is turning left or right
boolean r2TiltingIn, r2TiltingOut;           //Whether R2 is currently tilting in or out

float r2Angle;                               //The current angle which R2 is facing
float r2HeadAngle;

boolean probingOut, probingIn;               //Whether R2's probe is currently going in or out
boolean waiting;                             //Waiting
float wait;                                  //Wait counter

boolean doorOpening, doorClosing;            //Whether or not the door is currently opening or closing

float zoom;                                  //Zoom of the camera
float camStart;                              //Z position that the camera starts at
float camY;
float camX;

//float time = 0;                              // keep track of passing of time

int seq;                                     //The current sequence that is playing

void setup() {
  size(800, 800, P3D);
  noStroke();
  
  main = new R2D2();
  waiting = false;
  wait = 0;
  r2TurningLeft = false;
  r2TurningRight = false;
  r2TiltingIn = false;
  r2TiltingOut = false;
  doorClosing = false;
  probingOut = false;
  probingIn = false;
  r2Zpos = 350;
  r2Xpos = 0;
  r2Angle = 180;                             //have R2 facing away from the beginning
  r2HeadAngle = 0;
  camY = 0;
  camX = 0;
  
  halls = new Hall[5];                       //instantiating the hall array to make the hallway
  for(int i = 0; i < halls.length; i++) {
    halls[i] = new Hall();
    if(i == 1 || i == 4) {                   //puts doors at these hall sections
      halls[i].door = true;
      if(i == 1) {
        halls[i].controlPanel = true;        //putting a control panel at this hall section
      }
    }
  }
  
  main.setHeadTurnInt(1);                    //When R2's head turns, it turns at an interval of 1 degree
  headTurningRight = true;
  headTurningLeft = false;
  
  camStart = 175;
  zoom = 0;
  
  seq = 0;                                   //start at sequence 0
}

void draw() {
  
  resetMatrix();
  background(0); 
  
  // set up for perspective projection
  perspective (PI * 0.333, 1.0, 0.01, 1000.0);
    
  // create an ambient light source
  ambientLight (102, 115, 125);
  
  // create light sources
  lightSpecular (204, 204, 204);
  directionalLight (50, 50, 55, 0.5, -0.7, -1);
  directionalLight (100, 100, 105, -.7, -0.2, -1);
  directionalLight (152, 152, 155, 0, 1, 0);
  
  //Checking what is the current sequence that is playing
  //And does the actions for that sequence
  if(seq == 0) {
    seq0();
  } else if(seq == 1) {
    seq1();
  } else if(seq == 2) {
    seq2();
  } else if(seq == 3) {
    seq3();
  } else if(seq == 4) {
    seq4();
  } else if(seq == 5) {
    seq5();
  } else if(seq == 6) {
    seq6();
  } else if(seq == 7) {
    seq7();
  } else if(seq == 8) {
    seq8();
  } else if(seq == 9) {
    seq9();
  }

  // step forward in time
  //time += 0.05;
}


//R2 going down the hallway
void seq0() {
  camera (0.0, camY, camStart-zoom, 0.0, camY, -100.0, 0.0, 1.0, 0.0);
  
  
  zoom += .5;             //zooms in camera
  r2Zpos -= 2;             //moves R2 forward
  
  if(camY < 10) {
    camY += .1;
  }
  
  float headTurnLim = 60;                            //R2 Turns his head 60 degrees to the right
  if(headTurningRight) {
    if(main.getHeadAngle() > -headTurnLim) {         //Turn his head if he hasn't reached the limit yet
      main.turnHeadRight();
    } else {                                         //Once he reaches the limit
      headTurningRight = false;                      //No longer turning his head right
      headTurningLeft = true;                        //Turning his head left
    }
  }else if (headTurningLeft) {                       //Turning head to left
    if(main.getHeadAngle() < 0) {                    //If the head isn't in the front-facing position yet
      main.turnHeadLeft();                           //Turn head left
    } else {                                         //Once the head reaches the front-facing position
      headTurningLeft = false;                       //No longer turning head left
    }
  }
  
  if(r2Zpos < 12) {                                  //Once he reaches this position (the end of the hall
    headTurningLeft = true;                           //Head turning left
    main.setHeadTurnInt(2);                           //Set the head turning interval to 2 degrees
    seq++;                                            //Go to the next sequence
  }
  
  
  drawEverything();
  
}

//R2 turning to the left
void seq1() {
  camera (camX, camY, camStart-zoom, 0.0, camY, -100.0, 0.0, 1.0, 0.0);
  zoom += .35;          //zooms in camera
  
  if(camX > -20) {
    camX -= .1;
  }
  
  if(camY < 10) {
    camY += .25;
  }
  float headTurnLim = 90;
  if(headTurningRight) {                          //Turning head to right
    if(main.getHeadAngle() > 0) {
      main.turnHeadRight();
    } else {
      headTurningRight = false;
    }
  }else if (headTurningLeft) {                    //Turning head to left
    if(main.getHeadAngle() < headTurnLim) {
      main.turnHeadLeft();
    } else {
      headTurningLeft = false;
      headTurningRight = true;
      r2TurningLeft = true;
    }
  }
  
  if(r2TurningLeft) {                             //Turning R2 to the left
    if(r2Angle < 270) {
      r2Angle += 2;
    } else {
      r2TurningLeft = false;                      //Once he's facing the control panel, no longer turning left
      r2TiltingIn = true;                         //Start tilting in
      seq++;                                      //Next sequence
    }
  }
  
  
  drawEverything();
}

//R2 going up to the console
void seq2() {
  camera (camX, 10, camStart-zoom, 0, camY, -100.0, 0.0, 1.0, 0.0);
  zoom += .25;          //zooms in camera
  
  if(camX > -20) {                                //pans camera to left
    camX -= .1;
  }
  if(camY < 30) {                                  //points cam downward
    camY += .5;
  }

  if(r2TiltingIn) {                               //R2 tilting in to stand up straight
    if(main.r2Tilt > 0) {
      main.tiltIn();
    } else {
      r2TiltingIn = false;
      headTurningLeft = true;
      seq++;
    }
  }
  
  if(r2Xpos > -18) {                              //R2 moving up to the console
    r2Xpos -= 1;
  }
  
  
  drawEverything();
}

//R2 turning his head to look at us
void seq3() {
  camera (camX, 10, camStart-zoom, 0, camY, -100.0, 0.0, 1.0, 0.0);
  zoom += .25;          //zooms in camera
  
  if(camX > -20) {
    camX -= .1;
  }
  
  if(camY < 30) {
    camY += .5;
  }

  if(headTurningLeft) {                           //Head turning left
    if(main.getHeadAngle() < 75) {
      main.turnHeadLeft();
    } else {
      headTurningLeft = false;
      headTurningRight = true;
    }
  } else if (headTurningRight) {                  //Head turning right
    if(main.getHeadAngle() > 0) {
      main.turnHeadRight();
    } else {
      headTurningRight = false;                   //end head turning right
      seq++;                                      //Next sequence
      probingOut = true;                          //Sending out his probe
      waiting = false;
      wait = 0;
    }
  }
  
  
  drawEverything();
}

//R2 reaching out to hack the console
void seq4() {
  camera (-20, 15, camStart-zoom-15, 0, 0.0, -100.0, 0.0, 1.0, 0.0);
  zoom -= .025;          //zooms in camera

  if(probingOut) {                                //Sending out R2's probe
    if(main.probePos < 10) {
      main.probeOut();
    } else {                                      //Stop sending out probe if it's in position
      probingOut = false;
      waiting = true;
    }
  }
  
  if(waiting) {                                  //Wait (R2 hacking into system
    if(wait == 100) {
      seq++;                                     //Next sequence
      waiting = false;                           //No more waiting
      wait = 0;                                  //Set wait counter back to nothing
      doorOpening = true;                        //Door starts opening
      camY = 0;
      zoom -= 5;
    } else {
      wait += 1;                                 //Wait time going by
      main.turnProbe();                          //Turn R2's probe as waiting (while he's hacking in)
      if(wait == 75) {
        probingIn = true;
      }
    }
    
    if(wait%20 == 0) {
      main.changeLight();
    }
    
    if(main.probePos > 0 && probingIn) {         //Bringing R2's probe back in
      main.probeIn();
    } else if(main.probePos == 0) {
      probingIn = false;
    }
  }
  
  drawEverything();
}

//Door opening
void seq5() {
  camera (0.0, 0.0, camStart-zoom, 0.0, 0.0, -100.0, 0.0, 1.0, 0.0);
  //zoom += .25;          //zooms in camera

  if(doorOpening) {                              //Door is opening
    if(halls[1].doorPos < halls[1].hallWidth/4) {
      halls[1].openDoor();
    } else {                                     //Stop door opening if it's in position
      doorOpening = false;
      r2TiltingOut = true;
      r2TurningLeft = true;
      seq++;
    }
  }
  
  
  drawEverything();
}

//R2 facing us
void seq6() {
  camera (0.0, 0, camStart-zoom, 0.0, camY, -100.0, 0.0, 1.0, 0.0);
  //zoom +=.25;
  
  if(camY < 80) {                        //pointing camera down to look at R2
    camY += 1.25;
  }
  
  if(r2TiltingOut) {                    //R2 tilting back as he moves to turn
    if(main.r2Tilt < 20) {
      main.tiltOut();
    } else {
      r2TiltingOut = false;
    }
  }
  
  if(r2TurningLeft) {                   //R2 turning to face the cam
    if(r2Angle < 360) {
      r2Angle += 2;
    } else {
      seq++;
      r2Angle = 0;
      r2TurningLeft = false;
      r2TurningRight = true;
      headTurningRight = true;
      r2HeadAngle = 360;
      main.setHeadTurnInt(5);
    }
  }
  
  if(r2Xpos < 0) {                     //R2 moving back to the center of the hall
    r2Xpos++;
  }
  
  drawEverything();
}

//R2 dance (he spins his head and turns)
void seq7() {
  camera (0.0, 0, camStart-zoom, 0.0, camY, -100.0, 0.0, 1.0, 0.0);
  //zoom +=.25;
  float turnLim = 30;
  
  if(headTurningRight) {                      //his head does a full 360
   if(r2HeadAngle > 0) {
     main.turnHeadRight();
     r2HeadAngle -= main.getHeadTurnInt();
   } else {
     headTurningRight = false;
     r2TurningRight = false;
     r2TurningLeft = true;
     seq++;
   }
  }
  
  if(r2TurningRight) {                        //Turning back and forth (like he's dancing)
   if(r2Angle > -turnLim) {
     r2Angle -= 1;
   } else {
     r2TurningRight = false;
     r2TurningLeft = true;
   }
  } else if(r2TurningLeft) {
   if(r2Angle < turnLim) {
     r2Angle += 1;
   } else {
     r2TurningRight = true;
     r2TurningLeft = false;
   }
  }
  
  drawEverything();
  
}

//R2 turning away to face the door
void seq8() {
  camera (0.0, 0, camStart-zoom, 0.0, camY, -100.0, 0.0, 1.0, 0.0);
  zoom -= .25;
  if(r2TurningLeft) {                       //turning left to face away
    if(r2Angle < 180) {
      r2Angle += 5;
    } else {
      r2TurningLeft = false;
      seq++;
    }
  }
  
  drawEverything();
}

//R2 rolling away and closing the door while camera zooms out
void seq9() {
  camera (0.0, 0, camStart-zoom, 0.0, camY, -100.0, 0.0, 1.0, 0.0);
  if(camY > 0) {                          //raising the camera
    camY-= .2;
  }
  
  if(zoom > 0) {                          //zooming camera out
    zoom -= .25;
    
  } else {
    
    setup();                              //restart if camera is back in original position
  }
  if (r2Zpos > -300) {                    //R2 rolling away
    r2Zpos--;
    if(r2Zpos == -150) {
      doorClosing = true;
    }
  }
  
  if(doorClosing && halls[1].doorPos > 0) {  //door closing
    halls[1].closeDoor();
  }
  
  drawEverything();
}


//Draws R2D2 and the hallway
void drawEverything() {
  //Draw R2
  pushMatrix();
  translate(0, 10, 0);
  scale(.5, .5, .5);
  translate(r2Xpos, 0, r2Zpos);
  rotate(radians(r2Angle), 0, 1, 0);
  main.drawR2D2();
  popMatrix();
  
  
  //Draw hallway (object replicated by instancing)
  pushMatrix();
  translate(0, 0, 100);
  //int numHalls = 5;
  float hallDepth = 75;
  for(int i = 0; i < halls.length; i++) {
    
   pushMatrix();
   translate(0, 0, -(i*hallDepth));
   halls[i].drawHall();
   popMatrix();
  }
  popMatrix();
}


//Shapes==============================================================================

//Makes a 3d trapezoid
//Input: width, height, depth
void trapezoid(float w, float h, float d) {
  //top plate
  beginShape();
  vertex(-w/4, 0, -d/4);
  vertex(w/4, 0, -d/4);
  vertex(w/4, 0, d/4);
  vertex(-w/4, 0, d/4);
  vertex(-w/4, 0, -d/4);
  endShape(CLOSE);
  
  //bottom plate
  beginShape();
  vertex(-w/2, h, -d/2);
  vertex(w/2, h, -d/2);
  vertex(w/2,h, d/2);
  vertex(-w/2, h, d/2);
  vertex(-w/2, h, -d/2);
  endShape(CLOSE);
  
  //front plate
  beginShape();
  vertex(-w/4, 0, d/4);
  vertex(w/4, 0, d/4);
  vertex(w/2, h, d/2);
  vertex(-w/2, h, d/2);
  vertex(-w/4, 0, d/4);
  endShape(CLOSE);
  
  //back plate
  beginShape();
  vertex(-w/4, 0, -d/4);
  vertex(w/4, 0, -d/4);
  vertex(w/2, h, -d/2);
  vertex(-w/2, h, -d/2);
  vertex(-w/4, 0, -d/4);
  endShape(CLOSE);
  
  //left plate
  beginShape();
  vertex(-w/4, 0, -d/4);
  vertex(-w/4, 0, d/4);
  vertex(-w/2, h, d/2);
  vertex(-w/2, h, -d/2);
  vertex(-w/4, 0, -d/4);
  endShape(CLOSE);

  //right plate
  beginShape();
  vertex(w/4, 0, -d/4);
  vertex(w/4, 0, d/4);
  vertex(w/2, h, d/2);
  vertex(w/2, h, -d/2);
  vertex(w/4, 0, -d/4);
  endShape(CLOSE);
}



// Draw a cylinder of a given radius, height and number of sides.
// The base is on the y=0 plane, and it extends vertically in the y direction.
void cylinder (float radius, float height, int sides) {
  int i,ii;
  float []c = new float[sides];
  float []s = new float[sides];

  for (i = 0; i < sides; i++) {
    float theta = TWO_PI * i / (float) sides;
    c[i] = cos(theta);
    s[i] = sin(theta);
  }
  
  // bottom end cap
  
  normal (0.0, -1.0, 0.0);
  for (i = 0; i < sides; i++) {
   ii = (i+1) % sides;
   beginShape(TRIANGLES);
   vertex (c[ii] * radius, 0.0, s[ii] * radius);
   vertex (c[i] * radius, 0.0, s[i] * radius);
   vertex (0.0, 0.0, 0.0);
   endShape();
  }
  
  // top end cap

  normal (0.0, 1.0, 0.0);
  for (i = 0; i < sides; i++) {
  ii = (i+1) % sides;
  beginShape(TRIANGLES);
  vertex (c[ii] * radius, height, s[ii] * radius);
  vertex (c[i] * radius, height, s[i] * radius);
  vertex (0.0, height, 0.0);
  endShape();
  }
  
  // main body of cylinder
  for (i = 0; i < sides; i++) {
    ii = (i+1) % sides;
    beginShape();
    normal (c[i], 0.0, s[i]);
    vertex (c[i] * radius, 0.0, s[i] * radius);
    vertex (c[i] * radius, height, s[i] * radius);
    normal (c[ii], 0.0, s[ii]);
    vertex (c[ii] * radius, height, s[ii] * radius);
    vertex (c[ii] * radius, 0.0, s[ii] * radius);
    endShape(CLOSE);
  }
}