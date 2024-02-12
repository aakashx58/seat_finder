import 'package:flutter/material.dart';
import '../model/seat.dart';

class SelectionButtonProvider with ChangeNotifier {
  List<Seat> _selectedSeats = [];

  List<Seat> get selectedSeats => _selectedSeats;

// By using this getter, external code can retrieve the selected seats
// without direct access to the private _selectedSeats list.This is a common
// practice in object - oriented programming to encapsulate internal state
// and provide controlled access to it.

  void addSeat(Seat seat) {
    _selectedSeats.add(seat);
    notifyListeners();
  }

  void removeSeat(Seat seat) {
    _selectedSeats.remove(seat);
    notifyListeners();
  }

  void findSeat(Seat seat) {
    _selectedSeats.remove(seat);
    notifyListeners();
  }

  bool isSeatSelected(Seat seat) {
    return _selectedSeats.contains(seat);
  }
}
