import 'package:fibonanci_assignment/components/list_view.dart';
import 'package:fibonanci_assignment/models/number.dart';
import 'package:fibonanci_assignment/services/fibonanci.dart';
import 'package:fibonanci_assignment/utils/themes/custom_text_theme.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();

  Map<int, int> _fibonacciNumbers = {};
  int? _removedKey;

  Map<FibonacciType, Map<int, int>> fibonacciGroupMap = {
    FibonacciType.circle: {},
    FibonacciType.close: {},
    FibonacciType.square: {},
  };

  @override
  void initState() {
    super.initState();
    _fibonacciNumbers = generateFibonacci(41);
  }

  void _jumpToIndex(int index) {
    double position = index * 53.0;
    _scrollController.animateTo(
      position,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void _moveNumberToGroup(FibonacciType type, int key) {
    int? number = _fibonacciNumbers[key];

    if (number == null) return;

    _fibonacciNumbers.remove(key);

    Map<int, int> newGroupMap = fibonacciGroupMap[type] ?? {};

    Map<int, int> entry = <int, int>{key: number};
    newGroupMap.addEntries(entry.entries);

    Map<int, int> sortedGroupMap = Map.fromEntries(
      newGroupMap.entries.toList()
        ..sort(
          (e1, e2) => e1.key.compareTo(e2.key),
        ),
    );

    fibonacciGroupMap[type] = sortedGroupMap;
  }

  void _moveNumberToList(FibonacciType type, int key) {
    final groupMap = fibonacciGroupMap[type] ?? {};

    if (groupMap.isNotEmpty) {
      int? number = groupMap[key];

      if (number == null) return;

      groupMap.remove(key);
      _removedKey = key;

      Map<int, int> newGroupMap = _fibonacciNumbers;

      Map<int, int> entry = <int, int>{key: number};
      newGroupMap.addEntries(entry.entries);

      Map<int, int> sortedGroupMap = Map.fromEntries(
        newGroupMap.entries.toList()
          ..sort(
            (e1, e2) => e1.key.compareTo(e2.key),
          ),
      );

      _fibonacciNumbers = sortedGroupMap;

      final index = _fibonacciNumbers.keys.toList().indexOf(key);
      _jumpToIndex(index);
    }
  }

  void showFibonacciGroup(
      {required FibonacciType type, required int addedKey}) {
    Map<int, int>? numbers = fibonacciGroupMap[type];

    if (numbers == null) return;

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return numbers.isNotEmpty
            ? Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Text(
                        getTypeTitle(type),
                        style: subHeadingText(),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: numbers.length,
                        itemBuilder: (context, index) {
                          int? key = numbers.keys.elementAt(index);
                          int? number = numbers[key];

                          if (number == null) return const SizedBox.shrink();

                          return ListViewComponent(
                            fibonacciNumbers: number,
                            index: key,
                            trailing: getFibonacciIcon(number), // Corrected
                            onTap: () => onTapRemove(
                              type: type,
                              key: key,
                            ),
                            status: key == addedKey ? NumberStatus.added : null,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              )
            : const Center(child: Text('No numbers found.'));
      },
    );
  }

  void onTapAdd({required int key}) {
    int? number = _fibonacciNumbers[key];

    if (number == null) return;

    FibonacciType type = getFibonacciType(number);

    setState(() {
      _moveNumberToGroup(type, key);
    });

    Map<int, int> fibonacciGroup = fibonacciGroupMap[type] ?? {};

    if (fibonacciGroup.isNotEmpty) {
      showFibonacciGroup(type: type, addedKey: key);
    }
  }

  void onTapRemove({required int key, required FibonacciType type}) {
    setState(() {
      _moveNumberToList(type, key);
    });

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Assignment',
          style: headingText(),
        ),
      ),
      body: ListView.builder(
        controller: _scrollController,
        itemCount: _fibonacciNumbers.length,
        itemBuilder: (context, index) {
          int? key = _fibonacciNumbers.keys.elementAt(index);
          int? number = _fibonacciNumbers[key];

          if (number == null) return const SizedBox.shrink();

          return ListViewComponent(
            fibonacciNumbers: number,
            index: key,
            trailing: getFibonacciIcon(number),
            onTap: () => onTapAdd(key: key),
            status: key == _removedKey ? NumberStatus.removed : null,
          );
        },
      ),
    );
  }
}
