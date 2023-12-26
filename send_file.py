import serial
import serial.tools.list_ports
from xmodem import XMODEM
import io
import time
import logging 
import sys
from pathlib import Path 

#logging.basicConfig(filename='serial.log', level=logging.DEBUG)

# Protocol bytes
ESC = 27

UPLOAD = 'upload'

class Command:
    commandQueue = []

    serialPort = None
    command = None
    file_path = None
    overwrite = None

    def upload_file(self):
        if (self.file_path):
            fileName = Path(self.file_path).stem + ".txt"
            if (self.overwrite):
                self.queue_command("xdel " + fileName)          

            self.queue_command("xdl " + fileName + " -t ")                      

    def send_command(self, cmd):
        print('sending->' + cmd)
        self.serialPort.write((cmd + '\r\n').encode())

    def queue_command(self, cmd):
        self.commandQueue.append(cmd)

    def process(self, data, data_str):
        if (self.command == UPLOAD):
            if (data[0] == ESC):
                print('upload rejected')              
            elif data_str.find('txt is not found!') != -1:
                # Controller appears to be happy to accept the file            
                with open(self.file_path, 'rb') as file_stream:
                    modem = XMODEM(getc, putc)
                    if modem.send(file_stream, callback=transfer_callback):
                        print('transfer ok')
                    else:
                        print('transfer failed')

cmd = Command()

def main(args, cmd):
    if len(args) < 3 or args[1].lower() != UPLOAD:
        print("Usage: script_name.py upload <file_path> [overwrite]")
        return
    
    cmd.command = args[1].lower()
   
    fullPath = Path(args[2]).resolve()
    if (fullPath.exists):
        cmd.file_path = str(fullPath)
    cmd.overwrite = False  # Default value for overwrite

    if len(args) > 3:
        cmd.overwrite = args[3].lower() == 'true'

# Function to get data to be sent via XMODEM
def getc(size, timeout=1):
    data = ser.read(size) or None
    return data

# Function to send data via XMODEM
def putc(data, timeout=1):
    return ser.write(data)

def transfer_callback(total, success, fail):
    pass

def read_all_bytes():
    if (ser.in_waiting > 0):
        # read the bytes and convert from binary array to ASCII
        return ser.read(ser.in_waiting)
    return None

def find_usb_serial_port():
    ports = serial.tools.list_ports.comports()
    for port in ports:
        if "USB Serial Port" in port.description:
            return port.device
    return None

def quit():
    ser.close()
    exit()

main(sys.argv, cmd)

# Find the first USB Serial Port
usb_serial_port = find_usb_serial_port()

if usb_serial_port:
    print("USB Serial Port found:", usb_serial_port)
else:
    print("No USB Serial Port found.")
    
if (not usb_serial_port):
    exit(1)

# Open the serial port
ser = serial.Serial(
    port=usb_serial_port, 
    baudrate=115200, 
    parity=serial.PARITY_NONE, 
    stopbits=serial.STOPBITS_ONE, 
    bytesize=serial.EIGHTBITS, 
    timeout=0.5,
)

cmd.serialPort = ser

print('GSK Controller')
print('xcd user                             change to user parition')
print('xdl <file name> -t <data>            upload a program')

cmd.upload_file()
cmd.commandQueue.insert(0, 'xcd user')

while True:
    time.sleep(0.50)
    data = read_all_bytes()

    if (data):
        data_str = data.decode('ascii')

        if (len(data_str) == 1 and not data_str.isprintable()):            
            pass
        else:
            print(data_str)

        cmd.process(data, data_str)        
    else:
        if (len(cmd.commandQueue) > 0):
            command  = cmd.commandQueue.pop(0)

            cmd.send_command(command)
        else:
            if (command):                
                quit()

            # get keyboard input
            data = input()
            
            if data == 'exit':
                quit()
            else: 
                if data.startswith('xdl'):
                    upload = True
                ser.write((data + '\r\n').encode())