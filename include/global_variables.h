#pragma once
#include <string>
#include <thread>

inline std::string PROGRAM_ROOT_DIRECTORY;
const inline std::string SECRETS_LOCATION = "/etc/rrms/secrets.yaml";
const inline unsigned int THREADS_NUMBER = std::thread::hardware_concurrency();
