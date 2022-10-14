import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:stick_it/stick_it.dart';
import 'package:testdemocamera/circulariconbutton.dart';
import 'package:uuid/uuid.dart';

class AdvancedExample extends StatefulWidget {
  const AdvancedExample({Key? key}) : super(key: key);
  static String routeName = 'advanced-example';
  static String routeTitle = 'Advanced Example';

  @override
  _AdvancedExampleState createState() => _AdvancedExampleState();
}

class _AdvancedExampleState extends State<AdvancedExample> {
  final String _background =
      'https://images.unsplash.com/photo-1545147986-a9d6f2ab03b5?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=934&q=80';

  final _picker = ImagePicker();

  late StickIt _stickIt;

  File? _image;

  @override
  Widget build(BuildContext context) {
    double bottomPadding = MediaQuery.of(context).size.height / 4;
    double rightPadding = MediaQuery.of(context).size.width / 12;
    double boxSize = 56.0;
    _stickIt = StickIt(
      stickerList: [
        Image.asset(
          'assets/img/emo2.png',
          height: 500,
          width: 500,
          fit: BoxFit.cover,
        ),
        Image.asset('assets/img/new.png'),
        Image.asset("assets/img/emo1.png"),
        Image.asset("assets/img/emo3.png"),
        Image.asset("assets/img/emo4.png"),
        Image.asset("assets/img/emo5.png"),
        Image.asset("assets/img/emo6.png"),
        Image.asset("assets/img/emo7.png"),
      ],
      key: UniqueKey(),
      panelHeight: 175,
      panelBackgroundColor: Colors.white,
      panelStickerBackgroundColor: Theme.of(context).primaryColorLight,
      stickerSize: 100,
      child: _image == null
          ? Image.network(_background)
          : Image.file(_image!, fit: BoxFit.cover),
    );

    return Scaffold(
      body: Stack(
        children: [
          _stickIt,
          Positioned(
              top: 50,
              child: InkWell(
                onTap: () {
                  setState(() {
                    _image = null;
                  });
                },
                child: const Icon(
                  Icons.cancel,
                  size: 50,
                ),
              )
              // IconButton(
              //   onPressed: () {},

              // )
              ),
          Positioned(
            bottom: bottomPadding,
            right: rightPadding,
            child: Column(
              children: [
                CircularIconButton(
                  onTap: () async {
                    final image = await _stickIt.exportImage();
                    final directory = await getApplicationDocumentsDirectory();
                    final path = directory.path;
                    final uniqueIdentifier = const Uuid().v1();
                    final file =
                        await File('$path/$uniqueIdentifier.png').create();
                    file.writeAsBytesSync(image);
                    GallerySaver.saveImage(file.path,
                            albumName: 'Emoji Editor Techdock')
                        .then((value) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        backgroundColor: Colors.green,
                        content: Text("Saved in Your Galary"),
                      ));
                    });
                  },
                  boxColor: Colors.deepOrange,
                  boxWidth: boxSize,
                  boxHeight: boxSize,
                  iconWidget: const Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 36,
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                CircularIconButton(
                  onTap: () {
                    generateModal(context);
                  },
                  boxWidth: boxSize,
                  boxHeight: boxSize,
                  iconWidget: const Icon(
                    Icons.camera,
                    color: Colors.white,
                  ),
                  boxColor: Colors.deepOrange,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future getImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    } else {
      print('No image selected.');
    }
  }

  void generateModal(BuildContext context) {
    showModalBottomSheet<void>(
      backgroundColor: Colors.deepOrange,
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 128,
          color: Colors.deepOrange,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Expanded(
                  child: InkWell(
                    onTap: () {
                      getImage(ImageSource.gallery);
                      Navigator.pop(context);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.photo,
                          color: Colors.deepOrange,
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        SizedBox(
                          width: 200,
                          child: Text('Select img from gallery'),
                        )
                      ],
                    ),
                  ),
                ),
                const Divider(
                  height: 2,
                  indent: 64,
                  endIndent: 64,
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      getImage(ImageSource.camera);
                      Navigator.pop(context);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.camera_alt,
                          color: Theme.of(context).primaryColor,
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        const SizedBox(
                          width: 200,
                          child: Text('Select img from camera'),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
