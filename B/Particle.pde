class Particle 
{
  PVector loc;
  float maxLife, life, lifeRate;
  float seedX, seedY;
  float alpha;
  float r, maxOff;

  Particle() 
  {
    getPosition();
    maxLife = random(1, 1.5);
    life = maxLife;
    lifeRate = random(maxLife/128, maxLife/32);
    seedX = random(50);
    seedY = random(50);
    alpha = 150;
    maxOff = 30;
  }

  void update() 
  {
    loc.add(new PVector(map(noise(seedX), 0, 1, -maxLife, maxLife), map(noise(seedY), 0, 1, -maxLife, maxLife)));
    r = random(8,12) * life/maxLife;
    seedX += 0.05;
    seedY += 0.05;
    life -= lifeRate;
    alpha -= 2;
  }

  void display() 
  {
    pushStyle();
    noStroke();
    if(random(1) < 0.5) 
    { 
      stroke(0, alpha);
      fill(0, alpha);
    }
    else 
    {
      stroke(255, alpha);
      fill(255, 50);
    }
    ellipse(loc.x, loc.y, r, r);
    popStyle();
    
    pushStyle();
    strokeWeight(1);
    point(loc.x + random(-maxOff, maxOff), loc.y +random(-maxOff, maxOff));
    popStyle();
  }

  // Get a random position inside the text
  void getPosition() 
  {
     do
     {
       loc = new PVector(random(width), random(height));
     } while(isInText(loc) == false); //find a particle location till it's inside the text
  }

  // Check if a given position is inside text
  boolean isInText(PVector v) 
  {
    return pg.get(int(v.x), int(v.y)) == color(0);
  }
}