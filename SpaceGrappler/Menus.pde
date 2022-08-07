void helpText(){
  int offset=0;
  fill(255);
  textSize(50);
  offset+=45;
  text("Keys:",50,offset);
  textSize(30);
  offset+=35;
  text("z=accelerate",50,offset);
  offset+=30;
  text("x=grapple",50,offset);
  offset+=30;
  text("c=shoot",50,offset);
  offset+=30;
  text("r=main menu",50,offset);
  offset+=30;
  text("1=testing level",50,offset);
  offset+=30;
  text("2=main level",50,offset);
  offset+=30;
  text("2=blank level",50,offset);
}
  
  //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

void drawMenu(){
  //title
  background(20,80,150);
  textSize(200);
  fill(255);
  text("Space Grappler",width/2-720,250);
  
  //button 1
  noStroke();
  fill(80,80,230);
  if(mouseX<width/2+500 && mouseX>width/2-500 && mouseY>450 && mouseY<750) fill(100,100,250);
  rect(width/2-500,450,1000,300,15);
  
  fill(255);
  textSize(100);
  text("Start game",width/2-250,630);
  
  //different levels
  fill(80,80,230);
  if(mouseX<width/2-25 && mouseX>width/2-500 && mouseY>800 && mouseY<1100) fill(100,100,250);
  rect(width/2-500,800,475,300,15);
  fill(255);
  textSize(80);
  text("Test area",width/2-450,980);
  
  fill(80,80,230);
  if(mouseX<width/2+500 && mouseX>width/2+25 && mouseY>800 && mouseY<1100) fill(100,100,250);
  rect(width/2+25,800,475,300,15);
  fill(255);
  textSize(80);
  text("Blank area",width/2+60,980);
  
  //help menu
   //button 1
  noStroke();
  fill(80,80,230);
  if(mouseX<width/2+500 && mouseX>width/2-500 && mouseY>1150 && mouseY<1450) fill(100,100,250);
  rect(width/2-500,1150,1000,300,15);
  
  fill(255);
  textSize(100);
  text("Info menu",width/2-250,1330);
}

  //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  
void playerKill(){
  resetMatrix();
  inMenu=true;
  grappled=false;
  menu="game over";
  background(0);
  fill(255);
  textSize(500);
  text("GAME",500,600);
  text("OVER",550,1100);
  textSize(70);
  text("click anywhere to continue",800,1250);
}

void win(){
  resetMatrix();
  inMenu=true;
  grappled=false;
  menu="game won";
  background(80,80,240);
  fill(255);
  textSize(500);
  text("YOU",500,600);
  text("WIN!",550,1100);
  textSize(70);
  text("click anywhere to continue",800,1250);
}

  //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

void help(){
  background(20,80,150);
  int offset=0;
  fill(255);
  textSize(200);
  offset+=250;
  text("Keys:",300,offset);
  textSize(60);
  offset+=200;
  text("z=accelerate",300,offset);
  offset+=60;
  text("x=grapple",300,offset);
  offset+=60;
  text("c=shoot",300,offset);
  offset+=60;
  text("r=main menu",300,offset);
  offset+=60;
  text("h=help overlay",300,offset);
  offset+=60;
  text("mouse=aim ship",300,offset);
  offset+=60;
  
  textSize(200);
  offset=250;
  text("Instructions:",1000,offset);
  offset+=200;
  textSize(60);
  text("Lazer larry is out for war against everyone",1000,offset);
  offset+=60;
  text("and only you can stop him! Use your grapple",1000,offset);
  offset+=60;
  text("on walls to swing around the map and avoid",1000,offset);
  offset+=60;
  text("his lazers and missiles. Build up speed",1000,offset);
  offset+=60;
  text("and nail him on his weak spot on his back.",1000,offset);
  offset+=120;
  
  text("But be careful, one hit and you're toast,",1000,offset);
  offset+=60;
  text("and ramming Larry will do more damage to",1000,offset);
  offset+=60;
  text("you than to him.",1000,offset);
  offset+=60;
  
}
