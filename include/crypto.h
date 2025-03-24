#pragma once
#include <string>

enum CEASAR_CIPHER_MODE
{
  Decrypt,
  Encrypt,
};

const inline int SALT_LENGTH = 64;

std::string GetSHA256Digest(const std::string& inputStr);
std::string GetRandomSalt(const int& length = SALT_LENGTH);
std::string CeasarCipher(const std::string& inputText, CEASAR_CIPHER_MODE mode, int amount);
