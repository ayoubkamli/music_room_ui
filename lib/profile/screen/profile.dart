import 'package:flutter/material.dart';
import 'package:myapp/constant/constant.dart';
import 'package:myapp/events/widgets/future_image.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// backgroundColor: Colors.black,
      appBar: getAppBar('Profile'),
      body: getBody(context),
    );
  }
}

PreferredSizeWidget getAppBar(String title) {
  return AppBar(
      automaticallyImplyLeading: true,
      title: Text(title),
      leading: IconButton(
        icon: Icon(Icons.home),
        onPressed: () {
          //
        },
      ));
}

getBody(BuildContext context) {
  double width = MediaQuery.of(context).size.width;
  return SingleChildScrollView(
    //
    scrollDirection: Axis.vertical,
    child: Column(
      children: [
        FutureBuilder<String>(
          future: getImageUrl(imageUrl),
          builder: (context, snapshot) {
            //
            if (snapshot.hasData) {
              return Container(
                height: 250,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                        snapshot.data!,
                      ),
                      fit: BoxFit.cover),
                  color: Colors.green,

                  /// borderRadius: BorderRadius.circular(10),
                ),
              );
            }
            return CircularProgressIndicator();
          },
        ),
        Container(
          color: Colors.green,
          width: width,
          child: TextButton(
              onPressed: () => {},
              child: Text(
                'Edit Profile Picture',
                style: TextStyle(color: Colors.white),
              )),
        ),
        _loginForm(),
      ],
    ),
  );
}

Widget _loginForm() {
  return Form(
    /// key: _formKey,
    child: Padding(
      padding: EdgeInsets.all(40.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _emailField(),

          /// _passwordField(),
          /// _loginButton(),
        ],
      ),
    ),
  );
}

Widget _emailField() {
  /// return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
  return TextFormField(
    keyboardType: TextInputType.emailAddress,
    decoration:
        InputDecoration(icon: Icon(Icons.email), hintText: 'Email@eample.com'),

    /// validator: (value) => state.isValidEmail ? null : 'Invalid email',
    /// onChanged: (value) => context.read<LoginBloc>().add(
    ///       LoginEmailChanged(email: value),
    ///     ),
    /// onChanged: ,
  );

  /// });
}
