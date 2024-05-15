PImage Hintergrund;
PImage StartBild;
float pr = 400;   //position Raumschiff
int SpielPhase = 1;
int tempoH = 10;
int hindernisPhase = 1;
int score = 0; 
float w = 300;
int framerate = 100;

//Hindernisse
int[] posX = new int [7];
int[] posY = new int [7];
float dc = 80;  
color[] farbe = new color [7];
int x = 2400;







void setup() {
  size(1200,800); 
  Hintergrund = loadImage("Hintergrund.jpg");
  StartBild = loadImage("BlickAusRaumschiff.jpg");
  frameRate(framerate);
}


void draw(){
  image(Hintergrund,0,0,width,height);
  
    
  
  //Bevor Spiel startet
  if (SpielPhase == 1) {
    score = 0;
    fill(#F2B3D0,75);
    rect(0,0,width,height);
    fill(255);
    
    //Text
    textSize(25);
    textAlign(CENTER);
    text("use the arrow keys or 'w' and 's' to steer",width/2,250);
    text("avoid the obstacles for as long as possible",width/2,350);
    text("press 'space' to start", width/2,450);
    text("if 'space' does not work, press the right mouse button on the game and try again  ",width/2, 550);
    
    
        //Spiel Start
        
        if (keyPressed && key == ' ') {
          SpielPhase = 2;
        }
  }
        //Spiel !!
        else if (SpielPhase == 2) {
          
        //score und Tempo der Hindernisse
        fill(255);
        textSize(30);
        text("score",900,50);
        textSize(30);
        score++;
        text(score,1000,50);
        
        if (score > w){
          framerate = framerate + 100;
          w = w + 200;
          tempoH = tempoH + 3;
        }
        
        
        
        //Raumschiff
        fill(255);
        triangle(90,pr + 5,75,pr + 5,50,pr + 40); //flügel 1
        fill(#F26CD1);
        circle(100,pr,60);
        fill(255);
        triangle(110,pr + 5,85,pr + 5,60,pr + 40); //flügel 2
        fill(#33B5F0);
        noStroke();
        arc(100,pr,40,40,radians(270),radians(360));
        
        //Steuerung
        if(keyPressed){
          
          if(key == 'w') {
              pr = pr - 10;
            }
        
             else if(key == 's') {
              pr = pr + 10;
             }
        
          if(key == CODED){
      
              if(keyCode == UP) {  //funktioniert nicht
              pr = pr - 10;
              }
     
              else if(keyCode == DOWN) {   //funktioniert nicht
               pr = pr + 10;
              }    
          }
        }
    
        //Hindernisse
        if(hindernisPhase == 1){
          for (int i = 0; i < posX.length; i++) {
          posX[i] = (int) random(1200,2400);
          posY[i] = (int) random(0, height);
          hindernisPhase = 2;
          int r, g, b;
          r = (int) random(20,256); //nicht 0 damit es keine zu dunkeln Farben gibt, die man auf dem Schwarzen Hintergrund nicht sieht. 
          g = (int) random(20,256);
          b = (int) random(20,256);
          farbe[i] = color(r,g,b);
        }
        }
        
    
        //Hindernisse
        for (int i = 0; i < posX.length; i++) {
          fill(farbe[i]);
          circle(posX[i], posY[i], dc);
          posX[i] = posX[i] - tempoH;
            if (posX[i] > 2400) {
            posX[i] = 0;
               } else if (posX[i] < (-40)) {
                 posX[i] = width;
                 posY[i] = int(random(0,height));
                 
        }
            // Crash
            if(sqrt((posX[i] - 100) * (posX[i] - 100) + (pr - posY[i]) * (pr - posY[i])) <= 70){
              SpielPhase = 3;
            }  
                 
                 }
        }


      



      
      //Spiel Ende
        if(SpielPhase == 3) {
        fill(#FA3041,75);
        rect(0,0,width,height);
        fill(255);
        
        //Text
        textSize(90);
        textAlign(CENTER);
        text("CRASHED!",width/2,280);
        textSize(50);
        text("your score:",width/2 - 100,390);
        text(score,width/2 + 100,390);
        
        //Kasten
        stroke(0);
        fill(0);
        strokeWeight(10);
        fill(255,50);
        rect(100,450,350,120);
        rect(800,450,350,120);
        textSize(50);
        fill(0);
        stroke(30);
        text("tap to restart",265,525);
        text("homescreen",965,525);
        
        
    if(mousePressed && mouseButton == LEFT)
    {
      if(mouseX >= 100 && mouseX <= 450 && mouseY >= 450 && mouseY <= 570)
      {
        SpielPhase = 2;
        hindernisPhase = 1;
      }
      else if(mouseX >= 800 && mouseX <= 1150 && mouseY >= 450 && mouseY <= 570)
      {
        SpielPhase = 1;
        hindernisPhase = 1;
      }
    }  //Quelle Frau Klankert
        
  }
      
      
}
