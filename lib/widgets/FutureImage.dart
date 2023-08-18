import '../exports/exports.dart';

class FutureImage extends StatelessWidget {
  final Future<String?>? future;
  const FutureImage({super.key, this.future});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: future,
        builder: (context, snapshot) {
          return snapshot.hasData
              ? Container(
                  width: 45,
                  height: 45,
                  margin: const EdgeInsets.all(0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      image: DecorationImage(
                          filterQuality: FilterQuality.high,
                          fit: BoxFit.fill,
                          image: NetworkImage(
                            snapshot.data!,
                          ))),
                )
              : CircularProgressIndicator.adaptive();
        });
  }
}
