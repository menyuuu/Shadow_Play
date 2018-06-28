import ddf.minim.*;
import ddf.minim.effects.*;
import ddf.minim.ugens.*;

import de.voidplus.leapmotion.*;
import processing.sound.*;


String[][] birds;

Minim minim;

Visitor visitorLeft;
Visitor visitorHand;

int lastLeftID = -1;
int lastHandtID = -1;

LeapMotion leap;
int count = 0; 

boolean handToggle = false;

int timer;
int fadeCount;

//BILDER//
PImage startscreen, background, back, middle, front, frontLight;
PVector handPosition;

void setup()
{

  //size(984, 1000);
  fullScreen(P2D, 2); //1280 x 960
  background(0);

  birds = new String[6][3];


  birds[0][0] = "Nightingale-01.wav";
  birds[0][1] = "Nightingale-02.wav";
  birds[0][2] = "Nightingale-03.wav";	

  birds[1][0] = "Misteldrossel-01.wav";
  birds[1][1] = "Misteldrossel-02.wav";
  birds[1][2] = "Misteldrossel-03.wav";

  birds[2][0] = "Kleiber-01.wav";
  birds[2][1] = "Kleiber-01.wav";
  birds[2][2] = "Kleiber-01.wav";

  birds[3][0] = "Amsel-01.wav";
  birds[3][1] = "Amsel-02.wav";
  birds[3][2] = "Amsel-03.wav";

  birds[4][0] = "Zaunkoenig-01.wav";
  birds[4][1] = "Zaunkoenig-01.wav";
  birds[4][2] = "Zaunkoenig-01.wav";

  birds[5][0] = "Kuckuck-01.wav";
  birds[5][1] = "Kuckuck-01.wav";
  birds[5][2] = "Kuckuck-01.wav";

  // birds[6][0] = "Meise-01.wav";
  // birds[6][1] = "Meise-01.wav";
  // birds[6][2] = "Meise-01.wav";


  minim = new Minim(this);

  leap = new LeapMotion(this);
  handPosition = new PVector();

  //BILDER// 
  background = loadImage("background-01.png"); 
  back = loadImage("back-01.png");
  middle = loadImage("middle-01.png");
  front = loadImage("front-01.png");
  frontLight = loadImage("frontLight-01.png");
  //startscreen = loadImage("startscreen-01.png");           //MACBOOK
  startscreen = loadImage("startscreen-01_projector.png");   //PROJECTOR
}

void draw()
{  //background(255);

  //image(startscreen, 0, 0, width, height);     //MACBOOk
  image(startscreen, -2, -240, 1285, 1600);     //PROJECTOR

  for (Hand hand : leap.getHands ()) 
  {   
    handPosition = hand.getPosition();
  }

  float frontY= (-250-(handPosition.y*1.5)/1.1);
  float middleY= (-250-(handPosition.y*1.5)/1.25);
  float backY= (-250-(handPosition.y*1.5)/1.35);
  float backgroundY = (-250-(handPosition.y*1.5)/1.6);
  //println(handPosition.y);

  // handle images 

  //BACKGROUND
  image(background, 200, backgroundY-100, 984, 2518); 

  //BACK
  image(back, 200, backY-100, 984, 2518);

  //MIDDLE
  image(middle, 200, middleY-100, 984, 2518);

  //FRONT
  image(front, 200, frontY-100, 984, 2518);

  //FRONT_LIGHT
  //image(frontLight, -2, -400, 1285, 1600);     //MACBOOK
  image(frontLight, -2, -240, 1285, 1600);       //PROJECTOR


  Hand myHand = leap.getLeftHand();
  if (myHand != null ) {
    /// if left hand is not available, then get right hand
    myHand = leap.getRightHand();
  }
  if (myHand != null) { 

    if (lastHandtID != myHand.getId()) {
      // new
      visitorHand = new Visitor(birds [int(random(0, 6))]); 
      //println(Visitor(birds);
      lastHandtID = myHand.getId();
      visitorHand.handpinch(myHand.getPinchStrength());
      //myHand.draw();
      //visitorHand.draw();

      println("hand new ID");
    } else {
      // same
      visitorHand.handpinch(myHand.getPinchStrength());
      //visitorHand.draw();
      //myHand.draw();
      //println("Right hand same ID");
      //pushStyle();
      //fill(255);
      //stroke(255);

      //myHand.draw();
      //popStyle();
    }
    timer = 0;
    fadeCount = 0;
  } else {
    timer++;
    if (visitorHand != null) {
      visitorHand.player1.pause();
      visitorHand = null;
      println("rightHand Stop Audio");
    }
    if (timer >=80) {
      //println("timer", timer);
      //delay(500);
      // misisng
      //image(startscreen, 0, 0, width, height);    //MACBOOK
      image(startscreen, -2, -240, 1285, 1600);     //PROJECTOR

      //image(startscreen, 470, -850, 984, 2519);
      visitorHand = null;
      // println("no Right hand");
      //timer = millis();
      // fadeCount++;
      // if (fadeCount<255) {
      //fill(0, 0, 0, fadeCount);
      //image(startscreen, 0, 0, width, height);    //MACBOOK
      //image(startscreen, -2, -240, 1285, 1600);     //PROJECTOR
      //tint(255, fadeCount);
      //}
      //rect(0, 0, width, height);
    }
  }
}
