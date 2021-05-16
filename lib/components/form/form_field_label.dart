import 'package:etherwallet/constants/colors.dart';
import 'package:etherwallet/constants/syles.dart';
import 'package:flutter/material.dart';

class FormFieldLabel extends StatelessWidget {
  final String label;
  final bool isRequired;
  TextStyle style = header4;
  FormFieldLabel({Key key, this.label, this.isRequired = false, this.style})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              style: style ?? formFieldLabel.copyWith(color: ANColor.white),
              children: <TextSpan>[
                TextSpan(
                  text: this.label ?? "",
                ),
                if (isRequired)
                  TextSpan(
                    text: ' *',
                    style: TextStyle(
                        color: ANColor.danger, fontWeight: FontWeight.normal),
                  ),
              ],
            ),
          ),
          // Row(
          //   children: [
          //     Expanded(
          //       child: Text(
          //         this.label ?? "",
          //         style: style ?? formFieldLabel,
          //       ),
          //     ),
          //     if (isRequired)
          //       Text(
          //         "*",
          //         style: TextStyle(color: DTColor.danger),

          //         //danger used for now just to differentiate color
          //       )
          //   ],
          // ),
          SizedBox(
            height: 6,
          ),
        ],
      ),
    );
  }
}
