import processing.serial.*;
Serial mySerial;
PrintWriter output;
void setup() {
   print("new");
   size(800, 600);   
   background(0);
   mySerial = new Serial( this, Serial.list()[0], 9600 );
   output = createWriter( "data.xml" );
   output.println( "New file" );
   
   println(Serial.list()[0]);
}
void draw() {
  fill(0);
  stroke(0, 0, 0);
  rect(0, 0, 2000, 50);
  
    if (mySerial.available() > 0 ) {
         String value = mySerial.readStringUntil('\n');
              println("serial" +  value);
         if ( value != null ) {
              println("val" +  value);
              output.print( value );
         }
    }
}

void keyPressed() {
    output.flush();  // Writes the remaining data to the file
    output.close();  // Finishes the file
    exit();  // Stops the program
}
