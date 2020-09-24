import 'package:equatable/equatable.dart';

class UserApp extends Equatable {
  final String id;
  final String name;
  final String email;
  final String profilePicture;
  final List<String> preferedGenre;
  final String language;
  final int balance;

  UserApp({
    this.id,
    this.name,
    this.email,
    this.profilePicture,
    this.balance,
    this.language,
    this.preferedGenre,
  });

  //use copy woth if we want to change variable inside created User
  UserApp copyWith({String name, String profilePicture, int balance}) {
    return UserApp(
      id: this.id,
      email: this.email,
      name: name ?? this.name,
      profilePicture: profilePicture ?? this.profilePicture,
      balance: balance ?? this.balance,
      preferedGenre: this.preferedGenre,
      language: this.language,
    );
  }

  @override
  List<Object> get props => [
        id,
        name,
        email,
        profilePicture,
        preferedGenre,
        language,
        balance,
      ];
}
