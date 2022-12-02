import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kimmy/core/utils/extensions.dart';

import '../component/app_bar/blur_app_bar.dart';
import 'global_props.dart';

Widget createTextFormField({
  String? Function(String value)? validator,
  required String labelText,
  String? hintText,
  bool nullable = false,
  Widget? suffixIcon,
  Widget? icon,
  TextEditingController? controller,
  int? maxLines,
  String? defaultValue,
  bool enabled = true,
  bool? obscureText,
  bool readOnly = false,
  void Function()? onTap,
  void Function(String)? onChanged
}) {
  controller = controller ?? TextEditingController();
  if(defaultValue!= null){
    controller.text = defaultValue;
  }
  if(labelText == "密码"&&obscureText == null) {
    obscureText = true;
  }
  return TextFormField(
    controller: controller,
    minLines: 1,
    maxLines: obscureText == true ? 1 :maxLines,
    enabled: enabled,
    obscureText: obscureText ?? false,
    readOnly: readOnly,
    onTap: onTap,
    onChanged: onChanged,
    validator: (value){
      if(!nullable){
        if(value == null || value == ""){
          return "$labelText 不可为空！";
        }
      }
      return validator==null ? null : validator(value!);
    },
    decoration: InputDecoration(
      contentPadding: const EdgeInsets.symmetric(vertical: 0,horizontal: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
      ),
      labelText: labelText,
      hintText: hintText,
      suffixIcon: suffixIcon,
      icon: icon,
    ),
  ).intoContainer(
    margin: const EdgeInsets.fromLTRB(6, 12, 6, 0)
  );
}