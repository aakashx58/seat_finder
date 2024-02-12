import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:seat_finder/confirm_selection_page.dart';
import 'package:seat_finder/model/seat.dart';
import 'package:seat_finder/provider/selection_button_provider.dart';

import '../components/cabin_widget.dart';

class SelectionButtonPage extends StatefulWidget {
  const SelectionButtonPage({super.key});

  @override
  State<SelectionButtonPage> createState() => _SelectionButtonPageState();
}

class _SelectionButtonPageState extends State<SelectionButtonPage>
    with AutomaticKeepAliveClientMixin<SelectionButtonPage> {
  String? searchText;
  @override
  bool get wantKeepAlive => true;
  Seat seat = Seat();
  TextEditingController searchController = TextEditingController();

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   List<Seat> seats =
  //       Provider.of<SelectionButtonProvider>(context, listen: false)
  //           .selectedSeats; // to obtain the value of selectedSeats from a
  //   // provider of type SelectionButtonProvider
  //
  //   // The listen parameter is set to false to indicate that this widget does not
  //   // need to rebuild when the value changes. In the context of initState,
  //   // it's common to set listen to false to avoid unnecessary rebuilds.
  //
  //   // for (var x in seats) {
  //   //   log("--------------------");
  //   //   log(x.seatIndex.toString());
  //   // }
  // }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SelectionButtonProvider>(
        builder: (context, provider, child) {
      return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: Text(
            'Seat Finder',
            style: GoogleFonts.dancingScript(
                color: Colors.lightBlueAccent,
                fontSize: 44,
                fontWeight: FontWeight.bold),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          child: FloatingActionButton.extended(
            onPressed: () {
              Navigator.of(context).push(
                CupertinoPageRoute(
                  builder: (context) => const ConfirmSelectionPage(),
                ),
              );
            },
            backgroundColor: Colors.blue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            label: Text(
              'Confirm Selection',
              style: GoogleFonts.montserrat(
                fontSize: 24,
              ),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            children: [
              const SizedBox(
                height: 8,
              ),
              TextFormField(
                controller: searchController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      strokeAlign: 15.0,
                      style: BorderStyle.solid,
                      width: 2,
                      color: Colors.lightBlueAccent,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  contentPadding: const EdgeInsets.all(10),
                  hintText: 'Enter Seat Number...',
                  // prefixIcon: Icon(Icons.search_outlined),
                  border: const OutlineInputBorder(
                    borderSide: BorderSide(
                      strokeAlign: 5.0,
                      color: Colors.blue,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.check,
                        color: Provider.of<SelectionButtonProvider>(context)
                                .selectedSeats
                                .isEmpty
                            ? Colors.black12
                            : Colors.blue),
                    onPressed: () {
                      provider.findSeat(seat);
                      Navigator.of(context).push(
                        CupertinoPageRoute(
                          builder: (context) => const ConfirmSelectionPage(),
                        ),
                      );
                    },
                  ),
                ),
                onChanged: (value) {
                  searchText = value;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: 10,
                    itemBuilder: (context, index) => Builder(
                          builder: (context) => CabinWidget(
                            index: index,
                            searchBarText: searchText,
                          ),
                        )),
              ),
            ],
          ),
        ),
      );
    });
  }
}
