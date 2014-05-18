
// Dessine le carré aux coordonnées fournies
void move(){
  
  fill(255,50,145);
  rect(pos_x, pos_y, 30, 30);
  
}

// récuprèe la position de "l'objet main"
void getHandPos(Hand hand){
  
  hp = hand.getPosition();
  
}
