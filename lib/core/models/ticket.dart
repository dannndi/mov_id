import 'package:equatable/equatable.dart';
import 'package:mov_id/core/models/cinema.dart';
import 'package:mov_id/core/models/movie_detail.dart';

class Ticket extends Equatable {
  final String userName;
  final MovieDetail movieDetail;
  final Cinema cinema;
  final DateTime bookedDate;
  final List<String> seats;
  final int totalPrice;
  final String bookingCode;
  final DateTime dateOfBuying;

  Ticket({
    this.userName,
    this.movieDetail,
    this.cinema,
    this.bookedDate,
    this.seats,
    this.totalPrice,
    this.bookingCode,
    this.dateOfBuying,
  });

  Ticket copywith({
    String username,
    MovieDetail movieDetail,
    Cinema cinema,
    DateTime bookedDate,
    List<String> seats,
    int totalPrice,
    String bookingCode,
    DateTime dateOfBuying,
  }) {
    return Ticket(
      userName: username ?? this.userName,
      movieDetail: movieDetail ?? this.movieDetail,
      cinema: cinema ?? this.cinema,
      bookedDate: bookedDate ?? this.bookedDate,
      seats: seats ?? this.seats,
      totalPrice: totalPrice ?? this.totalPrice,
      bookingCode: bookingCode ?? this.bookingCode,
      dateOfBuying: dateOfBuying ?? this.dateOfBuying,
    );
  }

  @override
  List<Object> get props => [
        userName,
        movieDetail,
        cinema,
        bookedDate,
        seats,
        totalPrice,
      ];
}
