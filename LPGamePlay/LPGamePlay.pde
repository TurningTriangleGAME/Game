
/*
---------------------------------------------------------------------------------
TurningTriangle
Projet ISN 2014 ALGUIRIEV Adam - Bay-Eymère Argann - Toulemonde Blanche
Adapation du gameplay sur LeapMotion par ALGUIRIEV Adam

matériel utilisé    : LeapMotion (PC)
librairie utilisée  : LeapMotion for Processing
EDI                 : Processing 2.1
---------------------------------------------------------------------------------
*/

import de.voidplus.leapmotion.*;
import development.*;


LeapMotion leap;      //objet Leap
PVector hp;           //vecteur de la position de la main
float pos_x = 390;    //position de la main sur l'axe x
float pos_y;          //position de la main sur l'axe y
int hands_count = 0;  //nombre de mains détectées à l'écran

void setup(){
  size(800, 500, P3D);
  leap = new LeapMotion(this);
  noStroke();
  
}

void draw(){
  //int fps = leap.getFrameRate();
  //frameRate(fps);
  
    background(100);
    fill(0,204,204);
    rect(0,0, width,  100);
    rect(0,400, width,  100);
  
  for (Hand hand : leap.getHands()) {
    
    hands_count = leap.countHands();
    if (hands_count != 1) { IncorrectHand(); }
    
    getHandPos(hand); 
       
    pos_y = hp.y;
    if (pos_y > 100 && pos_y < 350) { move(); }
}

}

void move(){
  
  fill(255,50,145);
  rect(pos_x, pos_y, 30, 30);
  
}

void getHandPos(Hand hand){
  
  hp = hand.getPosition();
  
}

void IncorrectHand(){
  
  fill(255,50,145);
  
  if (hands_count > 1){
    text("Veuillez retirer une main.", 50, 50);
  } else {
    text("Erreur, retirez vos mains de la zone de détection puis replacez en un.", 50, 50);
  }
  
}

