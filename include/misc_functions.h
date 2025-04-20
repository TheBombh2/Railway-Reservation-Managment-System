#pragma once
#include <string>
#include <yaml-cpp/yaml.h>

std::string GetExecutableDirectory(char* argvInput);
std::string ConcatenatePaths(std::initializer_list<std::string> input);
void WriteInitialSecretsFile();
YAML::Node LoadSecretsFile();
