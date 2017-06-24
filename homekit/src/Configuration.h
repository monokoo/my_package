#pragma once
//
//  Configuration.h
//  Workbench
//
//  Created by Wai Man Chan on 10/27/14.
//
//

#define HomeKitLog 1
#define HomeKitReplyHeaderLog 0
#define PowerOnTest 0

//Device Setting
#define deviceName "House Sensor"    //Name
#define deviceIdentity "12:24:51:48:27:73"  //ID
#define _manufactuerName "stones"   //Manufactuer
#define devicePassword "624-10-526" //Password
#define deviceUUID "33F48751-6F19-63CF-9552-8F4228F69D52"   //UUID, for pair verify
#define controllerRecordsAddress "/etc/homekit" //Where to store the client keys

//Number of client
/*
 * BEWARE: Never set the number of client to 1
 * iOS HomeKit pair setup socket will not release until the pair verify stage start
 * So you will never got the pair corrected, as it is incomplete (The error require manually reset HomeKit setting
 */
#define numberOfClient 20
//Number of notifiable value
/*
 * Count how many notifiable value exist in your set
 * For dynamic add/drop model, please estimate the maximum number (Too few->Buffer overflow)
 */
#define numberOfNotifiableValue 2

#define keepAlivePeriod 60

//If you compiling this to microcontroller, set it to 1
#define MCU 0

#include <openssl/sha.h>
#include <stdint.h>
#include <unistd.h>

typedef SHA512_CTX SHACTX;
#define SHAInit SHA512_Init
#define SHAUpdate SHA512_Update
#define SHAFinal SHA512_Final
#define SHA_DIGESTSIZE 64
#define SHA_BlockSize 128
