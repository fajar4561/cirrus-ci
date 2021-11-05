telegram_id=@WalkingCI
bot_api=2077617614:AAFOXH87MefDeZQO2LmTLVFAHYyQB8pW05Q
curl -s "https://api.telegram.org/bot${bot_api}/sendmessage" -d "text=Привет, сборка LineageOS 18.1 для Redmi 9T / Poco M3 началась!
      
      https://cirrus-ci.com/build/$CIRRUS_BUILD_ID
      
      $show" -d "chat_id=${telegram_id}" -d "parse_mode=HTML"
