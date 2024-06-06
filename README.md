# GeoPic(지오픽)
---
실시간 지도를 기반으로 정확한 위치에 무슨 일이 일어났는 지 눈으로 볼 수 있는 **실시간 지도 기반** SNS 서비스입니다.

![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white) 

# Getting Star
t
## 0. Pre-need
### - NaverAPI code

you have to make .env file. Add .env file on the root directory
your .env file should look like this,
``` .env
NAVER_CLIENT_ID={YOUR_CLIENT_ID}
NAVER_CLIENT_SECRET={YOUR_CLIENT_SECRET}

BASE_URL={your backend service url}
WS_URL={your websocket service url}

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

# Existing Error
---
There occurs an error when building the code. Therefore, you might need to fix some code of generated file.
If your code look like this,
``` dart
# article_client.g.dart 
@override
Future<ArticleRecord> createRecord(ArticleRecord record) async {
	final _extra = <String, dynamic>{};
	final queryParameters = <String, dynamic>{};
	final _headers = <String, dynamic>{};
	final _data = record;
```

Change code like below.
``` dart
# article_client.g.dart 
@override
Future<ArticleRecord> createRecord(ArticleRecord record) async {
	final _extra = <String, dynamic>{};
	final queryParameters = <String, dynamic>{};
	final _headers = <String, dynamic>{};
	final _data = <String, dynamic>{};
	_data.addAll(record.toJson());
```

You also have to change ==**live_stream_client.g.dart**==  createRecord like above.


# Project Structure
- use Bloc Pattern
```
📦lib  
 ┣ 📂core  
 ┃ ┣ 📂common  
 ┃ ┃ ┣ 📜converter.dart  # Convert of JsonConverter  
 ┃ ┃ ┣ 📜location.dart  # Set initialize location  
 ┃ ┃ ┗ 📜logger.dart    # Set up Logger  
 ┃ ┣ 📂errors  
 ┃ ┃ ┣ 📜api_failure.dart  # Define api_failure   
 ┃ ┃ ┗ 📜api_failure.freezed.dart  # created file    
 ┃ ┣ 📂observers  
 ┃ ┃ ┣ 📜app_router_observer.dart  # logging app_router state  
 ┃ ┃ ┗ 📜bloc_observer.dart  # logging bloc state   
 ┃ ┣ 📂resources  
 ┃ ┃ ┣ 📂injection  
 ┃ ┃ ┃ ┣ 📜injection.config.dart  # created file  
 ┃ ┃ ┃ ┗ 📜injection.dart  # For GetIt Setup  
 ┃ ┃ ┣ 📂injection_module   
 ┃ ┃ ┃ ┗ 📜injection_module.dart  # Register module to getIT  
 ┃ ┃ ┣ 📂storage   
 ┃ ┃ ┃ ┣ 📜profile_storage.dart  # Use for profile => Later for access_token  
 ┃ ┃ ┃ ┣ 📜search_storage.dart  # Use for Search Phrase  
 ┃ ┃ ┃ ┣ 📜storage.dart # Abstract of SharedPreferences  
 ┃ ┃ ┃ ┗ 📜storage_key.dart  # Using Storage Key  
 ┃ ┃ ┣ 📜app_assets.dart  # Store assets of app  
 ┃ ┃ ┗ 📜app_colors.dart  # Store app colors  
 ┃ ┣ 📂routers    
 ┃ ┃ ┣ 📜app_router.dart  # set up app_router  
 ┃ ┃ ┣ 📜app_routes.dart  # routes of all pages. You need to make routes for all new pages  
 ┃ ┃ ┗ 📜app_routes.g.dart  # created file  
 ┃ ┗ 📂services  
 ┃ ┃ ┣ 📜err_tracking_service.dart  # err_tracking  
 ┃ ┃ ┗ 📜image_picker_service.dart  # image_picker  
 ┣ 📂feature  
 ┃ ┣ 📂article  
 ┃ ┃ ┣ 📂datasources  
 ┃ ┃ ┃ ┣ 📜article_client.dart  # Define API  
 ┃ ┃ ┃ ┗ 📜article_client.g.dart  # Created file  
 ┃ ┃ ┣ 📂models  
 ┃ ┃ ┃ ┣ 📜article_record.dart  # Set up models using on flutter  
 ┃ ┃ ┃ ┣ 📜article_record.freezed.dart  # Created file  
 ┃ ┃ ┃ ┗ 📜article_record.g.dart  # Created file  
 ┃ ┃ ┗ 📂repositories  
 ┃ ┃ ┃ ┗ 📜article_repository.dart  # Handling api call on this file  
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
 ┃ ┃ ┃ ┣ 📜article_record_cubit.dart  # Define the event of actions  
 ┃ ┃ ┃ ┣ 📜article_record_cubit.freezed.dart  # Created file  
 ┃ ┃ ┃ ┗ 📜article_record_state.dart  # Define State of the page  
 ┃ ┃ ┗ 📂view  
 ┃ ┃ ┃ ┣ 📜activity_record_location.dart  # Component for the page  
 ┃ ┃ ┃ ┣ 📜activity_record_position.dart   
 ┃ ┃ ┃ ┣ 📜article_record_content.dart  
 ┃ ┃ ┃ ┣ 📜article_record_page.dart  # Main page to show. Use BlocProvider here.  
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
 ```