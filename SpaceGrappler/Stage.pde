//uses Array for collision, array for edges, and array for fill
//not the most efficent but as player collsion doesn't check what side the player is on it requires it's own set of walls

//sets area for first stage
void stageOne(){
  test = new ArrayList<PVector>();
  inMenu=false;
  grappled=false;
  
  fireCooldown=0;
  bullets = new ArrayList<Shot>();
  deletedShots= new ArrayList<Shot>();
  missiles = new ArrayList<Shot>();
  deletedMissiles= new ArrayList<Shot>();
  
  wallCollide = new ArrayList();
  wallCollide.add(new Line2D.Float(50,0,50,height));
  wallCollide.add(new Line2D.Float(0,50,width,50));
  wallCollide.add(new Line2D.Float(width-50,0,width-50,height));
  wallCollide.add(new Line2D.Float(0,height-50,width,height-50));
  
  
  wallCollide.add(new Line2D.Float(400,400,400,650));
  wallCollide.add(new Line2D.Float(400,400,650,400));
  wallCollide.add(new Line2D.Float(400,650,650,650));
  wallCollide.add(new Line2D.Float(650,400,650,650)); 
  
  wallDraw = new ArrayList();
  wallDraw.add(new Line2D.Float(0,0,0,height));
  wallDraw.add(new Line2D.Float(0,0,width,0));
  wallDraw.add(new Line2D.Float(0,height,width,height));
  wallDraw.add(new Line2D.Float(width,0,width,height));
  wallDraw.add(new Line2D.Float(450,450,600,450));
  wallDraw.add(new Line2D.Float(450,450,450,600));
  wallDraw.add(new Line2D.Float(450,600,600,600));
  wallDraw.add(new Line2D.Float(600,450,600,600));
  testAdd(450,450,600,600);

  testAdd(-width,-height,2*width,0);
  testAdd(-width,2*height,2*width,height);
  testAdd(-width,0,0,height);
  testAdd(width,0,2*width,height);
  
  playerX = width/2;
  playerY = height/2;
  playerR = 0;
  moveX = 0;
  moveY = 0;
  boss=null;
}

void stageTwo(){
  inMenu=false;
  grappled=false;
  test = new ArrayList<PVector>();
  wallDraw=new ArrayList();
  wallCollide = new ArrayList();
  fireCooldown=0;
  bullets = new ArrayList<Shot>();
  deletedShots= new ArrayList<Shot>();
  missiles = new ArrayList<Shot>();
  deletedMissiles= new ArrayList<Shot>();
  
  //sets up boss
  boss = new Boss(1);
  
  //outer walls spanning a 5000 wide space
  wallDraw(0,0,1500,0);
  wallDraw(2500,0,4000,0);
  wallDraw(0,0,0,1500);
  wallDraw(0,2500,0,4000);
  wallDraw(0,4000,1500,4000);
  wallDraw(2500,4000,4000,4000);
  wallDraw(4000,0,4000,1500);
  wallDraw(4000,2500,4000,4000);
  
  wallCollide(50,50,3950,50);
  wallCollide(50,50,50,3950);
  wallCollide(50,3900,3950,3950);
  wallCollide(3950,50,3950,3950);
  
  //top outside
  testAdd(-width,-height,4000+width,0);
  //left outside
  testAdd(-width,0,0,4000);
  //right outside
  testAdd(4000+width,0,4000,4000);
  //bottom outside
  testAdd(-width,height+4000,4000+width,4000);
  
  

  //indent on top side
  wallDraw(1500,0,1500,700);
  wallDraw(2500,0,2500,700);
  wallDraw(1500,700,2500,700);
  
  testAdd(1500,0,2500,700);
  
  wallCollide(1450,0,1450,750);
  wallCollide(2550,0,2550,750);
  wallCollide(1450,750,2550,750);
  
  
  
  //indent on left
  wallDraw(0,1500,700,1500);
  wallDraw(0,2500,700,2500);
  wallDraw(700,1500,700,2500);
  
  testAdd(0,1500,700,2500);
  
  wallCollide(0,1450,750,1450);
  wallCollide(0,2550,750,2550);
  wallCollide(750,1450,750,2550);
  
  
  //indent on right
  wallDraw(4000,1500,3300,1500);
  wallDraw(4000,2500,3300,2500);
  wallDraw(3300,1500,3300,2500);
  
  testAdd(4000,1500,3300,2500);
  
  wallCollide(4000,1450,3250,1450);
  wallCollide(4000,2550,3250,2550);
  wallCollide(3250,1450,3250,2550);
  
  
  //indent on bottom side
  wallDraw(1500,4000,1500,3300);
  wallDraw(2500,4000,2500,3300);
  wallDraw(1500,3300,2500,3300);
  
  testAdd(1500,4000,2500,3300);
  
  wallCollide(1450,4000,1450,3250);
  wallCollide(2550,4000,2550,3250);
  wallCollide(1450,3250,2550,3250);
  
  
  //top left box
  wallDraw(550,550,550,800);
  wallDraw(550,550,800,550);
  wallDraw(800,550,800,800);
  wallDraw(550,800,800,800);
  
  testAdd(550,550,800,800);
  
  wallCollide(500,500,500,850);
  wallCollide(500,500,850,500);
  wallCollide(850,500,850,850);
  wallCollide(500,850,850,850);
  
  
  //top right box
  wallDraw(3450,550,3450,800);
  wallDraw(3450,550,3200,550);
  wallDraw(3200,550,3200,800);
  wallDraw(3450,800,3200,800);
  
  testAdd(3450,550,3200,800);
  
  wallCollide(3500,500,3500,850);
  wallCollide(3500,500,3150,500);
  wallCollide(3150,500,3150,850);
  wallCollide(3500,850,3150,850);
  
  //bottom right box
  wallDraw(3450,3450,3450,3200);
  wallDraw(3450,3450,3200,3450);
  wallDraw(3200,3200,3450,3200);
  wallDraw(3200,3200,3200,3450);
  
  testAdd(3450,3450,3200,3200);
  
  wallCollide(3500,3500,3500,3150);
  wallCollide(3500,3500,3150,3500);
  wallCollide(3150,3150,3500,3150);
  wallCollide(3150,3150,3150,3500);
  
  //bottom left box
  wallDraw(550,3450,550,3200);
  wallDraw(550,3450,800,3450);
  wallDraw(800,3200,550,3200);
  wallDraw(800,3200,800,3450);
  
  testAdd(550,3450,800,3200);
  
  wallCollide(500,3500,500,3150);
  wallCollide(500,3500,850,3500);
  wallCollide(850,3150,500,3150);
  wallCollide(850,3150,850,3500);
  
  
  playerX = 1000;
  playerY = 1000;
  playerR = 0;
  moveX = 0;
  moveY = -15;
}

private void wallCollide(int x1,int y1,int x2,int y2){
  wallCollide.add(new Line2D.Float(x1,y1,x2,y2));
}
private void wallDraw(int x1,int y1,int x2,int y2){
  wallDraw.add(new Line2D.Float(x1,y1,x2,y2));
}
private void testAdd(int x1,int y1,int x2,int y2){
  test.add(new PVector(x1,y1));
  test.add(new PVector(x2,y2));
}

void blankStage(){
  inMenu=false;
  wallCollide = new ArrayList();//clears walls
  wallDraw = new ArrayList();
  playerX=0;
  playerY=0;
  moveX=0;
  moveY=0;
  grappled=false;
  boss=null;
  test=new ArrayList<PVector>();
  fireCooldown=0;
  bullets = new ArrayList<Shot>();
  deletedShots= new ArrayList<Shot>();
  missiles = new ArrayList<Shot>();
  deletedMissiles= new ArrayList<Shot>();
}
