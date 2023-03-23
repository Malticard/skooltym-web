import '/exports/exports.dart';

class CropSample extends StatefulWidget {
  final Uint8List image;
  final CropController controller;
  final void Function(Uint8List) onCrop;
  const CropSample(
      {Key? key,
      required this.image,
      required this.controller,
      required this.onCrop})
      : super(key: key);
  @override
  _CropSampleState createState() => _CropSampleState();
}

class _CropSampleState extends State<CropSample> {
  var _loadingImage = false;

  var _isSumbnail = false;
  var _isCropping = false;
  var _isCircleUi = false;
  Uint8List? _croppedData;
  var _statusText = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height / 2,
      child: Center(
        child: Visibility(
          visible: !_isCropping,
          child: Expanded(
            flex: 3,
            child: Column(
              children: [
                Expanded(
                  child: Visibility(
                    visible: _croppedData == null,
                    child: Stack(
                      children: [
                        if (widget.image.isNotEmpty) ...[
                          Crop(
                            controller: widget.controller,
                            image: widget.image,
                            onCropped: (croppedData) {
                              setState(() {
                                _croppedData = croppedData;
                                _isCropping = false;
                              });
                            },
                            withCircleUi: _isCircleUi,
                            onStatusChanged: (status) => setState(() {
                              _statusText = <CropStatus, String>{
                                    CropStatus.nothing:
                                        'Crop has no image data',
                                    CropStatus.loading:
                                        'Crop is now loading given image',
                                    CropStatus.ready: 'Crop is now ready!',
                                    CropStatus.cropping:
                                        'Crop is now cropping image',
                                  }[status] ??
                                  '';
                            }),
                            initialSize: 0.5,
                            maskColor: _isSumbnail ? Colors.white : null,
                            cornerDotBuilder: (size, edgeAlignment) =>
                                const SizedBox.shrink(),
                            interactive: true,
                            fixArea: true,
                            radius: 20,
                            initialAreaBuilder: (rect) {
                              return Rect.fromLTRB(
                                rect.left + 24,
                                rect.top + 24,
                                rect.right - 24,
                                rect.bottom - 24,
                              );
                            },
                          ),
                          IgnorePointer(
                            child: Padding(
                              padding: const EdgeInsets.all(24),
                              child: Container(
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(width: 4, color: Colors.white),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            ),
                          ),
                        ],
                        Positioned(
                          right: 16,
                          bottom: 16,
                          child: GestureDetector(
                            onTapDown: (_) =>
                                setState(() => _isSumbnail = true),
                            onTapUp: (_) => setState(() => _isSumbnail = false),
                            child: CircleAvatar(
                              backgroundColor: _isSumbnail
                                  ? Colors.blue.shade50
                                  : Colors.blue,
                              child: Center(
                                child: Icon(Icons.crop_free_rounded),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    replacement: Center(
                      child: _croppedData == null
                          ? SizedBox.shrink()
                          : Image.memory(_croppedData!),
                    ),
                  ),
                ),
                if (_croppedData == null)
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              icon: Icon(Icons.crop_7_5),
                              onPressed: () {
                                _isCircleUi = false;
                                widget.controller.aspectRatio = 16 / 4;
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.crop_16_9),
                              onPressed: () {
                                _isCircleUi = false;
                                widget.controller.aspectRatio = 16 / 9;
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.crop_5_4),
                              onPressed: () {
                                _isCircleUi = false;
                                widget.controller.aspectRatio = 4 / 3;
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.crop_square),
                              onPressed: () {
                                _isCircleUi = false;
                                widget.controller
                                  ..withCircleUi = false
                                  ..aspectRatio = 1;
                              },
                            ),
                            IconButton(
                                icon: Icon(Icons.circle),
                                onPressed: () {
                                  _isCircleUi = true;
                                  widget.controller.withCircleUi = true;
                                }),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Container(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                _isCropping = true;
                              });
                              _isCircleUi
                                  ? widget.controller.cropCircle()
                                  : widget.controller.crop();
                              Routes.popPage(context);
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              child: Text('Crop'),
                            ),
                          ),
                        ),
                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
                const SizedBox(height: 16),
                Text(_statusText),
                const SizedBox(height: 16),
              ],
            ),
          ),
          replacement: const CircularProgressIndicator(),
        ),
      ),
    );
  }

  Expanded _buildSumbnail(Uint8List data) {
    return Expanded(
      child: InkWell(
        onTap: () {
          _croppedData = null;
        },
        child: Container(
          height: 100,
          decoration: BoxDecoration(
            border: Border.all(
              width: 8,
              color: Colors.blue,
            ),
          ),
          child: Image.memory(
            data,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
