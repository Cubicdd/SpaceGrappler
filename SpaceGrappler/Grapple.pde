void launchGrapple(){
  grappleHeld=true;
  
  int gDistance=1000;
  float maxX=(sin(playerR)*gDistance)+playerX;
  float maxY=(-cos(playerR)*gDistance)+playerY;
  float grappleX=maxX, grappleY=maxY;
  
  for(Line2D w:wallDraw){
    if(w.intersectsLine(playerX,playerY,grappleX,grappleY)){
      //intersect code from: http://www.java2s.com/example/java-utility-method/line-intersect/intersection-line2d-a-line2d-b-94184.html
      double x1 = playerX, y1 = playerY, x2 = maxX, y2 = maxY, x3 = w.getX1(), y3 = w.getY1(), x4 = w.getX2(), y4 = w.getY2();
      double d = (x1 - x2) * (y3 - y4) - (y1 - y2) * (x3 - x4);
      grappleX = (float)(((x3 - x4) * (x1 * y2 - y1 * x2) - (x1 - x2) * (x3 * y4 - y3 * x4)) / d);
      grappleY = (float)(((y3 - y4) * (x1 * y2 - y1 * x2) - (y1 - y2) * (x3 * y4 - y3 * x4)) / d);
      
      grappled=true;
      within90=true;
    }
  }  
  if(grappled==true){
    grapplePoint = new PVector(grappleX,grappleY);
    moveDistance = sqrt(sq(moveX)+sq(moveY));
  }
}

  //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

void moveGrapple(){
  if(within90){
    float angleMove = atan2(moveY,moveX);
    float angleGrapple = atan2(grapplePoint.y-playerY,grapplePoint.x-playerX);
    
    difference = ((angleMove-angleGrapple+3*PI)%(2*PI))-PI;//edge case if angleMove is close to 1.5PI now, was 2
    
    within90 = (abs(difference)<=PI/2);//works just fine yet that VV doesn't
  }
  if(!within90){
    //move player around grapplePoint by move distance over radius radians
    
    int direction;
    if(difference<1)direction=1;//fix this
    else if(difference>1) direction=-1;
    else direction=0;
    
    //distance from player to grapple point
    float grappleDistance = sqrt(sq(grapplePoint.x-playerX)+sq(grapplePoint.y-playerY));
    float ratio = moveDistance/grappleDistance*direction;
    
    //ratio is always positive which is a problem
    
    float playerAngle = atan2(playerY-grapplePoint.y,playerX-grapplePoint.x);
    
    moveX = cos(ratio+playerAngle)*grappleDistance+grapplePoint.x-playerX;
    moveY = sin(ratio+playerAngle)*grappleDistance+grapplePoint.y-playerY;
    
    if(direction==0){
      moveX=0;
      moveY=0;
    }
    
    //playerR=ratio+playerAngle-PI/2;//move outside if statement
  }
  playerR = atan2(playerY-grapplePoint.y,playerX-grapplePoint.x)-PI/2;
  movePlayer();
}

  //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

void releaseGrapple(){
  grappled=false;
  //update moveX and moveY
}
