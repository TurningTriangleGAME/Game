
// Dessine le carré aux coordonnées fournies
void move(){
  
  fill(255,50,145);
  rect(pos_x, pos_y, 30, 30);   // dessin du carré avec les coordonnées mises à jour
  
}

// récuprèe la position de "l'objet main"
void getHandPos(Hand hand){
  
  hp = hand.getPosition();     // Ecriture des coordonnées dans le Vecteur hp
  
}
