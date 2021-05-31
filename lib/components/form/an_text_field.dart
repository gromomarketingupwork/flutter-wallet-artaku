import 'dart:ffi';

import 'package:etherwallet/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class ANTextFormField extends StatelessWidget {
  final ValueChanged<dynamic> onChange;
  final String attribute;
  final Key key;
  final Function validator;
  final dynamic initialValue;
  final Color fillColor;
  final String placeholder;
  final String hintText;
  final bool readOnly;
  final String prefixText;
  final double width;
  final TextInputType keyboardType;
  final TextEditingController textCtrl;
  final List<TextInputFormatter> inputFormatters;
  final TextCapitalization textCapitalization;
  final TextInputAction textInputAction;
  final Widget suffixIcon;
  final bool obscureText;
  final int maxLines;
  final double borderRadius;
  final String labelText;

  const ANTextFormField({
    this.onChange,
    this.key,
    this.initialValue,
    this.fillColor,
    this.placeholder = "",
    this.hintText = "",
    this.labelText = "",
    this.borderRadius = 12.0,
    this.readOnly = false,
    this.obscureText = false,
    this.prefixText,
    this.keyboardType = TextInputType.name,
    this.textCtrl,
    this.suffixIcon,
    this.inputFormatters,
    this.width,
    this.maxLines = 1,
    this.textCapitalization = TextCapitalization.none,
    this.textInputAction = TextInputAction.next,
    this.attribute,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    TextEditingController textCtrl = TextEditingController(text: initialValue);
    textCtrl.selection = TextSelection.fromPosition(
        TextPosition(offset: textCtrl.text?.length ?? 0));
    return FormBuilderField(
        key: key,
        name: this.attribute,
        validator: this.validator,
        builder: (FormFieldState<dynamic> state) => Container(
              width: width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    inputFormatters: inputFormatters,
                    keyboardType: keyboardType,
                    obscureText: obscureText,
                    textCapitalization: textCapitalization,
                    textInputAction: textInputAction,
                    cursorHeight: 20,
                    maxLines: maxLines,
                    // textAlign: TextAlign.center,
                    readOnly: readOnly,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(11),
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: ANColor.white,
                      hintText: hintText,
                      // suffixText: suffixText,
                      suffixIcon: suffixIcon,
                      prefixText: prefixText,
                      counterText: "",
                        labelText: labelText,
                      hintStyle:
                          TextStyle(color: Colors.black.withOpacity(0.6), fontStyle: FontStyle.italic, fontSize: 20),
                      labelStyle: TextStyle(height: 1),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
                        borderSide: BorderSide(
                            width: 1, color: ANColor.black.withOpacity(0.12)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
                        borderSide: BorderSide(
                            width: 1, color: ANColorNew.primary.withOpacity(0.12)),
                      ),
                      // focusedBorder: InputBorder.none
                    ),
                    controller: textCtrl,
                    onChanged: (val) {
                      if (null != state) {
                        state.didChange(val);
                      }
                      if (onChange != null) {
                        onChange(val);
                      }
                    },
                  ),
                  if (null != state && state.hasError)
                    Text(
                      state.errorText ?? "",
                      style: TextStyle(fontSize: 12, color: Colors.red),
                    )
                ],
              ),
            ));
  }
}

class ANTextField extends FormField<dynamic> {
  ANTextField(
      {FormFieldSetter<dynamic> onSaved,
      FormFieldValidator<int> validator,
      final ValueChanged<dynamic> onChange,
      dynamic initialValue,
      Color fillColor,
      String placeholder = "",
      String hintText = "",
      bool readOnly = false,
      String prefixText,
      double width,
      double height,
      TextInputType keyboardType = TextInputType.name,
      TextEditingController textCtrl,
      List<TextInputFormatter> inputFormatters,
      TextCapitalization textCapitalization = TextCapitalization.none,
      TextInputAction textInputAction = TextInputAction.next})
      : super(
          onSaved: onSaved,
          validator: validator,
          initialValue: initialValue,
          builder: (FormFieldState<dynamic> state) {
            print("dropdown state  ${state.value}");
            textCtrl = TextEditingController(text: initialValue);
            textCtrl.selection = TextSelection.fromPosition(
                TextPosition(offset: textCtrl.text?.length ?? 0));
            return Container(
              width: width,
              height: height,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    inputFormatters: inputFormatters,
                    keyboardType: keyboardType,
                    textCapitalization: textCapitalization,
                    textInputAction: textInputAction,
                    readOnly: readOnly,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(11),
                      border: InputBorder.none,
                      filled: true,
                      fillColor: fillColor != null ? fillColor : ANColor.white,
                      hintText: hintText,
                      // suffixText: suffixText,
                      // suffixIcon: suffixIcon,
                      prefixText: prefixText,
                      counterText: "",
                      hintStyle:
                          TextStyle(color: Colors.black.withOpacity(0.5)),
                      labelStyle: TextStyle(height: 1),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                        borderSide: BorderSide(
                            width: 1, color: ANColor().textSecondary),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                        borderSide: BorderSide(
                            width: 1, color: ANColor().textSecondary),
                      ),
                      // focusedBorder: InputBorder.none
                    ),
                    controller: textCtrl,
                    onChanged: (val) {
                      state.didChange(val);
                      if (onChange != null) {
                        onChange(val);
                      }
                      // textCtrl.text = v;
                    },
                  ),
                  if (state.hasError)
                    Text(
                      state.errorText ?? "",
                      style: TextStyle(fontSize: 12, color: Colors.red),
                    )
                ],
              ),
            );
          },
        );
}
