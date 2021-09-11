class LoginModel {
  String email;
  String password;

  LoginModel(this.email, this.password);

  toJson() => {
        email: this.email,
        password: this.password,
      };
}
