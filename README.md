# Smart Garden IoT System

## Introduction
In modern life, maintaining and caring for a garden has become increasingly difficult. Plants require constant monitoring and proper care, including watering, fertilizing, and ensuring optimal conditions such as light, temperature, and soil moisture. However, due to busy schedules, many people struggle to dedicate time to garden maintenance. Additionally, monitoring essential parameters without specialized equipment can be challenging, leading to declining plant health and overall garden deterioration.

With the rapid advancement of digital technology, integrating technological solutions into daily life has become an inevitable trend. The Internet of Things (IoT) is one of the most prominent fields, offering exceptional benefits in connecting, monitoring, and controlling devices remotely. In agriculture, automation and optimization of farming processes through IoT not only save time and effort but also enhance productivity and efficiency.

Based on this practical need, our team has developed the **Smart Garden IoT System**. The project aims to design and develop a system that allows users to monitor and control an irrigation system remotely via a Web/App application. The system uses sensors to measure various environmental parameters and controls the water pump either automatically or manually based on the collected data. Additional features include notifications for extreme conditions, plant recognition, plant care advice, and disease detection.

This report documents the entire research, design, and implementation process of the system. It includes theoretical foundations, implementation methods, achieved results, challenges faced, and lessons learned during development.

## Problem Statement
### 1. Problem Description
In the current scenario, plant care in gardens or greenhouses requires high optimization and automation to save time, reduce labor, and increase productivity. The challenge is to design and implement a **Smart Garden IoT System** that enables users to efficiently monitor and control environmental factors such as soil moisture, light, and temperature. The system should provide management and automation features based on collected data, along with additional functionalities like user notifications, news updates, plant identification, plant disease detection, and personalized plant care recommendations.

### 2. Core Requirements
- **Connectivity**: The system uses standard WiFi protocols to connect and transmit data.
- **Data Collection & Processing**: Devices must be capable of measuring and recording environmental data (temperature, humidity, and light). Pre-processing data at the device level to reduce latency and save bandwidth.
- **Security**: The system uses HTTPS protocol for secure data transmission.
- **Reliability**: The system ensures stable operation, with the irrigation system functioning even in case of a WiFi disconnection.

### 3. System Development Process
- Identify the project scope, key system functions, and required technologies. Select sensors and establish a development timeline.
- Design a detailed hardware architecture and assemble the circuit. Develop firmware for automated cultivation control.
- Research and implement communication protocols between system components using HTTPS.
- Design a detailed software architecture. Develop a multi-platform application using Flutter and optimize the UI.
- Test and deploy the software. Create user documentation.

## Technologies Used
- **Hardware**: ESP32 microcontroller, soil moisture sensors, temperature sensors, water pump
- **Software**: Flutter (for mobile and web applications), Firebase (for real-time database), Arduino IDE (for firmware development)
- **Protocols**: HTTPS for secure communication
- **Cloud Services**: Firebase for data storage and analytics

## Features
- Remote monitoring of environmental factors (soil moisture, temperature, light)
- Automated or manual irrigation control
- Alerts and notifications for extreme conditions
- Plant identification and disease detection
- Personalized plant care recommendations
- News and updates related to smart gardening

## System Architecture
The **Smart Garden IoT System** consists of three main components: the hardware system, the mobile/web application, and the cloud server. The hardware system includes sensors for data collection and an ESP32 microcontroller for data processing and control. The mobile/web application allows users to monitor and control the system remotely. The cloud server stores data, processes real-time information, and provides additional functionalities such as plant identification and disease detection.

![System Architecture](./image/1.png)

## Installation & Usage
### 1. Hardware Setup
- Connect ESP32 to the necessary sensors and actuators (soil moisture sensor, temperature sensor, water pump, etc.).
- Flash the firmware to the ESP32 board.
- Connect the system to WiFi.

![Hardware Setup](./image/2.png)

### 2. Software Setup
#### Mobile/Web Application
- Install **Flutter SDK**
- Clone this repository:
  ```bash
  git clone https://github.com/hantdev/smart-garden.git
  cd smart-garden
  ```
- Install dependencies:
  ```bash
  flutter pub get
  ```
- Configure `.env` file in `plantapp/assets/env` with your Firebase and API keys:
  
    ```bash
    FIREBASE_API_KEY= "",
    FIREBASE_AUTH_DOMAIN= "",
    FIREBASE_DATABASE_URL= "",
    FIREBASE_PROJECT_ID= "",
    FIREBASE_STORAGE_BUCKET= "",
    FIREBASE_MESSAGING_SENDER_ID= "",
    FIREBASE_APP_ID= "",
    FIREBASE_MEASUREMENT_ID= ""

    OPENWEATHER_API=""

    PLANTID_API_URL= ""
    PLANTID_API_KEY= ""

    NEWS_API_KEY = ""
    NEWS_API_URL = ""
    ```

- Run the application:
  
  ```bash
  flutter run
  
  # flutter run -d chrome --web-renderer html
  ```

### 3. Server Setup (Optional) 

- Deploy Firebase functions for cloud storage and real-time data processing.

## Some Screenshots

![img](./image/3.png)

![img](./image/4.png)

![img](./image/5.png)

![img](./image/6.png)

![img](./image/7.png)

![img](./image/8.png)

![img](./image/9.png)

![img](./image/10.png)

![img](./image/11.png)

![img](./image/12.png)

![img](./image/13.png)

## Conclusion
The **Smart Garden IoT System** is a comprehensive solution for modern plant care, offering advanced features for monitoring, control, and automation. The system provides users with real-time data on environmental conditions, automated irrigation control, plant identification, disease detection, and personalized plant care recommendations. By integrating IoT technology with cloud services and mobile/web applications, the system offers a user-friendly interface for remote management and monitoring.

## Future Enhancements
- Integration with AI for predictive plant care
- Voice control functionality
- Advanced analytics for plant health
- Integration with smart home systems

## Acknowledgements

This project was developed as part of the **IoT and Applications** course at the **Hanoi University of Science and Technology**, Hanoi, Vietnam. We would like to express our gratitude to our instructor, Dr. Dang Tuan Linh, for his guidance and support throughout the project. We would also like to thank our classmates for their collaboration and feedback during the development process.
