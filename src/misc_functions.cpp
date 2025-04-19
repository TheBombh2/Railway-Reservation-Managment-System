#include <filesystem>
#include <iostream>
#include "misc_functions.h"

std::string GetExecutableDirectory(char *argvInput)
{
  std::filesystem::path launchPath = std::filesystem::current_path() / std::filesystem::path(argvInput);
  try
  {
    return std::filesystem::canonical(launchPath.parent_path()).string();
  }
  catch(const std::filesystem::filesystem_error& e)
  {
    std::cerr << "ERROR: Failed to determine pwd of running program\n";
    throw;
  }
}

void WriteInitialSecretsFile()
{

}

