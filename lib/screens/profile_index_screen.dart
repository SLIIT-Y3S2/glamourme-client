import 'package:flutter/material.dart';
import 'package:flutter_app/blocs/authentication/authentication_bloc.dart';
import 'package:flutter_app/globals.dart';
import 'package:flutter_app/widgets/profile_screen_list_item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileIndexScreen extends StatelessWidget {
  const ProfileIndexScreen({Key? key}) : super(key: key);
  void _signOut(BuildContext context) {
    BlocProvider.of<AuthenticationBloc>(context).add(const SignOutEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: profileNavigatorKey,
        appBar: AppBar(title: const Text('Profile')),
        body: ListView(
          children: <Widget>[
            ProfileScreenListItem(
              title: 'Your Favorites',
              leadingIcon: Icons.favorite_outline,
              onTap: null,
              subtitle: 'Reorder your favorite services in a click',
              trailingIcon: Icons.arrow_forward_ios,
            ),
            ProfileScreenListItem(
              title: 'Your Favorites',
              leadingIcon: Icons.favorite_outline,
              onTap: null,
              subtitle: 'Reorder your favorite services in a click',
              trailingIcon: Icons.arrow_forward_ios,
            ),
            ProfileScreenListItem(
              title: 'Your Favorites',
              leadingIcon: Icons.favorite_outline,
              onTap: null,
              subtitle: 'Reorder your favorite services in a click',
              trailingIcon: Icons.arrow_forward_ios,
            ),
            ProfileScreenListItem(
              title: 'Signout',
              leadingIcon: Icons.logout,
              onTap: _signOut,
              subtitle: '',
              trailingIcon: Icons.arrow_forward_ios,
              isSignOutButton: true,
            ),
            //Sign out button
          ],
        ));
  }
}
