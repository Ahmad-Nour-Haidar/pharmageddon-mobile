import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImageHelper {
  final ImagePicker _imagePicker = ImagePicker();
  final ImageCropper _imageCropper = ImageCropper();

  Future<XFile?> pickImage({
    ImageSource source = ImageSource.gallery,
    int imageQuality = 100,
  }) async {
    return await _imagePicker.pickImage(
      source: source,
      imageQuality: imageQuality,
    );
  }

  Future<CroppedFile?> cropImage({
    required XFile file,
    CropStyle style = CropStyle.circle,
  }) async {
    return await _imageCropper.cropImage(
      sourcePath: file.path,
      compressQuality: 100,
      cropStyle: style,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
      ],
      compressFormat: ImageCompressFormat.png,
      uiSettings: [
        AndroidUiSettings(),
      ],
    );
  }
}
