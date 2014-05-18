1.	/* --------------------------------------------------------------------------
2.	 * SimpleOpenNI Adaptation Jeu interactif Turning Triangle par Blanche Toulemonde
3.	 * --------------------------------------------------------------------------
4.	 * Basé sur une démo montrant comment utiliser le générateur des gestes de la main.
5.	 * ----------------------------------------------------------------------------
6.	 * Source:
7.	 * Processing Wrapper for the OpenNI/Kinect 2 library
8.	 * http://code.google.com/p/simple-openni
9.	 * --------------------------------------------------------------------------
10.	 * Programme: Max Rheiner / Interaction Design / Zhdk / http://iad.zhdk.ch/
11.	 * Date: 12/12/2012 (m/d/y)
12.	 * ----------------------------------------------------------------------------
13.	 */
14.	 
15.	import java.util.Map;
16.	import java.util.Iterator;
17.	 
18.	import SimpleOpenNI.*; //déclaration de la librairie SimpleOpenNI
19.	 
20.	int pos_rect_x = 49; //position du rectangle sur l'axe des abscisses
21.	int L_rect = 50; //Largeur du rectangle
22.	int H_rect = 50; //Hauteur du rectangle
23.	 
24.	SimpleOpenNI context;
25.	int handVecListSize = 20; //taille de la liste qui va contenir les différents vecteurs de coordonnés de la main
26.	Map<Integer,ArrayList<PVector>>  handPathList = new HashMap<Integer,ArrayList<PVector>>(); //contient tous les vecteurs positions (X, Y, Z)
27.	color[]       userClr = new color[]{ color(255,0,0)}; //couleur
28.	                                   
29.	void setup()
30.	{
31.	  frameRate(30); //le nombre d'images par secondes (fluidité du programme)
32.	  size(640,480); //taille de la fenêtre
33.	 
34.	  context = new SimpleOpenNI(this); //activaiton et paramètres de l'objet 'context'
35.	  if(context.isInit() == false) //si il ne s'initialise pas.. le  message suivant s'affiche
36.	  {
37.	     println("Impossible d'initialiser SimpleOpenNI, vérifiez que Kinect est connecté."); //...ce message s'affiche
38.	     exit();
39.	     return;  
40.	  }  
41.	 
42.	  // enable depthMap generation
43.	  context.enableDepth(); //initialisation capteur sensitif de détection des mouvements
44.	 
45.	  // enable hands + gesture generation
46.	  context.enableHand(); //initialisation pour capter la main
47.	  context.startGesture(SimpleOpenNI.GESTURE_WAVE); //detection de la main lorsqu'on effectue une vague avec celle-ci
48.	 
49.	 }
50.	 
51.	void draw() //dessin (boucle)
52.	{
53.	  // rafraichissement caméra
54.	  context.update();
55.	 
56.	  background(255); //couleur fond d'écran
57.	   
58.	  // dessiner détection main
59.	  if(handPathList.size() > 0)  
60.	  {    
61.	    Iterator itr = handPathList.entrySet().iterator();    
62.	    while(itr.hasNext())
63.	    {
64.	      Map.Entry mapEntry = (Map.Entry)itr.next();
65.	      int handId =  (Integer)mapEntry.getKey();
66.	      ArrayList<PVector> vecList = (ArrayList<PVector>)mapEntry.getValue(); //contient tous les vecteurs positions (X, Y et Z)
67.	      PVector p;
68.	      PVector p2d = new PVector(); //coordonnées
69.	     
70.	        noFill();
71.	        strokeWeight(1);        
72.	        Iterator itrVec = vecList.iterator();
73.	        beginShape();
74.	          while( itrVec.hasNext() )
75.	          {
76.	            p = (PVector) itrVec.next(); //detecte vecteur mouvement main
77.	            context.convertRealWorldToProjective(p,p2d); //permet la détection du mouvement de la main
78.	          }
79.	        endShape();  
80.	 
81.	        p = vecList.get(0);
82.	        context.convertRealWorldToProjective(p,p2d);
83.	        fill(253, 108, 158); //couleur rectangle
84.	        rect(pos_rect_x,p2d.y, L_rect, H_rect);
85.	 
86.	    }        
87.	  }
88.	}
89.	 
90.	 
91.	// -----------------------------------------------------------------
92.	// évèneent de la main
93.	 
94.	void onNewHand(SimpleOpenNI curContext,int handId,PVector pos) //Nouvelle détection de la main
95.	{
96.	  println("onNewHand - handId: " + handId + ", pos: " + pos);
97.	 
98.	  ArrayList<PVector> vecList = new ArrayList<PVector>();
99.	  vecList.add(pos);
100.	 
101.	  handPathList.put(handId,vecList);
102.	}
103.	 
104.	void onTrackedHand(SimpleOpenNI curContext,int handId,PVector pos)
105.	{
106.	  ArrayList<PVector> vecList = handPathList.get(handId); //liste vecteur mouvement de la main
107.	  if(vecList != null)
108.	  {
109.	    vecList.add(0,pos);
110.	    if(vecList.size() >= handVecListSize)
111.	      //enelève le dernier point
112.	      vecList.remove(vecList.size()-1);
113.	  }  
114.	}
115.	 
116.	void onLostHand(SimpleOpenNI curContext,int handId) //détection de la main perdue
117.	{
118.	  println("onLostHand - handId: " + handId);
119.	  handPathList.remove(handId); //rectangle disparaît
120.	}
121.	 
122.	// -----------------------------------------------------------------
123.	// évènements des gestes (mouvement)
124.	 
125.	void onCompletedGesture(SimpleOpenNI curContext,int gestureType, PVector pos) //complement de type de mouvements de la main
126.	 
127.	{
128.	 
129.	  int handId = context.startTrackingHand(pos);
130.	  println("hand stracked: " + handId);
131.	}
