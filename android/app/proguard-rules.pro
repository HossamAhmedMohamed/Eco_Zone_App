# Keep classes for Dio & OkHttp
-keep class okhttp3.** { *; }
-dontwarn okhttp3.**

# Keep classes for Gson (لو بتستخدمه)
-keep class com.google.gson.** { *; }
-dontwarn com.google.gson.**

# لو بتستخدم retrofit
-keep class retrofit2.** { *; }
-dontwarn retrofit2.**

# لو بتستخدم Firebase
-keep class com.google.firebase.** { *; }
-dontwarn com.google.firebase.**

# Firebase Core
-keep class com.google.firebase.** { *; }
-dontwarn com.google.firebase.**

# Firebase Analytics
-keep class com.google.firebase.analytics.** { *; }

# Firebase Messaging (لو بتستخدم الإشعارات)
-keep class com.google.firebase.messaging.** { *; }
-dontwarn com.google.firebase.messaging.**

# Firebase Auth (لو بتستخدم تسجيل الدخول)
-keep class com.google.firebase.auth.** { *; }
-dontwarn com.google.firebase.auth.**

# Firebase Firestore
-keep class com.google.firebase.firestore.** { *; }
-dontwarn com.google.firebase.firestore.**

# Firebase Realtime Database
-keep class com.google.firebase.database.** { *; }
-dontwarn com.google.firebase.database.**

-keep class android.content.SharedPreferences { *; }
-keep class android.preference.PreferenceManager { *; }

-keep class com.google.android.gms.maps.** { *; }
-keep interface com.google.android.gms.maps.** { *; }
-dontwarn com.google.android.gms.maps.**


