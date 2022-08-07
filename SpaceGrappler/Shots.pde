class Shot{
  PVector position;
  PVector direction;
  int lifespan;
  int SIZE;
  int type;
  
  public Shot(PVector position,PVector direction,int lifespan,int type){
    this.position = position;
    this.direction=direction;
    this.lifespan=lifespan;
    this.type = type;
    SIZE = 20;
  }
  
  public void drawShot(){
    if(type==1){
      noStroke();
      fill(255);
      ellipse(position.x,position.y,SIZE,SIZE);
      return;
    }
    if(type==2){
      pushMatrix();
      translate(position.x,position.y);
      rotate(atan2(playerY-position.y,playerX-position.x));
      noStroke();
      fill(255);
      rect(25,25,-50,-50);
      fill(255,0,0);
      beginShape();
      vertex(25,25);
      vertex(35,15);
      vertex(35,-15);
      vertex(25,-25);
      endShape(CLOSE);
      popMatrix();
    }
  }
  
  public void moveShot(){
    
    if(lifespan==0){//kills bullet if out of time
      if(type==1)
        deletedShots.add(this);
      if(type==2)
        deletedMissiles.add(this);
      return;
    }
    if(type==2){
      float Tlength = 10;
      direction.x=Tlength * cos(atan2(playerY-position.y,playerX-position.x));
      direction.y=Tlength * sin(atan2(playerY-position.y,playerX-position.x));
    }
    
    for(Line2D w:wallCollide){  //if colliding with wall
      if(w.intersectsLine(position.x,position.y,position.x+direction.x,position.y+direction.y)){
        if(type==1)
        deletedShots.add(this);
        else if(type==2)
        deletedMissiles.add(this);
      }
    }
    position.x+=direction.x;
    position.y+=direction.y;
    
    if(type==2){
      float dist = sqrt(sq(playerX-position.x)+sq(playerY-position.y));
      if(dist<55)playerKill();
      for(Shot s:bullets){
        if(sqrt(sq(s.position.x-position.x)+sq(s.position.y-position.y))<40) {
          deletedMissiles.add(this);
          deletedShots.add(s);
        }
      }
    }
    
    lifespan--;
  }
}
