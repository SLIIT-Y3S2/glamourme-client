import 'package:flutter/material.dart';
import 'package:flutter_app/app_locale.dart';
import 'package:flutter_app/blocs/authentication/authentication_bloc.dart';
import 'package:flutter_app/globals.dart';
import 'package:flutter_app/screens/profile_language_overview_screen.dart';
import 'package:flutter_app/widgets/profile_screen_list_item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';

class ProfileIndexScreen extends StatelessWidget {
  const ProfileIndexScreen({Key? key}) : super(key: key);

  void _signOut(BuildContext context) {
    BlocProvider.of<AuthenticationBloc>(context).add(const SignOutEvent());
    if (profileNavigatorKey.currentState!.canPop()) {
      profileNavigatorKey.currentState!.pop();
    }
  }

  // Navigate to ProfileLanguageOverviewScreen
  // TODO To be changed later
  void _navigateToProfileLanguageOverviewScreen(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => ProfileLanguageOverviewScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: profileNavigatorKey,
        appBar: AppBar(title: Text(AppLocale.profile.getString(context))),
        body: ListView(
          children: <Widget>[
            ProfileScreenListItem(
              title: AppLocale.yourFavourites.getString(context),
              leadingIcon: Icons.favorite_outline,
              onTapFunc: null,
              subtitle: AppLocale.yourFavouritesDescription.getString(context),
              trailingIcon: Icons.arrow_forward_ios,
            ),
            ProfileScreenListItem(
              title: AppLocale.language.getString(context),
              leadingIcon: Icons.language,
              onTapFunc: () =>
                  _navigateToProfileLanguageOverviewScreen(context),
              subtitle: AppLocale.languageDescription.getString(context),
              trailingIcon: Icons.arrow_forward_ios,
            ),
            ProfileScreenListItem(
              title: AppLocale.payments.getString(context),
              leadingIcon: Icons.credit_card,
              onTapFunc: null,
              subtitle: AppLocale.paymentsDescription.getString(context),
              trailingIcon: Icons.arrow_forward_ios,
            ),
            ProfileScreenListItem(
              title: AppLocale.signout.getString(context),
              leadingIcon: Icons.logout,
              onTapFunc: () => _signOut(context),
              subtitle: '',
              trailingIcon: Icons.arrow_forward_ios,
              isSignOutButton: true,
            ),
            //Sign out button
          ],
        ));
  }
}
