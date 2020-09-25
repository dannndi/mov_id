import 'dart:io';

import 'package:equatable/equatable.dart';

class RegisterUser extends Equatable {
  final String email;
  final String name;
  final String password;
  final File profilePicture;
  final List<String> preferedGenres;
  final String language;

  RegisterUser({
    this.email,
    this.name,
    this.password,
    this.profilePicture,
    this.preferedGenres,
    this.language,
  });
  RegisterUser copyWith({
    String email,
    String name,
    String password,
    File profilePicture,
    List<String> preferedGenres,
    String language,
  }) {
    return RegisterUser(
      email: email ?? this.email,
      name: name ?? this.name,
      password: password ?? this.password,
      profilePicture: profilePicture ?? this.profilePicture,
      preferedGenres: preferedGenres ?? this.preferedGenres,
      language: language ?? this.language,
    );
  }

  @override
  List<Object> get props => [
        email,
        name,
        password,
        profilePicture,
        language,
        language,
      ];
}
