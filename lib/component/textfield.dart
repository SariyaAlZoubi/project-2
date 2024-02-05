import 'package:flutter/material.dart';


Widget textFormFieldCompany({
  required TextEditingController controller,
  required String hintText,
  double ?height,
  double ?width

}) {
  return TextFormField(

    textDirection: TextDirection.rtl,
    keyboardType: hintText=='ادخل رقم الهاتف '?TextInputType.number:TextInputType.text,
    controller: controller,
    style:  TextStyle(
      fontFamily: "Cairo",
      fontSize: height!*0.013+width!*0.009,
    ),
    cursorColor: Colors.teal,
    decoration: InputDecoration(

      filled: true,
      fillColor: Colors.grey.shade100,
      contentPadding:  EdgeInsets.only(left: height*0.02+width*0.01,right: height*0.018+width*0.01,top: height*0.013+width*0.006,bottom: height*0.013+width*0.006),
      hintText: hintText,
      hintTextDirection: TextDirection.rtl,
      hintStyle: TextStyle(
          fontSize: height*0.015,
          fontFamily: "Cairo",
          fontWeight: FontWeight.w400,
          color: Colors.grey.shade900),
      labelStyle: const TextStyle(
          fontWeight: FontWeight.w400, fontSize: 14, color: Colors.black),
      enabledBorder: OutlineInputBorder(
        borderSide:  const BorderSide(color: Colors.teal, width: 2),
        borderRadius: BorderRadius.circular(40),
      ),
      floatingLabelStyle: const TextStyle(
        color: Colors.black,
        fontSize: 18.0,
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.blueGrey, width: 1.5),
        borderRadius: BorderRadius.circular(40.0),
      ),
    ),
  );
}
