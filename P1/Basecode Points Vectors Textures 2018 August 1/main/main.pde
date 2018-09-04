// base code 01 for graphics class 2018, Jarek Rossignac

// **** LIBRARIES
import processing.pdf.*;    // to save screen shots as PDFs, does not always work: accuracy problems, stops drawing or messes up some curves !!!
import java.awt.Toolkit;
import java.awt.datatransfer.*;


// **** GLOBAL VARIABLES

// COLORS
color // set more colors using Menu >  Tools > Color Selector
   black=#000000, grey=#5F5F5F, white=#FFFFFF, 
   red=#FF0000, green=#00FF01, blue=#0300FF,  
   yellow=#FEFF00, cyan=#00FDFF, magenta=#FF00FB, 
   orange=#FCA41F, dgreen=#026F0A, brown=#AF6E0B;

// FILES and COUNTERS
String PicturesFileName = "SixteenPoints";
int frameCounter=0;
int pictureCounterPDF=0, pictureCounterJPG=0, pictureCounterTIF=0; // appended to file names to avoid overwriting captured images

// PICTURES
PImage myFace; // picture of student's face as /data/myFace.jpg in sketch folder !!!!!!!!

// TEXT
PFont bigFont; // Font used for labels and help text

// KEYBOARD-CONTROLLED BOOLEAM TOGGLES AND SELECTORS 
int method=0; // selects which method is used to set knot values (0=uniform, 1=chordal, 2=centripetal)
boolean animating=true; // must be set by application during animations to force frame capture
boolean texturing=false; // fill animated quad with texture
boolean showBezierConstruction=false, showBezier=false; // toggle Bezier
boolean showNevilleConstruction=false, showNeville=true; // Toggle Bspline
boolean showControlVectors=true;
boolean showInstructions=true;
boolean showLabels=true;
boolean fill=false;
boolean filming=false;  // when true frames are captured in FRAMES for a movie

// flags used to control when a frame is captured and which picture format is used 
boolean recordingPDF=false; // most compact and great, but does not always work
boolean snapJPG=false;
boolean snapTIF=false;   

// ANIMATION
float totalAnimationTime=3; // at 1 sec for 30 frames, this makes the total animation last 90 frames
float time=0;

//POINTS 
int pointsCountMax = 32;         //  max number of points
int pointsCount=4;               // number of points used
PNT[] Point = new PNT[pointsCountMax];   // array of points
PNT A, B, C, D; // Convenient global references to the first 4 control points 
PNT P; // reference to the point last picked by mouse-click


// **** SETUP *******
void setup()               // executed once at the begining LatticeImage
  {
  size(800, 800, P2D);            // window size
  frameRate(30);             // render 30 frames per second
  smooth();                  // turn on antialiasing
  bigFont = createFont("AdobeFanHeitiStd-Bold-32", 16); textFont(bigFont); // font used to write on screen
  myFace = loadImage("data/studentFace.jpg");  // file containing photo of student's face
  declarePoints(Point); // creates objects for 
  readPoints("data/points.pts");
  A=Point[0]; B=Point[1]; C=Point[2]; D=Point[3]; // sets the A B C D pointers
  textureMode(NORMAL); // addressed using [0,1]^2
  } // end of setup


// **** DRAW
void draw()      // executed at each frame (30 times per second)
  {
  if(recordingPDF) startRecordingPDF(); // starts recording graphics to make a PDF
  
  if(showInstructions) showHelpScreen(); // display help screen with student's name and picture and project title

  else // display frame
    {
    background(white); // erase screen
        
    // Update animation time
    if(animating) 
      {
      if(time<1) time+=1./(totalAnimationTime*frameRate); // advance time
      else  time=0; // reset time to the beginning
      }
    
    
    
   // WHEN USING 4 CONTROL POINTS:  Use this for cubic Neville (3451) or for morphing edges (6491)
   if(pointsCount==4)
      {
      if(showControlVectors)         // Draw vectors
        {
        stroke(grey,100); strokeWeight(5); 
        for(int i=0; i<pointsCount-1; i++) arrow(Point[i],Point[i+1]);
        }
        
      if(showNeville) // Show Neville curve, animation, and possibly constuction
          {
            
          // Set time values (knots) associated with the control points 
          float a=0, b=0.33, c=0.67, d=1; // uniform setting of knots
          textAlign(LEFT, TOP); // writeLine assumes text position is not centered
          if(method==0) // use uniform spacing for  knots (intermediate times) at B and C
            {
            writeLine("Uniform knot spacing",0); // write this at top of screen (0)
            }
          if(method==1) // use distance-based spacing for  knots (intermediate times) at B and C
            {
            //**UG** ADD YOUR CODE HERE TO COMPUTE CHORDAL KNOTS
            writeLine("Chordal knot spacing",0); // write this at top of screen (0)
            }
          if(method==2) // use square-root spacing for knots (intermediate times) at B and C
            {
            //**UG** ADD YOUR CODE HERE TO COMPUTE CENTRIPETAL KNOTS
            writeLine("Centripetal knot spacing",0); // write this at top of screen (0)
            }
          b/=d; c/=d; d=1; // normalize knots so that d==1 
        
        
    
          // Draw interpolating cubic Neville curve 

          // Draw moving red circle in its current position   
          noFill(); stroke(red); 
          PNT Q = Neville(a,A,b,B,c,C,d,D,time); // compute disk center as point on the curve at parameter t=time
          drawCircle(Q,15); // draw the moving disk
          
          if (showNevilleConstruction) 
            showNevilleConstruction(a,A,b,B,c,C,d,D,time);
          else
            {
            strokeWeight(6); noFill(); stroke(blue); // draw fat curve without filling its interior
            drawNevilleCurve(a,A,b,B,c,C,d,D);
            }
          // Draws intermediate positions 
          fill(red); noStroke(); for(int i=1; i<9; i++) drawCircle(LERP(A,(float)i/9,D),6); // (notice the ``float'') 
          } // end ShowNeville

      
      if(showBezier) // Show Bezier curve, animation, and possibly constuction
          {
         // Draw  cubic bezier curve 
          if(showBezierConstruction) 
            showBezierConstruction(A,B,C,D,time);
          else
            {
            noFill(); 
            strokeWeight(6); stroke(red,100); drawBezierCurve(A,B,C,D); // draw fat curve without filling its interior
            noStroke(); fill(red); drawCircle(Bezier(A,B,C,D,time),10);
            }
     
          }
          
          
      // Draw and label control points
      if(showLabels) // draw names of control points
        {
        textAlign(CENTER, CENTER); // to position the label around the point
        stroke(black); strokeWeight(1); // attribute of circle around the label
        showLabelInCircle(A,"A"); showLabelInCircle(B,"B"); showLabelInCircle(C,"C"); showLabelInCircle(D,"D"); 
         }
      else // draw small dots at control points
        {
        fill(brown); stroke(brown); 
        drawCircle(A,6); drawCircle(B,6); drawCircle(C,6); drawCircle(D,6);
        }
      noFill(); 
      
      } // end of when 4 points
      


     
    // WHEN USING 16 CONTROL POINTS (press '4' to make them or 'R' to load them from file) 
    if(pointsCount==16)
      {
      noFill(); strokeWeight(6); 
      for(int i=0; i<4; i++) {stroke(50*i,200-50*i,0); drawQuad(Point[i*4],Point[i*4+1],Point[i*4+2],Point[i*4+3]);}
      strokeWeight(2); stroke(grey,100); for(int i=0; i<4; i++) drawOpenQuad(Point[i],Point[i+4],Point[i+8],Point[i+12]);
 
 
      // Draw control points
      if(showLabels) // draw names of control points
        {
        textAlign(CENTER, CENTER); // to position the label around the point
        stroke(black); strokeWeight(1); // attribute of circle around the label
        for(int i=0; i<pointsCount; i++) showLabelInCircle(Point[i],Character.toString((char)(int)(i+65)));
        }
      else // draw small dots at control points
        {
        fill(blue); stroke(blue); strokeWeight(2);  
        for(int i=0; i<pointsCount; i++) drawCircle(Point[i],4);
        }
        
      // Animate quad
      strokeWeight(20); stroke(red,100); // semitransparent
       //**G** ADD YOUR CODE FOR MORPHING QUADS IN THE ``quads'' TAB 
       // use it to set A, B, C, D to be the vertices of the morphed quad at the current time
       PNT At=P(), Bt=P(), Ct=P(), Dt=P();
       morphQuads(At,Bt,Ct,Dt,Point,time);
       noFill(); noStroke(); 
       if(texturing) 
         drawQuadTextured(At,Bt,Ct,Dt,myFace); // see ``points'' TAB for implementation
       else
         {
         noFill(); 
         if(fill) fill(yellow);
         strokeWeight(20); stroke(red,100); // semitransparent
         drawQuad(At,Bt,Ct,Dt);
         }
 
      } // end of when 16 points
     
        
      
    } // end of display frame
    
    
    
  // snap pictures or movie frames
  if(recordingPDF) endRecordingPDF();  // end saving a .pdf file with the image of the canvas
  if(snapTIF) snapPictureToTIF();   
  if(snapJPG) snapPictureToJPG();   
  if(filming) snapFrameToTIF(); // saves image on canvas as movie frame 
  
  } // end of draw()
