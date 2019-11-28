import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:mall/core/constant.dart';
import 'package:mall/core/injection.dart';
import 'package:mall/core/util/localization/string_localization.dart';
import 'package:mall/core/util/nav.dart';
import 'package:mall/features/backend/presentation/user_view_model.dart';
import 'package:mall/features/theme/domain/entities/theme_entity.dart';
import 'package:mall/features/theme/presentation/theme_view_model.dart';

ListTile buildSignUpListTile(BuildContext context) {
  return ListTile(
    title: Text(string(context, 'title_sign_up_page')),
    onTap: () {
      locator<Nav>()
          .router
          .navigateTo(context, 'SignUpPage', transition: TransitionType.fadeIn);
    },
  );
}

ListTile buildChangeDisplayImageListTile(BuildContext context) {
  return ListTile(
    title: Text(string(context, 'label_change_display_picture')),
    onTap: () {
      locator<Nav>().router.navigateTo(context, 'ChangeDisplayPicturePage',
          transition: TransitionType.fadeIn);
    },
  );
}

ListTile buildChangeUsernameListTile(BuildContext context) {
  return ListTile(
    title: Text(string(context, 'label_change_username')),
    onTap: () {
      locator<Nav>().router.navigateTo(context, 'ChangeUsernamePage',
          transition: TransitionType.fadeIn);
    },
  );
}

ListTile buildChangePasswordListTile(BuildContext context) {
  return ListTile(
    title: Text(string(context, 'label_change_password')),
    onTap: () {
      locator<Nav>().router.navigateTo(context, 'ChangePasswordPage',
          transition: TransitionType.fadeIn);
    },
  );
}

ListTile buildChangeEmailAddressListTile(BuildContext context) {
  return ListTile(
    title: Text(string(context, 'label_change_email_address')),
    onTap: () {
      locator<Nav>().router.navigateTo(context, 'ChangeEmailPage',
          transition: TransitionType.fadeIn);
    },
  );
}

ListTile buildSignOutListTile(
    BuildContext context, UserViewModel userViewModel) {
  return ListTile(
    title: Text(string(context, 'label_sign_out')),
    onTap: () async {
      await userViewModel.signOut();
      locator<Nav>().router.navigateTo(context, 'AuthPage',
          clearStack: true, transition: TransitionType.fadeIn);
    },
  );
}

ListTile buildThemeListTile(
    BuildContext context, ThemeViewModel themeViewModel) {
  return ListTile(
    title: Text(string(context, 'label_change_theme')),
    subtitle: Padding(
      padding: const EdgeInsets.fromLTRB(0, sizeLarge, 0, 0),
      child: ToggleButtons(
        children: _themeRow(context),
        onPressed: (int index) {
          themeViewModel.setTheme(ThemeType.values[index], notify: true);
        },
        isSelected: _themeSelectedStatus(themeViewModel.getLastTheme().type),
      ),
    ),
  );
}

List<Widget> _themeRow(BuildContext context) {
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

List<bool> _themeSelectedStatus(ThemeType themeType) {
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
