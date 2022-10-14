import 'package:flutter/material.dart';

class Emoji extends StatefulWidget {
  const Emoji({Key? key}) : super(key: key);

  @override
  State<Emoji> createState() => _EmojiState();
}

class _EmojiState extends State<Emoji> {
  bool _isDropped = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LongPressDraggable<String>(
              // Data is the value this Draggable stores.
              data: "red",
              feedback: Material(
                child: Container(
                  height: 170.0,
                  width: 170.0,
                  decoration: const BoxDecoration(
                    color: Colors.redAccent,
                  ),
                  child: const Center(
                    child: Text(
                      'Dragging',
                      textScaleFactor: 2,
                    ),
                  ),
                ),
              ),
              childWhenDragging: Container(
                height: 150.0,
                width: 150.0,
                color: Colors.grey,
                child: const Center(
                  child: Text(
                    'I was here',
                    textScaleFactor: 2,
                  ),
                ),
              ),
              child: Container(
                height: 150.0,
                width: 150.0,
                color: Colors.redAccent,
                child: const Center(
                  child: Text(
                    'Drag me',
                    textScaleFactor: 2,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.15,
            ),
            DragTarget<String>(
              builder: (
                BuildContext context,
                List<dynamic> accepted,
                List<dynamic> rejected,
              ) {
                return Card(
                  // borderType: BorderType.RRect,
                  // radius: const Radius.circular(12),
                  // padding: const EdgeInsets.all(6),
                  // color: Colors.white,
                  // strokeWidth: 2,
                  // dashPattern: [8],
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                    child: Container(
                      height: 200,
                      width: 200,
                      color: _isDropped ? Colors.redAccent : null,
                      child: Center(
                          child: Text(
                        !_isDropped ? 'Drop here' : 'Dropped',
                        textScaleFactor: 2,
                      )),
                    ),
                  ),
                );
              },
              onAccept: (data) {
                debugPrint('hi $data');
                setState(() {
                  _isDropped = true;
                });
              },
              onWillAccept: (data) {
                return data == "red";
              },
              onLeave: (data) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  backgroundColor: Colors.green,
                  content: Text("Saved in Your Galary"),
                ));
              },
            ),
          ],
        ),
      ),
    ));
  }
}
