import 'dart:async';
import 'dart:io';
import 'UserRegister.dart';
import 'login.dart';
void main() async {
  print("===== Welcome to Our system =====");
  print("");
  print("=== Select option You want below ====");
  print("=== 1. Login                     ====");
  print("=== 2. Register                  ====");
  stdout.write("Press (1) to Login or Press (2) to register: ");
  var userSelection = stdin.readLineSync();
  if (userSelection == "1") {
      login();
  
  } else if (userSelection == "2") {
    userRegister();
  }
}
