import 'package:flutter/material.dart';

class LogoAnimatedWidget extends StatefulWidget {
  const LogoAnimatedWidget({super.key});

  @override
  State<LogoAnimatedWidget> createState() => _LogoAnimatedWidgetState();
}

/// [AnimationController]s can be created with `vsync: this` because of
/// [TickerProviderStateMixin].
class _LogoAnimatedWidgetState extends State<LogoAnimatedWidget>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  )..repeat(reverse: true);
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.fastOutSlowIn,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ScaleTransition(
          scale: _animation,
          child: Padding(
            padding: EdgeInsets.all(0),
            child: ClipRRect(
              borderRadius: BorderRadius.all(
                Radius.circular(999),
              ),
              child: Image.asset(
                'assets/images/icon_no_alpha.png',
                fit: BoxFit.cover,
                height: MediaQuery.of(context).size.width / 1.5,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
