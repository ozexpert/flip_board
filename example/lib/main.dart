import 'package:flutter/material.dart';

import 'pages/board/flip_frase_board_page.dart';
import 'pages/board/flip_matrix_board_single_child_page.dart';
import 'pages/board/flip_matrix_board_stream_page.dart';
import 'pages/clock/flip_clock_page.dart';
import 'pages/clock/flip_countdown_clock_page.dart';
import 'pages/widget/flip_widgets_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flip Board',
        routes: {
          'flip_widgets': (_) => FlipWidgetsPage(),
          'flip_image': (_) => FlipMatrixBoardSingleChildPage(),
          'flip_stream': (_) => FlipMatrixBoardStreamPage(),
          'flip_frase_board': (_) => FlipFraseBoardPage(),
          'flip_clock': (_) => FlipClockPage(),
          'countdown_clock': (_) => FlipCountdownClockPage(),
        },
        home: HomePage(),
      );
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Flip Board')),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTileTheme(
            iconColor: Colors.blueGrey[700],
            tileColor: Colors.grey[300],
            contentPadding: const EdgeInsets.all(8.0),
            shape: Border.all(color: Colors.black38),
            child: ListView(
              children: [
                _tile(
                  context,
                  Icons.flip,
                  'Flip & Spin',
                  'Simple Flip and Spin Widgets',
                  'flip_widgets',
                ),
                _tile(
                  context,
                  Icons.dashboard,
                  'Flip Image Board',
                  'Animate the display of a single image',
                  'flip_image',
                ),
                _tile(
                  context,
                  Icons.blur_on,
                  'Flip Stream Board',
                  'Animate a stream of images',
                  'flip_stream',
                ),
                _tile(
                  context,
                  Icons.sort_by_alpha,
                  'Flip Frase Board',
                  'Flip FLUTTER FLIP BOARD',
                  'flip_frase_board',
                ),
                _tile(
                  context,
                  Icons.watch,
                  'Flip Clock',
                  'A nice looking clock',
                  'flip_clock',
                ),
                _tile(
                  context,
                  Icons.run_circle,
                  'Flip Countdown Clock',
                  'A nice looking countdown clock',
                  'countdown_clock',
                ),
              ],
            ),
          ),
        ),
      );

  Widget _tile(
    BuildContext context,
    IconData icon,
    String title,
    String subtitle,
    String route,
  ) =>
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: ListTile(
          leading: Icon(icon, size: 48.0),
          title: Text(title),
          subtitle: Text(subtitle),
          onTap: () => Navigator.of(context).pushNamed(route),
        ),
      );
}
