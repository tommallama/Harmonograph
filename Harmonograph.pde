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
float secondsToRunSimulation = 1000;  

// Spacing between measurements in seconds must be less than secondsToRunSimulation
float deltaTime = .1;              

// Initial Amplitudes 
float A1 = 100; 
float A2 = 100; 
float A3 = 100; 
float A4 = 100;

// Frequencies in Hz
float f1 = 0.5;
float f2 = 0.2;
float f3 = 0.1;
float f4 = 0.4;

// Phase offsets in degrees
float p1 = 45;
float p2 = 45;
float p3 = 87;
float p4 = 90;

// Damping terms
float d1 = 0.0001;
float d2 = 0.0021;
float d3 = 0.0054;
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
  strokeWeight(1);
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
  
  // Plot points
    for(int i = 0; i<numberOfSamples-1 ; i++){      
      stroke(map(i,0,numberOfSamples,0,255),0,255-map(i,0,numberOfSamples,0,255));
      line(harmPoints[i].x,harmPoints[i].y,harmPoints[i+1].x,harmPoints[i+1].y);
  }
}

float convertToRadians(float deg){
  return deg*PI/180.0;
}

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
    float freqPlusPhaseRadians_1 = t*f1+convertToRadians(p1);
    float freqPlusPhaseRadians_2 = t*f2+convertToRadians(p2);
    float x = A1*sin(freqPlusPhaseRadians_1)*exp(-1*d1*t) +
              A2*sin(freqPlusPhaseRadians_2)*exp(-1*d2*t);
              
    // Map the reutrn value to the screen limits
    x = map(x,-xMax,xMax,0,width);
    return x; //<>//
}

float calculateHarmonographPoint_Y(float t){  
    //y(t)= A3*sin(t*f3+p3)*exp(-d3*t) + A4*sin(t*f4+p4)*exp(-d4*t)
    float freqPlusPhaseRadians_3 = t*f3+convertToRadians(p3);
    float freqPlusPhaseRadians_4 = t*f4+convertToRadians(p4);
    float y = A3*sin(freqPlusPhaseRadians_3)*exp(-1*d3*t) +
              A4*sin(freqPlusPhaseRadians_4)*exp(-1*d4*t);              
    y = map(y,-yMax,yMax,0,height);
    return y;
}
