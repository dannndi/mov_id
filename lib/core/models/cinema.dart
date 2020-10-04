import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Cinema extends Equatable {
  final String name;

  Cinema({@required this.name});
  @override
  List<Object> get props => [name];
}

List<Cinema> dummyCinema = [
  Cinema(name: "XX1 Buah Batu"),
  Cinema(name: "XX1 City Link"),
  Cinema(name: "CGV Miko Mall"),
  Cinema(name: "CGV Paris Van Java"),
];
