import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';

class Sellcar extends StatefulWidget {
  const Sellcar({super.key});

  @override
  State<Sellcar> createState() => _SellcarState();
}

class _SellcarState extends State<Sellcar> {
  final userid = FirebaseAuth.instance.currentUser?.uid;
  final _formKey = GlobalKey<FormState>();
  final _makeController = TextEditingController();
  final _modelController = TextEditingController();
  final _variantController = TextEditingController();
  final _priceController = TextEditingController();
  final _detailsController = TextEditingController();
  final _imageController = TextEditingController();
  final _carnameController = TextEditingController();
  File? _image;
  bool _isLoading = false;

  Future<void> _pickImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

  void _clearFormFields() {
    _makeController.clear();
    _modelController.clear();
    _variantController.clear();
    _priceController.clear();
    _detailsController.clear();
    _imageController.clear();
    _carnameController.clear();
  }

  Future<String> _uploadImage(File image) async {
    final storageRef = FirebaseStorage.instance
        .ref()
        .child('files')
        .child('${DateTime.now()}.jpg');
    final uploadTask = storageRef.putFile(image);
    final snapshot = await uploadTask.whenComplete(() {});
    final downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<void> _postAd() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    try {
      String? imageUrl;
      if (_image != null) {
        imageUrl = await _uploadImage(_image!);
      }

      CollectionReference collRef =
          FirebaseFirestore.instance.collection('ads');
      await collRef.add({
        'image': _imageController.text,
        'make': _makeController.text,
        'model': _modelController.text,
        'variant': _variantController.text,
        'price': _priceController.text,
        'details': _detailsController.text,
        'carname': _carnameController.text,
        'sellerid': userid,
        'createdAt': Timestamp.now(),
      });
      _clearFormFields();
    } catch (e) {
      // Handle errors here
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Sell your Car'),
        backgroundColor: Color.fromARGB(255, 151, 0, 0),
      ),
      body: Container(
        color: Colors.black,
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: Container(
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(16.0),
            ),
            height: 400,
            width: 600,
            child: Center(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: _pickImage,
                          child: Container(
                            width: 170,
                            height: 100,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.add, size: 30),
                                  Text('Add Picture'),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 80),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildTextFormField(
                                'Enter Car Name',
                                'Please enter Car name',
                                _carnameController,
                                300),
                            SizedBox(height: 8),
                            _buildTextFormField('Enter Make',
                                'Please enter Make', _makeController, 300),
                            SizedBox(height: 8),
                            _buildTextFormField('Enter Model',
                                'Please enter Model', _modelController, 300),
                            SizedBox(height: 8),
                            _buildTextFormField(
                                'Enter Variant',
                                'Please enter Variant',
                                _variantController,
                                300),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        _buildTextFormField('Enter Price', 'Please enter Price',
                            _priceController, 150),
                        SizedBox(width: 16),
                        _buildTextFormField('Enter Details',
                            'Please enter Details', _detailsController, 300,
                            height: 60, maxLines: 3),
                      ],
                    ),
                    SizedBox(height: 50),
                    ElevatedButton(
                      onPressed: _isLoading ? null : _postAd,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 151, 0, 0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: _isLoading
                          ? CircularProgressIndicator(color: Colors.black)
                          : Text(
                              'Post Ad',
                              style: TextStyle(color: Colors.black),
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextFormField(String hint, String validationMessage,
      TextEditingController controller, double width,
      {double height = 30, int maxLines = 1}) {
    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(
        color: Colors.grey[400],
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
          hintText: hint,
          border: InputBorder.none,
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return validationMessage;
          }
          return null;
        },
      ),
    );
  }
}
