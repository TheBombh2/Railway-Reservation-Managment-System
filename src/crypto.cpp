#include <iostream>
#include <sstream>
#include <iomanip>
#include <assert.h>
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
  for(int i = 0; i < inputText.size(); i++)
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
