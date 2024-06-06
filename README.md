# GeoPic(지오픽)
---
실시간 지도를 기반으로 정확한 위치에 무슨 일이 일어났는 지 눈으로 볼 수 있는 **실시간 지도 기반** SNS 서비스입니다.

![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white) 

# Getting Start
## 1. Install Flutter
### macOS
- you can easily install flutter in macOS
``` shell 
brew install flutter
```
### Others
- Check below site for install
[Flutter Install](https://flutter-ko.dev/get-started/install) 

## 2. Clone the repository

``` bash
git clone https://github.com/rlaminseok0824/GeoPic.git
```

## 3. Install Dependencies

``` Shell
flutter pub get
```

## 4. Generate Codes
- As we use builder for the app. You have to build codes.
``` bash
dart run build_runner build --delete-conflicting-outputs
```

## 5. Run the app
- Now you can run the app
``` bash
flutter run
```

# Project Structure
  - Use Bloc Pattern
📦lib  
 ┣ 📂core  
 ┃ ┣ 📂common  
 ┃ ┃ ┣ 📜converter.dart  
 ┃ ┃ ┣ 📜location.dart  
 ┃ ┃ ┗ 📜logger.dart   
 ┃ ┣ 📂errors  
 ┃ ┃ ┣ 📜api_failure.dart 
 ┃ ┃ ┗ 📜api_failure.freezed.dart  
 ┃ ┣ 📂observers  
 ┃ ┃ ┣ 📜app_router_observer.dart
 ┃ ┃ ┗ 📜bloc_observer.dart
 ┃ ┣ 📂resources  
 ┃ ┃ ┣ 📂injection  
 ┃ ┃ ┃ ┣ 📜injection.config.dart
 ┃ ┃ ┃ ┗ 📜injection.dart  
 ┃ ┃ ┣ 📂injection_module  
 ┃ ┃ ┃ ┗ 📜injection_module.dart
 ┃ ┃ ┣ 📂storage  
 ┃ ┃ ┃ ┣ 📜profile_storage.dart  
 ┃ ┃ ┃ ┣ 📜search_storage.dart 
 ┃ ┃ ┃ ┣ 📜storage.dart 
 ┃ ┃ ┃ ┗ 📜storage_key.dart  
 ┃ ┃ ┣ 📜app_assets.dart 
 ┃ ┃ ┗ 📜app_colors.dart  
 ┃ ┣ 📂routers  
 ┃ ┃ ┣ 📜app_router.dart 
 ┃ ┃ ┣ 📜app_routes.dart
 ┃ ┃ ┗ 📜app_routes.g.dart 
 ┃ ┗ 📂services  
 ┃ ┃ ┣ 📜err_tracking_service.dart  
 ┃ ┃ ┗ 📜image_picker_service.dart  
 ┣ 📂feature  
 ┃ ┣ 📂article  
 ┃ ┃ ┣ 📂datasources  
 ┃ ┃ ┃ ┣ 📜article_client.dart  
 ┃ ┃ ┃ ┗ 📜article_client.g.dart 
 ┃ ┃ ┣ 📂models  
 ┃ ┃ ┃ ┣ 📜article_record.dart
 ┃ ┃ ┃ ┣ 📜article_record.freezed.dart
 ┃ ┃ ┃ ┗ 📜article_record.g.dart  
 ┃ ┃ ┗ 📂repositories  
 ┃ ┃ ┃ ┗ 📜article_repository.dart  
 ┃ ┣ 📂live_stream  
 ┃ ┃ ┣ 📂datasources  
 ┃ ┃ ┣ 📂models  
 ┃ ┃ ┗ 📂repositories  
 ┃ ┣ 📂picture  
 ┃ ┃ ┗ 📂datasources  
 ┃ ┣ 📂search  
 ┃ ┃ ┣ 📂datasources  
 ┃ ┃ ┣ 📂models  
 ┃ ┃ ┗ 📂repositories  
 ┃ ┗ 📂websocket  
 ┃ ┃ ┣ 📂datasources  
 ┃ ┃ ┣ 📂models  
 ┃ ┃ ┗ 📂repositories  
 ┣ 📂presentation  
 ┃ ┣ 📂article  
 ┃ ┃ ┣ 📂bloc  
 ┃ ┃ ┃ ┣ 📜article_record_cubit.dart
 ┃ ┃ ┃ ┣ 📜article_record_cubit.freezed.dart 
 ┃ ┃ ┃ ┗ 📜article_record_state.dart 
 ┃ ┃ ┗ 📂view  
 ┃ ┃ ┃ ┣ 📜activity_record_location.dart  
 ┃ ┃ ┃ ┣ 📜activity_record_position.dart  
 ┃ ┃ ┃ ┣ 📜article_record_content.dart  
 ┃ ┃ ┃ ┣ 📜article_record_page.dart  
 ┃ ┃ ┃ ┣ 📜article_record_picture.dart  
 ┃ ┃ ┃ ┗ 📜article_record_title.dart  
 ┃ ┣ 📂article_view  
 ┃ ┃ ┣ 📂bloc  
 ┃ ┃ ┗ 📂view  
 ┃ ┣ 📂common  
 ┃ ┃ ┣ 📂bottom_sheet  
 ┃ ┃ ┣ 📂buttons  
 ┃ ┃ ┣ 📂scaffolds  
 ┃ ┃ ┗ 📂text_fields  
 ┃ ┣ 📂home  
 ┃ ┃ ┣ 📂bloc  
 ┃ ┃ ┃ ┣ 📜home_bottom_navigation_bar_cubit.dart  
 ┃ ┃ ┃ ┣ 📜home_bottom_navigation_bar_cubit.freezed.dart 
 ┃ ┃ ┃ ┗ 📜home_bottom_navigation_bar_state.dart  
 ┃ ┃ ┗ 📂view  
 ┃ ┃ ┃ ┣ 📜home_bottom_navigation_bar.dart  
 ┃ ┃ ┃ ┣ 📜home_page.dart  
 ┃ ┃ ┃ ┗ 📜home_page_view.dart  
 ┃ ┣ 📂live_stream  
 ┃ ┃ ┣ 📂bloc  
 ┃ ┃ ┗ 📂view  
 ┃ ┣ 📂map  
 ┃ ┃ ┣ 📂bloc  
 ┃ ┃ ┃ ┣ 📜map_cubit.dart  
 ┃ ┃ ┃ ┣ 📜map_cubit.freezed.dart  
 ┃ ┃ ┃ ┗ 📜map_state.dart  
 ┃ ┃ ┗ 📂view  
 ┃ ┃ ┃ ┣ 📜article_record_bottom_sheet.dart  
 ┃ ┃ ┃ ┣ 📜current_position_button.dart  
 ┃ ┃ ┃ ┣ 📜map_page.dart  
 ┃ ┃ ┃ ┣ 📜map_search_bar.dart  
 ┃ ┃ ┃ ┗ 📜map_view.dart  
 ┃ ┣ 📂profile  
 ┃ ┃ ┣ 📂bloc  
 ┃ ┃ ┗ 📂view  
 ┃ ┣ 📂search  
 ┃ ┃ ┣ 📂bloc  
 ┃ ┃ ┗ 📂view  
 ┃ ┗ 📜app.dart  
 ┗ 📜main.dart