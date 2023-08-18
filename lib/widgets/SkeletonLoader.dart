import 'package:admin/exports/exports.dart';

class SkeletonLoader extends StatefulWidget {
  final int boxes;
  const SkeletonLoader({super.key, this.boxes = 4});

  @override
  State<SkeletonLoader> createState() => _SkeletonLoaderState();
}

class _SkeletonLoaderState extends State<SkeletonLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  Animation<double>? _skeletonAnimation;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      value: 0,
      duration: Duration(milliseconds: 900),
    )..repeat(reverse: true);
    _skeletonAnimation =
        Tween<double>(begin: 0.1, end: 0.78).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return AnimatedBuilder(
      animation: _skeletonAnimation!,
      builder: (context, child) => SizedBox(
        height: Responsive.isMobile(context) ? 100 : 200,
        child: GridView.count(
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: Responsive.isMobile(context) ? 2 : 4,
          crossAxisSpacing: defaultPadding,
          mainAxisSpacing: 4,
          childAspectRatio: Responsive.isMobile(context)
              ? (_size.width < 650 && _size.width > 350 ? 1.3 : 1)
              : (_size.width < 1400 ? 1.1 : 1.4),
          children: List.generate(
            widget.boxes,
            (index) => Opacity(
              opacity: _skeletonAnimation!.value,
              child: Card(
                elevation: 0,
                color: Colors.grey[300],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
