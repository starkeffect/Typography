int maxParticles = 100; 
ArrayList <Particle> particles = new ArrayList <Particle> ();
PGraphics pg;

void setup() 
{
  // Setting up sketch
  size(800, 800);
  smooth(12);
  background(255);
  frameRate(18);
  
  // Creating the text mask
  pg = createGraphics(width, height);
  pg.beginDraw();
  pg.textSize(width/1.5);
  pg.textAlign(CENTER, CENTER);
  pg.fill(0);
  pg.text("B", pg.width/2, pg.height/2.2); // Change these values to align the text
  pg.endDraw();
}

void draw() 
{
  // Update the particle array
  addRemoveParticles();
  
  // Evolve and display particle
  for (Particle p : particles) 
  {
    p.update();
    p.display();
  }
  
  //saveFrame("frames/####.tif");
}

void addRemoveParticles() 
{
  // Removes particle with non-positive lives
  for (int i=particles.size()-1; i>=0; i--) 
  {
    Particle p = particles.get(i);
    if (p.life <= 0) 
    {
      particles.remove(i);
    }
  }
  
  // Add particles to reach the "maxParticles" limit
  while (particles.size () < maxParticles) 
  {
    particles.add(new Particle());
  }
}