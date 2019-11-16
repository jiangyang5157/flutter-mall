import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_button/flutter_progress_button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mall/constant.dart';
import 'package:mall/core/util/localization/string_localization.dart';
import 'package:mall/core/util/widgets/three_size_dot.dart';

class ChangeDisplayPicturePage extends StatefulWidget {
  ChangeDisplayPicturePage({Key key}) : super(key: key);

  @override
  _ChangeDisplayPicturePageState createState() =>
      _ChangeDisplayPicturePageState();
}

class _ChangeDisplayPicturePageState extends State<ChangeDisplayPicturePage> {
  File _displayPictureFile;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _displayPictureFile = image;
    });
  }

  @override
  void dispose() {
    super.dispose();
    print('#### _ChangeDisplayPicturePageState - dispose');
  }

  @override
  void initState() {
    super.initState();
    print('#### _ChangeDisplayPicturePageState - initState');
  }

  @override
  Widget build(BuildContext context) {
    print('#### _ChangeDisplayPicturePageState - build');

    return Scaffold(
      appBar: AppBar(
        title: Text(string(context, 'title_change_display_picture_page')),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, sizeLarge, 0, 0),
                    child: GestureDetector(
                      onTap: () {
                        getImage();
                      },
                      child: Container(
                        width: userDisplayPictureSize,
                        height: userDisplayPictureSize,
                        child: Card(
                          child: _displayPictureFile == null
                              ? Container()
                              : Image.file(_displayPictureFile),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, sizeNormal, 0, 0),
                    child: ButtonBar(
                      mainAxisSize: MainAxisSize.max,
                      alignment: MainAxisAlignment.end,
                      children: <Widget>[
                        ProgressButton(
                          defaultWidget: Text(string(context, 'label_confirm')),
                          progressWidget: ThreeSizeDot(),
                          width: lrBtnWidth,
                          animate: false,
                          onPressed: () async {
                            return () {};
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
