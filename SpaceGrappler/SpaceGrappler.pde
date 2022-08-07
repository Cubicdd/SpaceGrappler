import java.awt.*;
import java.util.*;
import java.awt.geom.Line2D;
import java.awt.geom.Line2D.*;



int reboundCount, fireCooldown;
float playerX,//player location
      playerY,
      playerR,//player rotation
      playerS,//player acceleration
      moveX,//movement vector
      moveY,
      reboundX,//bounce vector
      reboundY,
      moveDistance,
      difference,
      shotSpeed;
boolean rLeft,rRight, boost, grappleHeld,help;//if buttons are held or not
boolean grappled, within90, inMenu;//if grapple is out or not
ArrayList<Line2D> wallCollide, wallDraw;//collision lines and drawn lines
ArrayList<PVector>test;
PVector grapplePoint;
ArrayList<Shot> bullets,deletedShots;
ArrayList<Shot> missiles,deletedMissiles;
String menu;
Boss boss;

  //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

void setup(){
  fullScreen();
  frameRate(60);
  playerX = width/2;//establishes player
  playerY = height/2;
  playerR = 0.0;
  playerS=0.2;
  reboundX=0;
  reboundY=0;
  reboundCount=0;
  grappled=false;
  
  moveX = 0;
  moveY = 0;
  
  rLeft = false;
  rRight = false;
  
  help = false;
  
  difference = 0;

  stageTwo();  //sets up terrain for first level
  within90 = true;
  
  menu="main";
  
  fireCooldown=0;
  bullets = new ArrayList<Shot>();
  deletedShots= new ArrayList<Shot>();
  missiles = new ArrayList<Shot>();
  deletedMissiles= new ArrayList<Shot>();
  boss=null;
  
  shotSpeed=30;
  
  inMenu=true;
  
}

  //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

void draw(){
  if(inMenu){
    menu();
  }
  else gameplay();
  if(!(menu=="main"||menu=="game over")||!inMenu){
    fill(80,80,230);
    if(mouseX<width-50 && mouseX>width-150 && mouseY>50 && mouseY<150) fill(100,100,250);
    rect(width-150,50,100,100,10);
    fill(255);
    textSize(35);
    text("main",width-142,95);
    text("menu",width-149,130);
  }
}

  //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
void gameplay(){
    pushMatrix();
  translate(width/2-playerX,height/2-playerY);
  //^^ makes camera follow player
  
  background(20,120,160);
  
  //walls
  noStroke();
  fill(60,120,255);
  for(int i=0;i<test.size()/2;i++){
    rect(test.get(2*i).x,test.get(2*i).y,test.get((2*i)+1).x-test.get(2*i).x,test.get((2*i)+1).y-test.get(2*i).y);
  }
  
  strokeWeight(15);
  stroke(20,60,120);
  for(Line2D l : wallDraw){//draws walls
    line((float)l.getX1(),(float)l.getY1(),(float)l.getX2(),(float)l.getY2());
  }
  
  
    if(grappled){//draws grapple line
    stroke(0);
    strokeWeight(6);
    line(playerX, playerY, grapplePoint.x, grapplePoint.y);
  }
  
  //player
  pushMatrix();
  translate(playerX,playerY);
  rotate(playerR);
  player();    //draws player at proper position
  popMatrix();
  if(grappled){
    moveGrapple();
  }
  else{
    inputPlayer();  //updates player position
    movePlayer();
  }
  
  for(Shot s:bullets){
    s.moveShot();
    s.drawShot();
  }
  for(Shot s:missiles){
    s.moveShot();
    s.drawShot();
  }
  missiles.removeAll(deletedMissiles);
  deletedMissiles.clear();
  bullets.removeAll(deletedShots);
  deletedShots.clear();
  
  if(boss!=null){
    boss.bossAttack();
    boss.drawBoss();
    boss.collideBoss();
  }
    
  if(fireCooldown>0)fireCooldown--;  
  popMatrix();
  
  if(help)helpText();
}

  //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  void menu(){
    if(menu=="game over"){
      playerKill();
      return;
    }
    if(menu=="game won"){
      win();
      return;
    }
    if(menu=="help"){
      help();
      return;
    }
    drawMenu();
  }
  
  //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

void keyPressed(){
  if(inMenu)return;
  if(key==CODED){//updates key pressed booleans
    if(keyCode==LEFT){
      rLeft=true;
    }
    if(keyCode==RIGHT){
      rRight=true;
    }
  }
  if(key=='z')boost=true;
  if(key=='x'){
    if(!grappleHeld){
      launchGrapple();
    }
  }
  if(key=='c'&&fireCooldown==0){
    PVector position = new PVector(playerX,playerY);
    PVector direction = new PVector(sin(playerR)*shotSpeed,-cos(playerR)*shotSpeed);
    Shot s = new Shot(position,direction,50,1);
    bullets.add(s);
    fireCooldown=100;
  }
  if(key=='h')help=true;
  
  if(key=='r')setup();//resets game
  //if(key=='1')stageOne();//sets up first level  removed as only used for testing
  //if(key=='2') stageTwo();
  //if(key=='3') blankStage();
}
void keyReleased(){
  if(inMenu)return;
  if(key==CODED){
    if(keyCode==LEFT){
      rLeft=false;//updates key pressed booleans
    }
    if(keyCode==RIGHT){
      rRight=false;
    }
  }
  if(key=='z')boost=false;
  if(key=='x'){
    releaseGrapple();
    grappleHeld=false;
  }
  if(key=='h')help=false;
}  
  
  //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
void mouseReleased(){
  if(inMenu){
    if(menu!="main"){
      menu="main";
    }
    else if(mouseX<width/2+500 && mouseX>width/2-500 && mouseY>450 && mouseY<750 && menu=="main"){
      stageTwo();
    }
    else if(mouseX<width/2-25 && mouseX>width/2-500 && mouseY>800 && mouseY<1100){
      stageOne();
    }
    else if(mouseX<width/2+500 && mouseX>width/2+25 && mouseY>800 && mouseY<1100){
      blankStage();
    }
    else if(mouseX<width/2+500 && mouseX>width/2-500 && mouseY>1150 && mouseY<1450){
      menu="help";
    }
  }
  if(mouseX<width-50 && mouseX>width-150 && mouseY>50 && mouseY<150) setup();
}
