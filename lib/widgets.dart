import 'package:flutter/material.dart';
import 'value.dart';
import 'state.dart';
import 'package:provider/provider.dart';

//местное видео

//кнопка попробовать бесплатно
class ButtonFree extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(48),
          ),
          color: backgroundColorBut1,
          boxShadow: [
            BoxShadow(
              color: shadowBut1,
              offset: Offset(0, 2),
              blurRadius: 0,
            ),
          ]),
      child: MaterialButton(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        color: backgroundColorBut1,
        child:
            Text('Создание консультации', style: TextStyle(color: colorBut1)),
        onPressed: () {
          context.read<StateButton>().press(-1);
        },
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
            side: BorderSide(color: Colors.transparent)),
      ),
    );
  }
}

//контейнер нижнего bar
class ContainerBottomBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(
            top: 10, bottom: 10, left: widthScr * 0.1, right: widthScr * 0.1),
        height: 60,
        width: widthScr,
        decoration: BoxDecoration(
          border: Border.all(
            color: borderColorBottomBar,
            width: 1,
          ),
          color: backgroundColorBottomBar,
        ),
        child: ButtonFree());
  }
}
