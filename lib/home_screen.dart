import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nfc_demo/home_state.dart';
import 'package:nfc_demo/home_state_notifier.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  late TextEditingController _textController;
  @override
  void dispose() {
    _textController.dispose();
    _tabController!.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _textController = TextEditingController();
    _tabController?.addListener(() {
      if (_tabController?.index == 0) {
        ref.read(homeProvider.notifier).startScanning();
      } else {
        ref.read(homeProvider.notifier).clearOldResult();
        ref.read(homeProvider.notifier).stopScanning();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(homeProvider);
    final homeStateNotifier = ref.read(homeProvider.notifier);
    return Scaffold(
      appBar: AppBar(
          title: const Text('NFC Flutter Kit Example App'),
          bottom: TabBar(tabs: const <Widget>[
            Tab(text: 'read'),
            Tab(text: 'write'),
          ], controller: _tabController)),
      body: TabBarView(controller: _tabController, children: <Widget>[
        state.supportsNFC
            ? _buildReadTab(state)
            : const Center(
                child: Text("NFC unsupported"),
              ),
        state.supportsNFC
            ? _buildWriteTab(state, homeStateNotifier)
            : const Center(
                child: Text("NFC unsupported"),
              )
      ]),
    );
  }

  Widget _buildWriteTab(HomeState state, HomeStateNotifier homeStateNotifier) {
    return Scrollbar(
      child: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      ElevatedButton(
                        onPressed: () => homeStateNotifier.write(),
                        child: const Text("Start writing"),
                      ),
                      ElevatedButton(
                        onPressed: () => showDialogAddRecord(state),
                        child: const Text("Add record"),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Text('Result: ${state.errorText}'),
                  const SizedBox(
                    height: 12,
                  ),
                  ListView.separated(
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 12,
                    ),
                    shrinkWrap: true,
                    itemCount: state.records.length,
                    itemBuilder: (context, index) => Dismissible(
                        key: Key(state.records[index]),
                        onDismissed: (direction) =>
                            homeStateNotifier.deleteRecord(index),
                        child: Container(
                          decoration: BoxDecoration(border: Border.all()),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(state.records[index].toString()),
                          ),
                        )),
                  ),
                ])),
      ),
    );
  }

  Widget _buildReadTab(HomeState state) {
    return Scrollbar(
        child: SingleChildScrollView(
            child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 12),
            state.readResults.isNotEmpty
                ? ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.readResults.length,
                    itemBuilder: (context, index) =>
                        Text(state.readResults[index]))
                : const Text('No tag scanned yet.'),
            const SizedBox(height: 12),
          ]),
    )));
  }

  void showDialogAddRecord(HomeState state) {
    showDialog(
        context: context,
        builder: (BuildContext dialogContext) {
          return SimpleDialog(
            contentPadding: const EdgeInsets.all(16),
            title: const Text('Add Text Record'),
            children: [
              TextField(
                decoration: const InputDecoration(labelText: 'text'),
                controller: _textController,
              ),
              ElevatedButton(
                child: const Text('OK'),
                onPressed: () {
                  if (_textController.text.isNotEmpty) {
                    log(_textController.text);
                    ref
                        .read(homeProvider.notifier)
                        .addNewRecord(_textController.text);
                    Navigator.pop(context);
                    _textController.clear();
                  }
                },
              )
            ],
          );
        });
  }
}
