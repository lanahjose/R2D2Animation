//Transformations to draw R2D2
//Lanah Marie Jose

class R2D2 {

  float r2Tilt;                //How much the main body is tilted
  float armTilt;               //How much his arms are tilted
  float headAngle;
  float headTurnInt;
  
  float probePos;
  float probeAngle;
  
  boolean tiltedOut;
  boolean lightRed;
  
  R2D2() {
    r2Tilt = 20;
    armTilt = 10;
    headAngle = 0;
    headTurnInt = 1;
    probePos = 0;
    probeAngle = 0;
    tiltedOut = false;
    lightRed = true;
  }
  
  void turnHeadLeft() {
    headAngle += headTurnInt;
    if (headAngle >= 360) {
      headAngle = headAngle - 360;
    }
  }
  
  void turnHeadRight() {
    headAngle -= headTurnInt;
    if (headAngle >= 360) {
      headAngle = headAngle - 360;
    }
  }
  
  void setHeadTurnInt(float headTurn) {
    this.headTurnInt = headTurn;
  }
  
  float getHeadTurnInt() {
    return headTurnInt;
  }
  
  float getHeadAngle() {
    return headAngle;
  }
  
  //Tilts r2d2 and tilts out his legs
  void tiltOut() {
    if(r2Tilt <20) {
      r2Tilt++;
      armTilt+=.5;
    } else {
      tiltedOut = true;
    }
  }
  
  void tiltIn() {
    if(r2Tilt > 0) {
      r2Tilt--;
      armTilt-=.5;
      tiltedOut = false;
    }
  }
  
  void drawR2D2() {
    
    //Draws head and cylinder body
    pushMatrix();
    rotate(radians(r2Tilt), 1, 0, 0);
    mainBody();
    popMatrix();
    
    //Draws both arms
    pushMatrix();
    bothArms();
    popMatrix();
    
    //Draws the foot below the main body
    pushMatrix();
    translate(0, 24, r2Tilt/2);
    lowerFoot();
    popMatrix();
  }
  
  void mainBody() {
    pushMatrix();
    rotate(radians(headAngle), 0, 1, 0);
    translate(0, -4, 0);
    head();
    popMatrix();
    
    pushMatrix();
    translate(0, -0, 0);
    body();
    popMatrix();
    
    pushMatrix();
    translate(-5,0, probePos);
    probe();
    popMatrix();
    
    
  }
  
  void probeOut() {
    if(probePos < 10) {
      probePos++;
    }
  }
  
  void probeIn() {
    if(probePos > 0) {
      probePos-= .5;
    }
  }
  
  void turnProbe() {
    probeAngle += 2;
  }
  

  void probe() {
    pushMatrix();
    fill(125, 125, 125);
    ambient(50, 50, 50);
    specular(155, 155, 155);
    shininess(15.0);
    translate(0, 0, -2);
    rotate(radians(90), 1, 0, 0);
    cylinder(.5, 10, 32);
    popMatrix();
    
    pushMatrix();
    translate(0, 0, 5);
    rotate(radians(90), 1, 0, 0);
    cylinder(1, 2, 32);
    popMatrix();
    
    pushMatrix();
    fill(15, 15, 15);
    translate( 0, 0, 6);
    rotate(radians(90 + probeAngle), 0, 0, 1);
    box(.5, 2.25, 2);
    popMatrix();
    
    pushMatrix();
    fill(15, 15, 15);
    translate( 0, 0, 6);
    rotate(-radians(0 - probeAngle), 0, 0, 1);
    box(.5, 2.25, 2);
    popMatrix();
  }
  
  
  //Draw R2D2's head
  void head() {
    
    //Draw sphere
    pushMatrix();
    fill(125, 125, 125);
    ambient(50, 50, 50);
    specular(155, 155, 155);
    shininess(15.0);
    scale(1, .9, 1);                  //Flattens the sphere a little bit
    sphereDetail(40);
    sphere(10);
    popMatrix();
    
    //R2D2's "neck"
    //Draw cylinder
    pushMatrix();
    cylinder (10.0, 4.0, 32);        
    popMatrix();
    
    
    //The blue rings around his neck
    pushMatrix(); 
    fill (0, 50, 200);
    ambient (100, 100, 200);
    specular (0, 0, 0);
    shininess (1.0);
    translate(0, 2.5, 0);
    cylinder (10.1, .75, 32);        
    popMatrix();
    
    
    //Draw face
    pushMatrix();
    translate(0, -3, 9);
    face();
    popMatrix();
    
    //Blue Panels around head--------------------------
    for(int i = 0; i < 5; i++) {
      pushMatrix();
      fill (0, 50, 200);
      ambient (100, 100, 200);
      specular (0, 0, 0);
      shininess (1.0);
      rotate(radians(i*15+50), 0, 1, 0);
      translate(0, .75, 9.1);
      //rotate(radians(7), 1, 0, 0);
      box (2, 3, 2);
      popMatrix();
    }
    
    pushMatrix();
    rotate(radians(-25), 0, 1, 0);
    translate(0, .75, 9.1);
    box (2, 3, 2);
    popMatrix();
    
    pushMatrix();
    rotate(radians(-38), 0, 1, 0);
    translate(0, .75, 9.1);
    box (1, 3, 2);
    popMatrix();
    
    for(int i = 0; i < 5; i++) {
      pushMatrix();
      rotate(radians(-(i*10+55)), 0, 1, 0);
      translate(0, .75, 9.1);
      //rotate(radians(7), 1, 0, 0);
      box (2, 3, 2);
      popMatrix();
    }
    
    for(int i = 0; i < 3; i++) {
      pushMatrix();
      rotate(radians((i*10+125)), 0, 1, 0);
      translate(0, .75, 9.1);
      //rotate(radians(7), 1, 0, 0);
      box (2, 3, 2);
      popMatrix();
    }
    
    for(int i = 0; i < 3; i++) {
      pushMatrix();
      rotate(radians((i*8+180)), 0, 1, 0);
      translate(0, .75, 9.1);
      //rotate(radians(7), 1, 0, 0);
      box (2, 3, 2);
      popMatrix();
    }
    for(int i = 0; i < 3; i++) {
      pushMatrix();
      rotate(radians((i*15+215)), 0, 1, 0);
      translate(0, .75, 9.1);
      //rotate(radians(7), 1, 0, 0);
      box (2, 3, 2);
      popMatrix();
    }
    
    pushMatrix();
    rotate(radians(163), 0, 1, 0);
    translate(0, .5, 9.5);
    rotate(radians(90), 1, 0, 0);
    nob();
    popMatrix();
    
    //light on the back
    pushMatrix();
    fill(250, 250, 250);
    ambient(50, 50, 50);
    specular(155, 155, 155);
    shininess(15.0);
    
    rotate(radians(190), 0, 1, 0);
    translate(0, .8, 10);
    scale(1, 1, .6);
    sphereDetail(40);
    sphere(1);
    popMatrix();
    
    
    
    //-------------------------------------------------
    
    //Top blue part
    pushMatrix();
    fill (0, 50, 200);
    ambient (100, 100, 200);
    specular (0, 0, 0);
    shininess (1.0);
    translate(0, -8, 0);
    scale(1, .4, 1);
    sphereDetail(40);
    sphere(3);
    popMatrix();
    
    
    //Draw back nob
    pushMatrix();
    translate(3, -7, -5);
    rotateX(-radians(90));
    rotateX(-radians(60));
    rotateZ(-radians(20));
    //rotateZ(-radians(30));
    //translate(0, -12, -3);
    nob();
    popMatrix();
    
    
    
    
  }
  
  void face() {
    pushMatrix();
    rotate (radians(30), 1.0, 0.0, 0.0);    //Tilts eye plate      
    translate(0, 0, -.5);              
    eye();
    popMatrix();
    
    pushMatrix();
    translate(0, 4, 0);
    mouth();
    popMatrix();
    
    
  }
  
  void eye() {
    
    //draw box that houses eye
    pushMatrix(); 
    fill (0, 50, 200);
    ambient (100, 100, 200);
    specular (0, 0, 0);
    shininess (1.0);
    box (5, 4, 2);
    popMatrix();
    
    //draws eye part of eye
    pushMatrix();
    fill(20, 20, 20);
    ambient(50, 50, 50);
    specular(155, 155, 155);
    shininess(15.0);
    scale(1, 1, .5);                    //Flattens sphere
    translate(-.5, 0, 1.5);
    sphereDetail(40);
    sphere(1.5);
    popMatrix();
    
  }
  
  //Changes the color of R2D2's light on his mouth
  void changeLight() {
    lightRed = !lightRed;
  }
  
  void mouth() {
    //draw box
    pushMatrix();
    fill (0, 50, 200);
    ambient (100, 100, 200);
    specular (0, 0, 0);
    shininess (1.0);
    translate(1, 0, 0);
    box (3, 2.5, 2.5);
    popMatrix();
    
    //Little skinny box beside main mouth box
    pushMatrix();
    translate(-1.5, 0, 0);
    box(1, 2.5, 2.5);
    popMatrix();
    
    //Red light
    pushMatrix();
    pushStyle();
    fill(250, 0, 0);
    ambient(50, 50, 50);
    specular(155, 155, 155);
    shininess(15.0);
    if(lightRed) {
      emissive(200, 50, 50);
    } else {
      emissive(50, 200, 200);
    }
    scale(1, 1, .5);
    translate(1.25, 0, 1.6);
    sphereDetail(40);
    sphere(1.2);
    popStyle();
    popMatrix();
    
    //Nob to the right of the mouth
    pushMatrix();
    rotateX(radians(90));
    rotateZ(-radians(30));
    translate(4.25, 1.5, .5);
    nob();
    popMatrix();
    
  }
  
  void nob() {
    pushMatrix();
    fill(150, 150, 150);
    ambient(50, 50, 50);
    specular(155, 155, 155);
    shininess(15.0);
    cylinder(1.5, 1, 32);
    popMatrix();
    
    pushMatrix();
    cylinder(1, 2, 32);
    popMatrix();
  }
  
  void body() {
    
    //Body cylinder
    pushMatrix();
    fill (250, 250, 250);
    ambient (50, 50, 50);
    specular (150, 150, 150);
    shininess (15.0);
    cylinder (10.0, 22.0, 32);
    popMatrix();
    
    //Lower body cylinder
    pushMatrix();
    translate(0, 22, 0);
    cylinder (9, 2, 32);
    popMatrix();
    
    //3 blue stripes on front of chest
    pushMatrix();
    translate(0, .5, 8);
    frontStripes();
    popMatrix();
    
    //Front Panel
    pushMatrix();
    translate(0, 11, 9.5);
    frontPanel();
    popMatrix();
    
    //Bottom Panel
    pushMatrix();
    translate(0, 19, 9.5);
    lowerPanel();
    popMatrix();
    
    //Side Panels
    pushMatrix();
    fill (0, 50, 200);
    ambient (100, 100, 200);
    specular (0, 0, 0);
    shininess (1.0);
    rotate(radians(90), 0, 1, 0);
    translate(0, 12, 9.1);
    box (5, 6, 2);
    popMatrix();
    
    pushMatrix();
    rotate(-radians(90), 0, 1, 0);
    translate(0, 12, 9.1);
    box (5, 6, 2);
    popMatrix();
    
    
    
    
  }
  
  
  void bothArms() {
    //Draw right arm
    pushMatrix();
    translate(14, 5, 0);
    rotate(-radians(armTilt), 1, 0, 0);
    scale(.75, 1, 1);
    arm();
    popMatrix();
    
    //Draw left arm
    pushMatrix();
    translate(-14, 5, 0); 
    rotate(-radians(armTilt), 1, 0, 0);
    rotate(radians(180), 0, 1, 0);
    scale(.75, 1, 1);
    arm();
    popMatrix();
    
    
    //The feet at the bottom of the arms
    pushMatrix();
    bothFeet();
    popMatrix();
  }
  
  //Left and right feet
  void bothFeet() {
    //Left foot
    pushMatrix();
    translate(-1, 19, -armTilt/3);
    translate(14, 5, 0);
    scale(.75, 1, 1);
    foot(10, 4, 15);
    popMatrix();
    
    //Right foot
    pushMatrix();
    translate(1, 19, -armTilt/3);
    translate(-14, 5, 0);
    scale(.75, 1, 1);
    foot(10, 4, 15);
    popMatrix();
    
    //The boxes on the inside of the feet -----
    pushMatrix();
    translate(-4.5, 1, 0);
    translate(1, 19, -armTilt/3);
    translate(14, 5, 0);
    scale(.75, 1, 1);
    box(3.5, 6,7.5);
    popMatrix();
    
    pushMatrix();
    translate(4.5, 1, 0);
    translate(-1, 19, -armTilt/3);
    translate(-14, 5, 0);
    scale(.75, 1, 1);
    box(3.5, 6,7.5);
    popMatrix();
    //-----------------------------------------
    
    //Rounded top of the boxes inside the feet
    pushMatrix();
    translate(-4.5, -1.75, -3.75);
    translate(1, 19, -armTilt/3);
    translate(14, 5, 0);
    scale(.75, .75, 1);
    rotate(radians(90), 1, 0, 0);
    cylinder(1.75, 7.5, 32);
    popMatrix();
    
    pushMatrix();
    translate(4.5, -1.75, -3.75);
    translate(-1, 19, -armTilt/3);
    translate(-14, 5, 0);
    scale(.75, .75, 1);
    rotate(radians(90), 1, 0, 0);
    cylinder(1.75, 7.5, 32);
    popMatrix();
  }
  
  //The 3 front stripes on the chest
  void frontStripes() {
    float t = 2;                  //spacing between the stripes
    
    for(int i = 0; i < 3; i++) {
      pushMatrix();
      fill (0, 50, 200);
      ambient (100, 100, 200);
      specular (0, 0, 0);
      shininess (1.0);
      scale(1, 1, .5);
      translate(0, t*i, 0);
      cylinder(5, 1, 32);
      popMatrix();
    }
  }
  
  //Foot below the main body
  void lowerFoot() {
    pushMatrix();
    foot(8, 4, 15);
    popMatrix();
    
    //The "leg" that connects the main body to the foot
    pushMatrix();
    fill(250, 250, 250);
    ambient(50, 50, 50);
    specular(150, 150, 150);
    shininess(15.0);
    rotate(radians(r2Tilt), 1, 0, 0);
    box(2, 8, 6);
    popMatrix();
  }
  
  //The panel on the center of the front body
  void frontPanel() {
    pushMatrix();
    fill (0, 50, 200);
    ambient (100, 100, 200);
    specular (0, 0, 0);
    shininess (1.0);
    box (5, 8, 2);
    popMatrix();
    
    pushMatrix();
    fill (250, 250, 250);
    translate(0, -2, 0);
    rotate(radians(90), 1, 0, 0);
    cylinder(2, 1.5, 32);
    popMatrix();
    
    pushMatrix();  
    translate(0, 2, 0);
    rotate(radians(90), 1, 0, 0);
    cylinder(2, 1.5, 32);
    popMatrix();
  }
  
  
  void lowerPanel() {
    pushMatrix();
    fill (0, 50, 200);
    ambient (100, 100, 200);
    specular (0, 0, 0);
    shininess (1.0);
    box (4, 4, 2);
    popMatrix();
    
    pushMatrix();
    fill (250, 250, 250);
    rotate(radians(90), 1, 0, 0);
    cylinder(1.5, 1.5, 32);
    popMatrix();
  }
  
  void arm() {
    //Arm connection
    pushMatrix();
    fill(250, 250, 250);
    ambient(50, 50, 50);
    specular(150, 150, 150);
    shininess(15.0);
    translate(-2, 0, 0);
    rotate(radians(90), 0, 0, 1);
    cylinder(3, 4, 32);
    popMatrix();
    
    //Nob at the end of the shoulder
    pushMatrix();
    translate(2, 0, 0);
    rotate(radians(90), 0, 0, 1);
    cylinder(2, 4, 32);
    popMatrix();
    
    //Shoulder
    pushMatrix();
    rotate(radians(90), 0, 0, 1);
    translate(0, -1, 0);
    cylinder(4, 4, 32);
    popMatrix();
    
    pushMatrix();
    translate(-1, 3, 3);
    box(4, 7, 2);
    popMatrix();
    
    pushMatrix();
    translate(-1, 3, -3);
    box(4, 7, 2);
    popMatrix();
    
    //Arm
    pushMatrix();
    translate(-1.5, 10, 0);
    box(3, 20, 6);
    popMatrix();
    
    //lower box
    pushMatrix();
    translate(-1, 15, 0);
    box(4, 5,8);
    popMatrix();
    
    //Blue part of arm
    pushMatrix();
    fill (0, 50, 200);
    ambient (100, 100, 200);
    specular (0, 0, 0);
    shininess (1.0);
    translate(-1, 10, 0);
    box(3, 15, 3);
    popMatrix();
    
    pushMatrix();
    translate(.4, 3, 0);
    box(3, 4, 4);
    popMatrix();
    
  }
  
  void foot(float w, float h, float d) {
    //Trapezoid. Main part of foot
    pushMatrix();
    fill(250, 250, 250);
    ambient(50, 50, 50);
    specular(150, 150, 150);
    shininess(15.0);
    trapezoid(w, h, d);
    popMatrix();
    
    //Box on the sides of the foot
    pushMatrix();
    translate(0, h+.5, 0);
    box(w, 1.5, d);
    popMatrix();
    
    //Cylinder on the sides of foot
    pushMatrix();
    translate(w/2-.5, h/1.5, 0);
    rotate(radians(90), 0, 0, 1);
    cylinder(h/1.75, w-1, 32);
    popMatrix();
    
    //Lower part of foot. The "sole" of the shoe
    pushMatrix();
    translate(0, h/1.5, 0);
    //rotate(radians(90), 0, 0, 1);
    box(w, h/2, d/5);
    popMatrix();
  }
}