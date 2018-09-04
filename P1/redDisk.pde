float r=50;

void setup() 
  {
  size(600, 400, P2D);
  }

void draw() 
  {
  background(255);
  fill(255,0,0);
  myDrawDisk(mouseX,mouseY,r);
  fill(0,0,200);
  text("x="+nf(mouseX,0,0)+", y="+nf(mouseY,0,0)+", r="+nf(r,0,0),200,20);
  }

void myDrawDisk(float px, float py, float pr) 
  {
  ellipse(px,py,pr*2,pr*2);
  }

void keyPressed()
  {
  if(key==',') r=max(1,r-1);
  if(key=='.') r=r+1;
  }