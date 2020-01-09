##############
## Script listens to serial port and writes contents into a file
##############
## requires pySerial to be installed 
## pip3 install pyserial
from serial import Serial
import datetime
import time

serial_port = '/dev/ttyACM1' #'COM7' # /dev/cu.usbmodem1411'  #'/dev/cu.usbmodem1421'; #/dev/ttyACM0';
baud_rate = 9600; #In arduino, Serial.begin(baud_rate)
#write_to_file_path = "output_" + str(datetime.datetime.now() ) + ".txt";
write_to_file_path = "output_" + str( int(time.time()) ) + ".txt";


output_file = open(write_to_file_path, "w+", buffering=1);
ser = Serial(serial_port, baud_rate)
while True:
    line = ser.readline();
    line = line.decode("utf-8") #ser.readline returns a binary, convert to string
    now = datetime.datetime.now()
    print(str(now) + "    " + line);
    output_file.write( line );   #str(now)+line);
