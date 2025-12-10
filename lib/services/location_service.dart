import 'package:geolocator/geolocator.dart';

class LocationService {
  Future<Position> getCurrentLocation() async {
    // GPS bật chưa?
    bool enabled = await Geolocator.isLocationServiceEnabled();
    if (!enabled) {
      throw Exception("Vui lòng bật GPS để ứng dụng hoạt động.");
    }

    // Kiểm tra quyền
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception("Ứng dụng cần quyền truy cập vị trí.");
      }
    }

    // Bị chặn vĩnh viễn
    if (permission == LocationPermission.deniedForever) {
      throw Exception(
        "Bạn đã từ chối quyền vị trí vĩnh viễn. Hãy bật lại trong cài đặt ứng dụng.",
      );
    }

    // Mọi thứ OK → lấy vị trí
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  Future<String> getCityName(double lat, double lon) async {
    return "Unknown"; // Có thể bổ sung reverse geocoding sau
  }
}
