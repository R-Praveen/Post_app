import 'package:flutter/material.dart';
import 'package:posts_app/blocs/profile_bloc.dart';
import 'package:posts_app/local_database/app_database.dart';
import 'package:posts_app/screens/login.dart';
import 'package:posts_app/theme/colors.dart';
import 'package:posts_app/theme/text_styles.dart';
import 'package:provider/provider.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<ProfileBloc>(context);
    return StreamBuilder<User>(
      stream: bloc.userDetails,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox();
        } else {
          return _Body(user: snapshot.data as User);
        }
      },
    );
  }
}

class _Body extends StatelessWidget {
  final User user;
  const _Body({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<ProfileBloc>(context);
    bloc.isUserLoggedOut.listen((value) async {
      if (value) {
        Navigator.of(context).pushNamedAndRemoveUntil(
          Login.route,
          (Route<dynamic> route) => false,
        );
      }
    });
    return Scaffold(
      backgroundColor: AppColors.black,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _getHeader(context),
            _getContent(
              context,
              user,
            ),
            _logOut(bloc, context),
          ],
        ),
      ),
    );
  }

  Widget _getHeader(BuildContext context) {
    return Container(
      color: AppColors.tundora,
      alignment: Alignment.center,
      height: MediaQuery.of(context).size.height * 0.15,
      padding: EdgeInsets.only(
        left: MediaQuery.of(context).size.width * 0.05,
        top: MediaQuery.of(context).size.height * 0.05,
      ),
      child: Row(
        children: [
          CircleAvatar(
            child: Image.asset("lib/assets/profile.png"),
            radius: 30,
            backgroundColor: AppColors.tundora,
            foregroundColor: AppColors.tundora,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.02,
          ),
          Text(
            "User Profile",
            style: TextStyles.textFieldTitle().copyWith(fontSize: 22),
          ),
        ],
      ),
    );
  }

  Widget _getContent(BuildContext context, User user) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.05,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionHeading(context, "Basic Information"),
          _getItem("Name", user.name),
          _getItem("Email", user.email),
          _getItem("Password", user.password),
          _getItem("Phone Number", user.phoneNumber),
          _getItem("Website", user.website),
          _getItem("Company", user.companyName),
          _sectionHeading(context, "Address Information"),
          _getItem("Street", user.street),
          _getItem("Suite", user.suite),
          _getItem("City", user.city),
          _getItem("Zip Code", user.zipCode),
        ],
      ),
    );
  }

  Widget _sectionHeading(BuildContext context, String heading) {
    return Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).size.width * 0.08),
      child: Text(
        heading.toUpperCase(),
        style: TextStyles.profileItemValueStyle(),
      ),
    );
  }

  Widget _getItem(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyles.profileItemTitleStyle(),
          ),
          Text(
            value,
            style: TextStyles.profileItemValueStyle(),
          ),
        ],
      ),
    );
  }

  Widget _logOut(ProfileBloc bloc, BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.05,
      ),
      child: Material(
        color: AppColors.transparent,
        child: InkWell(
          onTap: () {
            bloc.logOut();
          },
          child: _sectionHeading(context, "Log out"),
        ),
      ),
    );
  }
}
