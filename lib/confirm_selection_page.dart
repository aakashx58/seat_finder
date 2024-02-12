import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:seat_finder/provider/selection_button_provider.dart';

class ConfirmSelectionPage extends StatefulWidget {
  const ConfirmSelectionPage({super.key});

  @override
  State<ConfirmSelectionPage> createState() => _ConfirmSelectionPageState();
}

class _ConfirmSelectionPageState extends State<ConfirmSelectionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Confirm Selection",
          style: GoogleFonts.montserrat(
            fontSize: 24,
          ),
        ),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Consumer<SelectionButtonProvider>(
          // rebuilds its child widget whenever the value of the provider changes.
          builder: (context, provider, child) {
            return (provider.selectedSeats.isEmpty)
                ? const Center(
                    child: Text("Please select tickets..."),
                  )
                : Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Selected Seats",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Total: ${provider.selectedSeats.length}",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: provider.selectedSeats.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.symmetric(vertical: 4.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Seat No.: ${provider.selectedSeats[index].seatIndex}",
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Text(
                                    "Type: ${provider.selectedSeats[index].seatType}",
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  );
          },
        ),
      ),
    );
  }
}
