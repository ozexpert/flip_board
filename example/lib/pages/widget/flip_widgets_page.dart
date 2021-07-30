import 'dart:async';

import 'package:flip_board/flip_widget.dart';
import 'package:flutter/material.dart';

/// Page with four FlipWidgets showing all flip direction animations.
///
/// Very simple page with four [FlipWidget] instances for the same broadcast stream.
/// Each [FlipWidget] is configured to flip with a different AxisDirection.
class FlipWidgetsPage extends StatefulWidget {
  @override
  _FlipWidgetState createState() => _FlipWidgetState();
}

class _FlipWidgetState extends State<FlipWidgetsPage> {
  final _flipController = StreamController<int>.broadcast();
  final _spinController = StreamController<int>.broadcast();
  int _nextFlipValue = 0;
  int _nextSpinValue = 0;

  @override
  void dispose() {
    _flipController.close();
    _spinController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final greyColors = ColorScheme.fromSwatch(primarySwatch: Colors.blueGrey);
    final amberColors = ColorScheme.fromSwatch(primarySwatch: Colors.amber);
    return Scaffold(
      appBar: AppBar(title: const Text('Flip & Spin')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _flipWheel(greyColors),
            const SizedBox(height: 20.0),
            _spinWheel(amberColors),
          ],
        ),
      ),
    );
  }

  Widget _flipWheel(ColorScheme colors) =>
      _wheel('Flip Widget', colors, _flipWidget, _flipButton);

  Widget _spinWheel(ColorScheme colors) =>
      _wheel('Spin Widget', colors, _spinWidget, _spinButton);

  Widget _wheel(
    String title,
    ColorScheme colors,
    Widget Function(AxisDirection) _widget,
    Widget _button,
  ) =>
      Theme(
        data: ThemeData(colorScheme: colors),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _wheelTitle(title, colors),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [_widget(AxisDirection.up)],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _widget(AxisDirection.left),
                _button,
                _widget(AxisDirection.right),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [_widget(AxisDirection.down)],
            ),
          ],
        ),
      );

  Widget _wheelTitle(String title, ColorScheme colors) => Row(
        children: [
          Container(
            margin: const EdgeInsets.only(left: 24.0),
            padding: const EdgeInsets.all(8.0),
            color: colors.secondary,
            child: Text(
              title,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: colors.onSecondary,
              ),
            ),
          ),
        ],
      );

  Widget get _flipButton => Container(
        width: 100.0,
        height: 100.0,
        child: IconButton(
          onPressed: _flip,
          icon: const Icon(Icons.add_circle, size: 48.0),
        ),
      );

  Widget get _spinButton => Container(
        width: 100.0,
        height: 100.0,
        child: IconButton(
          onPressed: _spin,
          icon: const Icon(
            Icons.add_circle,
            size: 48.0,
            color: Colors.red,
          ),
        ),
      );

  Widget _flipWidget(AxisDirection direction) => Container(
        child: FlipWidget(
          itemStream: _flipController.stream,
          itemBuilder: _itemBuilder,
          initialValue: _nextFlipValue,
          flipDirection: direction,
          flipCurve: direction == AxisDirection.down
              ? FlipWidget.bounceFastFlip
              : FlipWidget.defaultFlip,
          flipDuration: const Duration(milliseconds: 1000),
          perspectiveEffect: 0.008,
          panelSpacing: 0.8,
        ),
      );

  Widget _spinWidget(AxisDirection direction) => Container(
        child: SpinFlipWidget(
          itemStream: _spinController.stream,
          itemBuilder: _itemBuilder,
          initialValue: _nextFlipValue,
          flipDirection: direction,
          flipDuration: const Duration(milliseconds: 1000),
          perspectiveEffect: 0.008,
          panelSpacing: 0.8,
        ),
      );

  Widget _itemBuilder(BuildContext context, int? value) => Container(
        width: 72.0,
        height: 72.0,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryVariant,
          borderRadius: const BorderRadius.all(Radius.circular(4.0)),
          border: Border.all(color: Theme.of(context).colorScheme.background),
        ),
        child: Text(
          ((value ?? 0) % 10).toString(),
          style: TextStyle(
            color: Theme.of(context).colorScheme.onPrimary,
            fontSize: 60.0,
          ),
        ),
      );

  void _flip() => _flipController.add(++_nextFlipValue);
  void _spin() => _spinController.add(++_nextSpinValue);
}
