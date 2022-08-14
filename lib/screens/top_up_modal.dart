import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:klik/main/extensions/WidgetExtension.dart';
import 'package:klik/main/utils/AppColors.dart';
import 'package:klik/screens/KAHomeScreen.dart';





class TopUpModalPage extends StatefulWidget {
  final String url;
  TopUpModalPage({Key? key, required this.url}) : super(key: key);

  @override
  State<TopUpModalPage> createState() => _TopUpModalPageState();
}

class _TopUpModalPageState extends State<TopUpModalPage> {

  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      url: widget.url,
      withJavascript: true,
      withZoom: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: appWhite,
        actions: [
          IconButton(onPressed: (){
            int count = 0;
            Navigator.of(context).popUntil((_) => count++ >= 2);
          }, icon: Icon(Icons.close_outlined, color: appBlueWidget, size: 30,))
        ],
      ),
      initialChild: Center(
        child: SpinKitThreeBounce(
          itemBuilder: (BuildContext context, int index) {
            return DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: index.isEven ? Colors.red : Colors.green,
              ),
            );
          },
        ),
      ),
    );
  }
}
