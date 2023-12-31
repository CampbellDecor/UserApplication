import 'package:campbelldecor/screens/dash_board/homescreen.dart';
import 'package:campbelldecor/screens/notifications/notification_setup.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../reusable/reusable_methods.dart';
import '../../reusable/reusable_widgets.dart';
import '../../utils/color_util.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseApi notificationServices = FirebaseApi();
  String verificationId = '';
  String otp = '';
  String token = '';
  bool isCodeSent = false;

  final CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('users');
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _confirmPassTextController = TextEditingController();
  TextEditingController _userTextController = TextEditingController();
  TextEditingController _addressTextController = TextEditingController();
  TextEditingController _phoneNoTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Sign UP",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          hexStringtoColor("CD2B80"),
          hexStringtoColor("9546C4"),
          hexStringtoColor("5E40FA")
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
                20, MediaQuery.of(context).size.height * 0.2, 20, 0),
            child: Column(
              children: <Widget>[
                logoWidget("assets/images/signup.png"),
                textField("Enter Your UserName", Icons.person_outlined, false,
                    _userTextController),
                const SizedBox(
                  height: 20,
                ),
                textField("Enter Your Email", Icons.email_outlined, false,
                    _emailTextController),
                const SizedBox(
                  height: 20,
                ),
                textField("Enter Your Password", Icons.lock_outlined, true,
                    _passwordTextController),
                const SizedBox(
                  height: 20,
                ),
                textField("Confirm Password", Icons.lock_open_rounded, true,
                    _confirmPassTextController),
                const SizedBox(
                  height: 20,
                ),
                textField("Enter Your Phone Number", Icons.phone_outlined,
                    false, _phoneNoTextController),
                const SizedBox(
                  height: 20,
                ),
                textField("Enter Your Address", Icons.home_outlined, false,
                    _addressTextController),
                const SizedBox(
                  height: 20,
                ),
                reusableButton(
                  context,
                  false,
                  () async {
                    if (_userTextController.text.isNotEmpty &&
                        _emailTextController.text.isNotEmpty &&
                        _passwordTextController.text.isNotEmpty &&
                        _phoneNoTextController.text.isNotEmpty &&
                        _addressTextController.text.isNotEmpty) {
                      if (_passwordTextController.text ==
                          _confirmPassTextController.text) {
                        verifyPhoneNumber(_phoneNoTextController.text);
                        // await _verifyOTP();
                        showModalBottomSheet(
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30),
                              ),
                            ),
                            backgroundColor: Colors.blue.shade400,
                            context: context,
                            builder: (BuildContext context) {
                              return SingleChildScrollView(
                                child: Padding(
                                  padding: const EdgeInsets.all(18.0),
                                  child: SizedBox(
                                    height: 900,
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 20,
                                        ),
                                        imgContainer(
                                            'assets/images/otp.png', 200, 200),
                                        // if (isCodeSent)
                                        TextField(
                                          decoration: InputDecoration(
                                            prefixIcon: Icon(
                                              Icons.verified_outlined,
                                              color: Colors.black,
                                            ),
                                            labelText: "Enter OTP",
                                            labelStyle: TextStyle(
                                                color: Colors.black
                                                    .withOpacity(0.9)),
                                            filled: true,
                                            floatingLabelBehavior:
                                                FloatingLabelBehavior.never,
                                            fillColor:
                                                Colors.white.withOpacity(0.3),
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30.0),
                                                borderSide: const BorderSide(
                                                    width: 0,
                                                    style: BorderStyle.none)),
                                          ),
                                          keyboardType: TextInputType.number,
                                          onChanged: (value) {
                                            otp = value;
                                          },
                                          cursorColor: Colors.white,
                                          style: TextStyle(
                                              color: Colors.black87
                                                  .withOpacity(0.9)),
                                        ),
                                        SizedBox(height: 20),
                                        // if (isCodeSent)
                                        SizedBox(
                                          width: double.infinity,
                                          height: 50,
                                          child: ElevatedButton(
                                              style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateProperty
                                                          .resolveWith(
                                                              (states) {
                                                    if (states.contains(
                                                        MaterialState
                                                            .pressed)) {
                                                      return Colors.black26;
                                                    }
                                                    return Colors.white;
                                                  }),
                                                  shape:
                                                      MaterialStateProperty.all<
                                                          RoundedRectangleBorder>(
                                                    RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    (30))),
                                                  )),
                                              onPressed: () async {
                                                Navigator.of(context).pop();

                                                await _verifyOTP();
                                              },
                                              child: Text(
                                                "VERIFY OTP",
                                                style: const TextStyle(
                                                    color: Colors.black87,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16),
                                              )),
                                        ),
                                        SizedBox(height: 20),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            });
                      } else {
                        showErrorAlert(context,
                            'Password and Confirm password not Matched ');
                      }
                    } else {
                      showErrorAlert(context, 'Please Fill the All fields ');
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void insertUserData(
      String name, String email, String phoneNo, String address, String id) {
    notificationServices.getDeviceToken().then((value) {
      token = value;
    });
    collectionReference
        .doc(id)
        .set({
          'name': name,
          'email': email,
          'phoneNo': phoneNo,
          'isBlock': false,
          'address': address,
          'imgURL':
              "https://firebasestorage.googleapis.com/v0/b/campbelldecor-c2d1f.appspot.com/o/Users%2Fuser.png?alt=media&token=af8768f7-68e4-4961-892f-400eee8bae5d",
          'deviceTokenForNotification': token
        })
        .then((_) async {})
        .catchError((error) {
          print('Failed to store user data: $error');
        });
  }

  Future<void> verifyPhoneNumber(String phoneNumber) async {
    verified(AuthCredential authResult) {}

    verificationFailed(authException) {
      print('Verification failed: $authException');
      if (authException.toString() ==
          "[firebase_auth/too-many-requests] We have blocked all requests from this device due to unusual activity. Try again later.") {
        showInformation(context,
            "Looks like you've made several attempts. Take a short break and try again later. Thank you!");
      } else {
        showInformation(context,
            "Apologies for the inconvenience. Please attempt again later.");
      }
    }

    codeSent(String verificationId, [int? forceResendingToken]) {
      setState(() {
        this.verificationId = verificationId;
        this.isCodeSent = true;
      });
    }

    codeAutoRetrievalTimeout(String verificationId) {
      print('Verification timeout: $verificationId');
      showToast("Verification timeout,try again.");
    }

    await _auth.verifyPhoneNumber(
      phoneNumber: '+94 $phoneNumber',
      timeout: const Duration(seconds: 60),
      verificationCompleted: verified,
      verificationFailed: verificationFailed,
      codeSent: codeSent,
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
    );
  }

  Future<void> _verifyOTP() async {
    try {
      final AuthCredential phoneCredential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: otp,
      );

      final UserCredential userCredential =
          await _auth.signInWithCredential(phoneCredential);
      final User? user = userCredential.user;

      if (user != null) {
        final AuthCredential emailCredential =
            await EmailAuthProvider.credential(
          email: _emailTextController.text,
          password: _passwordTextController.text,
        );
        await user.linkWithCredential(emailCredential);

        await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: _emailTextController.text,
                password: _passwordTextController.text)
            .then((value) {
          insertUserData(
              _userTextController.text,
              _emailTextController.text,
              _phoneNoTextController.text,
              _addressTextController.text,
              FirebaseAuth.instance.currentUser!.uid);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
          );
        }).catchError((error) {
          if (error is FirebaseAuthException) {
            if (error.code == 'email-already-in-use') {
              showInformation(context,
                  'The email address is already in use by another account.');
            } else {
              print("Try again");
            }
          }
        });
      } else {
        print('User is null');
      }
    } catch (e) {
      print("Error: $e");
      if (e is FirebaseAuthException && e.code == 'provider-already-linked') {
        showInformation(
            context, "The email address is already in use by another account.");
      } else {
        showInformation(context, "An error occurred: $e");
      }
    }
  }
}
