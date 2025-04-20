#include <filesystem>
#include <iostream>
#include "global_variables.h"
#include "misc_functions.h"

int main(int argc, char** argv)
{
  PROGRAM_ROOT_DIRECTORY = GetExecutableDirectory(argv[0]); 
  if(!std::filesystem::exists(ConcatenatePaths({PROGRAM_ROOT_DIRECTORY, "secrets.yaml"})))
  {
    std::cout << "secrets.yaml was not found and has been recreated. Please make sure it contains accurate values. The program will now terminate";
    WriteInitialSecretsFile();
    return -1;
  }
}
