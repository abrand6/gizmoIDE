import processing.serial.*;
import processing.sound.*;

int[][] rx;
int[][] gx;
int[][] bx;

SinOsc[] sineWaves; // Array of sines
float[] sineFreq; // Array of frequencies
int numSines = 10;


ArrayList mouse = new ArrayList();
float dist = 100;
float color1 = random(200, 255);
float color2 = random(200, 255);
float color3 = random(200, 255);

// The serial port:
Serial myPort;


int rect_size = 150;

int x = 0;
int y = 0;


void setup() 
{
  
  size(1000, 1000);
  background(255); //white background
  smooth();
  rectMode(CORNER);
  stroke(0,200);
  strokeWeight(1);
  //noFill();
  
  String portName = Serial.list()[0];
  myPort = new Serial(this, portName, 9600);

  rx = new int[4][5];
  gx = new int[4][5];
  bx = new int[4][5];

  sineWaves = new SinOsc[numSines]; // Initialize the oscillators
  sineFreq = new float[numSines]; // Initialize array for Frequencies

  for (int i = 0; i < numSines; i++) {
    // Calculate the amplitude for each oscillator
    float sineVolume = (1.0 / numSines) / (i + 1);
    // Create the oscillators
    sineWaves[i] = new SinOsc(this);
    // Start Oscillators
    sineWaves[i].play();
    // Set the amplitudes for all oscillators
    sineWaves[i].amp(sineVolume);
  }
  
  // set the inicial colors of the matrix
  //for (int i=0; i<4; i++)
  //{
  //  for (int j=0; j<5; j++)
  //  {
  //    rx[i][j]=(i+j)*20;
  //    gx[i][j]=(i+j);
  //    bx[i][j]=(i)*20;
  //  }
  //}

}

void draw() {

  //Map mouseY from 0 to 1
  float yoffset = map(mouseY, 0, height, 0, 1);
  //Map mouseY logarithmically to 150 - 1150 to create a base frequency range
  float frequency = pow(1000, yoffset) + 150;
  //Use mouseX mapped from -0.5 to 0.5 as a detune argument
  float detune = map(mouseX, 0, width, -0.5, 0.5);

  for (int i = 0; i < numSines; i++) { 
    sineFreq[i] = frequency * (i + 1 * detune);
    // Set the frequencies for all oscillators
    sineWaves[i].freq(sineFreq[i]);
  }
  
  color col = color(color1,color2,color3);
  float color1_change = random(-5,5);
  float color2_change = random(-5,5);
  float color3_change = random(-5,5);
  
    color1 += color1_change;
    color2 += color2_change;
    color3 += color3_change;
    
    fill(col, 96);
    stroke(col, 96);


    float radius = (mouseY*mouseX);

line(mouseX, mouseY, 0, 0);
line(mouseX, mouseY, width, height);
 
PVector d = new PVector(mouseX, mouseY, 0);
  mouse.add(0, d);
 
  for (int p=0; p<mouse.size (); p++) {
    PVector v = (PVector) mouse.get(p);
    float join = p/mouse.size() + d.dist(v)/dist;
    if (join < random(2) && mouseButton == LEFT) { 
 
      line(d.x, d.y, v.x, v.y);
    }
   
  }
  
  for (int i=0; i<4; i++)
  {
    for (int j=0; j<5; j++)
    {
      // draw colored rectangles
      x = j*(750)/5;
      y = i*(600)/4;
      //fill(rx[i][j], gx[i][j], bx[i][j], 255);
      //rect(x, y, rect_size, rect_size);
      // send color values to serial port
      myPort.write((i) + "," + (j) + "," + rx[i][j] + "," + gx[i][j] + "," + bx[i][j] + "\n");
      // send color values to Processing console
      println((i) + "," + (j) + "," + rx[i][j] + "," + gx[i][j] + "," + bx[i][j] + "\n");
    }
  }
  



  
  // LINHA 0
  if ((mouseX <= 150) && (mouseY <= 150)) {
    reset_colors();
    rx[0][0]=0;
    gx[0][0]=255;
    bx[0][0]=0;
  } else if ((mouseX <= 300) && (mouseY <= 150)) {
    reset_colors();
    rx[0][1]=0;
    gx[0][1]=255;
    bx[0][1]=0;
  } else if ((mouseX <= 450) && (mouseY <= 150)) {
    reset_colors();
    rx[0][2]=0;
    gx[0][2]=255;
    bx[0][2]=0;
  } else if ((mouseX <= 600) && (mouseY <= 150)) {
    reset_colors();
    rx[0][3]=0;
    gx[0][3]=255;
    bx[0][3]=0;
  } else { //if ((mouseX <= 750) && (mouseY <= 150))   {
    reset_colors();
    rx[0][4]=0;
    gx[0][4]=255;
    bx[0][4]=0;
  }


  // line 1
  if ((mouseX <= 150) && (mouseY <= 300) && (mouseY >= 150)) {
    reset_colors();
    rx[1][0]=0;
    gx[1][0]=255;
    bx[1][0]=0;
  } else if ((mouseX <= 300) && (mouseY <= 300) && (mouseY >= 150)) {
    reset_colors();
    rx[1][1]=0;
    gx[1][1]=255;
    bx[1][1]=0;
  } else if ((mouseX <= 450) && (mouseY <= 300) && (mouseY >= 150)) {
    reset_colors();
    rx[1][2]=0;
    gx[1][2]=255;
    bx[1][2]=0;
  } else if ((mouseX <= 600) && (mouseY <= 300) && (mouseY >= 150)) {
    reset_colors();
    rx[1][3]=0;
    gx[1][3]=255;
    bx[1][3]=0;
  } else if ((mouseX <= 750) && (mouseY <= 300) && (mouseY >= 150)) {
    reset_colors();
    rx[1][4]=0;
    gx[1][4]=255;
    bx[1][4]=0;
  }


  // line 2
  else if ((mouseX <= 150) && (mouseY <= 450) && (mouseY >= 300)) {
    reset_colors();
    rx[2][0]=0;
    gx[2][0]=255;
    bx[2][0]=0;
  } else if ((mouseX <= 300) && (mouseY <= 450) && (mouseY >= 300)) {
    reset_colors();
    rx[2][1]=0;
    gx[2][1]=255;
    bx[2][1]=0;
  } else if ((mouseX <= 450) && (mouseY <= 450) && (mouseY >= 300)) {
    reset_colors();
    rx[2][2]=0;
    gx[2][2]=255;
    bx[2][2]=0;
  } else if ((mouseX <= 600) && (mouseY <= 450) && (mouseY >= 300)) {
    reset_colors();
    rx[2][3]=0;
    gx[2][3]=255;
    bx[2][3]=0;
  } else if ((mouseX <= 750) && (mouseY <= 450) && (mouseY >= 300)) {
    reset_colors();
    rx[2][4]=0;
    gx[2][4]=255;
    bx[2][4]=0;
  }


  // line 3
  else if ((mouseX <= 150) && (mouseY <= 600) && (mouseY >= 450)) {
    reset_colors();
    rx[3][0]=0;
    gx[3][0]=255;
    bx[3][0]=0;
  } else if ((mouseX <= 300) && (mouseY <= 600) && (mouseY >= 450)) {
    reset_colors();
    rx[3][1]=0;
    gx[3][1]=255;
    bx[3][1]=0;
  } else if ((mouseX <= 450) && (mouseY <= 600) && (mouseY >= 450)) {
    reset_colors();
    rx[3][2]=0;
    gx[3][2]=255;
    bx[3][2]=0;
  } else if ((mouseX <= 600) && (mouseY <= 600) && (mouseY >= 450)) {
    reset_colors();
    rx[3][3]=0;
    gx[3][3]=255;
    bx[3][3]=0;
  } else if  ((mouseX <= 750) && (mouseY <= 600) && (mouseY >= 450)) {
    reset_colors();
    rx[3][4]=0;
    gx[3][4]=255;
    bx[3][4]=0;
  }
}

void reset_colors()
{
  for (int i=0; i<4; i++)
  {
    for (int j=0; j<5; j++)
    {
      rx[i][j]=(i+j)*20;
      gx[i][j]=(i+j);
      bx[i][j]=(i)*20;
    }
  }
}

void mouseClicked(){ //add real button here
    saveFrame(); 
}

void keyPressed() {
  background(random(255), random(150), random(255));
}