import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seat_finder/model/seat.dart';
import 'package:seat_finder/provider/selection_button_provider.dart';

class SeatWidget extends StatefulWidget {
  SeatWidget(
      {Key? key,
      required this.seatIndex,
      required this.seatType,
      required this.searchBarText})
      : super(key: ValueKey(seatIndex));

  final int seatIndex;
  final String seatType;
  final String? searchBarText;

  @override
  State<SeatWidget> createState() => _SeatWidgetState();
}

class _SeatWidgetState extends State<SeatWidget>
    with AutomaticKeepAliveClientMixin<SeatWidget> {
  @override
  bool get wantKeepAlive => true;
  Seat seat = Seat();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    seat = Seat(seatIndex: widget.seatIndex, seatType: widget.seatType);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SelectionButtonProvider>(
        builder: (context, provider, child) {
      return GestureDetector(
        onTap: () {
          provider.selectedSeats.contains(seat)
              ? provider.removeSeat(seat)
              : provider.addSeat(seat);
        }, //to select and deselect seats
        child: Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
            boxShadow: [
              BoxShadow(
                color: (widget.searchBarText.toString() ==
                        widget.seatIndex.toString())
                    ? Colors.blue.withOpacity(0.6)
                    : Colors.transparent,
                spreadRadius: 2,
                blurRadius: 2,
                offset: const Offset(0, 1),
              ),
            ],
            border: Border.all(
              color: (widget.searchBarText == widget.seatIndex.toString())
                  ? Colors.blue
                  : Colors.transparent,
              width: 2,
            ),
            color: (provider.selectedSeats.contains(seat))
                ? const Color(0xff126DCA)
                : const Color(0xffCEEAFF),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.seatIndex.toString(),
                style: TextStyle(
                  fontSize: 16,
                  color: (provider.selectedSeats.contains(seat))
                      ? const Color(0xffCEEAFF)
                      : const Color(0xff126DCA),
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                widget.seatType,
                style: TextStyle(
                  fontSize: 12,
                  color: (provider.selectedSeats.contains(seat))
                      ? const Color(0xffCEEAFF)
                      : const Color(0xff126DCA),
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
