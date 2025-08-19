import 'package:daily_price_list/Resources/Routes/RouteNames.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Authviewmodel extends GetxController {
  static Authviewmodel get to => Get.find();
//initlize the auth
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //reactive user
  final Rx<User?> _user = Rx<User?>(null);
  User? get user => _user.value;
  //phone verfication stroage
  String? _verfication;
  int? _resendToken;

  @override
  void onInit() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      _user.value = user;
    });
    super.onInit();
  }

//function for handling the post login navigation
  Future<void> handlePostLoginNavigation() async {
    final prefs = await SharedPreferences.getInstance();
    final locationSelected = prefs.getBool('locationSelected') ?? false;

    if (locationSelected) {
      Get.offAllNamed(Routenames.HomeScreen);
    } else {
      Get.offAllNamed(Routenames.selectlocationScreen);
    }
  }

  //--------------------EMAIL LOGIN------------------------
  //SIGNUP
  Future<void> signupWithEmail(String email, String password) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      // send email verfication
      await credential.user?.sendEmailVerification();
      await handlePostLoginNavigation();
      Get.snackbar(
          'Success!', "Account Created Successfully\nCheck email verficcation");
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Sign Up Error!", e.message ?? e.code);
    } catch (e) {
      Get.snackbar("Sign Up Error!", e.toString());
    }
  }

  //SIGNIN
  Future<void> signInWithEmail(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      await handlePostLoginNavigation();
      //on Succes the authStatechaneges will occur and the trigger will be to the HomeScreen
    } on FirebaseAuthException catch (e) {
      Get.snackbar('SignIn Error!', e.message ?? e.code);
    } catch (e) {
      Get.snackbar('SignIn Error!', e.toString());
    }
  }

  //FORGOT PASSWORD
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      Get.snackbar('Reset Email Sent!', 'Check your email to reset password.');
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Error', e.message ?? e.code);
    }
  }

  //---------------------------GOOGLE SIGNIN-------------------
  Future<void> signInWithGoogle() async {
    try {
      await GoogleSignIn.instance.initialize(
          clientId:
              '127595726955-249ps7jh4eb7vjqkpud0i389ugg3ee78.apps.googleusercontent.com',
          serverClientId:
              '127595726955-d4qmm0j1f80ocahmm0pi8lkh1e62setq.apps.googleusercontent.com');

      //instance
      final GoogleSignInAccount? googleUser =
          await GoogleSignIn.instance.authenticate();

      //if user cancel exit
      if (googleUser == null) return;
      //Obtain auth details from Google
      final GoogleSignInAuthentication googleAuth = googleUser.authentication;

      //create new credential for Firebase
      final credential =
          GoogleAuthProvider.credential(idToken: googleAuth.idToken);

      //signin to Firebase
      await _auth.signInWithCredential(credential);
      await handlePostLoginNavigation();
      Get.offAllNamed(Routenames.selectlocationScreen);
      Get.snackbar('Success', 'Logged in with Google ✅');
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Google SignIn Error!', e.message ?? e.code);
      print(e.message ?? e.code);
    } catch (e) {
      Get.snackbar('Google SignIn Error!', e.toString());
      print(e.toString());
    }
  }

  //------------------------FACEBOOK SIGNIN----------------------
  Future<void> signInWIthFacebook() async {
    final LoginResult result = await FacebookAuth.instance.login();

    try {
      if (result.status == LoginStatus.success) {
        final accessToken = result.accessToken;
        final credential =
            FacebookAuthProvider.credential(accessToken!.tokenString);

        await _auth.signInWithCredential(credential);
        await handlePostLoginNavigation();
        Get.snackbar('Success', 'Logged in with Facebook ✅');
      } else if (result.status == LoginStatus.cancelled) {
        Get.snackbar('Facebook', "LogIn Cancelled");
      } else {
        Get.snackbar('Facebook Error!', result.message ?? 'Unknown');
      }
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Facebook SingIn Error!', e.message ?? e.code);
      print(e.message ?? e.code);
    } catch (e) {
      Get.snackbar('Facebook SignIn Error1', e.toString());
      print(e.toString());
    }
  }

  //----------------------------SIGN OUT ----------------------

  // Future<void> signOut() async {
  //   try {
  //     final GoogleSignIn googleSignIn = GoogleSignIn.instance;
  //     await _auth.signOut();
  //     await googleSignIn.signOut();
  //     await FacebookAuth.instance.logOut();
  //     Get.snackbar('SignOut Success', 'Successfully SignOut');
  //     Get.offAllNamed(Routenames.signinScreen);
  //   } catch (e) {
  //     Get.snackbar("SignOut Error!", e.toString());
  //   }
  // }

  // Future<void> signOut() async {
  //   try {
  //     // Sign out from all providers
  //     final GoogleSignIn googleSignIn = GoogleSignIn.instance;
  //     await _auth.signOut();
  //     await googleSignIn.signOut();
  //     await FacebookAuth.instance.logOut();

  //     // Clear location selection
  //     final prefs = await SharedPreferences.getInstance();
  //     await prefs.remove('locationSelected');

  //     // Navigate after all operations complete
  //     Get.offAllNamed(Routenames.signinScreen);
  //     Get.snackbar('Success', 'Signed out successfully');
  //   } catch (e) {
  //     Get.snackbar("SignOut Error!", e.toString());
  //   }
  // }

  Future<void> signOut() async {
    try {
      //signout from firebase
      await _auth.signOut();
      final GoogleSignIn googleSignIn = GoogleSignIn.instance;
      try {
        await googleSignIn.signOut();
      } catch (e) {
        Get.snackbar("SignOut Error!", e.toString());
      }
      try {
        await FacebookAuth.instance.logOut();
      } catch (e) {
        Get.snackbar("SignOut Error!", e.toString());
      }

      // // Clear location selection if needed
      // final prefs = await SharedPreferences.getInstance();
      // await prefs.remove('locationSelected');
      // Clear all user-related preferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('locationSelected');
      await prefs.remove('savedProvince');
      await prefs.remove('savedDistrict');
      await prefs.remove('savedZone');

      Get.offAllNamed(Routenames.signinScreen);
      Get.snackbar('Success', 'Signed out successfully');
    } catch (e) {
      Get.snackbar("SignOut Error!", e.toString());
      print(e.toString());
    }
  }

  //----------------------REGISTER USING OTP----------------------

  //start phone auth -> sends SMS and recieve VerficationId in callback
  Future<void> startPhoneAuth(String phoneNumber,
      {bool isResend = false}) async {
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: const Duration(seconds: 60),
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _auth.signInWithCredential(credential);
          await handlePostLoginNavigation();
          Get.snackbar('Success', 'Phone number verified automatically ✅');
        },
        verificationFailed: (FirebaseAuthException e) {
          Get.snackbar('Phone Verification Failed', e.message ?? e.code);
          print(e.message ?? e.code);
        },
        codeSent: (String verificationId, int? resendToken) {
          _verfication = verificationId;
          _resendToken = resendToken;
          if (!isResend) {
            Get.toNamed(Routenames.verficationScreen);
          } else {
            Get.snackbar('OTP Resent', 'Check your messages 📩');
          }
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          _verfication = verificationId;
        },
        forceResendingToken: isResend ? _resendToken : null,
      );
    } catch (e) {
      Get.snackbar("Phone Verification Error!", e.toString());
      print(e.toString());
    }
  }

  // Verify entered OTP
  Future<void> verifySMSCode(String smsCode) async {
    try {
      if (_verfication == null) {
        Get.snackbar("Error!", "No verification ID. Please request OTP again.");
        return;
      }

      final credential = PhoneAuthProvider.credential(
        verificationId: _verfication!,
        smsCode: smsCode,
      );

      await _auth.signInWithCredential(credential);
      Get.snackbar('Success', "OTP verified ✅");
      Get.offNamed(Routenames.selectlocationScreen);
    } on FirebaseAuthException catch (e) {
      Get.snackbar("OTP Error!", e.message ?? e.code);
      print(e.message ?? e.code);
    } catch (e) {
      Get.snackbar('OTP Error!', e.toString());
      print(e.toString());
    }
  }
}
