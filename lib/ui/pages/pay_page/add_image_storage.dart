import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_beats/ui/pages/page.dart';
import 'dart:math' as math;
import 'package:multi_image_picker/multi_image_picker.dart';

class AddImageStorage extends StatefulWidget {
  final ListCountImage listCountImage;

  const AddImageStorage({required this.listCountImage});

  @override
  _AddImageStorageState createState() => _AddImageStorageState();
}
typedef void ListCountImage(int count);
class _AddImageStorageState extends State<AddImageStorage> {

  List<Asset> images = <Asset>[];

  Future<void> loadAssets() async {
    List<Asset> resultList = <Asset>[];
    String error = 'No Error Detected';
    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 100,
        enableCamera: true,
        selectedAssets: images,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          statusBarColor: "#E82F08",
          actionBarColor: "#E82F08",
          actionBarTitle: "Image",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
      CardPaymentLocalPage.of(context)!.listImage = (resultList.length);
    } on Exception catch (e) {
      error = e.toString();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please ${e.toString()}!')));
      CardPaymentLocalPage.of(context)!.listImage = (resultList.length);
    }
    if (!mounted) return;

    setState(() {
      images = resultList;
      // _error = error;
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Row(
      children: [
        Expanded(
          child:
            Stack(
              children: <Widget>[
                Container(
                    width: width * .25,
                    height: width * .25,
                    child: DashedRect(
                      color: Colors.black,
                      strokeWidth: 2.0,
                      gap: 5.0,
                    )),
                Container(
                  width: width * .25,
                  height: width * .25,
                  child: MaterialButton(
                    color: Colors.black12,
                    elevation: 0.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(width * .025),
                    ),
                    onPressed: () => loadAssets(),
                    child: Text(
                      'Thêm hình ảnh',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black54,
                          fontSize: width * .035,
                          letterSpacing: 1.5,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ],
            ),
          flex: 2,
        ),
        Expanded(
          child: Container(
              height: width * .25,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  physics: Platform.isAndroid
                      ? ClampingScrollPhysics()
                      : BouncingScrollPhysics(),
                  itemCount: images.length,
                  itemExtent: width*.3,
                  itemBuilder: (context, index) {
                    Asset asset = images[index];
                    return Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: AssetThumb(
                        quality: 80,
                        asset: asset,
                        width: 300,
                        height: 300,
                      ),
                    );
                  })),
          flex: 4,
        )
      ],
    );
  }
}

class DashedRect extends StatelessWidget {
  final Color color;
  final double strokeWidth;
  final double gap;

  DashedRect(
      {this.color = Colors.black, this.strokeWidth = 1.0, this.gap = 5.0});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.all(strokeWidth / 2),
        child: CustomPaint(
          painter:
              DashRectPainter(color: color, strokeWidth: strokeWidth, gap: gap),
        ),
      ),
    );
  }
}

class DashRectPainter extends CustomPainter {
  double strokeWidth;
  Color color;
  double gap;

  DashRectPainter(
      {this.strokeWidth = 5.0, this.color = Colors.red, this.gap = 5.0});

  @override
  void paint(Canvas canvas, Size size) {
    Paint dashedPaint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    double x = size.width;
    double y = size.height;

    Path _topPath = getDashedPath(
      a: math.Point(0, 0),
      b: math.Point(x, 0),
      gap: gap,
    );

    Path _rightPath = getDashedPath(
      a: math.Point(x, 0),
      b: math.Point(x, y),
      gap: gap,
    );

    Path _bottomPath = getDashedPath(
      a: math.Point(0, y),
      b: math.Point(x, y),
      gap: gap,
    );

    Path _leftPath = getDashedPath(
      a: math.Point(0, 0),
      b: math.Point(0.001, y),
      gap: gap,
    );

    canvas.drawPath(_topPath, dashedPaint);
    canvas.drawPath(_rightPath, dashedPaint);
    canvas.drawPath(_bottomPath, dashedPaint);
    canvas.drawPath(_leftPath, dashedPaint);
  }

  Path getDashedPath({
    required math.Point<double> a,
    required math.Point<double> b,
    required gap,
  }) {
    Size size = Size(b.x - a.x, b.y - a.y);
    Path path = Path();
    path.moveTo(a.x, a.y);
    bool shouldDraw = true;
    math.Point currentPoint = math.Point(a.x, a.y);

    num radians = math.atan(size.height / size.width);

    num dx = math.cos(radians) * gap < 0
        ? math.cos(radians) * gap * -1
        : math.cos(radians) * gap;

    num dy = math.sin(radians) * gap < 0
        ? math.sin(radians) * gap * -1
        : math.sin(radians) * gap;

    while (currentPoint.x <= b.x && currentPoint.y <= b.y) {
      shouldDraw
          ? path.lineTo(currentPoint.x.toDouble(), currentPoint.y.toDouble())
          : path.moveTo(currentPoint.x.toDouble(), currentPoint.y.toDouble());
      shouldDraw = !shouldDraw;
      currentPoint = math.Point(
        currentPoint.x + dx,
        currentPoint.y + dy,
      );
    }
    return path;
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
