#pragma once
#include <string>

enum CAESAR_CIPHER_MODE
{
  Decrypt,
  Encrypt,
};

const inline int SALT_LENGTH = 16;

std::string GetSHA256Digest(const std::string& inputStr);
std::string GetRandomSalt(const int& length = SALT_LENGTH);
std::string CaesarCipher(const std::string& inputText, CAESAR_CIPHER_MODE mode, int amount);

std::string GetUUIDv7();
std::string GetUUIDv4();
