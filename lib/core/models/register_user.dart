import 'dart:io';

import 'package:equatable/equatable.dart';

class RegisterUser extends Equatable {
  final String email;
  final String name;
  final String password;
  final File profilePicture;
  final List<String> selectedGenres;
  final String selectedLanguage;

  RegisterUser({
    this.email,
    this.name,
    this.password,
    this.profilePicture,
    this.selectedGenres,
    this.selectedLanguage,
  });
  RegisterUser copyWith({
    String email,
    String name,
    String password,
    File profilePicture,
    List<String> selectedGenres,
    String selectedLanguage,
  }) {
    return RegisterUser(
      email: email ?? this.email,
      name: name ?? this.name,
      password: password ?? this.password,
      profilePicture: profilePicture ?? this.profilePicture,
      selectedGenres: selectedGenres ?? this.selectedGenres,
      selectedLanguage: selectedLanguage ?? this.selectedLanguage,
    );
  }

  @override
  List<Object> get props => [
        email,
        name,
        password,
        profilePicture,
        selectedGenres,
        selectedLanguage,
      ];
}
