import 'package:flutter/material.dart';
import 'package:klik/main/utils/AppColors.dart';
import 'package:klik/main/utils/AppConstant.dart';


Widget raisedButton(Function () onPressed, String? btnText, double? width, double? heigth){
  return Container(
    width: width,
    height: heigth,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 10),
        shadowColor: appShadowColor.withOpacity(0.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5)
        ),
        elevation: 5,
        primary: appButtonColor,
        onPrimary: appWhite,
      ),
      onPressed: onPressed,
      child: Text(
        btnText!,
        style: const TextStyle(
          color: appWhite,
          fontSize: 18,
        ),
      ),
    ),
  );
}
Widget shadowTextField(TextEditingController _controller, String labelText){
  return  Container(
    height: 50,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(8.0)),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.1),
          spreadRadius: 5,
          blurRadius: 7,
          offset: Offset(0, 5), // changes position of shadow
        ),
      ],
    ),
    child: TextField(
      controller: _controller,
      autofocus: false,
      cursorColor: appTextColorSecondary,
      //  keyboardType: TextInputType.emailAddress,
     // textInputAction: TextInputAction.go,
      decoration: InputDecoration(
        border: InputBorder.none,
        focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            borderSide: BorderSide(color: Colors.white)

        ),
        contentPadding: const EdgeInsets.only( left: 32.0, right: 10.0),
        labelText: labelText,
        labelStyle: const TextStyle(
          color: Colors.black54,
          fontSize: 15,
        ),
      ),
    ),
  );
}
Widget shadowPasswordField(TextEditingController _controller, String labelText, bool showPassword, Function () onTap){
  return  Container(
    height: 50,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(8.0)),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.1),
          spreadRadius: 5,
          blurRadius: 7,
          offset: Offset(0, 5), // changes position of shadow
        ),
      ],
    ),
    child: TextField(
      controller: _controller,
      autofocus: false,
      obscureText: showPassword,
      cursorColor: appTextColorSecondary,
      //keyboardType: TextInputType.text,
     // textInputAction: TextInputAction.go,
      decoration: InputDecoration(
        border: InputBorder.none,
        focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            borderSide: BorderSide(color: Colors.white)

        ),
        contentPadding: const EdgeInsets.only( left: 32.0, right: 10.0),
        labelText: labelText,
        labelStyle: const TextStyle(
          color: Colors.black54,
          fontSize: 15,
        ),
        suffixIcon: GestureDetector(
          onTap: onTap(),
          child: Icon(showPassword ? Icons.visibility : Icons.visibility_off, size: 20, color: Colors.black54,),
        )
      ),
    ),
  );
}
Widget backButton(BuildContext context)=> Align(
  alignment: Alignment.topCenter,
  child: Container(
      height: 40,
      width: 40,
      decoration: const BoxDecoration(
          color: backNavBg,
          shape: BoxShape.circle
      ),
      child: Center(child: IconButton(onPressed: (){finish(context);}, icon: Image.asset('assets/images/icons/bkNavIcon.png', height: 20, width: 25,)))),
);


