// Dương đẩy code lên esp lên đây nhé

#include <Wire.h>
#include <Arduino.h>
#include <WiFi.h>
#include <Firebase_ESP_Client.h>
#include "addons/TokenHelper.h"
#include "addons/RTDBHelper.h"

#include <Adafruit_Sensor.h>
#include <DHT.h>
#include <DHT_U.h>

// WiFi Information
#define WIFI_SSID "Xom Tro T3"
#define WIFI_PASSWORD "772truongdinh"

// Firebase Information
#define API_KEY "AIzaSyBpnuQTxAQrp4KliZLXfqO9bhlGSoLEmbA"
#define USER_EMAIL "iot@gmail.com"
#define USER_PASSWORD "Duongquachiot"
#define DATABASE_URL "https://iot1-33b58-default-rtdb.asia-southeast1.firebasedatabase.app/"

// Firebase objects
FirebaseData fbdo;
FirebaseAuth auth;
FirebaseConfig config;

// Database Paths
const String moisturePath = "gardenId1/doAmDat/current";
const String pumpStatusPath = "gardenId1/mayBom/trangThai";
const String lightPath = "gardenId1/anhSang/current";
const String dhtTempPath = "gardenId1/dhtNhietDo/current";
const String dhtHumidityPath = "gardenId1/dhtDoAm/current";
const String distancePath = "gardenId1/khoangCach/current";

// Pin Definitions
const int pumpPin = 4;
const int moistureSensorPin = 34;
const int lightSensorPin = 35;
const int trigPin = 14;
const int echoPin = 12;
const int dhtPin = 27; // Chân DHT11

#define DHTTYPE DHT11 // Loại cảm biến DHT
DHT dht(dhtPin, DHTTYPE); // Khởi tạo DHT

bool signUp = false;
bool autoControl = false;

// Function Declarations
void connectToWifi();
void connectToFirebase();
void configListener();
void autoControlling();
void sendingData();
int readSoilMoisture();
int readLightIntensity();
float readDHTTemperature();
float readDHTHumidity();
int readDistance();

void setup() {
  Serial.begin(115200);
  pinMode(pumpPin, OUTPUT);
  pinMode(moistureSensorPin, INPUT);
  pinMode(lightSensorPin, INPUT);
  pinMode(trigPin, OUTPUT);
  pinMode(echoPin, INPUT);

  dht.begin(); // Bắt đầu sử dụng DHT11

  connectToWifi();
  connectToFirebase();
}

void loop() {
  configListener();
  autoControlling();
  sendingData();
}

// Connect to WiFi
void connectToWifi() {
  WiFi.begin(WIFI_SSID, WIFI_PASSWORD);
  Serial.print("\nConnecting to WiFi");
  while (WiFi.status() != WL_CONNECTED) {
    Serial.print(".,.");
    delay(300);
  }
  Serial.print("\nWiFi connected with IP: ");
  Serial.println(WiFi.localIP());
}

// Connect to Firebase
void connectToFirebase() {
  config.api_key = API_KEY;
  config.database_url = DATABASE_URL;
  auth.user.email = USER_EMAIL;
  auth.user.password = USER_PASSWORD;
  
  Firebase.reconnectWiFi(true);
  config.token_status_callback = tokenStatusCallback;
  Firebase.begin(&config, &auth);
  
  if (Firebase.ready() && Firebase.RTDB.setInt(&fbdo, moisturePath.c_str(), readSoilMoisture())) {
    Serial.println("Firebase connected and initial data set.");
    signUp = true;
  } else {
    Serial.printf("Firebase connect error: %s\n", fbdo.errorReason().c_str());
  }
}

// Read soil moisture value
int readSoilMoisture() {
  int sensorValue = analogRead(moistureSensorPin);
  Serial.print("Sensor Value: ");
   Serial.println(sensorValue);
  return map(sensorValue, 1600, 4095, 100, 0); // Adjusting based on sensor values
}

// Read light intensity
int readLightIntensity() {
  int lightValue = analogRead(lightSensorPin);
  return map(lightValue, 0, 4095, 100, 0); // Đo độ sáng từ 0 đến 100%
}

// Read temperature from DHT11
float readDHTTemperature() {
  float temp = dht.readTemperature();
  if (isnan(temp)) {
    Serial.println("Error reading temperature from DHT11");
    return -1;
  }
  return temp;
}

// Read humidity from DHT11
float readDHTHumidity() {
  float humidity = dht.readHumidity();
  if (isnan(humidity)) {
    Serial.println("Error reading humidity from DHT11");
    return -1;
  }
  return humidity;
}

// Read distance from HC-SR04
int readDistance() {
  digitalWrite(trigPin, LOW);
  delayMicroseconds(2);
  digitalWrite(trigPin, HIGH);
  delayMicroseconds(10);
  digitalWrite(trigPin, LOW);
  
  long duration = pulseIn(echoPin, HIGH);
  int distance = duration * 0.034 / 2; // Khoảng cách (cm)
  return distance;
}

// Config listener to check pump mode and control the pump
void configListener() {
  if (Firebase.ready() && signUp) {
    if (Firebase.RTDB.getInt(&fbdo, pumpStatusPath.c_str())) {
      int pumpState = fbdo.intData();
      Serial.print("Pump State from Firebase: ");
      Serial.println(pumpState);

      if (pumpState == 1) {
        digitalWrite(pumpPin, HIGH);
        Serial.println("Pump ON");
        autoControl = false;
      } else if (pumpState == 0) {
        digitalWrite(pumpPin, LOW);
        Serial.println("Pump OFF");
        autoControl = false;
      } else if (pumpState / 10 == 2) {
        autoControl = true;
        Serial.println("Pump in AUTO mode");
      }
    }
  } else {
    Serial.println("Firebase disconnected");
  }
}

// Auto control pump based on soil moisture
void autoControlling() {
  if (autoControl) {
    int soilMoisture = readSoilMoisture();
    int newPumpStatus;
    
    if (soilMoisture > 30) {
      digitalWrite(pumpPin, LOW);
      Serial.println("Pump OFF (Auto Mode)");
      newPumpStatus = 20; // Tự động, máy bơm Tắt
    } else {
      digitalWrite(pumpPin, HIGH);
      Serial.println("Pump ON (Auto Mode)");
      newPumpStatus = 21; // Tự động, máy bơm Bật
    }
    
    // Gửi trạng thái mới lên Firebase
    if (Firebase.ready() && signUp) {
      Firebase.RTDB.setInt(&fbdo, pumpStatusPath.c_str(), newPumpStatus);
    }
  }
}

// Send data to Firebase
void sendingData() {
  static unsigned long lastSendTime = 0;
  if (Firebase.ready() && signUp && millis() - lastSendTime > 10000) {
    int soilMoisture = readSoilMoisture();
    int lightIntensity = readLightIntensity();
    float dhtTemp = readDHTTemperature();
    float dhtHumidity = readDHTHumidity();
    int distance = readDistance();
    
    if (Firebase.RTDB.setInt(&fbdo, moisturePath.c_str(), soilMoisture)) {
      Serial.print("Sent Soil Moisture: ");
      Serial.println(soilMoisture);
    }
    if (Firebase.RTDB.setInt(&fbdo, lightPath.c_str(), lightIntensity)) {
      Serial.print("Sent Light Intensity: ");
      Serial.println(lightIntensity);
    }
    if (Firebase.RTDB.setFloat(&fbdo, dhtTempPath.c_str(), dhtTemp)) {
      Serial.print("Sent DHT Temperature: ");
      Serial.println(dhtTemp);
    }
    if (Firebase.RTDB.setFloat(&fbdo, dhtHumidityPath.c_str(), dhtHumidity)) {
      Serial.print("Sent DHT Humidity: ");
      Serial.println(dhtHumidity);
    }
    if (Firebase.RTDB.setInt(&fbdo, distancePath.c_str(), distance)) {
      Serial.print("Sent Distance: ");
      Serial.println(distance);
    }

    lastSendTime = millis();
  }
}
