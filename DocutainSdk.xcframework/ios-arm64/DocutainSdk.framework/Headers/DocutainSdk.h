//
//  DocutainSdk.h
//  DocutainSdk
//
//  Created by Marvin Frankenfeld on 16.11.22.
//

#import <Foundation/Foundation.h>
#import <stdint.h>

//! Project version number for DocutainSdk.
FOUNDATION_EXPORT double DocutainSdkVersionNumber;

//! Project version string for DocutainSdk.
FOUNDATION_EXPORT const unsigned char DocutainSdkVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <DocutainSdk/PublicHeader.h>

bool libInitSDK(const char* sLizenzKey, const char* sPath, const char* sPackageName, uint32_t version);
uint32_t libVersion();
const char* libGetLastError(uint32_t* pnLastError);
bool libSetLastError(uint32_t nLastError, const char* sLastErrorMessage);
uint32_t libGetLastErrorCode();
const char* libLoggerFilename();
bool libLoadFile(const char* sPath);
bool libLoad(uint8_t*, int32_t size, const char* sExtension);
char* libWritePDF(const char* sFilePath, const char* sFileName, bool bOverwrite, uint32_t nFormat);
bool libLoadAndCalcClipingColor(uint8_t* data, int32_t height, int32_t width, int32_t* pX1, int32_t* pY1, int32_t* pX2, int32_t* pY2, int32_t* pX3, int32_t* pY3, int32_t* pX4, int32_t* pY4, bool bPixelStride1);
void libSetClipingModelPath(const char* sModelPath);
void libCancelCalcCliping();
uint32_t libNAktPage();
uint32_t libNPages();
bool libLoadOrgJPEGCamera(uint8_t* data, int32_t size, int32_t height, int32_t width, bool bSwappedDimensions);
bool libCalcCliping(int32_t* pX1, int32_t* pY1, int32_t* pX2, int32_t* pY2, int32_t* pX3, int32_t* pY3, int32_t* pX4, int32_t* pY4);
bool libCut(int32_t pX1, int32_t pY1, int32_t pX2, int32_t pY2, int32_t pX3, int32_t pY3, int32_t pX4, int32_t pY4);
bool libConvert(int32_t mode);
bool libAktImageJPG(uint8_t* data, int32_t* size);
bool libInitScanStapel();
bool libGoToPage(uint32_t page);
bool libRotate(uint8_t direction);
bool libRemovePage(uint32_t page);
void libFreeAllScannedPages();
bool libNextOCRPageJPG(uint8_t* data, int32_t* page, int32_t* size);
bool libFulltextOpenPage(uint32_t nPage, uint16_t nWidth, uint16_t nHeight);
bool libFulltextAddWord(const char* wort, int16_t left, int16_t top, int16_t right, int16_t bottom);
bool libFulltextWriteOCRFile(uint32_t nPage);
const char* libFulltextGetText(int32_t nPage);
const char* libAnalyze();
bool libAnalyzeConfig(uint32_t toRead, const char* sOwnIBAN);
bool libLoadDocFile(const char* sFilename, uint32_t documentType, uint32_t nPages);
bool libLoadDocFileMemory(uint8_t* pData, int32_t size, uint32_t documentType, uint32_t nPages);
bool libReadDeviceConfig(uint8_t* bAutomatischAusloesen);
bool libWriteDeviceConfig(bool bAutomatischAusloesen);
bool libStoreAktToOrgCut();
bool libLoadPreviewImage();
const char* libGetFilterPreviewImage(uint32_t colorMode);
int32_t libGetColorModeAktPage();
void libWriteTrace(int TraceLevel, const char* sTrace);
void libSetLogLevel(uint32_t nLevel);
bool libDeleteTempFiles(bool bTrace);
//muss wieder entfernt werden, nur für test zwecke
//const char* libGetOCRData();
