import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/auth/models/user.dart';
import 'package:myapp/constant/constant.dart';
import 'package:myapp/events/widgets/future_image.dart';
import 'package:myapp/formStatus/form_submission_status.dart';
import 'package:myapp/profile/bloc/edit_profile_bloc.dart';
import 'package:myapp/profile/bloc/edit_profile_event.dart';
import 'package:myapp/profile/bloc/edit_profile_state.dart';
import 'package:myapp/profile/repository/profile_repository.dart';
import 'package:myapp/widgets/multi_select_chip.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({Key? key}) : super(key: key);

  @override
  _EditProfileViewState createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  final _formKey = GlobalKey<FormState>();
  final UserData profile = UserData();
  List<String> selectedPrefList = [];
  late Future<UserData> userProfile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(),
      body: BlocProvider(
        create: (context) => EditProfileBloc(
          profileRepository: context.read<ProfileRepository>(),
        ),
        child: getBody(),
      ),
    );
  }

  PreferredSizeWidget getAppBar() {
    return AppBar(
      backgroundColor: Colors.black,
      elevation: 0,
      title: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Edit Profile",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                )),
            Icon(Icons.list)
          ],
        ),
      ),
    );
  }

  getBody() {
    return BlocBuilder<EditProfileBloc, EditProfileState>(
      builder: (context, state) {
        // context.read<EditProfileBloc>().add(
        //     //
        //     );
        context.read<EditProfileBloc>().add(EditProfileInitialEvent());

        return SingleChildScrollView(
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [_editProfileForm()],
          ),
        );
      },
    );
  }

  Widget _editProfileForm() {
    return BlocListener<EditProfileBloc, EditProfileState>(
      listener: (context, state) {
        final formStatus = state.formStatus;
        if (formStatus is SubmissionFailed) {
          _showSnackBar(context, formStatus.exception.toString());
        }
      },
      child: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.all(40.0),
          child: Column(
            children: [
              _imageProfile(),
              _emailField(),
              _usernameField(),
              _shipSelect(),
              _editEventButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _imageProfile() {
    // return BlocBuilder(builder: (context, state) {
    return FutureBuilder<String>(
        future: getImageUrl(imageUrl),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Container(
              height: 250,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(snapshot.data!), fit: BoxFit.cover),
                  color: Colors.green),
            );
          }
          return CircularProgressIndicator();
        });
    // }
    // );
  }

  Widget _emailField() {
    return BlocBuilder<EditProfileBloc, EditProfileState>(
        builder: (context, state) {
      return FutureBuilder<UserData>(
          future: ProfileRepository().getUserProfile(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  icon: Icon(Icons.email),
                  // hintText: snapshot.data!.data!.email!,
                ),
                initialValue: snapshot.data!.data!.email!,

                /// validator: (value) => state.isValideEmail ? null,
                onChanged: (value) => context.read<EditProfileBloc>().add(
                      EditProfileEmailChanged(email: value),
                    ),
              );
            }
            return const CircularProgressIndicator();
          });
    });
  }

  Widget _usernameField() {
    return BlocBuilder<EditProfileBloc, EditProfileState>(
        builder: (context, state) {
      return FutureBuilder<UserData>(
          future: ProfileRepository().getUserProfile(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  icon: Icon(Icons.verified_user),
                  // hintText: snapshot.data!.data!.id!,
                ),
                initialValue: snapshot.data!.data!.id,

                /// validator: (value) => state.isValideEmail ? null,
                onChanged: (value) => context.read<EditProfileBloc>().add(
                      EditProfileUsernameChanged(username: value),
                    ),
              );
            }
            return const CircularProgressIndicator();
          });
    });
  }

  Widget _shipSelect() {
    return BlocBuilder<EditProfileBloc, EditProfileState>(
      builder: (context, state) {
        return FutureBuilder<UserData>(
            future: ProfileRepository().getUserProfile(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Center(
                      child: Column(
                        children: [
                          ElevatedButton(
                              onPressed: () => {
                                    _showPrefDialog(),
                                    context.read<EditProfileBloc>().add(
                                        EditProfilePrefsChanged(
                                            prefs: selectedPrefList)),
                                  },
                              child: Text('add preferences')),
                          Text(selectedPrefList.join(" , "))
                        ],
                      ),
                    ));
              }
              return const CircularProgressIndicator();
            });
      },
    );
  }

  _showPrefDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Preferences'),
            content: MultiSelectChip(
              prefList,
              selectedPrefList,
              onSelectionChanged: (selectedList) {
                setState(() {
                  selectedPrefList = selectedList;
                });
              },
            ),
            actions: [
              TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('Add'))
            ],
          );
        });
  }

  Widget _editEventButton() {
    return BlocBuilder<EditProfileBloc, EditProfileState>(
        builder: (context, state) {
      return state.formStatus is FormSubmitting
          ? CircularProgressIndicator()
          : Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.green),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        side: BorderSide(color: Colors.green),
                      ),
                    ),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      context.read<EditProfileBloc>().add(
                          EditProfilePrefsChanged(prefs: selectedPrefList));
                      context
                          .read<EditProfileBloc>()
                          .add(EditProfileFormSubmitted());
                    }
                  },
                  child: Text('Edit Event')),
            );
    });
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
