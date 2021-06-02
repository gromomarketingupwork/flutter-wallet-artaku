import 'package:etherwallet/constants/colors.dart';
import 'package:etherwallet/constants/syles.dart';
import 'package:flutter/material.dart';

class ANButton extends StatelessWidget {
  final String label;
  final Function onClick;
  final bool disabled;
  final bool loading;
  final double borderRadius;
  final double height;
  final Color buttonColor;
  final Color textColor;
  final double width;

  const ANButton(
      {Key key,
      this.label,
      this.onClick,
      this.disabled,
      this.loading,
      this.width = double.infinity,
      this.borderRadius = 10,
      this.height = 42,
      this.buttonColor = ANColor.secondary,
      this.textColor = ANColor.textPrimary})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        color: buttonColor,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            if (null != this.onClick) {
              this.onClick();
            }
          },
          child: Container(
            alignment: Alignment.center,
            height: height,
            width: width,
            child: Text(
              this.label ?? "Button",
              style: header5.copyWith(color: textColor, fontWeight: FontWeight.w500),
            ),
          ),
        ),
      ),
    );
  }
}

class DTIconButton extends StatelessWidget {
  final String label;
  final Function onClick;
  final bool disabled;
  final bool loading;
  final double borderRadius;
  final double height;
  final Color buttonColor;
  final Color iconColor;
  final Widget icon;
  final double width;

  const DTIconButton(
      {Key key,
      this.label,
      this.onClick,
      this.icon,
      this.disabled,
      this.loading,
      this.width = double.infinity,
      this.borderRadius = 10,
      this.height = 42,
      this.buttonColor = Colors.transparent,
      this.iconColor = ANColor.textPrimary})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          if (null != onClick) {
            onClick();
          }
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 6, horizontal: 6),
          child: this.icon ??
              SizedBox(
                height: 0,
                width: 0,
              ),
        ),
      ),
    ));
  }
}

class ANOutlinedButton extends StatelessWidget {
  final String label;
  final Function onClick;
  final bool disabled;
  final bool loading;
  final double borderRadius;
  final double height;
  final Color buttonColor;
  final Color iconColor;
  final Widget icon;
  final double width;
  final Color textColor;
  final Color borderColor;

  const ANOutlinedButton(
      {Key key,
      this.label,
      this.onClick,
      this.icon,
      this.disabled,
      this.loading,
      this.width = double.infinity,
      this.borderRadius = 10,
      this.height = 42,
        this.borderColor = ANColor.black,
      this.buttonColor = Colors.transparent,
      this.textColor = ANColor.textPrimary,
      this.iconColor = ANColor.textPrimary})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            color: buttonColor,
            border: Border.all(width: 1, color: borderColor)
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              if (null != onClick) {
                onClick();
              }
            },
            child: Container(
                width: width,
                height: height,
                padding: EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    this.icon ??
                        SizedBox(
                          height: 0,
                          width: 0,
                        ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        child: Text(
                          this.label ?? "Button",
                          style: header5.copyWith(color: textColor, fontWeight: FontWeight.w600),
                        ),
                      ),
                    )
                  ],
                )),
          ),
        ));
  }
}
