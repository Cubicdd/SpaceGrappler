class Boss{
  int look;
  int cooldown1,cooldown2,cooldown3;
  int vunrable;
  float targetX,targetY;
  public Boss(int appearance){
    look=appearance;
    cooldown1=180;
    cooldown2=240;
    targetX=0;
    targetY=0;
  }
  
  void drawBoss(){
    if(look==1)bossOne();
  }
  void collideBoss(){
    if(sqrt(sq(2000-playerX)+sq(2000-playerY))<500){
      playerKill();
    }
    float weakX=2000;
    float weakY=2000;
    if(cooldown1<1){
      weakX=500*-cos(atan2(targetY,targetX))+2000;
      weakY=500*-sin(atan2(targetY,targetX))+2000;
    }else{
      weakX=500*-cos(atan2(playerY-2000,playerX-2000))+2000;
      weakY=500*-sin(atan2(playerY-2000,playerX-2000))+2000;
    }
    fill(255);
    for(Shot s:bullets){
      if(sqrt(sq(2000-s.position.x)+sq(2000-s.position.y))<500){
        deletedShots.add(s);
      }
      else if(sqrt(sq(s.position.x-weakX)+sq(s.position.y-weakY))<200){
        win();
      }
    }
  }
  
  
  void bossAttack(){
    laser();
    missiles();
    obstacles();
  }

  float dist = 0;
  void laser(){
    if(cooldown1<1){
      if(cooldown1==0){
        targetX = playerX-2000;
        targetY = playerY-2000;
      }
      else if(cooldown1>-30){
        strokeWeight(2);
        pushMatrix();
        translate(2000,2000);
        rotate(atan2(targetY,targetX));
        stroke(240,40,40);
        line(0,0,4000,0);
        popMatrix();
      }
      else if(cooldown1>-60){
        strokeWeight(70);
        
        boolean isHit;
        if((playerX<2000 && targetX>2000) || (playerX>2000 && targetX<2000))isHit=false;
        else{
    
          float xa = 0;//sets variable names so formula matches notes for troubleshooting
          float ya = 0;
          float xb = targetX;
          float yb = targetY;
          float xc = playerX-2000;
          float yc = playerY-2000;
          double s=(  ((xb-xa)*(xc-xa) + (yb-ya)*(yc-ya))/ 
                      (Math.pow((xb-xa),2) + Math.pow((yb-ya),2)));///gets distance along from lazer turret that player is perendicular to
          double Px = (1-s)*width/2 +s*xb;  //points on line that player is perpendicular to
          double Py= (1-s)*height/2+s*yb;
          double distance = Math.sqrt(Math.pow(xc-Px,2)+Math.pow(yc-Py,2));//distance from line
          //text((int)distance,50,50);
          isHit = distance<70;
        }
        
        pushMatrix();
        translate(2000,2000);
        rotate(atan2(targetY,targetX));
        //ellipse(localX,localY,1000,1000);
        stroke(240,40,40);
        
        line(0,0,4000,0);
        popMatrix();
        
        if(isHit){
          playerKill();
        }
        
      }else if(cooldown1>-90){
        //empty to stop rotating for small time after firing
      }
      else cooldown1=180;
    }
    cooldown1--;
  }
  void missiles(){
    if(cooldown2==0){
      PVector direction = new PVector(0,0);
      PVector position= new PVector(2000,2000);
      missiles.add(new Shot(position,direction,36000,2));
      if(cooldown2==0) cooldown2=160;
    }
    cooldown2--;
  }
  void obstacles(){}
}

void bossOne(){
  pushMatrix();
  translate(2000,2000);
  noStroke();
  fill(80);
  ellipse(0,0,1000,1000);//body
  
  if(boss.cooldown1>0) rotate(atan2(playerY-2000,playerX-2000)-PI/2);
  else rotate(atan2(boss.targetY,boss.targetX)-PI/2);
  noStroke();
  fill(60);
  rect(-100,0,200,800,5);//cannon
  fill(210,60,60);
  ellipse(0,-500,200,200);//weak point
  
  //silly face
  fill(255);
  ellipse(-75,600,120,120);//eyeballs
  ellipse(75,600,120,120);
  fill(50);
  ellipse(-75,600,50,50);//pupils
  ellipse(75,600,50,50);
  
  pushMatrix();//angry eyebrows
    fill(0);
    translate(65,500);
    rotate(-0.5);
    rect(-60,-40,120,80);
  popMatrix();
  pushMatrix();
    fill(0);
    translate(-65,500);
    rotate(0.5);
    rect(-60,-40,120,80);
  popMatrix();
  popMatrix();
}

void defeatBoss(){
  inMenu=true;
  menu="game win";
}
