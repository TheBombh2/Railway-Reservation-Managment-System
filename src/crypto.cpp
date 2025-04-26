#include <iostream>
#include <sstream>
#include <iomanip>
#include <assert.h>
#include <random>
#include <chrono>
#include <algorithm>
#include <openssl/rand.h>
#include <openssl/sha.h>
#include "crypto.h"

std::string GetSHA256Digest(const std::string& inputStr)
{
  unsigned char outputBuffer[SHA256_DIGEST_LENGTH];
  SHA256((const unsigned char*)inputStr.c_str(), inputStr.length(), outputBuffer);
  std::stringstream ss;
  for(int i = 0; i < SHA256_DIGEST_LENGTH; i++)
    ss << std::hex << std::setw(2) << std::setfill('0') << (int)outputBuffer[i];
  return ss.str();
}

std::string GetRandomSalt(const int& length)
{
  std::string output;
  output.resize(length);
  unsigned char bytesBuffer[length];
  int result = RAND_bytes(bytesBuffer, length);
  assert(result == 1 && "ERROR: Generating a secure salt has failed.");
  for(int i = 0; i < length; i++)
    output[i] = static_cast<char>((bytesBuffer[i] % 95) + 32);
  return output;
}

std::string CeasarCipher(const std::string& inputText, CEASAR_CIPHER_MODE mode, int amount)
{
  std::string output;
  output.resize(inputText.size());
  
  //ASCII letters range from 32 to 126
  for(unsigned int i = 0; i < inputText.size(); i++)
  {
    int asciiVal = static_cast<int>(inputText[i]);
    if(mode == CEASAR_CIPHER_MODE::Encrypt)
      asciiVal += amount;
    else if(mode == CEASAR_CIPHER_MODE::Decrypt)
      asciiVal -= amount;
  
    //Truncate output to limited values
    while(asciiVal < 32)
      asciiVal += 95;
    while(asciiVal > 126)
      asciiVal -= 95;
    output[i] = static_cast<char>(asciiVal);
  }
  return output;
}

std::string GetUUIDv7()
{
  //Copied From:
  //https://antonz.org/uuidv7/#cpp
  //
  //I am not sure if this is the most optimized implemenation in the world, but it'll have to do

  // random bytes
  std::random_device rd;
  std::array<uint8_t, 16> random_bytes;
  std::generate(random_bytes.begin(), random_bytes.end(), std::ref(rd));
  std::array<uint8_t, 16> value;
  std::copy(random_bytes.begin(), random_bytes.end(), value.begin());

  // current timestamp in ms
  auto now = std::chrono::system_clock::now();
  auto millis = std::chrono::duration_cast<std::chrono::milliseconds>(
      now.time_since_epoch()
  ).count();

  // timestamp
  value[0] = (millis >> 40) & 0xFF;
  value[1] = (millis >> 32) & 0xFF;
  value[2] = (millis >> 24) & 0xFF;
  value[3] = (millis >> 16) & 0xFF;
  value[4] = (millis >> 8) & 0xFF;
  value[5] = millis & 0xFF;

  // version and variant
  value[6] = (value[6] & 0x0F) | 0x70;
  value[8] = (value[8] & 0x3F) | 0x80;

  std::stringstream ss;
  for(unsigned int i = 0; i < value.size(); i++)
  {
    if(i == 4 || i == 6 || i == 8 || i == 10)
      ss << '-';
    ss << std::hex << std::setw(2) << std::setfill('0') << (int)value[i];
  }
  return ss.str();
}

std::string GetUUIDv4()
{
  unsigned char buffer[16];
  int result = RAND_bytes(buffer, 16);
  assert(result == 1 && "ERROR: Generating a secure token has failed.");
  
  std::stringstream ss;
  for(unsigned int i = 0; i < 16; i++)
  {
    if(i == 4 || i == 6 || i == 8 || i == 10)
      ss << '-';
    ss << std::hex << std::setw(2) << std::setfill('0') << (int)buffer[i];
  }
  return ss.str();
}

