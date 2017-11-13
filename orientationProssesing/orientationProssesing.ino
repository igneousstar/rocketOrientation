/*****************************************************************/
// The SFE_LSM9DS1 library requires both Wire and SPI be
// included BEFORE including the 9DS1 library.
#include <Wire.h>
#include <SPI.h>
#include <SparkFunLSM9DS1.h>

//////////////////////////
// LSM9DS1 Library Init //
//////////////////////////
// Use the LSM9DS1 class to create an object. [imu] can be
// named anything, we'll refer to that throught the sketch.
LSM9DS1 imu;

///////////////////////
// Example I2C Setup //
///////////////////////
// SDO_XM and SDO_G are both pulled high, so our addresses are:
#define LSM9DS1_M 0x1E // Would be 0x1C if SDO_M is LOW
#define LSM9DS1_AG  0x6B // Would be 0x6A if SDO_AG is LOW

/*
 * Max and min for the different axies
 */
float magXmax = 0;

float magYmax = 0;

float magZmax = 0;

float magXmin = 0;

float magYmin = 0;

float magZmin = 0;

/**
 * For setting the max and min durint calibration
 */

void setMaxMin(float *Max, float *Min, float val){
  if(val > *Max){
    *Max = val;
  }
  if(val < *Min){
    *Min = val;
  }
}

/*
 * Centers the values of the magnometer for calibration
 * Helps overcome soft iron disortations
 */
float scaleVector(float Max, float Min, float val){
  val = val - (0.5*(Max + Min));
//  return map(val, Min - 0.5*(Max + Min), Max - 0.5*(Max + Min),-10.0, 10.0);
  return val;
}

void setup() 
{
  
  Serial.begin(9600);
  
  // Before initializing the IMU, there are a few settings
  // we may need to adjust. Use the settings struct to set
  // the device's communication mode and addresses:
  imu.settings.device.commInterface = IMU_MODE_I2C;
  imu.settings.device.mAddress = LSM9DS1_M;
  imu.settings.device.agAddress = LSM9DS1_AG;
  // The above lines will only take effect AFTER calling
  // imu.begin(), which verifies communication with the IMU
  // and turns it on.
  if (!imu.begin())
  {
    Serial.println("Failed to communicate with LSM9DS1.");
    Serial.println("Double-check wiring.");
    Serial.println("Default settings in this sketch will " \
                  "work for an out of the box LSM9DS1 " \
                  "Breakout, but may need to be modified " \
                  "if the board jumpers are.");
    while (1)
      ;
  }
  imu.settings.mag.scale = 4;
  imu.settings.mag.XYPerformance = 3;
  imu.settings.mag.ZPerformance = 3;
  imu.settings.accel.highResEnable = true;
  imu.settings.accel.scale = 2;
  imu.settings.mag.lowPowerEnable = false;

  //Calibrate the magnometer
  //Spin it around like crazy so it can get
  //as many readings as it can
  for(int i = 0; i < 10000; i++){
    imu.readMag();
    setMaxMin(&magXmax, &magXmin, imu.calcMag(imu.mx));
    setMaxMin(&magYmax, &magYmin, imu.calcMag(imu.my));
    setMaxMin(&magZmax, &magZmin, imu.calcMag(imu.mz));
    delay(1);
  }
  
  
}

void loop()
{
  imu.readMag();
  imu.readAccel();
  Serial.print(imu.calcAccel(imu.ax), 5);
  Serial.print(",");
  Serial.print(imu.calcAccel(imu.ay), 5);
  Serial.print(",");
  Serial.print(imu.calcAccel(imu.az), 5); 
  Serial.print(","); 
  Serial.print(scaleVector(magXmax, magXmin, imu.calcMag(imu.mx)), 5);
  Serial.print(",");
  Serial.print(scaleVector(magYmax, magYmin, imu.calcMag(imu.my)), 5);
  Serial.print(",");
  Serial.print(scaleVector(magZmax, magZmin, imu.calcMag(imu.mz)), 5);
  Serial.println();
}

