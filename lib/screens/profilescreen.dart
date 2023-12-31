import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taxiapp/controller/auth_controller.dart';
import 'package:taxiapp/screens/homeScreen.dart';
import 'package:taxiapp/widget/custombutton.dart';
import 'package:taxiapp/widget/greenintroWidget.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController homeController = TextEditingController();
  final TextEditingController businessController = TextEditingController();
  final TextEditingController shopController = TextEditingController();
  final ImagePicker _imagePicker = ImagePicker();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  File? _imageFile;
  AuthController authController = Get.find<AuthController>();
  Future<void> getImage(ImageSource source) async {
    try {
      final XFile? image = await _imagePicker.pickImage(source: source);
      if (image != null) {
        setState(() {
          _imageFile = File(image.path);
        });
      }
    } catch (e) {
      // Handle any errors that occur during image selection
      print("Error selecting image: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ClipPath(
              clipper: CurvedClipper(), // Custom clipper
              child: Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.2,
                decoration: BoxDecoration(
                  color: Colors.green, // Change color to your desired color
                ),
                child: Image.asset('assets/logo.png'),
              ),
            ),
            GestureDetector(
              onTap: () {
                getImage(ImageSource.gallery);
              },
              child: Container(
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey[200],
                  image: _imageFile != null
                      ? DecorationImage(
                          image: FileImage(_imageFile!),
                          fit: BoxFit.cover,
                        )
                      : null,
                ),
                child: _imageFile == null
                    ? Icon(
                        Icons.camera_alt,
                        size: 50.0,
                        color: Colors.grey[600],
                      )
                    : Container(),
              ),
            ),
            Container(
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    SizedBox(height: 20.0),
                    _buildTextField(nameController, 'Name'),
                    SizedBox(height: 10.0),
                    _buildTextField(homeController, 'Home Address'),
                    SizedBox(height: 10.0),
                    _buildTextField(businessController, 'Business Address'),
                    SizedBox(height: 10.0),
                    _buildTextField(shopController, 'Shop Address'),
                    SizedBox(height: 20.0),
                    Obx(
                      () => authController.isProfileUploading.value
                          ? Center(child: CircularProgressIndicator())
                          : customButton(
                              text: 'Save Profile',
                              onTap: () {
                                if (_imageFile == null) {
                                  Get.snackbar(
                                      'Warning', 'Please Upload Image');
                                  return;
                                }
                                authController.isProfileUploading(true);
                                authController.storeUserInfo(
                                    _imageFile!,
                                    nameController.text,
                                    homeController.text,
                                    businessController.text,
                                    shopController.text);
                              },
                            ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String labelText) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextFormField(
        controller: controller,
        validator: (val) {
          if (val == null || val.isEmpty) {
            return 'Enter your $labelText';
          }
          return null;
        },
        style: TextStyle(
          fontSize: 16.0,
          color: Colors.black,
        ),
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(
            color: Colors.green, // Change label text color to green
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.green, // Change border color to green
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.green, // Change focused border color to green
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
    );
  }
}
