import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;

class InputImage extends StatefulWidget {
  final Function? onSelectImage;

  const InputImage({Key? key, this.onSelectImage }) : super(key: key);

  @override
  _InputImageState createState() => _InputImageState();
}

class _InputImageState extends State<InputImage> {
  File? _selectedImage;
  
  Future<void> _selectPicture() async {
    final picker = ImagePicker();
    final imgFile =  await picker.pickImage(
        source: ImageSource.camera,
        maxWidth: 600,
    );
    // Nothing captured
    if(imgFile==null)
      {
        return ;
      }
    setState(() {
      _selectedImage= File(imgFile.path);
    });
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final fileName = path.basename(imgFile.path);
    final savedImage = await File(imgFile.path).copy('${appDir.path}/$fileName');
    widget.onSelectImage!(savedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 150,
          height: 150,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.grey,
            ),
          ),
          child: _selectedImage != null
              ? Image.file(
                  _selectedImage!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                )
              : Text(
                  'No Image Taken',
                  textAlign: TextAlign.center,
                ),
          alignment: Alignment.center,
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: TextButton.icon(
            icon: Icon(Icons.camera),
            onPressed: _selectPicture,
            label: Text("Take Picture"),
            style: TextButton.styleFrom(
              primary: Theme.of(context).primaryColor,
            ),
          ),
        ),
      ],
    );
  }
}
