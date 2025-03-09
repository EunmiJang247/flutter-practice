import 'package:first_app/4fourth_project_meals/screens/firstpage_categories.dart';
import 'package:first_app/4fourth_project_meals/screens/tabs.dart';
import 'package:flutter/material.dart';
import 'package:first_app/1first_project_dice_roller/gradient_container.dart';
import 'package:first_app/2second_project_quiz/quiz.dart';
import 'package:first_app/3third_project_wallet/firstpage.dart';

import 'package:flutter/services.dart'; // 세로모드만 가능하도록 고정하는 패키지

// // 첫번째 프로젝트
// void main() {
//   runApp(FirstProject(colors: [Colors.red, Colors.blue]));
// }

// 두번째 프로젝트(퀴즈 프로젝트)
// void main() {
//   runApp(const Quiz());
// }

// 세번째 프로젝트인데 세로방향만 고정되는 모드!! _1
// var kColorScheme =
//     ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 96, 59, 181));

// var kDarkColorScheme = ColorScheme.fromSeed(
//   seedColor: const Color.fromARGB(255, 5, 99, 125),
//   brightness: Brightness.dark,
// );

// void main() {
//   WidgetsFlutterBinding
//       .ensureInitialized(); // setPreferredOrientations 하기전에 바인딩 시켜줘야 한다
//   SystemChrome.setPreferredOrientations([
//     DeviceOrientation.portraitUp, // 세로 모드만 가능하도록
//   ]).then((fn) {
//     runApp(const MyApp()); // 그리고 then안에 runApp을 넣는다
//   });
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       darkTheme: ThemeData.dark().copyWith(
//         // 어두운 모드일때 테마스타일
//         colorScheme: kDarkColorScheme,
//         cardTheme: CardTheme().copyWith(
//           color: kDarkColorScheme.secondaryContainer,
//           margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//         ),
//         elevatedButtonTheme: ElevatedButtonThemeData(
//           style: ElevatedButton.styleFrom(
//               backgroundColor: kDarkColorScheme.primaryContainer,
//               foregroundColor: kDarkColorScheme.onPrimaryContainer),
//         ),
//       ),
//       theme: ThemeData().copyWith(
//         // 밝은 모드일 때 테마스타일
//         colorScheme: kColorScheme,
//         appBarTheme: const AppBarTheme().copyWith(
//           backgroundColor: kColorScheme.onPrimaryContainer,
//           foregroundColor: kColorScheme.primaryContainer,
//         ),
//         cardTheme: CardTheme().copyWith(
//           color: kColorScheme.secondaryContainer,
//           margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//         ),
//         elevatedButtonTheme: ElevatedButtonThemeData(
//           style: ElevatedButton.styleFrom(
//             backgroundColor: kColorScheme.primaryContainer,
//           ),
//         ),
//         textTheme: ThemeData().textTheme.copyWith(
//               titleLarge: TextStyle(
//                   fontWeight: FontWeight.bold,
//                   color: kColorScheme.onSecondaryContainer,
//                   fontSize: 16),
//             ),
//       ),
//       themeMode: ThemeMode.system,
//       home: const Expenses(),
//     );
//   }
// }

// 세번째 프로젝트. 세로 방향이 고정되지 않은 모드
// var kColorScheme =
//     ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 96, 59, 181));

// var kDarkColorScheme = ColorScheme.fromSeed(
//   seedColor: const Color.fromARGB(255, 5, 99, 125),
//   brightness: Brightness.dark,
// );

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       darkTheme: ThemeData.dark().copyWith(
//         // 어두운 모드일때 테마스타일
//         colorScheme: kDarkColorScheme,
//         cardTheme: CardTheme().copyWith(
//           color: kDarkColorScheme.secondaryContainer,
//           margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//         ),
//         elevatedButtonTheme: ElevatedButtonThemeData(
//           style: ElevatedButton.styleFrom(
//               backgroundColor: kDarkColorScheme.primaryContainer,
//               foregroundColor: kDarkColorScheme.onPrimaryContainer),
//         ),
//       ),
//       theme: ThemeData().copyWith(
//         // 밝은 모드일 때 테마스타일
//         colorScheme: kColorScheme,
//         appBarTheme: const AppBarTheme().copyWith(
//           backgroundColor: kColorScheme.onPrimaryContainer,
//           foregroundColor: kColorScheme.primaryContainer,
//         ),
//         cardTheme: CardTheme().copyWith(
//           // 카드위젯에 전부 영향을 주는 테마
//           color: kColorScheme.secondaryContainer,
//           margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//         ),
//         elevatedButtonTheme: ElevatedButtonThemeData(
//           style: ElevatedButton.styleFrom(
//             backgroundColor: kColorScheme.primaryContainer,
//           ),
//           // copyWith이 styleFrom과 같다 elevatedButtonTheme에서
//         ),
//         textTheme: ThemeData().textTheme.copyWith(
//               titleLarge: TextStyle(
//                   fontWeight: FontWeight.bold,
//                   color: kColorScheme.onSecondaryContainer,
//                   fontSize: 16),
//             ),
//       ),
//       themeMode: ThemeMode.system,
//       // themeMode: ThemeMode.dark,
//       // 시스템의 설정에 맞춘 밝기테마
//       home: const Expenses(), // ✅ Expenses를 여기서 감싸기
//     );
//   }
// }

// 네번째 프로젝트
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final theme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: const Color.fromARGB(255, 131, 57, 0),
  ),
  textTheme: GoogleFonts.latoTextTheme().copyWith(
    titleSmall: GoogleFonts.latoTextTheme().titleSmall?.copyWith(
          fontSize: 14,
        ),
  ),
);
void main() {
  runApp(const ProviderScope(
    child: App(),
  ));
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      home: TabsScreen(),
    );
  }
}
