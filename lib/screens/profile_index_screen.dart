import 'package:flutter/material.dart';
import 'package:flutter_app/blocs/authentication/authentication_bloc.dart';
import 'package:flutter_app/globals.dart';
import 'package:flutter_app/widgets/profile_screen_list_item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileIndexScreen extends StatelessWidget {
  const ProfileIndexScreen({Key? key}) : super(key: key);

  void _signOut(BuildContext context) {
    BlocProvider.of<AuthenticationBloc>(context).add(const SignOutEvent());
    if (profileNavigatorKey.currentState!.canPop()) {
      profileNavigatorKey.currentState!.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: profileNavigatorKey,
        appBar: AppBar(title: const Text('Profile')),
        body: ListView(
          children: <Widget>[
            const ProfileScreenListItem(
              title: 'Your Favorites',
              leadingIcon: Icons.favorite_outline,
              onTapFunc: null,
              subtitle: 'Reorder your favorite services in a click',
              trailingIcon: Icons.arrow_forward_ios,
            ),
            const ProfileScreenListItem(
              title: 'Language',
              leadingIcon: Icons.language,
              onTapFunc: null,
              subtitle: 'Select Your Language',
              trailingIcon: Icons.arrow_forward_ios,
            ),
            const ProfileScreenListItem(
              title: 'Payments',
              leadingIcon: Icons.credit_card,
              onTapFunc: null,
              subtitle: 'Reorder your favorite services in a click',
              trailingIcon: Icons.arrow_forward_ios,
            ),
            ProfileScreenListItem(
              title: 'Signout',
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
