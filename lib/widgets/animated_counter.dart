import 'package:material_ui/material_ui.dart';

class AnimatedCounter extends StatefulWidget {
  final int initialValue;
  final int maxValue;
  final Duration animationDuration;
  final Color? primaryColor;

  const AnimatedCounter({
    super.key,
    this.initialValue = 0,
    this.maxValue = 100,
    this.animationDuration = const Duration(milliseconds: 300),
    this.primaryColor,
  }) : assert(maxValue > 0),
        assert(initialValue >= 0 && initialValue <= maxValue);

  @override
  State<AnimatedCounter> createState() => _AnimatedCounterState();
}

class _AnimatedCounterState extends State<AnimatedCounter>
    with TickerProviderStateMixin {
  late int _counter;
  late AnimationController _controller;
  late Animation<double> _animation;
  late Animation<double> _buttonAnimation;

  @override
  void initState() {
    super.initState();

    _counter = widget.initialValue;

    _controller = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );

    _animation = Tween<double>(
      begin: 1.0,
      end: 1.25,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    debugPrint('AnimatedCounter: initState');
  }

  @override
  void didUpdateWidget(covariant AnimatedCounter oldWidget) {
    super.didUpdateWidget(oldWidget);
    _controller.duration = widget.animationDuration;
    _counter = _counter.clamp(0, widget.maxValue);
  }

  @override
  void dispose() {
    _controller.dispose();
    _buttonAnimation = Tween<double>(
      begin: 1.0,
      end: 0.85,
    ).chain(
      CurveTween(curve: Curves.easeOutBack),
    ).animate(_controller);
    debugPrint('AnimatedCounter: dispose');
    super.dispose();
  }

  void _changeValue(int value) {
    setState(() {
      _counter = value.clamp(0, widget.maxValue);
    });

    _controller.forward(from: 0).then((_) {
      if (mounted) {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    final color = _counter == widget.maxValue
        ? colors.error
        : widget.primaryColor ?? colors.primary;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Анімований лічильник'),
            const SizedBox(height: 20),
            ScaleTransition(
              scale: _animation,
              child: AnimatedDefaultTextStyle(
                duration: widget.animationDuration,
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
                child: Text('$_counter'),
              ),
            ),
            const SizedBox(height: 20),
            TweenAnimationBuilder<double>(
              tween: Tween<double>(
                end: _counter / widget.maxValue,
              ),
              duration: widget.animationDuration,
              builder: (context, value, child) {
                return LinearProgressIndicator(
                  value: value,
                  color: color,
                );
              },
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ScaleTransition(
                  scale: _buttonAnimation,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        onPressed: _counter > 0
                            ? () => _changeValue(_counter - 1)
                            : null,
                        icon: const Icon(Icons.remove),
                      ),
                      IconButton(
                        onPressed: () => _changeValue(0),
                        icon: const Icon(Icons.refresh),
                      ),
                      IconButton(
                        onPressed: _counter < widget.maxValue
                            ? () => _changeValue(_counter + 1)
                            : null,
                        icon: const Icon(Icons.add),
                      ),
                    ],
                  ),
                ),

              ],
            ),
          ],
        ),
      ),
    );
  }
}