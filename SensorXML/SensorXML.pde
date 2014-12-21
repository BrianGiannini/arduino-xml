import processing.serial.*;
Serial mySerial;
PrintWriter output;
void setup() {
   print("new");
   
   mySerial = new Serial( this, Serial.list()[0], 9600 );
   output = createWriter( "data.txt" );
   output.println( "New file" );
   
   println(Serial.list()[0]);
}
void draw() {
    if (mySerial.available() > 0 ) {
         String value = mySerial.readString();
                    println("tttttt" +  value);
         if ( value != null ) {
                    println("val" +  value);
              output.println( value );
         }
    }
}

void keyPressed() {
    output.flush();  // Writes the remaining data to the file
    output.close();  // Finishes the file
    exit();  // Stops the program
}
