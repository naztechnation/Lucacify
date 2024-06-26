import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../res/enum.dart';
import 'base_viewmodel.dart';

class FirebaseAuthProvider extends BaseViewModel {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseStorage = FirebaseFirestore.instance;

  Status _status = Status.uninitialized;

  Status get status => _status;
  String _message = '';
  String get message => _message;

  setBack() {
    _status = Status.authenticated;
    setViewState(ViewState.success);
  }

  Future<bool> isLoggedIn() async {
    //  bool isLoggedIn = await googleSignIn.isSignedIn();
    //  if (isLoggedIn &&
    //      prefs.getString(FirestoreConstants.id)?.isNotEmpty == true) {
    //    return true;
    //  } else {
    //    return false;
    //  }

    return true;
  }

  Future<void> registerUserWithEmailAndPassword({
  required String email,
  required String password,
  required String username,
}) async {
  _status = Status.authenticating;
  setViewState(ViewState.success);

  try {
    await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    if (_firebaseAuth.currentUser!.uid != null) {
      await _firebaseStorage
          .collection('users')
          .doc(_firebaseAuth.currentUser!.uid)
          .set({
        'chattingWith': null,
        'uid': _firebaseAuth.currentUser!.uid,
        'userName': username,
        'userEmail': email,
        'pushToken': '',
        'online': false,
      });

      _status = Status.authenticated;
      _message = '';
      setViewState(ViewState.success);
    }
  } on FirebaseAuthException catch (e) {
    _status = Status.authenticateError;
    setViewState(ViewState.success);

    if (e.code == 'email-already-in-use') {
            _message = 'The email address is already in use';
            _status = Status.authenticateError;
    setViewState(ViewState.success);

      
    } else if (e.code == 'weak-password') {
       _message = 'The password is too weak';
            _status = Status.authenticateError;
    setViewState(ViewState.success);
       
    } else {
      _message = '${e.message}';
            _status = Status.authenticateError;
    
    }
  }  catch (e) {
    _status = Status.authenticateError;
    setViewState(ViewState.success);

           _message = '$e';

  }
}


  Future<User?> loginWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;
      print("${user?.uid.toString()} cool uid" );
      return user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }

      return null;
    }
  }

  Future<User?> loginUserWithEmailAndPassword({
  required String email,
  required String password,
}) async {
  _status = Status.authenticating;
  setViewState(ViewState.loading);

  try {
    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    User? user = userCredential.user;
    _status = Status.authenticated;
    
    setViewState(ViewState.success);
    return user;
  } on FirebaseAuthException catch (e) {
    _status = Status.authenticateError;
    setViewState(ViewState.failed);

    if (e.code == 'user-not-found') {
           _message = 'No user found for that email.';

      
    } else if (e.code == 'wrong-password') {
                _message = 'Wrong password provided for that user.';
 
    } else {
     _message = 'FirebaseAuthException: ${e.message}';
       
    }

    return null;
  } catch (e) {
    _status = Status.authenticateError;
    setViewState(ViewState.failed);

    _message = 'Error during authentication: $e';
     

    return null;
  }
}



}
