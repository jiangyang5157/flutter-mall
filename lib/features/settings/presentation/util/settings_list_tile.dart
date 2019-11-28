import 'package:flutter/material.dart';
import 'package:mall/core/constant.dart';
import 'package:mall/core/util/localization/string_localization.dart';
import 'package:mall/features/theme/domain/entities/theme_entity.dart';
import 'package:mall/features/theme/presentation/theme_view_model.dart';

ListTile buildThemeListTile(
    BuildContext context, ThemeViewModel themeViewModel) {
  return ListTile(
    title: Text(string(context, 'label_change_theme')),
    subtitle: Padding(
      padding: const EdgeInsets.fromLTRB(0, sizeLarge, 0, 0),
      child: ToggleButtons(
        children: _themeTypeWidgets(context),
        onPressed: (int index) {
          themeViewModel.setTheme(ThemeType.values[index], notify: true);
        },
        isSelected:
            _themeTypeSelectedStatus(themeViewModel.getLastTheme().type),
      ),
    ),
  );
}

List<Widget> _themeTypeWidgets(BuildContext context) {
  var ret = List<Widget>();
  for (int i = 0; i < ThemeType.values.length; i++) {
    switch (ThemeType.values[i]) {
      case ThemeType.Light:
        ret.add(
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.brightness_high),
              SizedBox(width: sizeSmall),
              Text(string(context, 'label_light_theme')),
            ],
          ),
        );
        break;
      case ThemeType.Dark:
        ret.add(
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.brightness_low),
              SizedBox(width: sizeSmall),
              Text(string(context, 'label_dark_theme')),
            ],
          ),
        );
        break;
    }
  }
  return ret;
}

List<bool> _themeTypeSelectedStatus(ThemeType themeType) {
  var ret = List<bool>();
  for (int i = 0; i < ThemeType.values.length; i++) {
    if (ThemeType.values[i] == themeType) {
      ret.add(true);
    } else {
      ret.add(false);
    }
  }
  return ret;
}
