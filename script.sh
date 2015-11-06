echo Decrypting secrets
openssl aes-256-cbc -K $encrypted_d7f5e54ff428_key -iv $encrypted_d7f5e54ff428_iv -in secrets.tar.gz.enc -out secrets.tar.gz -d
tar xvf secrets.tar.gz
echo Building APK:
echo Executing java -jar apktool.jar b ../NetEase-Translation -o NetEase.apk
java -jar apktool.jar b ../NetEase-Translation -o NetEase.apk
echo ------------------------------------
if [ "$TRAVIS_BRANCH" = "301" ]
  then 
  cd ../NetEase-Translation/original
  zip -r ../../NetEase-Deps/Netease.apk META-INF/*
  cd ../../NetEase-Deps
fi
echo Signing APK:
echo Executing java -jar signapk.jar certificate.pem key.pk8 NetEase.apk NetEase_signed.apk
java -jar signapk.jar secrets/certificate.pem secrets/key.pk8 NetEase.apk NetEase_signed.apk
echo Uploading APK to GDrive:
 ./gdrive -c secrets/.gdrive/ upload -f NetEase_signed.apk -t NetEase_${TRAVIS_BUILD_NUMBER}_${TRAVIS_BRANCH}_signed.apk -p 0B2zELYFwobkXfm1hYVh1NUZOcHlFQ3R5SWdEd0ZzZGlsamk1VWhWc0FrUGk2QnVySlVNdDg


