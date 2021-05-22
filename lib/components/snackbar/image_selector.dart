import 'dart:io';

import 'package:etherwallet/constants/colors.dart';
import 'package:etherwallet/constants/syles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

class ImageSelector extends StatefulWidget {
  final ValueChanged valueChanged;
  final double width;
  final double height;

  ImageSelector({this.valueChanged, this.width, this.height});

  @override
  State<StatefulWidget> createState() => _ImageSelectorState();
}

class _ImageSelectorState extends State<ImageSelector> {
  File _image;
  final picker = ImagePicker();

  Future _getImage() async {
    final pickedFile = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        widget.valueChanged(_image);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _image == null ? _getImage : null,
      child: Container(
        height: widget.height,
        width: widget.width,
        color: ANColor.white.withOpacity(0.2),
        child: _image == null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    FontAwesomeIcons.cloudUploadAlt,
                    color: ANColor.primary,
                  ),
                  Divider(
                    color: Colors.transparent,
                  ),
                  Text(
                    'Choose from files',
                    style: header4.copyWith(color: ANColor.primary),
                  )
                ],
              )
            : Stack(
                children: [
                  Image.file(
                    _image,
                    fit: BoxFit.cover,
                    height: 250,
                  ),
                  Positioned(
                    right: 4.0,
                    bottom: 4.0,
                    child: FloatingActionButton(
                      onPressed: () {
                        setState(() {
                          _image = null;
                          widget.valueChanged(null);
                        });
                      },
                      mini: true,
                      backgroundColor: ANColor.primary,
                      child: Icon(
                        FontAwesomeIcons.solidTrashAlt,
                        color: ANColor.white,
                      ),
                    ),
                  )
                ],
              ),
      ),
    );
  }
}
