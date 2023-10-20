import 'package:flutter/material.dart';
import 'package:flutter_app/blocs/authentication/authentication_bloc.dart';
import 'package:flutter_app/globals.dart';
import 'package:flutter_app/screens/profile_language_overview_screen.dart';
import 'package:flutter_app/widgets/language_selector.dart';
import 'package:flutter_app/widgets/profile_screen_list_item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
        appBar: AppBar(title: Text(AppLocalizations.of(context)!.profile)),
        body: ListView(
          children: <Widget>[
            ProfileScreenListItem(
              title: AppLocalizations.of(context)!.yourFavourites,
              leadingIcon: Icons.favorite_outline,
              onTapFunc: null,
              subtitle: AppLocalizations.of(context)!.yourFavouritesDescription,
              trailingIcon: Icons.arrow_forward_ios,
            ),
            LanguageSelector(
              title: AppLocalizations.of(context)!.language,
              leadingIcon: Icons.language,
              subtitle: AppLocalizations.of(context)!.languageDescription,
            ),
            ProfileScreenListItem(
              title: AppLocalizations.of(context)!.payments,
              leadingIcon: Icons.credit_card,
              onTapFunc: null,
              subtitle: AppLocalizations.of(context)!.paymentsDescription,
              trailingIcon: Icons.arrow_forward_ios,
            ),
            ProfileScreenListItem(
              title: AppLocalizations.of(context)!.signout,
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
