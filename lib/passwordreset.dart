import 'dart:io';
import 'login.dart';
import 'UserRegister.dart';
import 'dart:async';
import 'dbConnection.dart';

Future passwordreset() async {
  var con = await dbConnect();
  print('Welcome in reset password page\n');
  stdout.write('Write your current first name: ');
  var infname = stdin.readLineSync();

  var fname = await con.query("SELECT fname FROM registration");
  var fnamelist = [];
  for (var fname1 in fname) {
    fnamelist.add(fname1.first.toString());
  }
  var lname = await con.query("SELECT lname FROM registration");
  var lnamelist = [];
  for (var lname2 in lname) {
    lnamelist.add(lname2.first.toString());
  }
  if (fnamelist.contains(infname)) {
    stdout.write('write your current last name: ');
    var lername = stdin.readLineSync();

    if (lnamelist.contains(lername)) {
      var lstnamedb = await con.query('select username from registration where lname =?', [lername]);

        stdout.write('write your new password: ');
        stdin.echoMode = false;
        var pasword = stdin.readLineSync();
        stdin.echoMode = true;
        print('');
        stdout.write('verify your password:');
        stdin.echoMode = false;
        var verset = stdin.readLineSync();
        stdin.echoMode = true;
        print('');
         if (verset == pasword) {
          var newpass = await con.query(
              'update registration set password =? where lname = ?',[verset, lername]);
         print('welcome $infname $lername:Your password reset is successfully\n');
          
          stdout.write('Press 1 for login, or any key for exit:');
          var log = stdin.readLineSync();
          if (log == '1') {
            login();
          } else {
            exit(0);
          }
          
        } else {
          print('password did not match');
          stdout.write('Press [1. for register]: ');
          var reg = stdin.readLineSync();
          if (reg == '1') {
            userRegister();
          } else {
            exit(0);
          }
        }
      }
    } else {
      print('Username not found');
      stdout.write('Press [1. for register or any key to exit]: ');
      var reg = stdin.readLineSync();
      if (reg == '1') {
        userRegister();
      } else {
        exit(0);
      }
    }
 
  await con.close();
  }


