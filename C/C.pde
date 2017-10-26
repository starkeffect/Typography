float minRad, maxRad, spacing;
float[] r, ang;
int numRings, n;
boolean[] loop;
float r_;


void setup()
{
  // Setting up sketch
  size(800, 800);
  background(255);
  smooth(12);
  frameRate(40);
  
  // Setting up drawing parameters
  minRad = width/3;
  spacing = 40;
  numRings = 6;
  n = 1;
  maxRad = minRad + (numRings * spacing);
  
  // Arrays to hold evolution paramenters for the rings
  r = new float[numRings];
  ang = new float[numRings];
  loop = new boolean[numRings];
  
  // Initializing evolution parameters
  for(int i=0; i<numRings; i++)
  {
    r[i] = minRad + (i * spacing);
    ang[i] = 0.0;
    loop[i] = true;
  }
  
  // Setting up sketch style
  stroke(0);
  noFill();
}

void draw()
{
  // background(255);
  // Smoother transition between frames
  pushStyle();
  noStroke();
  fill(255, 30);
  rect(0, 0, width, height);
  popStyle();
  
  // Evolving and drawing constituent rings for each frame
  for(int i=0; i<numRings; i++)
  {
    println(n);
    if(ang[i] <= 2 * n * PI && loop[i] == true)
    {
      // Setting up an oscillating stroke weight based on frame count and ring position
      strokeWeight(2 * (1 + (sin(frameCount * 0.05) * map(r[i], minRad, maxRad, 0.4, 0.6))));
      // Evolving the angle based on ring position
      ang[i] += 0.05 * map(r[i], minRad, maxRad, 1, 0.5);
      // Perturbing the ring radius
      if(i < numRings - 1) 
      {
        r_ = r[i] + random(-spacing, spacing);
      }
      else r_ = r[i];
      
      // Drawing the rings
      pushMatrix();
      translate(width/2, height/2);
      rotate(ang[i]);
      arc(0, 0, r_, r_, PI/2 - PI/8, 3 * PI/2 + PI/8);
      if(i < numRings - 1) ellipse(r[i]/2 + spacing * 1.2 * sin(ang[i] ), 0, 2, 2);
      popMatrix();
    }
    else
    {
      arc(width/2, height/2, r[i], r[i], PI/2 - PI/8, 3 * PI/2 + PI/8);
      // If finished one rotation, stop looping the ring
      loop[i] = false;
      // When all rings have finished one revolution, start looping again
      if(i == numRings - 1)
      {
        // Adding a small delay at the end of each rotation
        delay(200);
        // n keeps track of the number of rotations from start time
        n++;
        // Setting the looping paramater for each ring to true.
        for(int j=0; j<numRings; j++)
        {
          loop[j] = true;
        }
      }     
    }
  }
  
  //saveFrame("frames/####.tif");
}