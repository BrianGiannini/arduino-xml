import processing.serial.*;

Serial myPort; // The serial port
int xPos = 1; // horizontal position of the graph
float maxTemp = 0;
float minTemp = 1000;
float celciusTemp = 0;
float fahrenheitTemp = 0;
PrintWriter output;
XML xml;
XML tempChild;
XML valueC;
XML valueF;
int i;

void setup () {
  
  xml = new XML("Data");
  
// create file to store data 
// output = createWriter( "data.xml" );   

   
// set the window size:
size(800, 600);


// List all the available serial ports
println(Serial.list());
myPort = new Serial(this, Serial.list()[0], 9600);
// don't generate a serialEvent() unless you get a newline character:
myPort.bufferUntil('\n');
// set inital background:
background(0);

println(Serial.list()[0]);
}
void draw () {
 
}

void serialEvent (Serial myPort) {
  fill(0);
  stroke(0, 0, 0);
  rect(0, 0, 2000, 50);
  // get the ASCII string:
  String inString = myPort.readStringUntil('\n');
  celciusTemp = Float.parseFloat(inString);
  fahrenheitTemp = celciusTemp*1.8+32;
  
  // Write temperature value
  //output.println(celciusTemp);
   
  // add temp to XML
  i= i+1;  
  tempChild = xml.addChild("temperature");
  tempChild.setInt("id", i);
  
  valueC = tempChild.addChild("valc");
  valueC.setContent(String.valueOf(celciusTemp)); 
  valueC.setString("unit", "celcius");
  
  valueF = tempChild.addChild("valf");
  valueF.setContent(String.valueOf(fahrenheitTemp)); 
  valueF.setString("unit", "fahrenheit");
  
  saveXML(xml, "temperatures.xml");     
  
   
  
  if (celciusTemp > maxTemp){
    maxTemp = celciusTemp;
  }
  
  if (celciusTemp < minTemp){
    minTemp = celciusTemp;
  }
  
  if (inString != null) {
    // trim off any whitespace:
    inString = trim(inString);
    // convert to an int and map to the screen height:
    float inByte = float(inString) * 25;
    inByte = map(inByte, 400, 1023, 0, height);
    
    // draw the line:
    stroke(0, 200, 255);
    fill(255);
    line(xPos, height, xPos, height - inByte);
    textSize(48);
    fill(255, 255, 255);
    text(inString, 10, 50);
    textSize(32);
    fill(255, 0, 0);
    text("Min: " + minTemp +"°C", 180, 40);
    fill(0, 0, 255);
    text("  Max: " + maxTemp +"°C", 390, 40);
    
    
    // at the edge of the screen, go back to the beginning:
    if (xPos >= width) {
      xPos = 0;
      background(0);
    }
    else {
      // increment the horizontal position:
      xPos++;
    }
  }
}

void keyPressed() {
    output.flush();  // Writes the remaining data to the file
    output.close();  // Finishes the file
    saveXML(xml, "temperatures.xml");
    exit();  // Stops the program
}
