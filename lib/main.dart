import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(
    const ProviderScope(child: SeatFinderApp()),
  );
}

final searchController = Provider.autoDispose<TextEditingController>((ref) {
  return TextEditingController();
});

const List<MapEntry<bool, List<int>>> seatValues = [
  MapEntry(false, [1, 2, 3, 7]),
  MapEntry(true, [4, 5, 6, 8]),
  MapEntry(false, [9, 10, 11, 15]),
  MapEntry(true, [12, 13, 14, 16]),
  MapEntry(false, [17, 18, 19, 23]),
  MapEntry(true, [20, 21, 22, 24]),
  MapEntry(false, [25, 26, 27, 31]),
  MapEntry(true, [28, 29, 30, 32]),
  MapEntry(false, [33, 34, 35, 39]),
  MapEntry(true, [36, 37, 38, 40]),
  MapEntry(false, [41, 42, 43, 47]),
  MapEntry(true, [44, 45, 46, 48]),
  MapEntry(false, [49, 50, 51, 55]),
  MapEntry(true, [52, 53, 54, 56]),
  MapEntry(false, [57, 58, 59, 63]),
  MapEntry(true, [60, 61, 62, 64]),
  MapEntry(false, [65, 66, 67, 71]),
  MapEntry(true, [68, 69, 70, 72]),
];

enum Berth {
  lower('LOWER'),
  middle('MIDDLE'),
  upper('UPPER'),
  sideUpper('SIDE UPPER'),
  sideLower('SIDE LOWER');

  const Berth(this.text);
  final String text;
}

class SeatFinderApp extends ConsumerStatefulWidget {
  const SeatFinderApp({super.key});

  @override
  ConsumerState<SeatFinderApp> createState() => _SeatFinderAppState();
}

class _SeatFinderAppState extends ConsumerState<SeatFinderApp> {
  // late final TextEditingController searchController;
  late final ScrollController scrollController;

  @override
  void initState() {
    // searchController = TextEditingController();
    scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    // searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          toolbarHeight: size.height * 0.18,
          leadingWidth: double.maxFinite,
          leading: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                SizedBox(height: size.height * 0.03),
                const SizedBox(
                  width: double.maxFinite,
                  child: Text(
                    "Seat Finder",
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(width: 2, color: Colors.blue),
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 5,
                        child: _buildSearchField(),
                      ),
                      Expanded(
                        flex: 2,
                        child: _buildSearchButton(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        body: SafeArea(
          child: ListView.separated(
            controller: scrollController,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            itemCount: seatValues.length,
            itemBuilder: (context, index) {
              final seatRowValues = seatValues[index].value;
              final topPosition = seatValues[index].key;
              final tripleValues = seatRowValues.sublist(0, 3);
              final singleValue = seatRowValues[3];
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TripleBlocks(
                    topPosition: topPosition,
                    values: tripleValues,
                  ),
                  SingleBlock(
                    berth: topPosition ? Berth.sideUpper : Berth.sideLower,
                    value: singleValue,
                    topPosition: topPosition,
                  ),
                ],
              );
            },
            separatorBuilder: (context, index) =>
                SizedBox(height: index.isEven ? 25 : 0),
          ),
        ),
      ),
    );
  }

  TextField _buildSearchField() {
    return TextField(
      keyboardType: TextInputType.number,
      style: const TextStyle(fontSize: 20),
      onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
      controller: ref.watch(searchController),
      decoration: InputDecoration(
        hintText: "Enter Seat Number...",
        contentPadding: const EdgeInsets.symmetric(horizontal: 20),
        hintStyle:
            TextStyle(color: Colors.blue.shade200, fontWeight: FontWeight.bold),
        border: const OutlineInputBorder(borderSide: BorderSide.none),
        focusedBorder: const OutlineInputBorder(borderSide: BorderSide.none),
      ),
    );
  }

  FilledButton _buildSearchButton() {
    return FilledButton(
      style: FilledButton.styleFrom(
        backgroundColor: Colors.blue,
        disabledBackgroundColor: Colors.grey,
        fixedSize: const Size.fromHeight(60),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      onPressed: () {
        setState(() {});

        final value = double.parse(ref.watch(searchController).text);
        scrollController.animateTo(
          (value / 8).floor() * 150,
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOut,
        );
      },
      child: const Text('Find'),
    );
  }
}

class TripleBlocks extends StatelessWidget {
  final bool topPosition;
  final List<int> values;
  const TripleBlocks(
      {super.key, required this.topPosition, required this.values});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          bottom: topPosition ? 0 : null,
          top: topPosition ? null : 0,
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 1),
            width: 207,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: const Color.fromARGB(255, 115, 190, 252),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              CustomContainer(
                topPosition: topPosition,
                berth: Berth.lower,
                value: values[0],
              ),
              const SizedBox(width: 1),
              CustomContainer(
                topPosition: topPosition,
                berth: Berth.middle,
                value: values[1],
              ),
              const SizedBox(width: 1),
              CustomContainer(
                topPosition: topPosition,
                berth: Berth.upper,
                value: values[2],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class SingleBlock extends StatelessWidget {
  final int value;
  final Berth berth;
  final bool topPosition;
  const SingleBlock({
    super.key,
    required this.topPosition,
    required this.value,
    required this.berth,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          bottom: topPosition ? 0 : null,
          top: topPosition ? null : 0,
          child: Container(
            width: 79,
            height: 40,
            margin: const EdgeInsets.symmetric(vertical: 1),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: const Color.fromARGB(255, 115, 190, 252),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomContainer(
            value: value,
            berth: berth,
            topPosition: topPosition,
          ),
        ),
      ],
    );
  }
}

class CustomContainer extends ConsumerWidget {
  final int value;
  final Berth berth;
  final bool topPosition;
  const CustomContainer({
    super.key,
    required this.value,
    required this.berth,
    required this.topPosition,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isSelected = ref.read(searchController).text == value.toString();
    return GestureDetector(
      onTap: () {
        ref.refresh(searchController).text = value.toString();
      },
      child: Container(
        height: 63,
        width: 63,
        margin: const EdgeInsets.symmetric(vertical: 1),
        padding: const EdgeInsets.symmetric(vertical: 3),
        decoration: BoxDecoration(
          color: isSelected
              ? Colors.blue
              : const Color.fromARGB(255, 206, 230, 249),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Text(
                value.toString(),
                style: TextStyle(
                  fontSize: 25,
                  color: isSelected ? Colors.white : Colors.blue,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Align(
              alignment:
                  topPosition ? Alignment.topCenter : Alignment.bottomCenter,
              child: Text(
                berth.text,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.blue,
                  fontSize: 8,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
