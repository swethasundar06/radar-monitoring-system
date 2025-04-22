import processing.serial.*;  // Library for Serial communication
import java.awt.event.KeyEvent;
import java.io.IOException;

Serial myPort; // Serial port object
String angle = "";
String distance = "";
String data = "";
int iAngle = 0, iDistance = 0;
int index1 = 0;
PFont orcFont;

void setup() {
  size(1200, 700);  // Set window size
  smooth();
  
  // Open the serial port (update COM port as needed)
  myPort = new Serial(this, "COM5", 9600);
  myPort.bufferUntil('.'); // Wait for '.' to indicate end of data
}

void draw() {
  fill(98, 245, 31);
  noStroke();
  fill(0, 4); 
  rect(0, 0, width, height - height * 0.065);
  
  fill(98, 245, 31); // Green color
  drawRadar();
  drawLine();
  drawObject();
  drawText();
}

// Handles incoming serial data
void serialEvent(Serial myPort) {
  data = myPort.readStringUntil('.');
  
  if (data != null) {
    data = trim(data); // Remove extra spaces or newlines
    println("Received: " + data);  // Debugging output
    
    if (data.contains(",")) {
      index1 = data.indexOf(",");
      angle = data.substring(0, index1);
      distance = data.substring(index1 + 1);

      try {
        iAngle = int(angle);
        iDistance = int(distance);
      } catch (Exception e) {
        println("Error parsing data: " + data);
      }
    }
  }
}

// Draws the radar grid
void drawRadar() {
  pushMatrix();
  translate(width / 2, height - height * 0.074);
  noFill();
  strokeWeight(2);
  stroke(98, 245, 31);

  arc(0, 0, width * 0.9375, width * 0.9375, PI, TWO_PI);
  arc(0, 0, width * 0.73, width * 0.73, PI, TWO_PI);
  arc(0, 0, width * 0.521, width * 0.521, PI, TWO_PI);
  arc(0, 0, width * 0.313, width * 0.313, PI, TWO_PI);

  line(-width / 2, 0, width / 2, 0);
  for (int a = 30; a <= 150; a += 30) {
    line(0, 0, (-width / 2) * cos(radians(a)), (-width / 2) * sin(radians(a)));
  }
  popMatrix();
}

// Draws the detected object
void drawObject() {
  pushMatrix();
  translate(width / 2, height - height * 0.074);
  strokeWeight(9);
  stroke(255, 10, 10); // Red color
  float pixsDistance = iDistance * ((height - height * 0.1666) * 0.025);

  if (iDistance < 40) {
    line(pixsDistance * cos(radians(iAngle)), -pixsDistance * sin(radians(iAngle)),
         (width - width * 0.505) * cos(radians(iAngle)), -(width - width * 0.505) * sin(radians(iAngle)));
  }
  popMatrix();
}

// Draws the scanning line
void drawLine() {
  pushMatrix();
  strokeWeight(9);
  stroke(30, 250, 60);
  translate(width / 2, height - height * 0.074);
  line(0, 0, (height - height * 0.12) * cos(radians(iAngle)), -(height - height * 0.12) * sin(radians(iAngle)));
  popMatrix();
}

// Draws the text labels
void drawText() {
  pushMatrix();
  
  fill(0);
  noStroke();
  rect(0, height - height * 0.0648, width, height);
  fill(98, 245, 31);
  textSize(25);
  
  text("10cm", width * 0.6146, height * 0.9167);
  text("20cm", width * 0.719, height * 0.9167);
  text("30cm", width * 0.823, height * 0.9167);
  text("40cm", width * 0.9271, height * 0.9167);
  textSize(40);
  text("Radar Scanner", width * 0.125, height * 0.9723);
  text("Angle: " + iAngle + "°", width * 0.52, height * 0.9723);
  text("Distance: " + (iDistance < 40 ? iDistance + " cm" : "Out of Range"), width * 0.74, height * 0.9723);

  popMatrix();
}
