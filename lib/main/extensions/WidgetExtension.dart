import 'package:flutter/material.dart';

extension WidgetExtension on Widget{
  Future launch<T>(BuildContext context, {bool isNewTask = false}) async{
    if(this is StatefulWidget || this is StatelessWidget){
      if(isNewTask){
        return await Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (builder)=> this), (route) => route == null);
      }else{
        return await Navigator.of(context).push(MaterialPageRoute<T>(builder: (_)=> this));
      }
    }else{
      throw Exception('This ought be a stateless or stateful widget');
    }
  }

  Widget visible(bool visible , {Widget? defaultWidget})
  => visible ? this: defaultWidget ?? SizedBox();


  // default container with set width and optional height parameter
  Widget defaultContainer(double width, {double? height}){
    return Container(
      width: width,
      child: this,
    );
  }

  // add expand to parent widget
  Widget expand({flex = 1})=> Expanded(child: this, flex: flex,);

}