/*****************************************************************
Copyright 2018 https://github.com/tommallama

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the "Software"),
to deal in the Software without restriction, including without limitation
the rights to use, copy, modify, merge, publish, distribute, sublicense,
and/or sell copies of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
IN THE SOFTWARE.
******************************************************************/

/*****************************************************************
  Equations of motion:
    x(t)= A1*sin(t*f1+p1)*exp(-d1*t) + A2*sin(t*f2+p2)*exp(-d2*t)
    y(t)= A3*sin(t*f3+p3)*exp(-d3*t) + A4*sin(t*f4+p4)*exp(-d4*t)
  For more details see:
    https://en.wikipedia.org/wiki/Harmonograph
******************************************************************/

/*****************************************************************
  Start of user editable parameters
******************************************************************/

// How many seconds to calculate
float secondsToRunSimulation = 2000;  

// Spacing between measurements in seconds must be less than secondsToRunSimulation
float deltaTime = .05;              

// Initial Amplitudes
// These are scaled so the ratio to each other is all that matters in size
float A1 = 500; 
float A2 = 500; 
float A3 = 200; 
float A4 = 500;

// Frequencies
float f1 = 0.5;
float f2 = 0.2;
float f3 = 0.1;
float f4 = 0.4;

// Phase offsets in radians
float p1 = PI/2;
float p2 = PI/2;
float p3 = PI;
float p4 = PI/8;

// Damping terms. Keep these small to keep the oscillations alive.
float d1 = 0.0001;
float d2 = 0.0021;
float d3 = 0.4;
float d4 = 0.0001;

/*****************************************************************
  End of user editable parameters
******************************************************************/

int numberOfSamples = int(secondsToRunSimulation/deltaTime);  
HarmPoint[] harmPoints = new HarmPoint[numberOfSamples];
float xMax = A1+A2;
float yMax = A3+A4;


void setup() {
  size(1000, 1000);  
  strokeWeight(1.2);
  background(0);
  noLoop();  // Run once and stop
}

void draw() {
  // Populate points
  for(int i = 0; i<numberOfSamples ; i++){
    float t = i*deltaTime;
    float x = calculateHarmonographPoint_X(t);
    float y = calculateHarmonographPoint_Y(t);
    harmPoints[i] = new HarmPoint(x,y);
  }
      
    for(int i = 0; i<numberOfSamples-1 ; i++){      
      // Line colors defined here
      stroke(
        map(i,0,numberOfSamples,0,255),    // Red Value    0-255
        0,                                 // Green Value  0-255
        255-map(i,0,numberOfSamples,0,255) // Blue Value   0-255
        );
      // Draw lines
      line(harmPoints[i].x,harmPoints[i].y,harmPoints[i+1].x,harmPoints[i+1].y);
  }
}

// Harmonograph point class. 
// May add some additional parameters in here
class HarmPoint {
  float x;
  float y;
  HarmPoint(float x_, float y_) {
    x = x_;
    y = y_;
  }
}

float calculateHarmonographPoint_X(float t){  
    //x(t)= A1*sin(t*f1+p1)*exp(-d1*t) + A2*sin(t*f2+p2)*exp(-d2*t)
    float x = A1*sin(t*f1+p1)*exp(-1*d1*t) +
              A2*sin(t*f2+p2)*exp(-1*d2*t);
              
    // Map the return value to the screen limits
    x = map(x,-xMax,xMax,0,width);
    return x; //<>//
}

float calculateHarmonographPoint_Y(float t){  
    //y(t)= A3*sin(t*f3+p3)*exp(-d3*t) + A4*sin(t*f4+p4)*exp(-d4*t)
    float y = A3*sin(t*f3+p3)*exp(-1*d3*t) +
              A4*sin(t*f4+p4)*exp(-1*d4*t);   
              
    // Map the return value to the screen limits
    y = map(y,-yMax,yMax,0,height);
    return y;
}
