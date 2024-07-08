import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool showVideoPlayer = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: showVideoPlayer
          ? const _VideoPlayer()
          : _VideoSelector(
              onLogoTap: onLogoTap,
            ),
    );
  }

  onLogoTap() {
    setState(() {
      showVideoPlayer = true;
    });
  }
}

class _VideoSelector extends StatelessWidget {
  final VoidCallback onLogoTap;

  const _VideoSelector({
    required this.onLogoTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF2A3A7C),
              Color(0xFF000118),
            ]),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _Logo(
            onTap: onLogoTap,
          ),
          const SizedBox(
            height: 28,
          ),
          const _Title(),
        ],
      ),
    );
  }
}

class _Logo extends StatelessWidget {
  final VoidCallback onTap;

  const _Logo({
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Image.asset(
        'asset/img/logo.png',
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({super.key});

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(
      color: Colors.white,
      fontSize: 32,
      fontWeight: FontWeight.w300,
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          style: textStyle,
          'VIDEO',
        ),
        Text(
          style: textStyle.copyWith(
            fontWeight: FontWeight.w700,
          ),
          'PLAYER',
        ),
      ],
    );
  }
}

class _VideoPlayer extends StatelessWidget {
  const _VideoPlayer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('show video'),
    );
  }
}
