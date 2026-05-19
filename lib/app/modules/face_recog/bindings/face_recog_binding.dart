import 'package:get/get.dart';
import '../controllers/face_recog_controller.dart';

class FaceRecogBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FaceRecogController>(() => FaceRecogController());
  }
}