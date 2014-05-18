
//Traitement du nomrbe de mains détectées
void IncorrectHand(){
  
  fill(255,50,145);
  
  if (hands_count > 1){
    text("Veuillez retirer une main.", 50, 50); // message affiché si le nombre de mains est supérieur à 1
  } else {
    text("Erreur, retirez vos mains de la zone de détection puis replacez en un.", 50, 50); // message affiché si le nombre de mains est inférieur à 1 (impossible)
  }
  
}
