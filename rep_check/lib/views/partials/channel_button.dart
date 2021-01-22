import 'package:flutter/material.dart';
import 'package:rep_check/utils/constants.dart';
import 'package:rep_check/utils/enums.dart';

// ignore: must_be_immutable
class ChannelButton extends StatelessWidget {
  //required
  /// [buttonType] sets the style and icons of the button.
  ButtonType buttonType;

  //required
  /// [onPressed] Send a function to trigger the button.
  Function onPressed;

  //not required, default left
  /// [imagePosition] set the position of the icon.(left or right)
  ImagePosition imagePosition;

  //not required, default 5.0
  /// [elevation] set the button's elevation value.
  double elevation;

  //not required, Gets value according to buttonType.
  /// [btnColor] Set the background color of the button.
  Color btnColor;

  //not required, Gets value according to buttonType.
  /// [btnTextColor] set the button's text color.
  Color btnTextColor;

  //not required, Gets value according to buttonType.
  /// [btnText] set the button's text.
  String btnText;

  //not required, Gets value according to buttonSize.
  /// You can change the value of [width] when the text size becomes too small.
  double width;

  //not required, Gets value according to buttonSize.
  /// [padding] set the button's padding value.
  double padding;

  /// [_image] value cannot be assigned.Gets value according to [buttonType].
  Widget _image;

  /// [_fontSize] value cannot be assigned.Gets value according to [buttonSize].
  double _fontSize;

  /// [_imageSize] value cannot be assigned.Gets value according to [buttonSize].
  double _imageSize;

  //not required, button shape.
  /// [shape] set the button's shape.
  ShapeBorder shape;

  //not required, button model.
  /// [mini] It automatically takes value according to the selected constructor.
  bool mini;

  ChannelButton({
    @required this.buttonType,
    @required this.onPressed,
    this.imagePosition: ImagePosition.left,
    this.btnColor,
    this.btnTextColor,
    this.btnText,
    this.elevation: 5.0,
    this.width,
    this.padding,
    this.shape,
  })  : mini = false,
        assert(onPressed != null, 'onPressed is null!'),
        assert(buttonType != null, 'buttonType is null');

  ChannelButton.mini({
    @required this.buttonType,
    @required this.onPressed,
    this.btnColor,
    this.elevation: 5.0,
    this.padding,
  })  : mini = true,
        assert(onPressed != null, 'onPressed is null!'),
        assert(buttonType != null, 'buttonType is null');

  @override
  Widget build(BuildContext context) {
    _setButtonSize();
    _createStyle();
    return !mini
        ? MaterialButton(
            color: btnColor,
            shape: shape ?? StadiumBorder(),
            onPressed: onPressed,
            elevation: elevation,
            child: Container(
              width: width,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: imagePosition == ImagePosition.left
                    ? MainAxisAlignment.start
                    : MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.all(padding),
                    child: imagePosition == ImagePosition.left
                        ? _image
                        : Text(
                            btnText,
                            style: TextStyle(
                              fontSize: _fontSize,
                              color: btnTextColor,
                            ),
                          ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(padding),
                    child: imagePosition == ImagePosition.left
                        ? Text(
                            btnText,
                            style: TextStyle(
                              fontSize: _fontSize,
                              color: btnTextColor,
                            ),
                          )
                        : _image,
                  ),
                ],
              ),
            ),
          )
        : MaterialButton(
            onPressed: onPressed,
            color: btnColor,
            child: _image,
            elevation: elevation,
            padding: EdgeInsets.all(padding),
            shape: CircleBorder(),
          );
  }

  void _setButtonSize() {
    padding ??= !mini ? 5.5 : 6.5;
    width ??= 220;
    _fontSize = 17.0;
    _imageSize = !mini ? 28.0 : 34.0;
  }

  void _createStyle() {
    switch (buttonType) {
      case ButtonType.facebook:
        btnText ??= 'Facebook';
        btnTextColor ??= Colors.white;
        btnColor ??= Colors.blueAccent;
        _image = Image.asset(
          Constants.facebookKey,
          width: _imageSize,
          height: _imageSize,
        );
        break;

      case ButtonType.github:
        btnText ??= 'Github';
        btnTextColor ??= Colors.black87;
        btnColor ??= Colors.white;
        _image = Image.asset(
          Constants.githubKey,
          width: _imageSize,
          height: _imageSize,
        );
        break;

      case ButtonType.apple:
        btnText ??= 'Apple';
        btnTextColor ??= Colors.black;
        btnColor ??= Color(0xfff7f7f7);
        _image = Image.asset(
          Constants.appleKey,
          width: _imageSize,
          height: _imageSize,
        );
        break;

      case ButtonType.twitter:
        btnText ??= 'Twitter';
        btnTextColor ??= Colors.white;
        btnColor ??= Colors.lightBlueAccent;
        _image = Image.asset(
          Constants.twitterKey,
          width: _imageSize,
          height: _imageSize,
        );
        break;

      case ButtonType.google:
        btnText ??= 'Google';
        btnTextColor ??= Colors.black;
        btnColor ??= Color(0xfff7f7f7);
        _image = Image.asset(
          Constants.googleKey,
          width: _imageSize,
          height: _imageSize,
        );
        break;

      case ButtonType.youtube:
        btnText ??= 'Youtube';
        btnTextColor ??= Colors.white;
        btnColor ??= Color(0xded63447);
        _image = Image.asset(
          Constants.youtubeKey,
          width: _imageSize,
          height: _imageSize,
        );
        break;

      case ButtonType.microsoft:
        btnText ??= 'Microsoft';
        btnTextColor ??= Colors.white;
        btnColor ??= Color(0xff424874);
        _image = Image.asset(
          Constants.microsoftKey,
          width: _imageSize,
          height: _imageSize,
        );
        break;

      case ButtonType.mail:
        btnText ??= 'Mail';
        btnTextColor ??= Colors.white;
        btnColor ??= Color(0xff20639b);
        _image = Image.asset(
          Constants.mailKey,
          width: _imageSize,
          height: _imageSize,
        );
        break;

      case ButtonType.yahoo:
        btnText ??= 'Yahoo';
        btnTextColor ??= Colors.white;
        btnColor ??= Color(0xff7c5295);
        _image = Image.asset(
          Constants.yahooKey,
          width: _imageSize,
          height: _imageSize,
        );
        break;

      case ButtonType.amazon:
        btnText ??= 'Amazon';
        btnTextColor ??= Colors.black87;
        btnColor ??= Colors.white;
        _image = Image.asset(
          Constants.amazonKey,
          width: _imageSize,
          height: _imageSize,
        );
        break;

      case ButtonType.web:
        btnText ??= 'Official Website';
        btnTextColor ??= Colors.black87;
        btnColor ??= Colors.white;
        _image = Image.asset(
          Constants.webKey,
          width: _imageSize,
          height: _imageSize,
        );
        break;
    }
  }
}
