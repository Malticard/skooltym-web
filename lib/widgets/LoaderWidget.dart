// ignore_for_file: file_names, library_private_types_in_public_api

import 'dart:developer';

import '/exports/exports.dart';

class Loader extends StatefulWidget {
  final double size;
  final String? text;
  const Loader({super.key, this.size = 30, this.text = ''});

  @override
  _LoaderState createState() => _LoaderState();
}

class _LoaderState extends State<Loader> with TickerProviderStateMixin {
  double sides = 60;

  Animation<double>? animation;
  AnimationController? controller;
  Animation<double>? animationPulse;
  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )
      ..addListener(() {
        setState(() {});
      })
      ..repeat();

// tween animations
    Tween<double> radiusTween = Tween(begin: 0.2, end: 0.7);
// end of  tween animations

// curves animation implementing pulse
    animationPulse = CurveTween(curve: Curves.easeInOut).animate(controller!);

    animation = radiusTween.animate(controller!)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller?.reverse();
        } else if (status == AnimationStatus.dismissed) {
          controller?.forward();
        }
      });

    controller!.forward();
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // log("${(100 - (animation!.value * 100)).clamp(0, 1)}");
    return AnimatedBuilder(
      builder: (context, child) {
        return ListView.builder(
          itemBuilder: (context, index) => Opacity(
            opacity: animation!.value,
            child: ListTile(
              leading: CircleAvatar(
                radius: 40,
                backgroundColor: Theme.of(context).primaryColorLight,
              ),
              title: SizedBox(
                child: Card(
                  color: Theme.of(context).primaryColorLight,
                  elevation: 0,
                  child: Padding(
                    padding: EdgeInsets.all(15),
                  ),
                ),
              ),
              subtitle: SizedBox(
                height: 15,
                child: Card(color: Theme.of(context).primaryColorLight),
              ),
            ),
          ),
          itemCount: 10,
        );
      },
      animation: animation!,
    );
    /**
     * Card(
            color: Theme.of(context).primaryColorLight,
            child: SizedBox(
              height: 5,
              child: Row(
                children: [
                  Expanded(
                    flex: (animation!.value * 100).toInt(),
                    child: Container(
                      color: Theme.of(context).primaryColorDark,
                    ),
                  ),
                  Expanded(
                    flex: (100 - (animation!.value * 100)).toInt(),
                    child: Container(
                      color: Theme.of(context).primaryColorLight,
                    ),
                  ),
                ],
              ),
            ),
          ),
     */
  }
}
