#pragma once
#include <ctime>
#include <string>
#include <yaml-cpp/yaml.h>
#include "date/date.h"

#define VERIFY_TIME(tmObject) tmObject.tm_year != 9999 ? FormatTimeToString(tmObject) : ""

std::string GetExecutableDirectory(char* argvInput);
std::string ConcatenatePaths(std::initializer_list<std::string> input);
std::string FormatTimeToString(const std::tm& time);
void WriteInitialSecretsFile();
YAML::Node LoadSecretsFile();
std::tm GetEmptyTMObject();
date::sys_time<std::chrono::seconds> LoadTimeFromString(const std::string& input);
