//A strand is an array of 8 boolean values, and is used as the "DNA" of this genetic algorithm.
void setup() {//Called automatically by Processing, set up
  size(1366, 768);//set the window size to a 720p layout
  noStroke();
  title = loadFont("TitleFont.vlw");
  subtitle = loadFont("SubtitleFont.vlw");
  body = loadFont("BodyFont.vlw");
  setUpGen0();
}
void draw() {//called automatically and repeatedly by Processing
  if (reset) {
    reset=false;
    delay(7500);
  } else {
    background(127);
    textAlign(CENTER, TOP);
    fill(0);
    textFont(title);
    text("ARTIST", 682, 5);
    fill(38);
    textFont(body);
    textAlign(CENTER, BOTTOM);
    if (firstPlace) {
      text("Press the button corresponding in color to your favorite image.", 682, height);
    } else {
      text("Now press the button corresponding in color to your second-favorite image.", 682, height);
    }
    textFont(subtitle);
    textAlign(LEFT, TOP);  
    text("A\nR\nT\nI\nS\nT", 602, 155);
    text("lgorithmic\neal-time\nailored\nmage-based\nelective\nechnology", 630, 155);
    drawCurrentOrganisms();
  }
}
