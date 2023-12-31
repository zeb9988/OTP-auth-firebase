import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:taxiapp/screens/homeScreen.dart';
import 'package:taxiapp/screens/profilescreen.dart';

class AuthController extends GetxController {
  String userId = '';
  var verifyId = '';
  int? resendToken;
  bool phoneAuthCheck = false;
  dynamic credentials;

  phoneAuth(String phone) async {
    try {
      credentials = null;

      await FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: phone,
          timeout: Duration(seconds: 60),
          verificationCompleted: (PhoneAuthCredential credential) async {
            print('completed');
            credentials = credential;
            await FirebaseAuth.instance.signInWithCredential(credential);
          },
          forceResendingToken: resendToken,
          verificationFailed: (FirebaseAuthException e) {
            print(e);
          },
          codeSent: (String verificationId, int? resendtoken) async {
            verifyId = verificationId;
            resendToken = resendtoken;
          },
          codeAutoRetrievalTimeout: (String verificationId) {});
    } catch (e) {
      print(e);
    }
  }

  verifyOtp(String otpNumber) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verifyId, smsCode: otpNumber);
    print('looged in');
    await FirebaseAuth.instance.signInWithCredential(credential).then((value) {
      decideRoute();
    });
  }

  decideRoute() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get()
          .then((value) {
        if (value.exists) {
          Get.to(() => HomeScreen());
        } else {
          Get.to(() => ProfileScreen());
        }
      });
    }
  }

  Future<String> uploadImage(File? imageFile) async {
    if (imageFile == null) {
      return ''; // Return an empty URL or handle null imageFile gracefully
    }

    String imgUrl = '';
    String filename = imageFile.path;
    try {
      final ref = FirebaseStorage.instance.ref().child('users/$filename');
      final uploadTask = ref.putFile(imageFile);
      final taskSnapshot = await uploadTask.whenComplete(() => null);
      imgUrl = await taskSnapshot.ref.getDownloadURL();
    } catch (e) {
      // Handle any errors that occur during image upload
      print("Error uploading image: $e");
    }
    return imgUrl;
  }

  var isProfileUploading = false.obs;
  Future<void> storeUserInfo(File _imageFile, String name, String home,
      String business, String shop) async {
    if (_imageFile == null) {
      // Handle the case where no image is selected
      return;
    }

    try {
      String url = await uploadImage(_imageFile);
      String uid = FirebaseAuth.instance.currentUser!.uid;
      await FirebaseFirestore.instance.collection('users').doc(uid).set({
        'image': url,
        'name': name,
        'home_address': home,
        'business_address': business,
        'shop_address': shop
      });

      isProfileUploading(true);

      Get.to(() => HomeScreen());
    } catch (e) {
      // Handle any errors that occur during user info storage
      print("Error storing user info: $e");
    }
  }
}
