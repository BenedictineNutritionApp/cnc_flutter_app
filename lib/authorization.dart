import 'package:shared_preferences/shared_preferences.dart';

import 'connections/db_helper.dart';
import 'models/user_model.dart';

class Authorization {

  // Authorization._privateConstructor();
  //
  // static final Authorization _instance = Authorization._privateConstructor();
  //
  // factory Authorization() {
  //   return _instance;
  // }

  var db = new DBHelper();

  UserModel user;


  Future<bool> isLogged() async {
    var sharedPref = await SharedPreferences.getInstance();
    String id = sharedPref.getString('id');
    if(id != null){
    } else {
    }
    return id != null;
  }

  Future<bool> isScreenerComplete() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String id = prefs.get('id');
    if(id == null){
      return false;
    }
    var response = await db.getFormCompletionStatus();

    bool formComplete = (response.toString() == 'true');

    if (formComplete) {
      return true;
    } else {
      return false;
    }
  }

  Future<UserModel> getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String id = prefs.get('id');

  }
}