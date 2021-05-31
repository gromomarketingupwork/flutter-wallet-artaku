import 'package:etherwallet/constants/an_assets.dart';
import 'package:etherwallet/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ANAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Color backgroundColor = ANColor.primary;
  final AppBar appBar;
  final Widget wallet;

  ANAppBar({Key key, @required this.appBar, this.wallet}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      primary: true,
      elevation: 0,
      leading: Builder(
        builder: (context) => IconButton(
            icon: Icon(
              FontAwesomeIcons.arrowLeft,
              size: 22,
            ),
            onPressed: () => Navigator.of(context).pop()),
      ),
      actions: [
        Image.asset(ANAssets.appLogo),
        SizedBox(
          width: wallet == null
              ? MediaQuery.of(context).size.width * 0.3
              : MediaQuery.of(context).size.width * 0.21,
        ),
        wallet != null
            ? Padding(padding: EdgeInsets.only(right: 12), child: wallet)
            : SizedBox()
      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => new Size.fromHeight(60);
}

class ANAppBarNew extends StatelessWidget implements PreferredSizeWidget {
  final Color backgroundColor = ANColorNew.primary;
  final AppBar appBar;
  final Widget wallet;

  ANAppBarNew({Key key, @required this.appBar, this.wallet}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      primary: true,
      elevation: 0,
      leading: Builder(
        builder: (context) => IconButton(
            icon: Icon(
              FontAwesomeIcons.arrowLeft,
              size: 22,
            ),
            onPressed: () => Navigator.of(context).pop()),
      ),
      actions: [
        Container(
            height: 24,
            width: 144,
            child: Image.asset(ANAssets.appMainLogoWhite)),
        SizedBox(
          width: wallet == null
              ? MediaQuery.of(context).size.width * 0.3
              : MediaQuery.of(context).size.width * 0.21,
        ),
        wallet != null
            ? Padding(padding: EdgeInsets.only(right: 12), child: wallet)
            : SizedBox()
      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => new Size.fromHeight(60);
}
