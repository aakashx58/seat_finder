import 'package:flutter/material.dart';
import 'package:seat_finder/components/seat_widget.dart';
import 'custom_clip_path.dart';

class CabinWidget extends StatefulWidget {
  const CabinWidget(
      {super.key, required this.index, required this.searchBarText});

  final int? index;
  final String? searchBarText;

  @override
  State<CabinWidget> createState() => _CabinWidgetState();
}

class _CabinWidgetState extends State<CabinWidget> {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    ClipPath(
                      clipper: MyCustomClipperFromTop(),
                      child: Container(
                        height: 60,
                        width: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color:  const Color(0xff80CBFF),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 5),
                      child: Row(
                        children: [
                          SeatWidget(
                            seatIndex: 1 + widget.index! * 8,
                            seatType: "Upper",
                            searchBarText: widget.searchBarText,
                          ),
                          const SizedBox(width: 4),
                          SeatWidget(
                            searchBarText: widget.searchBarText,
                            seatIndex: 2 + widget.index! * 8,
                            seatType: "Middle",
                          ),
                            const SizedBox(width: 4),
                          SeatWidget(
                            searchBarText: widget.searchBarText,
                            seatIndex: 3 + widget.index! * 8,
                            seatType: "Lower",
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    ClipPath(
                      clipper: MyCustomClipperFromTop(),
                      child: Container(
                        height: 60,
                        width: 72,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: const Color(0xff80CBFF),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 5),
                      child: SeatWidget(
                        searchBarText: widget.searchBarText,
                        seatIndex: 7 + widget.index! * 8,
                        seatType: "Side Up",
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    ClipPath(
                      clipper: MyCustomCliperFromBottom(),
                      child: Container(
                        height: 60,
                        width: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: const Color(0xff80CBFF),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 5),
                      child: Row(
                        children: [
                          SeatWidget(
                            searchBarText: widget.searchBarText,
                            seatIndex: 6 + widget.index! * 8,
                            seatType: "Upper",
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          SeatWidget(
                            searchBarText: widget.searchBarText,
                            seatIndex: 5 + widget.index! * 8,
                            seatType: "Middle",
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          SeatWidget(
                            searchBarText: widget.searchBarText,
                            seatIndex: 4 + widget.index! * 8,
                            seatType: "Lower",
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    ClipPath(
                      clipper: MyCustomCliperFromBottom(),
                      child: Container(
                        height: 60,
                        width: 72,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color:const Color(0xff80CBFF),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 5),
                      child: SeatWidget(
                        searchBarText: widget.searchBarText,
                        seatIndex: 8 + widget.index! * 8,
                        seatType: "Side Low",
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 2),
      ],
    );
  }
}

