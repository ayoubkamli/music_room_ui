// import 'dart:convert';

// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:http/http.dart' as http;
// import 'package:myapp/auth/models/user.dart';
// import 'package:myapp/auth/utils/manage_token.dart';
// import 'package:myapp/constant/constant.dart';

// class GoogleSignInApi {
//   static final _googleSignIn = GoogleSignIn();

//   static Future<User?> loginWithGoogle() async {
//     final GoogleSignInAccount? response = await _googleSignIn.signIn();
//     final GoogleSignInAuthentication auth = await response!.authentication;
//     final String? googleAccessToken = auth.accessToken;
//     print(googleAccessToken);
//     print(googleOAuth);
//     http.Response? res = await http.post(googleOAuth,
//         headers: <String, String>{
//           'Content-Type': 'application/json; charset=UTF-8',
//         },
//         body: jsonEncode(
//           <String, String>{
//             'accessToken': googleAccessToken.toString(),
//           },
//         ));
//     print(res.statusCode.toString());
//     print(res.body.toString());
//     // User data = User.fromJson(jsonDecode(res.body));
//     var data = jsonDecode(res.body);
//     User user = User.fromJson(data['data']);
//     MyToken().setToken(user.token!);
//     print('---------->>>>>>' + user.token!);
//     // SessionCubit(authRepo: AuthRepository()).attemptAutoLogin();

//     return user;
//   }
// }
