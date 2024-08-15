import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const CustomAnimatedWidget(),
    );
  }
}

class CustomAnimatedWidget extends StatefulWidget {
  final bool isVisible;
  const CustomAnimatedWidget({super.key, this.isVisible = true});

  @override
  State<CustomAnimatedWidget> createState() => _CustomAnimatedWidgetState();
}

class _CustomAnimatedWidgetState extends State<CustomAnimatedWidget> with SingleTickerProviderStateMixin {
  AnimationController? _animationController;
  Animation<double>? _animation;
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_animationController!);
    if (widget.isVisible) {
      _animationController!.forward();
    } else {
      _animationController!.reverse();
    }
  }

  @override
  void didUpdateWidget(covariant CustomAnimatedWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isVisible != oldWidget.isVisible) {
      _animationController!.forward();
      setState(() {});
    } else {
      _animationController!.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FadeTransition(
        opacity: _animation!,
        child: Container(
          height: 200,
          width: 200,
          color: Colors.red,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController!.dispose();
    super.dispose();
  }
}
