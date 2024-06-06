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
 ┃ ┃ ┃ ┣ 📜live_stream_client.dart
 ┃ ┃ ┃ ┗ 📜live_stream_client.g.dart
 ┃ ┃ ┣ 📂models
 ┃ ┃ ┃ ┣ 📜live_stream_record.dart
 ┃ ┃ ┃ ┣ 📜live_stream_record.freezed.dart
 ┃ ┃ ┃ ┗ 📜live_stream_record.g.dart
 ┃ ┃ ┗ 📂repositories
 ┃ ┃ ┃ ┗ 📜live_stream_repository.dart
 ┃ ┣ 📂picture
 ┃ ┃ ┗ 📂datasources
 ┃ ┃ ┃ ┣ 📜picture_client.dart
 ┃ ┃ ┃ ┗ 📜picture_client.g.dart
 ┃ ┣ 📂search
 ┃ ┃ ┣ 📂datasources
 ┃ ┃ ┃ ┣ 📜search_client.dart
 ┃ ┃ ┃ ┗ 📜search_client.g.dart
 ┃ ┃ ┣ 📂models
 ┃ ┃ ┃ ┣ 📜location_info.dart
 ┃ ┃ ┃ ┣ 📜location_info.freezed.dart
 ┃ ┃ ┃ ┣ 📜location_info.g.dart
 ┃ ┃ ┃ ┣ 📜search_record.dart
 ┃ ┃ ┃ ┗ 📜search_record.freezed.dart
 ┃ ┃ ┗ 📂repositories
 ┃ ┃ ┃ ┗ 📜search_repository.dart
 ┃ ┗ 📂websocket
 ┃ ┃ ┣ 📂datasources
 ┃ ┃ ┃ ┗ 📜websocket_client.dart
 ┃ ┃ ┣ 📂models
 ┃ ┃ ┃ ┣ 📜websocket_model.dart
 ┃ ┃ ┃ ┣ 📜websocket_model.freezed.dart
 ┃ ┃ ┃ ┗ 📜websocket_model.g.dart
 ┃ ┃ ┗ 📂repositories
 ┃ ┃ ┃ ┗ 📜websocket_repository.dart
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
 ┃ ┃ ┃ ┣ 📜article_view_cubit.dart
 ┃ ┃ ┃ ┣ 📜article_view_cubit.freezed.dart
 ┃ ┃ ┃ ┗ 📜article_view_state.dart
 ┃ ┃ ┗ 📂view
 ┃ ┃ ┃ ┣ 📜article_list.dart
 ┃ ┃ ┃ ┣ 📜article_screen.dart
 ┃ ┃ ┃ ┣ 📜article_view_page.dart
 ┃ ┃ ┃ ┗ 📜livestream_screen.dart
 ┃ ┣ 📂common
 ┃ ┃ ┣ 📂bottom_sheet
 ┃ ┃ ┃ ┗ 📜app_record_bottom_sheet.dart
 ┃ ┃ ┣ 📂buttons
 ┃ ┃ ┃ ┗ 📜app_elevated_button.dart
 ┃ ┃ ┣ 📂scaffolds
 ┃ ┃ ┃ ┣ 📜backward_scaffold.dart
 ┃ ┃ ┃ ┣ 📜search_scaffold.dart
 ┃ ┃ ┃ ┗ 📜submit_scaffold.dart
 ┃ ┃ ┗ 📂text_fields
 ┃ ┃ ┃ ┗ 📜app_text_area.dart
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
 ┃ ┃ ┃ ┣ 📜live_stream_record_cubit.dart
 ┃ ┃ ┃ ┣ 📜live_stream_record_cubit.freezed.dart
 ┃ ┃ ┃ ┣ 📜live_stream_record_state.dart
 ┃ ┃ ┃ ┣ 📜webrtc_cubit.dart
 ┃ ┃ ┃ ┣ 📜webrtc_cubit.freezed.dart
 ┃ ┃ ┃ ┗ 📜webrtc_state.dart
 ┃ ┃ ┗ 📂view
 ┃ ┃ ┃ ┣ 📜live_stream_broadcast_page.dart
 ┃ ┃ ┃ ┣ 📜live_stream_record_location.dart
 ┃ ┃ ┃ ┣ 📜live_stream_record_page.dart
 ┃ ┃ ┃ ┣ 📜live_stream_record_position.dart
 ┃ ┃ ┃ ┣ 📜live_stream_record_title.dart
 ┃ ┃ ┃ ┗ 📜live_stream_record_video.dart
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
 ┃ ┃ ┃ ┣ 📜profile_record_cubit.dart
 ┃ ┃ ┃ ┣ 📜profile_record_cubit.freezed.dart
 ┃ ┃ ┃ ┗ 📜profile_record_state.dart
 ┃ ┃ ┗ 📂view
 ┃ ┃ ┃ ┣ 📜profile_record_page.dart
 ┃ ┃ ┃ ┗ 📜profile_record_view.dart
 ┃ ┣ 📂search
 ┃ ┃ ┣ 📂bloc
 ┃ ┃ ┃ ┣ 📜search_record_cubit.dart
 ┃ ┃ ┃ ┣ 📜search_record_cubit.freezed.dart
 ┃ ┃ ┃ ┗ 📜search_record_state.dart
 ┃ ┃ ┗ 📂view
 ┃ ┃ ┃ ┣ 📜search_bar.dart
 ┃ ┃ ┃ ┣ 📜search_page.dart
 ┃ ┃ ┃ ┣ 📜search_place_card.dart
 ┃ ┃ ┃ ┗ 📜search_place_cards.dart
 ┃ ┗ 📜app.dart
 ┗ 📜main.dart