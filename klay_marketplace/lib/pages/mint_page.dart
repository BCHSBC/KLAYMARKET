import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:dotted_border/dotted_border.dart';

class MintPage extends StatefulWidget {
  const MintPage({super.key});

  @override
  State<MintPage> createState() => _MintPageState();
}

class _MintPageState extends State<MintPage> {
  final _pickedImages = <Image>[];

  String _imageInfo = '';

  Future<void> _pickImage() async {
    final fromPicker = await ImagePickerWeb.getImageAsWidget();
    if (fromPicker != null) {
      setState(() {
        _pickedImages.clear();
        _pickedImages.add(fromPicker);
      });
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                width: double.infinity,
                padding: EdgeInsets.only(left:15),
                margin: EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Mint your Art',
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'FOUR',
                            fontSize: 32)),
                    Text(
                      'File types supported: JPG,JPEG,PNG,GIF',
                      style: TextStyle(
                          color: Colors.grey, fontFamily: 'FOUR', fontSize: 10),
                    ),
                  ],
                )),
            Container(
                padding: EdgeInsets.only(left:15),
                height: 257,
                width: 350,
                child: DottedBorder(
                  child: Container(
                    child: Center(
                      child:IconButton(
                      onPressed: () async{
                        _pickImage();
                      },
                      icon: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color:Colors.white.withOpacity(0.6),
                          shape: BoxShape.circle
                        ),
                        child: Icon(
                          CupertinoIcons.camera,
                          color:Colors.white,
                        ),
                      )
                    ),
                    ),
                    decoration: _pickedImages.length == 1 ?
                    BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: _pickedImages[0].image,
                      )
                    ):null,
                  ),
                  color: Colors.grey,
                  dashPattern: [5, 3],
                  borderType: BorderType.RRect,
                  radius: Radius.circular(10),
                ))
          ],
        ),
      ),
    );
  }
}
