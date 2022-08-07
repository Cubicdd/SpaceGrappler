//draws player ship
void player(){
  if(!grappled){
    stroke(240,40,60);
    strokeWeight(1);
    line(0,0,0,-1000);
  }
  stroke(255);
  strokeWeight(0);
  fill(255);
  beginShape();//main body
  vertex(0,-40);
  vertex(20,40);
  vertex(-20,40);
  endShape();
  
  //draws shot indicator
  noStroke();
  if(fireCooldown>60){
    fill(250,40,20);
  }else if(fireCooldown>0){
    fill(250,200,30);
  }else{
    fill(20,180,20);
  }
  ellipse(0,12,15,15);
  
  
  if(reboundX!=0 || reboundY!=0){  //draws shield grpahic on reound
  noFill();
  strokeWeight(3);
  stroke(180,20,230);
  circle(0,0,90);
  return;//doesn't draw thrust
  }
  
  
  if(boost&&!grappled){
    //draws thrusters
    fill(255,60,20);
    stroke(255,60,20);
    beginShape();
    vertex(20,40);
    vertex(15,75);
    vertex(10,65);
    vertex(5,75);
    vertex(0,65);
    vertex(-5,75);
    vertex(-10,65);
    vertex(-15,75);
    vertex(-20,40);
    endShape();
  }
}

  //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

//affects player
void inputPlayer(){
  //if(rLeft){//rotates player
  //  playerR-=0.1;
  //}
  //if(rRight){
  //  playerR+=0.1;
  //}
  
  playerR=atan2(mouseY-height/2,mouseX-width/2)+PI/2;
  
  if(boost && reboundX==0 && reboundY==0){//acceletates player if not in stun
    moveX +=playerS*sin(playerR);
    moveY +=playerS*-cos(playerR);
  }
}

void movePlayer(){
  for(Line2D w:wallCollide){  //collision code
    if(w.intersectsLine(playerX,playerY,playerX+moveX,playerY+moveY)&& (moveX!=0 || moveY!=0)){//check for collision
    
      releaseGrapple();
      
      if(w.intersectsLine(playerX,playerY,playerX,playerY+moveY)){
        reboundX=0;
        reboundY=-10*(moveY/abs(moveY));
      }
      if(w.intersectsLine(playerX,playerY,playerX+moveX,playerY)){
        reboundX=-10*(moveX/abs(moveX));
        reboundY=0;
      }
      reboundCount=10;
      
      //intersect code from: http://www.java2s.com/example/java-utility-method/line-intersect/intersection-line2d-a-line2d-b-94184.html
      double x1 = playerX, y1 = playerY, x2 = playerX+moveX, y2 = playerY+moveY, x3 = w.getX1(), y3 = w.getY1(), x4 = w.getX2(), y4 = w.getY2();
      double d = (x1 - x2) * (y3 - y4) - (y1 - y2) * (x3 - x4);
      playerX = (float)(((x3 - x4) * (x1 * y2 - y1 * x2) - (x1 - x2) * (x3 * y4 - y3 * x4)) / d);
      playerY = (float)(((y3 - y4) * (x1 * y2 - y1 * x2) - (y1 - y2) * (x3 * y4 - y3 * x4)) / d);
      //set player position to collision edge
      moveX=0;
      moveY=0;
      
    }
  }
  playerX+=moveX+reboundX;
  playerY+=moveY+reboundY;
  if(reboundCount!=0){
  reboundX-=reboundX/reboundCount;
  reboundY-=reboundY/reboundCount;
  reboundCount--;
  }
}
