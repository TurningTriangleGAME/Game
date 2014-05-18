
/*
---------------------------------------------------------------------------------
* TurningTriangle
* Projet ISN 2014 ALGUIRIEV Adam - Bay-Eymère Argann - Toulemonde Blanche
* Adapation du gameplay sur LeapMotion par ALGUIRIEV Adam

* matériel utilisé    : LeapMotion (PC)
* librairie utilisée  : LeapMotion for Processing 1.1.3.1
* EDI                 : Processing 2.1
---------------------------------------------------------------------------------
*/

//Chargement des bibliothèques utilisées
import de.voidplus.leapmotion.*;
import development.*;


LeapMotion leap;      //objet Leap
PVector hp;           //vecteur de la position de la main (contient 3 champs : x, y, z)
float pos_x = 390;    //position de la main sur l'axe x
float pos_y;          //position de la main sur l'axe y
int hands_count = 0;  //nombre de mains détectées à l'écran

void setup(){
  size(800, 500);                             // Délimitation de la taille de la fênetre
  leap = new LeapMotion(this);                // Déclaration de l'objet leap (LeapMotion)
  noStroke();                                 // Empêche le dessin des contours
  println("Projet ISN 2014 : https://github.com/TurningTriangleGAME/Game");
  
}

void draw(){
  
  frameRate(60);                              // Détermine le nombre d'images par secondes (fps) affichées
  
    background(100);                          // Remet le fond gris à chaque pasage dans la boucle "draw" permet d'effacer la position précédente du carré à l'écran
    fill(0,204,204);                          // On utilisera la couleur "cyan" pour le dessin des limites du terrain de jeu
    rect(0,0, width,  100);                   // Limite supérieure du terrain de jeu
    rect(0,400, width,  100);                 // Limite inférieure du terrain de jeu
  
  for (Hand hand : leap.getHands()) {         // Le passage dans la boucle s'effectuer lorsqu'au moins 1 main est détectée
    
    hands_count = leap.countHands();          // On récupère le nombre de mains détectées.
    if (hands_count != 1) { IncorrectHand(); }// Si le nombre de mains est différent de '1' alors on redirige vers la fonction "IncorrectHand"
    
    getHandPos(hand);                         // On récupère la position de l'objet "hand" en faisant appel à la fonction "getHandPos"
       
    pos_y = hp.y;
    
    if (pos_y > 100 && (pos_y+30) < 400) {    // Si la position sur l'axe X est comprise entre les limites du terrain de jeu...
        move();                               // alors on rafraichit la position à l'écran
    }
    else if (pos_y < 100) {                   // Si la main est située trop haut...
      pos_y = 100;                            // alors on fixe la position à la limite du terrain de jeu sur l'axe Y
      move();
    }
    else {
      pos_y = 370;                           // Si la main est située trop près de l'appareil...
      move();                                // alors on fixe la position à la limite du terrain de jeu sur l'axe Y
    }
}

}
