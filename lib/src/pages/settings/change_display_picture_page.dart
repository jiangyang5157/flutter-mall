import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_button/flutter_progress_button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mall/src/core/constant.dart';
import 'package:mall/src/utils/utils.dart';
import 'package:mall/src/widgets/three_size_dot.dart';

class ChangeDisplayPicturePage extends StatefulWidget {
  ChangeDisplayPicturePage({Key key}) : super(key: key);

  @override
  _ChangeDisplayPicturePageState createState() =>
      _ChangeDisplayPicturePageState();
}

//https://github.com/flutter/plugins/blob/master/packages/image_picker/example/lib/main.dart
class _ChangeDisplayPicturePageState extends State<ChangeDisplayPicturePage> {
  File _displayPictureFile;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
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
                    padding: const EdgeInsets.fromLTRB(
                        sizeLarge, sizeLarge, sizeLarge, 0),
                    child: SizedBox(),
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
