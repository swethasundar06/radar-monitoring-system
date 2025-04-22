# radar-monitoring-system
A real-time Radar Monitoring System using Arduino and Processing. The ultrasonic sensor scans surroundings with a servo motor, and the data is visualized as a radar interface in Processing.

# Radar Monitoring System

This project uses an Arduino UNO, HC-SR04 ultrasonic sensor, and a servo motor to detect objects and display them on a radar-like interface using Processing.

## Components
- Arduino UNO  
- HC-SR04 Sensor  
- Servo Motor  
- Processing IDE  

## How It Works
- The servo motor rotates the ultrasonic sensor from 0° to 180°.
- Distance and angle data are sent via serial.
- Processing reads the data and shows a live radar visualization.

## Setup
1. Upload `radar_monitoring.ino` to Arduino.
2. Connect components (Trig=10, Echo=11, Servo=9).
3. Run `radar_visual.pde` in Processing (change COM port if needed).

## Features
- Live radar sweep
- Distance & angle display
- Object detection alert (within 40 cm)

## License
MIT License

