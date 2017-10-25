PGraphics pg;
int nHor, nVer;
float gridSpacingHor, gridSpacingVer;
float r, r_;

void setup() 
{
  // Setting up sketch
  size(800, 800);
  frameRate(40);
  background(255);
  
  // Creating the alphabet mask
  pg = createGraphics(width, height);
  pg.beginDraw();
  pg.textSize(width/2);
  pg.textAlign(CENTER, CENTER);
  pg.fill(0);
  pg.text("A", pg.width/2, pg.height/2); // Change these values to align the text
  pg.endDraw();
  
  // Setting up the 2D grid (can be asymmetric)
  nHor = 90;
  nVer = 90;
  gridSpacingHor = float(width) / nHor;
  gridSpacingVer = float(height) / nVer;
  r = min(gridSpacingHor, gridSpacingVer);
  r_ = 0;
  
  // Gloabal sketch style
  strokeWeight(0.5);
  stroke(0);
}

void draw() 
{
  // Reset the background with each frame (not good for smooth transitions)
  // background(255);
  
  // Use this for smooth transitions
  pushStyle();
  fill(255, 30);
  noStroke();
  rect(0, 0, width, height);
  popStyle();

  // Draw shapes to the screen
  for (int y=0; y<nVer; y++) 
  {
    for (int x=0; x<nHor; x++) 
    {
      float e_x = x * gridSpacingHor;
      float e_y = y * gridSpacingVer;
      // Get PGraphics color at this coordinate
      color c = pg.get(int(e_x), int(e_y));
      // Check if the point is inside the letter or outside
      boolean textDrawn = (c == color(0));
      
      if(textDrawn == true)
      {
          fill(0, 200);
          r_ = r/2 * cos(frameCount * 0.01);
          pushMatrix();
          translate(e_x, e_y);
          rotate(random(2*PI));
          if(random(1) < 0.3) ellipse(30 * sin(frameCount * 0.01), random(-10,10), r_ * 1.4, r_ * 1.4);
          translate(0, 100 * sin(frameCount * 0.01));
          noFill();
          line(0, 0, 50 * sin(frameCount * 0.01), 0);
          rect(50 * sin(frameCount * 0.01), 0, r_ * 1 * sin(frameCount * 0.01) , r_ * 4 * sin(frameCount * 0.01));
          popMatrix();
      }
    }
  }
  //saveFrame("frames/####.tif");
}