telegram_id=
bot_api=
curl -s "https://api.telegram.org/bot2077617614:AAFOXH87MefDeZQO2LmTLVFAHYyQB8pW05Q/sendmessage" -d "text=Привет, сборка LineageOS 18.1 для Redmi 9T / Poco M3 началась!
      
      https://cirrus-ci.com/build/$CIRRUS_BUILD_ID
      
      $show" -d "chat_id=@WalkingCI" -d "parse_mode=HTML"
