/**

(
SynthDef("Xaraktiki",
{ arg  amp = 0.5, pan = 0, out = 0;
    var source;
    var panned_source;
    source = HPF.ar(BrownNoise.ar(amp, 0), MouseX.kr(1000,8000));
    panned_source = Pan2.ar(source, MouseX.kr(-0.9, 0.9));
    Out.ar( out, panned_source);
            }
       ).send(s);
)
 
// Roteador OSC
p = NetAddr("127.0.0.1", 12000);  // send to Processing
z = Synth("Xaraktiki");
OSCresponder(nil, "amp", { | time, resp, message |
        z.set("amp", message[1]);
}).add;
 
 
*/
import processing.opengl.*;
//import oscP5.*; 
//import netP5.*;
 
//OscP5 oscP5;
//NetAddress myRemoteLocation;
 
boolean miden, smoothFade;
boolean xar=true;
 
// Som Variáveis de entrada
float amp1, freq1, amp2, freq2, ampout, freqout;
float ElegxosAmp;
 
SketchLine  line0, line1, line2;
float x1, y1, x2, y2;
PImage cur;
 
int stoixeia = 30, lineAlpha = 50;
 
// Variáveis Física
        float[] x = new float[stoixeia];
        float[] y = new float[stoixeia];
        float[] epitaxinsiX = new float[stoixeia];
        float[] epitaxinsiY = new float[stoixeia];
        float[] elastikotita = new float[stoixeia];
        float[] aposbesi = new float[stoixeia];
        float[] deltaX = new float[stoixeia];
        float[] deltaY = new float[stoixeia];
        float fxMouse, fyMouse;
 
// Variáveis de Cor
        int colorL=255,strokeL, strokeValue = 20, strokeBackground = 5;
        int paintCount = 0, alphaSform;
        int r0,g0,b0,r1,g1,b1;
 
void setup()  {
        frameRate(240);
        size(displayWidth,displayHeight);
 
        line0 = new SketchLine(30);
        line1 = new SketchLine(stoixeia);
        line2 = new SketchLine(stoixeia + 1);
 
        line0.calcType( 0.2, 0.65 );  // 0.2, 0.65 writeLine
        line1.calcType( 0.1, 0.65 );  // 0.2, 0.65 writeLine
        line2.calcType( 0.3, 0.65 );  // 0.2, 0.65 writeLine
 
background(0);
  noFill();
  smooth();

  for (int i=0; i<stoixeia; i++){
    elastikotita[i] = 0.2*(.07*(i+1)); // 0.05  kai 0.005
    aposbesi[i] = 0.55-(0.02*i);
  }
}
 
void draw()  {
  myLine();
  noFill();
  
  if (mousePressed == true)  { 
      line0.calcPoints(mouseX, mouseY);
      line0.render(255,0,0, lineAlpha);
      line1.calcPoints(mouseX, mouseY);
      line1.render(255,255,0, lineAlpha);
      line2.calcPoints(mouseX, mouseY);
      line2.render(255,255,255, lineAlpha);
  } else 
  
  {
      line0.calcPoints(mouseX, mouseY);
      line0.render(255,0,0, 0);
      line1.calcPoints(mouseX, mouseY);
      line1.render(255,255,0, 0);
      line2.calcPoints(mouseX, mouseY);
      line2.render(255,255,255, 0);
   
  }
  
  if (smoothFade) {
    fill(0,12);
    rect(-10,-10,width,height);
  }
}
 
void myLine(){
 
  if (mousePressed == true)  { 
    if(miden == true) {
      for (int i=0; i<stoixeia; i++){
        x[i] = mouseX;// move worm
        y[i] = mouseY;
        miden = false;
      }
      
      //cursor(cur, 0,0);
    }
    
    strokeL = strokeValue;
  }
 
  noFill();
  drawline();
 
}
 
 
void drawline(){
    fxMouse = mouseX;
    fyMouse = mouseY;
 // beginShape();
    for (int i=0; i<5; i++){
    if (i==0){
      deltaX[i] = (fxMouse - x[i]);
      deltaY[i] = (fyMouse - y[i]);
      if (mousePressed && xar)  {
           
      }
  
       
    }
    else {
      deltaX[i] = (x[i-1]-x[i]);
      deltaY[i] = (y[i-1]-y[i]);
    }
      deltaX[i] *= elastikotita[i];      // Cria efeito elastikotita
      deltaY[i] *= elastikotita[i];
      epitaxinsiX[i] += deltaX[i];
      epitaxinsiY[i] += deltaY[i];
      x[i] += epitaxinsiX[i];           // Move it
      y[i] += epitaxinsiY[i];
      vertex(x[i],y[i]);
      epitaxinsiX[i] *= aposbesi[i];   // Desacelera elastikotita
    epitaxinsiY[i] *= aposbesi[i];
  }
  endShape();
}
 
 
 
void mouseReleased()  {
  if(xar)  {
   // OscMessage silence = new OscMessage("amp"); 
   // silence.add(0);
   // oscP5.send(silence, myRemoteLocation);     
  }
 
  line0.calcPointsStart(mouseX, mouseY);
}
 
void mousePressed()  {
      line0.calcPointsStart(mouseX, mouseY);
      line1.calcPointsStart(mouseX, mouseY);
      line2.calcPointsStart(mouseX, mouseY); 
}
 
 
void mouseDragged() {
}
 
 
void keyPressed(){
  if (key == 'z') {
    //cursor(cur, 0, 0);
  }
  if (key == 'b') {
    background(0);
  } 
  if (key == 's') {
    smoothFade = !smoothFade;
  } 
 
}
 
 
class  SketchLine  {
      int stoixeia = 1000, colorR, colorG, colorB, lineAlpha = 25;
      float elast, aposv;
      float[] x = new float[stoixeia];
      float[] y = new float[stoixeia];
      float[] epitaxinsiX = new float[stoixeia];
      float[] epitaxinsiY = new float[stoixeia];
      float[] elastikotita = new float[stoixeia];
      float[] aposvesi = new float[stoixeia];
      float[] deltaX = new float[stoixeia];
      float[] deltaY = new float[stoixeia];
      float pointX, pointY;
 
  SketchLine(int stoixeiaVar)  {
    stoixeia = stoixeiaVar;
  }
 
  void calcType(float elastikotitaVar, float aposvesiVar)  {
    elast = elastikotitaVar;
    aposv = aposvesiVar;
    for (int i=0; i < stoixeia; i++){
      elastikotita[i] = elast*(.07*(i+1));       // 0.05  kai 0.005
      aposvesi[i] = aposv-(0.02*i);
    }
  }
 
  void calcPoints(float pointXVar, float pointYVar)  {
    pointX = pointXVar;
    pointY = pointYVar;
 
    for (int i=0; i<stoixeia; i++){
      if (i==0){
        deltaX[i] = (pointX - x[i]);
        deltaY[i] = (pointY - y[i]);

      } 
      else  {
        deltaX[i] = (x[i-1]-x[i]);
        deltaY[i] = (y[i-1]-y[i]);
      }
      deltaX[i] *= elastikotita[i];    // Criar efeito elastikotita
      deltaY[i] *= elastikotita[i];
      epitaxinsiX[i] += deltaX[i];
      epitaxinsiY[i] += deltaY[i];
      x[i] += epitaxinsiX[i];// move it
      y[i] += epitaxinsiY[i];
      epitaxinsiX[i] *= aposvesi[i];    // Desacelerar elastikotita
      epitaxinsiY[i] *= aposvesi[i];
    }
  }
  void calcPointsStart(float pointXVar, float pointYVar)  {
    pointX = pointXVar;
    pointY = pointYVar;
    for (int i=0; i<stoixeia; i++){
      x[i] = mouseX;
      y[i] = mouseY;
    }
  }
 
 
  void render(int colorRVar, int colorGVar, int colorBVar, int lineAlphaVar)  {
    colorR = colorRVar;
    colorG = colorGVar;
    colorB = colorBVar;   
    lineAlpha = lineAlphaVar;   
    noFill();
    stroke(colorR, colorG, colorB, lineAlpha);
    beginShape();
    for (int i = 0; i < stoixeia; i++)  {
      curveVertex(x[i], y[i]);
    }
    endShape();
  }
 
}

boolean sketchFullScreen (){
  return true;
}
