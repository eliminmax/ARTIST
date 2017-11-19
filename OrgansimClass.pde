class Organism {
  boolean[][] colorHelix;
  boolean[][][] circlesHelixes;
  PGraphics OrganismDisplay=createGraphics(256, 256);  //initialize the organism, and set its initial strands
  Organism(boolean[][] colorHelix, boolean[][][] circlesHelixes) {
    //Set up the color helix 
    this.colorHelix=colorHelix;
    this.circlesHelixes=circlesHelixes;
  }
  Organism() {
    //Set up the color helix 
    this.colorHelix = new boolean[3][8];
    this.colorHelix[0]=randomStrand();
    this.colorHelix[1]=randomStrand();
    this.colorHelix[2]=randomStrand();
    //Set up the variables for the first circle
    this.circlesHelixes = new boolean[3][3][8];
    this.circlesHelixes[0][0]=randomStrand();
    this.circlesHelixes[0][1]=randomStrand();
    this.circlesHelixes[0][2]=randomStrand();
    //Set up the variables for the second circle
    this.circlesHelixes[1][0]=randomStrand();
    this.circlesHelixes[1][1]=randomStrand();
    this.circlesHelixes[1][2]=randomStrand();
    //Set up the variables for the third circle
    this.circlesHelixes[2][0]=randomStrand();
    this.circlesHelixes[2][1]=randomStrand();
    this.circlesHelixes[2][2]=randomStrand();
  }
  private boolean[] randomStrand() {
    boolean[] strand = {rand.nextBoolean(), rand.nextBoolean(), rand.nextBoolean(), rand.nextBoolean(), rand.nextBoolean(), rand.nextBoolean(), rand.nextBoolean(), rand.nextBoolean()};
    return strand;
  }


  //Prepare the PGraphics object to be displayed. shouldn't call unnecessarily due to it being an intensive process. 
  void prepDisplay() {
    //setup the display
    this.OrganismDisplay.beginDraw();
    this.OrganismDisplay.clear();
    this.OrganismDisplay.background(0);
    this.OrganismDisplay.strokeWeight(5);
    this.OrganismDisplay.noFill();
    //get color values from strands
    int r = createIntFrom(colorHelix[0]);
    int g = createIntFrom(colorHelix[1]);
    int b = createIntFrom(colorHelix[2]);
    //get coordinate values for the circles from strands
    int x0 = createIntFrom(circlesHelixes[0][0]);
    int y0 = createIntFrom(circlesHelixes[0][1]);
    int d0 = createIntFrom(circlesHelixes[0][2]);
    int x1 = createIntFrom(circlesHelixes[1][0]);
    int y1 = createIntFrom(circlesHelixes[1][1]);
    int d1 = createIntFrom(circlesHelixes[1][2]);
    int x2 = createIntFrom(circlesHelixes[2][0]);
    int y2 = createIntFrom(circlesHelixes[2][1]);
    int d2 = createIntFrom(circlesHelixes[2][2]);
    //set the stroke color
    this.OrganismDisplay.stroke(r, g, b);
    //draw circles to the PGrapgics object
    this.OrganismDisplay.ellipse(x0, y0, d0, d0);
    this.OrganismDisplay.ellipse(x1, y1, d1, d1);
    this.OrganismDisplay.ellipse(x2, y2, d2, d2);
    this.OrganismDisplay.endDraw();
  }
  //display the organism.
  void displayOrganism(int x, int y) {
    image(this.OrganismDisplay, x, y);
  }
}