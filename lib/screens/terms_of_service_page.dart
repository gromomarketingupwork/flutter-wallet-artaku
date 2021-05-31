import 'package:etherwallet/components/appbar/an_appbar.dart';
import 'package:etherwallet/components/button/an_button.dart';
import 'package:etherwallet/constants/an_assets.dart';
import 'package:etherwallet/constants/colors.dart';
import 'package:etherwallet/constants/syles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TermsOfServicePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
            child: Image.asset(ANAssets.mainBackgroundImage)),
        Scaffold(
          backgroundColor: ANColor.white.withOpacity(0.8),
          appBar: ANAppBarNew(
            appBar: AppBar(),
          ),
          body: Align(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 48),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  Text(
                    "TERMS OF SERVICE",
                    style: header2.copyWith(fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  Text(
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin laoreet leo ut purus condimentum gravida. Fusce lobortis, lacus a tristique accumsan, dui risus lobortis tellus, ut efficitur est lectus vitae urna. Vivamus tincidunt feugiat orci. Aliquam gravida dapibus porttitor. Praesent ultrices, elit semper interdum vulputate, elit risus ullamcorper neque, et feugiat erat sapien vitae lacus. Curabitur dolor lorem, interdum eget nisl eget, elementum hendrerit elit. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Mauris lorem neque, molestie et suscipit vitae, dapibus vitae dolor. Pellentesque mattis vehicula tellus, id condimentum erat hendrerit non.",
                    style: header4.copyWith(
                        color: ANColor.black.withOpacity(0.6),
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.2,
                  ),
                  ANButton(
                    label: 'CONTINUE',
                    width: 172,
                    height: 36,
                    buttonColor: ANColor.buttonPrimary,
                    borderRadius: 4,
                    textColor: ANColor.white,
                    onClick: () {
                      Navigator.of(context).pushNamed('/your-wallet');
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
