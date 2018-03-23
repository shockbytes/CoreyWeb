import 'dart:html';
import 'dart:async';
import 'dart:convert';

import 'package:angular/angular.dart';
import 'package:firebase/firebase.dart' as fb;
import 'package:firebase/firebase.dart';

@Injectable()
class FirebaseService {
  // Private fields
  fb.Auth _fbAuth;
  fb.GoogleAuthProvider _fbGoogleAuthProvider;
  fb.Database _fbDatabase;
  fb.Storage _fbStorage;
  fb.DatabaseReference _fbRefMessages;

  // Public fields
  fb.User user;

  FirebaseService() {
    _loadCredentials();
  }

  void _loadCredentials() {
    var url = "http://localhost:8080/firebase_config.json";
    HttpRequest.getString(url).then(_onCredentialsLoaded).catchError(_onError);
  }

  void _onCredentialsLoaded(String response) {
    var json = JSON.decode(response);

    fb.initializeApp(
        apiKey: json["apiKey"],
        authDomain: json["authDomain"],
        databaseURL: json["databaseURL"],
        storageBucket: json["storageBucket"]);

    _setupAuth();
  }

  bool _onError(Object any) {
    print("Error while requesting data... $any");
    return true;
  }

  void _authChanged(fb.User fbUser) {
    user = fbUser;
  }

  void _setupAuth() {
    _fbGoogleAuthProvider = new fb.GoogleAuthProvider();
    _fbAuth = fb.auth();
    _fbAuth.onAuthStateChanged.listen(_authChanged);
  }

  Future signIn() async {
    try {
      await _fbAuth.signInWithPopup(_fbGoogleAuthProvider);
      print(_fbAuth.currentUser.displayName);
    } catch (error) {
      print("$runtimeType::login() -- $error");
    }
  }

  void signOut() {
    _fbAuth.signOut();
  }

  bool isSignedIn() {
    return _fbAuth.currentUser != null;
  }
}
