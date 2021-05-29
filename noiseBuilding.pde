import processing.pdf.*;

Table t;

int sizel;
int sizef;

float[] posx = new float[5000];
float[] posy = new float[5000];
float[] posz = new float[5000];

float[] bx = new float[5000];
float[] by = new float[5000];
float[] bz = new float[5000];

int i;

float ti;

float rot = 40;

boolean recordPDF;

void setup() {
  size(1024, 1024, P3D);

  t = loadTable("points.csv", "header");
  println(t.getRowCount());

  for (TableRow tr : t.rows()) {
    noFill();
    i++;

    float x = tr.getFloat("x");
    float y = tr.getFloat("y");
    float z = tr.getFloat("z");

    posx[i] = x;
    posy[i] = y;
    posz[i] = z;

    bx[i] = x;
    by[i] = y;
    bz[i] = z;
  }

  smooth(8);
}

void draw() {

  background(240);

  if (recordPDF) {
    beginRaw(PDF, "pdf/p1.pdf" ); // If you include "####" in the filename -- "3D-####.pdf" -- separate, numbered PDFs will be made for each frame that is rendered.
  }

  ti += 0.01;

  sizel+=20;
  if (sizel >= t.getRowCount()) {
    sizel = t.getRowCount();
    sizef+=20;
    if (sizef >= t.getRowCount()) {
      sizef = t.getRowCount();
    }
  }

  translate(width/2, height/2-200, 400);
  rotateY(radians(rot));
  scale(8);
  strokeWeight(0.1);

  shearY(radians(map(mouseY, 0, height, -15, 15)));
  shearX(radians(map(mouseX, 0, width, -15, 15)));

  //float mx = mouseX-width/2;
  //float my = mouseY-height/2;

  beginShape(QUADS);
  for (int i = 0; i < sizel; i++) {
    noFill();
    stroke(10);

    //if (mousePressed) {
    //  if (dist(posx[i], posy[i], mx+cos(i*0.1)*10, my+sin(i*0.1)*10) < 150) {

    //    //posx[i] = mouseX;
    //    //posy[i] = mouseY;

    //    if (posx[i] - mx > 20) {
    //      posx[i] = posx[i]+noise(i*0.11)*20;
    //    } else {
    //      posx[i] = posx[i]-noise(i*0.22)*20;
    //    }

    //    if (posy[i] - my > 20) {
    //      posy[i] = posy[i]+noise(i*0.13)*20;
    //    } else {
    //      posy[i] = posy[i]-noise(i*0.17)*20;
    //    }
    //  } else {
    //    posx[i] = bx[i];
    //    posy[i] = by[i];
    //    posz[i] = bz[i];
    //  }
    //}

    vertex(posx[i], posy[i], posz[i]);
  }
  endShape();

  beginShape(QUADS);
  for (int i = 0; i < sizef; i++) {
    noStroke();
    fill(
      0+noise(posx[i]*0.1+ti)*255, 
      0+noise(posx[i]*0.2+ti)*255, 
      0+noise(posx[i]*0.3+ti)*255, 200
      );

    //if (mousePressed) {
    //  if (dist(posx[i], posy[i], mx+cos(i*0.1)*10, my+sin(i*0.1)*10) < 150) {

    //    //posx[i] = mouseX;
    //    //posy[i] = mouseY;

    //    if (posx[i] - my > 20) {
    //      posx[i] = posx[i]+noise(i*0.11)*20;
    //    } else {
    //      posx[i] = posx[i]-noise(i*0.22)*20;
    //    }

    //    if (posy[i] - my > 20) {
    //      posy[i] = posy[i]+noise(i*0.13)*20;
    //    } else {
    //      posy[i] = posy[i]-noise(i*0.17)*20;
    //    }
    //  } else {
    //    posx[i] = bx[i];
    //    posy[i] = by[i];
    //    posz[i] = bz[i];
    //  }
    //}

    vertex(posx[i], posy[i], posz[i]);
  }
  endShape();


  if (recordPDF) {
    endRaw();
    recordPDF = false;
  }

  //saveFrame("frame1/record_#####.png");
}

void mousePressed() {
  rot = random(0, 180);
  sizel = 0;
  sizef = 0;
}

void keyPressed() {

  if (key == 'r') {
    recordPDF = true;
  }
}
