void showHelpScreen()
    {
    background(yellow); // paints background in yellow
    image(partnerFace, width-150,150.*myFace.height/myFace.width,150,150.*myFace.height/partnerFace.width); 
    image(myFace, width-150,0,150,150.*myFace.height/myFace.width);
    
    fill(0);
    text("Me",600, 100);
    text("Partner",580,280);
    textAlign(LEFT, TOP);
    fill(black); // color for writing on screen (notice : writing text uses fill not stroke to define the color)
    int L=0; // line counter, incremented below for ech line
    writeLine("CLASS: CS3451 Fall 2018",L++);
   //writeLine("CLASS: CS6491 Fall 2018",L++); //*G use this in stead of the above line
    writeLine("PROJECT 1: Neville animation",L++);
    // writeLine("PROJECT 1: Morphing Quads",L++); //*G use this in stead of the above line
    writeLine("STUDENT: Jae Min Baek (John Baek)",L++); //**UG and G : Put your name here
    writeLine("PARTNER: Jeung Lee",L++); //**UG and G : Put your team partner's name here
    writeLine("MENU <SPACE>:hide/show",L++);
    writeLine("POINTS click&drag:closest, x:moveAll, z:zoomAll,",L++);
    writeLine("POINTS ]:square, /:align r:read, w:write",L++);
    writeLine("DISPLAY f:fill, #:Point IDs, v:vectors",L++);
    writeLine("ANIMATION a:on/off, ,/.:speedControl",L++);
    writeLine("Bezier b:curve, B:constructon",L++);
    writeLine("Neville n:curve, N:constructon",L++);
    writeLine("KNOTS 0:uniform, 1:chordal 2:centripetal",L++);
    writeLine("FILENAME FN C:set to content of clipboard",L++);
    writeLine("CAPTURE CANVAS to FN ~:pdf, !:jpg, @:tif, ':filming restart/stop",L++);
    writeLine("4 QUADS: 4:squares, R:read(FN), W:write(FN), f:fill, t:texture",L++);
    }
