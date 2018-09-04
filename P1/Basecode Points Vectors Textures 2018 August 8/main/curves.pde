//**** NEVILLE INTERPOLATING CURVES AND ANIMATIONS *** Project 1 for CS3451
PNT Neville(float a, PNT A, float b, PNT B, float t) {
  //**UG** ADD YOUR CODE HERE INSTEAD OF LINE BELOW
  //return new PNT(A.x + t*(B.x-A.x), A.y + t*(B.y-A.y)); // Q: do we need to use a and b?
  return LERP(A, (t-a)/(b-a), B);
}
  
PNT Neville(float a, PNT A, float b, PNT B, float c, PNT C, float t) {
    //**UG** ADD YOUR CODE HERE INSTEAD OF LINE BELOW
    PNT pab = Neville(a, A, b, B, t);
    PNT pbc = Neville(b, B, c, C, t);

  return Neville(a, pab, c, pbc, t); 
  }
  
PNT Neville(float a, PNT A, float b, PNT B, float c, PNT C, float d, PNT D, float t) {
  //**UG** ADD YOUR CODE HERE INSTEAD OF LINE BELOW
  PNT pabc = Neville(a, A, b, B, c, C, t);
  PNT pbcd = Neville(b, B, c, C, d, D, t);
  return Neville(a, pabc, d, pbcd, t);  
}

void drawNevilleCurve(float a, PNT A, float b, PNT B, float c, PNT C, float d, PNT D)
    {
    float du=1./90;
    beginShape(); 
      for(float u=0; u<=1.+du/2; u+=du) 
        vert(Neville(a,A,b,B,c,C,d,D,u)); // does not work yet (you must write that Neville function (in Tab points) )
    endShape(); 
    }

void showNevilleConstruction(float a, PNT A, float b, PNT B, float c, PNT C, float d, PNT D, float time) 
  {
  //**UG** ADD HERE YOUR SHOW NEVILLE CONSTRUCTION CODE,
  PNT Pab = Neville(a,A,b,B,time);
  PNT Pbc = Neville(b,B,c,C,time);
  PNT Pcd = Neville(c,C,d,D,time);
  PNT Pabc = Neville(a,A,b,B,c,C,time);
  PNT Pbcd = Neville(b,B,c,C,d,D,time); 
  PNT Pabcd = Neville(a, A, b, B, c, C, d, D, time);
  
  noFill();
  strokeWeight(14);
  stroke(orange,40); drawNevilleCurve(a, A, b, B, c, C, d, D);   

  noStroke();
  fill(red,100); drawCircle(Pab,16); 
  fill(green,100); drawCircle(Pbc,16);
  fill(blue,100); drawCircle(Pcd,16);
  fill(brown,100); drawCircle(Pabc,16);
  fill(magenta,100); drawCircle(Pbcd,16);
  fill(black,100); drawCircle(Pabcd,16);

  //  noFill();
 
  //stroke(blue);
  //strokeWeight(2);  drawEdge(A,B); drawEdge(B,C); drawEdge(C,D);
  //strokeWeight(6);  drawEdge(A,Pab);  drawEdge(B,Pbc); drawEdge(C,Pcd);

  ////stroke(green);    
  //strokeWeight(2);  drawEdge(Pab,Pbc); drawEdge(Pbc,Pcd); 
  //strokeWeight(6); drawEdge(Pab,Pabc);  drawEdge(Pbc,Pbcd); 

  //stroke(red);
  //strokeWeight(2);  drawEdge(Pabc,Pbcd); 
  //strokeWeight(6);  drawEdge(Pabc,Pabcd);  

  //noStroke();
  //float r=8;
  ////fill(blue); drawCircle(Pab,r); drawCircle(Pbc,r); drawCircle(Pcd,r);
  ////fill(green); drawCircle(Pabc,r); drawCircle(Pbcd,r); 
  ////fill(red); drawCircle(Pabcd,r);
  }

//**** BEZIER INTERPOLATING CURVES AND ANIMATIONS 
PNT Bezier(PNT A, PNT B, float t) 
  {
  return LERP(A,t,B);  
  }
  
PNT Bezier(PNT A, PNT B, PNT C, float t) 
  {
  PNT S = Bezier(A,B,t);
  PNT E = Bezier(B,C,t);
  return  Bezier(S,E,t);
  }
  
PNT Bezier(PNT A, PNT B, PNT C, PNT D, float t) 
  {
  PNT S = Bezier(A,B,C,t);
  PNT E = Bezier(B,C,D,t);
  return  Bezier(S,E,t);
  }

void drawBezierCurve(PNT A, PNT B, PNT C)
    {
    float du=1./90;
    beginShape(); 
      for(float u=0; u<=1.+du/2; u+=du) 
        vert(Bezier(A,B,C,u)); // does not work yet (you must write that Neville function (in Tab points) )
    endShape(); 
    }

void drawBezierCurve(PNT A, PNT B, PNT C, PNT D)
    {
    float du=1./90;
    beginShape(); 
      for(float u=0; u<=1.+du/2; u+=du) 
        vert(Bezier(A,B,C,D,u)); // does not work yet (you must write that Neville function (in Tab points) )
    endShape(); 
    }

void showBezierConstruction(PNT A, PNT B, PNT C, PNT D, float t)
  {
  PNT Pab = Bezier(A,B,t),  Pbc = Bezier(B,C,t),  Pcd = Bezier(C,D,t);
  PNT          Pabc = Bezier(Pab,Pbc,t),      Pbcd = Bezier(Pbc,Pcd,t);
  PNT                   Pabcd = Bezier(Pabc,Pbcd,t);
  noFill();

  strokeWeight(14);
  stroke(orange,40); drawBezierCurve(A,B,C);   
  stroke(magenta,40); drawBezierCurve(B,C,D);  
  
  noStroke();
  fill(orange,100); drawCircle(Pabc,16); 
  fill(magenta,100); drawCircle(Pbcd,16);
  
  noFill();
 
  stroke(blue);
  strokeWeight(2);  drawEdge(A,B); drawEdge(B,C); drawEdge(C,D);
  strokeWeight(6);  drawEdge(A,Pab);  drawEdge(B,Pbc); drawEdge(C,Pcd);

  stroke(green);    
  strokeWeight(2);  drawEdge(Pab,Pbc); drawEdge(Pbc,Pcd); 
  strokeWeight(6); drawEdge(Pab,Pabc);  drawEdge(Pbc,Pbcd); 

  stroke(red);
  strokeWeight(2);  drawEdge(Pabc,Pbcd); 
  strokeWeight(6);  drawEdge(Pabc,Pabcd);  

  noStroke();
  float r=8;
  fill(blue); drawCircle(Pab,r); drawCircle(Pbc,r); drawCircle(Pcd,r);
  fill(green); drawCircle(Pabc,r); drawCircle(Pbcd,r); 
  fill(red); drawCircle(Pabcd,r);
  }
