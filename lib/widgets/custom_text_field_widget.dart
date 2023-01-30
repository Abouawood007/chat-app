import 'package:flutter/material.dart';

Widget customTextFormField({
  String? hintText,
  TextEditingController? controller,
  String? Function(String?)? validate,
  VoidCallback? suffixFunction,
  String? Function(String?)? onSavedFunction,
  IconData? prefixIcon,
  IconData? suffixIcon,
  TextInputType? keyboardType,
  bool isPassword = false,
  Function(String)? onChanged
})=> TextFormField(
  style: const TextStyle(color:Colors.white),
    onChanged: onChanged,
    onSaved: onSavedFunction,
    obscureText: isPassword,
    keyboardType: keyboardType,
    controller: controller,
    validator: validate,
    decoration: InputDecoration(
        prefixIcon: Icon(prefixIcon,color: Colors.white),
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.white),
        suffixIcon: suffixIcon != null ?
        IconButton(
          onPressed: suffixFunction,
          icon: Icon(suffixIcon,color: Colors.white,),
        )
            : null,
        contentPadding: const EdgeInsets.all(10),
        enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(5)),
        border: OutlineInputBorder(borderSide: const BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(5))));

