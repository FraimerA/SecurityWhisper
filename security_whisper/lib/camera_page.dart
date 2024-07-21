// ignore_for_file: curly_braces_in_flow_control_structures

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  File? _image;
  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('CAMERA'),
        ),
        body: _buildMainView());
  }

  Widget _buildMainView() {
    return Center(
      child: _buildImagePicker(),
    );
  }

  Widget _buildImagePicker() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: _showPickImageSourceDialog,
        child: Container(
          decoration:
              BoxDecoration(border: Border.all(color: Colors.blue, width: 2)),
          width: double.infinity,
          height: 400,
          child: _buildImageView(),
        ),
      ),
    );
  }

  Widget _buildImageView() {
    if (_image == null)
      return const Center(
        child: Icon(
          Icons.add_a_photo,
          size: 80,
          color: Colors.grey,
        ),
      );
    else
      return Image.file(
        File(_image!.path),
        fit: BoxFit.fill,
      );
  }

  Future _pickImageFromGallery() async {
    Navigator.of(context).pop();
    final image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null)
      setState(() {
        _image = File(image.path);
      });
  }

  Future _pickImageFromCamera() async {
    Navigator.of(context).pop();
    final image = await picker.pickImage(source: ImageSource.camera);
    if (image != null)
      setState(() {
        _image = File(image.path);
      });
  }

  void _showPickImageSourceDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(32.0))),
              title: const Text('Seleccionar Imagen:'),
              content: Row(
                children: <Widget>[
                  Expanded(
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(0),
                      leading: const Icon(
                        Icons.photo_library,
                        size: 40,
                      ),
                      title: const Text(
                        'Desde Galería',
                      ),
                      onTap: _pickImageFromGallery,
                    ),
                  ),
                  Expanded(
                      child: ListTile(
                    contentPadding: const EdgeInsets.all(0),
                    leading: const Icon(
                      Icons.camera_alt,
                      size: 40,
                    ),
                    title: const Text('Desde Cámara'),
                    onTap: _pickImageFromCamera,
                  )),
                ],
              ));
        });
  }
}
