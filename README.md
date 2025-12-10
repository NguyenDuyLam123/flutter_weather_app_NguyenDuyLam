🌤️ Flutter Weather App – README
📌 Giới thiệu
Flutter Weather App là ứng dụng dự báo thời tiết theo thời gian thực, sử dụng OpenWeatherMap API.
Ứng dụng hỗ trợ:
* Lấy thời tiết hiện tại theo GPS
* Tìm kiếm theo tên thành phố
* Dự báo thời tiết theo giờ và 5 ngày
* Lưu thành phố yêu thích
* Hỗ trợ offline caching
* Tùy chỉnh đơn vị nhiệt độ, đơn vị gió, định dạng giờ (12h/24h)
Ứng dụng được xây dựng theo kiến trúc Provider – MVVM simplifed và tuân thủ yêu cầu của Lab 4 – Weather App.


🚀 Tính năng chính
🌡️ Thời tiết hiện tại
* Nhiệt độ, cảm giác như
* Biểu tượng thời tiết
* Độ ẩm, áp suất, tốc độ gió
* Tầm nhìn, lượng mây
* Nền giao diện thay đổi theo điều kiện thời tiết

🕛 Dự báo
* Dự báo theo giờ (24 giờ)
* Dự báo 5 ngày
* Min/Max temperature
* Tốc độ gió và độ ẩm

🔍 Tìm kiếm thành phố
* Tìm kiếm tức thì
* Hiển thị ngay khi chọn

📍 Vị trí hiện tại
* Tự động xác định GPS khi mở app
* Xử lý permission
* Xử lý lỗi khi bị từ chối quyền

⭐ Danh sách yêu thích
* Lưu tối đa nhiều thành phố
* Xóa hoặc thêm nhanh chóng
* Lưu vĩnh viễn (SharedPreferences)

📴 Hỗ trợ Offline
* Dùng dữ liệu caching khi không có mạng
* Hiển thị cảnh báo “Hiển thị dữ liệu offline”

⚙️ Màn hình Settings
* Đơn vị nhiệt độ: C° / F°
* Đơn vị tốc độ gió: m/s, km/h, mph
* Định dạng thời gian: 12h / 24h

📂 Cấu trúc thư mục
```
lib/
 ├─ main.dart
 ├─ models/
 ├─ providers/
 ├─ services/
 ├─ screens/
 ├─ widgets/
 ├─ utils/
 ├─ config/
 ```

🔑 Setup API Key
Đăng ký tại: https://openweathermap.org/api
Tạo file .env trong thư mục gốc:
```
    OPENWEATHER_API_KEY=your_api_key_here
```
Thêm vào pubspec.yaml:
```
    flutter_dotenv: ^5.1.0
```
Đảm bảo KHÔNG commit .env lên GitHub
Trong .gitignore:
```
.env
*.env
```
Tạo file .env.example:
```
OPENWEATHER_API_KEY=
```

⚙️ Cài đặt & chạy ứng dụng
```
flutter pub get
flutter run
```

🖼️ Screenshots
Tạo thư mục:
```
screenshots/
```

Thêm các ảnh sau (theo yêu cầu của Lab):
```
🌞 Trời nắng
🌧️ Trời mưa
☁️ Nhiều mây
🌙 Chế độ ban đêm
🔍 Màn hình tìm kiếm
📊 Màn hình dự báo
❗ Trạng thái lỗi
⏳ Trang loading

```

🧪 Testing
Các test đã được chuẩn bị:
* Kiểm tra parse JSON
* Kiểm tra API hoạt động
* Kiểm tra xử lý lỗi (city not found, timeout)
* Kiểm tra cache offline

Chạy test:
```
flutter test
```