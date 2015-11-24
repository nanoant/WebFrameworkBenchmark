#include "crow.h"

int main() {
  crow::SimpleApp app;
  CROW_ROUTE(app, "/")([]() { return "Hello World"; });
  crow::logger::setLogLevel(crow::LogLevel::ERROR);
  app.port(8080).multithreaded().run();
}
