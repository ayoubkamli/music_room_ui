import 'package:flutter/material.dart';
import 'package:myapp/constant/constant.dart';
import 'package:myapp/events/widgets/future_image.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  // final _formKey = GlobalKey<FormState>();
  // List<String> selectedPrefList = [];

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
        _profileForm(),
      ],
    ),
  );
}

Widget _profileForm() {
  return Form(
    // key: _formKey,
    child: Padding(
      padding: EdgeInsets.all(40.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _emailField(),
          _usernameField(),
          _shipSelect()

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

Widget _usernameField() {
  return TextField(
    decoration:
        InputDecoration(icon: Icon(Icons.verified_user), hintText: 'username'),
  );
}

Widget _shipSelect() {
  // return BlocBuilder<CreateEventBloc, CreateEventState>(
  //   builder: (context, state) {
  return Padding(
    padding: const EdgeInsets.only(top: 20.0),
    child: Center(
      child: Column(
        children: [
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  side: BorderSide(color: Colors.green),
                ),
              ),
            ),
            child: Text(
              'Add preferences',
              style: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
            onPressed: () => {
              // _showPrefDialog(),
              // context
              //     .read<CreateEventBloc>()
              //     .add(CreateEventPrefChanged(prefs: selectedPrefList))
            },
          ),
          // Text(selectedPrefList.join(" , ")),
        ],
      ),
    ),
  );
  //   },
  // );
}

// _showPrefDialog() {
//   showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Preferences'),
//           content: MultiSelectChip(
//             prefList,
//             selectedPrefList,
//             onSelectionChanged: (selectedList) {
//               setState(() {
//                 selectedPrefList = selectedList;
//               });
//             },
//           ),
//           actions: <Widget>[
//             TextButton(
//               onPressed: () => Navigator.of(context).pop(),
//               child: Text('Add'),
//             ),
//           ],
//         );
//       });
// }
