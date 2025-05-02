#pragma once
#include <ctime>
#include <string>
#include <yaml-cpp/yaml.h>

std::string GetExecutableDirectory(char* argvInput);
std::string ConcatenatePaths(std::initializer_list<std::string> input);
std::string FormatTimeToString(const std::tm& time);
void WriteInitialSecretsFile();
YAML::Node LoadSecretsFile();
