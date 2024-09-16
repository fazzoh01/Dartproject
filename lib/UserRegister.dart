import 'dart:async';
import 'dart:io';
import 'login.dart';

import 'dbConnection.dart';

Future userRegister() async {
  var conn = await dbConnect();
  print("=====WELCOME TO OUR REGISTRATION =====");

  print("");

  stdout.write("====1. Enter your ID: ");
  var id = stdin.readLineSync();

  stdout.write("====1. Enter your first name: ");
  var fname = stdin.readLineSync();

  stdout.write("====2. Enter your lName name: ");
  var lname = stdin.readLineSync();

  print("===== Select Your Gender =====");
  print("===== 1. Male            ======");
  print("===== 2. Female          =====");
  stdout.write("press (1) for Male or  (2) for Female: ");
  var user_gender = stdin.readLineSync();
  var gender;
  if (user_gender == "1")  {
    gender = "MALE";
  } else if (user_gender == "2") {
    gender = "FEMALE";
  }
  stdout.write("====1. Enter your department: ");
  var department = stdin.readLineSync();

  stdout.write("====1. Enter your collegue: ");
  var collegue = stdin.readLineSync();

  stdout.write("====3. Enter your username: ");
  var username = stdin.readLineSync();

  bool strong(String pasword) {
  bool uppercase = pasword.contains(RegExp(r'[A-Z]'));
  bool lowercase = pasword.contains(RegExp(r'[a-z]'));
  bool pasnumber = pasword.contains(RegExp(r'[0-9]'));
  bool specialcase = pasword.contains(RegExp(r'[!@#\$%^&*(),.?":{}|<>]'));
  bool paslength = pasword.length >= 8;
  return uppercase && lowercase && pasnumber && specialcase && paslength;
}

 String pasword;
  do {
    print('');
    print('Password should contain upper & small letters, numbers, and special characters');
    stdout.write("Enter password: ");
    stdin.echoMode = false;
    pasword = stdin.readLineSync()!; 
    stdin.echoMode = true;
    if (!strong(pasword)) {
      print('Password is not strong enough, try again');
    }
  } while (!strong(pasword));

  print("");
  stdout.write("====5. Enter your password to verify: ");
  stdin.echoMode = false;
  var verPassword = stdin.readLineSync();
  stdin.echoMode = true;
  var password;
  if (pasword == verPassword) {
    password = pasword;
    var user_data_insert = await conn.query(
      'insert into REGISTRATION values(?,?,?,?,?,?,?,?)',
      [id, fname, lname, gender, department, collegue, username, password,]);
  await conn.close();
    print("Thank you for using our registration menu");
    print("=====You are successfuly registered=====");
    print(" ______________________________________ ");
    print("#______________________________________#");
    print("You Want to login...?: ");
    print("1. Yes");
    print("2. No");

    stdout.write("Press (1) to accept login page, or (2) to cancel ");
    var userAcception = stdin.readLineSync();
    if (userAcception == "1") {
      login();
    } else {
      exit(0);
    }
  } else {
    print("Password did not match try again later");
    exit(0);
  }
  
}
