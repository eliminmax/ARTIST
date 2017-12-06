import java.util.Random;//import the random value generator library
import java.util.Collections;
PFont title, subtitle, body;
Random rand = new Random();//create random value generator
int generation = 0;
color[] colorKey = {color(255), color(255, 0, 0), color(255, 211, 0), color(57, 20, 175), color(0, 204, 0)};
color org0 = color(255);
color org1 = color(255, 0, 0);
color org2 = color(255, 211, 0);
color org3 = color(57, 20, 175);
color org4 = color(0, 204, 0);
ArrayList<Organism> nextGenOrganisms=new ArrayList<Organism>();//the two organisms that the next gen will be based on will go in here
ArrayList<Organism> currentOrganisms=new ArrayList<Organism>();//all current-gen organisms will go in here
int carryOver=0;
boolean firstPlace=true, reset=false;

void chooseOrganism(int organismIndex) {
  if (firstPlace) {
    nextGenOrganisms.add(currentOrganisms.get(organismIndex));
    firstPlace=false;
    carryOver=organismIndex;
  } else {
    if (carryOver!=organismIndex) {
      nextGenOrganisms.add(currentOrganisms.get(organismIndex));
      reprepOrganisms();
    }
  }
}
void drawCurrentOrganisms() {
  if (currentOrganisms.size()>=5) {
    textAlign(LEFT, BOTTOM);
    textFont(body);
    fill(colorKey[0]);
    text("1", 100, height+5);
    rect(200, 100, 275, 275);
    currentOrganisms.get(0).displayOrganism(210, 110);
    fill(colorKey[1]);
    text("2", 125, height+5);
    rect(891, 100, 275, 275);
    currentOrganisms.get(1).displayOrganism(901, 110);
    fill(colorKey[2]);
    text("3", 150, height+5);
    rect(100, 458, 275, 275);
    currentOrganisms.get(2).displayOrganism(110, 468);
    fill(colorKey[3]);
    text("4", 175, height+5);
    rect(555, 458, 275, 275);
    currentOrganisms.get(3).displayOrganism(565, 468);
    fill(colorKey[4]);
    text("5", 200, height+5);
    rect(991, 458, 275, 275);
    currentOrganisms.get(4).displayOrganism(1001, 468);
  }
}
void Reproduce(Organism starter, Organism alternate) {
  boolean[][] newCol = new boolean[3][8];
  for (int i = 0; i < starter.colorHelix.length; i++) {
    newCol[i] = mergeStrands(starter.colorHelix[i], alternate.colorHelix[i]);
  }
  boolean[][][] newCir = new boolean[3][3][8];
  for (int i = 0; i < starter.circlesHelixes.length; i++) {
    for (int n = 0; n < starter.circlesHelixes[i].length; n++) {
      newCir[i][n] = mergeStrands(starter.circlesHelixes[i][n], alternate.circlesHelixes[i][n]);
    }
  }
  currentOrganisms.add(0, new Organism(newCol, newCir));
  currentOrganisms.get(0).prepDisplay();
}
void reprepOrganisms() {//Reset all of the organisms
  generation++;
  while (currentOrganisms.size()>0) {
    currentOrganisms.remove(0);
  }
  if (generation<7) {
    Reproduce(nextGenOrganisms.get(0), nextGenOrganisms.get(1));
    Reproduce(nextGenOrganisms.get(1), nextGenOrganisms.get(0));
    Reproduce(nextGenOrganisms.get(0), new Organism());  
    Reproduce(nextGenOrganisms.get(1), new Organism());
    Reproduce(nextGenOrganisms.get(0), new Organism());
    Collections.shuffle(currentOrganisms);
    firstPlace=true;
  } else {
    Reproduce(nextGenOrganisms.get(0), nextGenOrganisms.get(1));
    background(0);
    fill(200);
    textFont(title);
    textAlign(CENTER, TOP);
    text("ARTIST", 682, 5);
    rectMode(CENTER);
    imageMode(CENTER);
    rect(width/2, 3*height/4, 275, 275);
    currentOrganisms.get(0).displayOrganism(width/2, 3*height/4);
    generation=0;
    setUpGen0();
    rectMode(CORNER);
    imageMode(CORNER);
    reset=true;
    firstPlace=true;
  }  
  while (nextGenOrganisms.size()>0) {
    nextGenOrganisms.remove(0);
  }
}
void setUpGen0() {
  while (currentOrganisms.size()>0) {
    currentOrganisms.remove(0);
  }
  while (currentOrganisms.size()<5) {
    //Create starting organisms
    currentOrganisms.add(0, new Organism());
    currentOrganisms.get(0).prepDisplay();
  }
}
int createIntFrom(boolean[] strand) {//Convert the strand into an integer
  int eger = 0;
  for (int erator = 0; erator < strand.length; erator++) {//iterates over strand, if the gene is true, add 2^n to the returned int where n is the iterator value
    if (strand[erator]) {
      eger += (pow(2, erator));
    }
  }  
  return eger;
}
boolean[] mergeStrands(boolean[] strandA, boolean[] strandB) {//take two strands, return an array of two strands made by mixing their values
  if (strandA.length==strandB.length) {//check to make sure the strands are the same length
    boolean container;
    for (int gene=0; gene < strandA.length; gene++) {//iterate over the genes
      if (rand.nextInt(int(pow(2, strandA.length))) >= pow(2, gene)) {
        for (int jean = gene; jean < strandA.length; jean++) {
          container = strandA[jean];
          strandA[jean] = strandB[jean];
          strandB[jean] = container;
        }
      }
    }
  }
  boolean[] finalStrand = mutate(strandA);
  return finalStrand;//returns mutation of strandA, and if they are the same length, they'll have "merged."
}
boolean[] mutate(boolean[] strand) {//each gene has a 1 in 10 chance of inverting before returned
  for (int eger=0; eger<strand.length; eger++) {
    if (rand.nextInt(10) == 5) {
      strand[eger]=!(strand[eger]);
    }
  }
  return strand;
}
String[] parseDataFrom(boolean[] strand) {
  String rawStrand = "";
  for (int i = strand.length-1; i>=0; i--) {
    if (strand[i]) {
      rawStrand += "1";
    } else {
      rawStrand += "0";
    }
  }
  String[] dat = {rawStrand, Integer.toString(createIntFrom(strand))};
  return dat;
}
String getVarName(int arrID, int elemID) {
  String id = "d";
  if (arrID == 0) {
    if (elemID == 0) {
      id = "r";
    }
    if (elemID == 1) {
      id = "g";
    }
    if (elemID == 2) {
      id = "b";
    }
  } else {
    id = "c" + Integer.toString(arrID-1);
    if (elemID == 0) {
      id += "x";
    }
    if (elemID == 1) {
      id += "y";
    }
    if (elemID == 2) {
      id += "d";
    }
  }
  return id;
}
