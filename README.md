# Flutter개발할때 규칙
위젯은 각각의 다른 파일로 구분해주는 것이 좋다.

# lib > main.dart
void main() {} -> void: 반환유형 main: 함수이름
main()은 Flutter/Dart에서 자동으로 실행되는 함수이기 때문에 별도로 호출할 필요가 없다
runApp에서 Flutter 애플리케이션을 시작한다
runApp()을 통해 최상위 위젯을 Flutter 엔진에 등록하면 화면이 그려진다.

# Formatter 돌리기
모든 )뒤에,를 치고 Cmd Shift P -> format document 클릭

# 라이브러리 종속성 관리하는 곳
pubspec.yaml

# dart에 대하여
dart는 객체지향언어이기 때문에 모든것이 Object로 작성된다.
내가 작성할 커스텀 위젯도 클라스로 작성해야 한다.

# dart의 변수 지정방법
const startAlignment = Alignment.topLeft;

# const와 var의 차이점
const: 컴파일 타임 상수(앱 실행 전에 값이 결정됨)
const message = "Hello, Dart!"; // 가능 (상수)
const now = DateTime.now(); // ❌ ERROR! (DateTime.now()는 실행 중에 값이 결정됨)
const를 붙이면 두번째로 랜더링 될때 두번째 메모리 개체가 생성되는 대신 기존 메모리가 재사용된다

var: 
변수 (Variable), 값 변경 가능
✅ 앱 실행 중에 값이 변경될 수 있음

아래의 경우 const를 앞에 붙일수 없는데, 색상 값은 런타임 시 상속되기 때문에다 

void main() {
  runApp(FirstProject(colors: [Colors.red, Colors.blue]));
}

# final
✅ 한 번 할당되면 변경 불가능
✅ 런타임(실행 시점)에 값이 결정됨
✅ 값을 실행 중에 동적으로 할당할 수 있음
실행 시점에서 값이 결정되지만, 한 번 할당된 이후에는 변경할 수 없음
final now = DateTime.now(); // 가능! (실행할 때 결정됨)
print(now); // 실행할 때마다 다른 값이 나옴
now = DateTime(2025, 1, 1); // ❌ 오류! (final 변수는 재할당 불가)
void main() {
  final int number; // 선언만 해놓음 (초기화X)
  number = 10; // ✅ 가능 (첫 할당)
  number = 20; // ❌ 오류 발생 (한 번 정하면 변경 불가!)
}
final 필드는 반드시 생성자에서 값을 받아야 한다

# 실행 시점(런타임) 컴파일 시점 차이?
컴파일 시점(Compile Time): 프로그램이 실행되기 전에, 소스 코드가 기계어로 변환되는 단계(const 변수는 이때 값이 확정됨)
실행 시점(Runtime): 프로그램이 실제로 실행되는 단계(final 변수는 이때 확정)

# StatelessWidget 
플러터에서 제공하는 클래스를 상속

# super.key
super.key: 부모에게 key를 전달하는 부분이다
super를 통해 부모에게 접근한다
용도: 위젯 트리를 최적화해서 불필요한 다시 그리기(Rebuild)를 방지하기 위해

# 구글폰트 추가 하는 명령어
flutter pub add google_fonts
style: GoogleFonts.lato(
    color: const Color.fromARGB(255, 201, 153, 251),
    fontSize: 24,
    fontWeight: FontWeight.bold),

# 하위 컴포넌트로 변수 상속하기
FirstProject(colors: [Colors.red, Colors.blue]) 이 함수 안에는
const FirstProject({super.key, required this.colors});

# required란?
required로 지정된 매개변수는 호출할 때 값을 빼먹을 수 없고, 값이 없으면 컴파일 오류가 발생한다. 

# MaterialApp
최상단에 MaterialApp가 있어야함

# Widget
Widget build(context) { -> 위젯을 반환하니까 맨 앞에 Widget을 써놓은 것이다
context 라는 매개변수를 넣어줘야 한다.

# StatefulWidget
StatefulWidget에서는 UI를 동적으로 변경할 때 State가 필요합니다
화면이 변하는 위젯은 StatefulWidget를 상속받는다 
StatefulWidget을 만들 때 반드시 createState() 메서드를 오버라이드 해야함(이 메서드는 위젯의 상태를 관리할 State 객체를 반환)
example)
class DiceRoller extends StatefulWidget {
  const DiceRoller({super.key});

  @override
  State<DiceRoller> createState() {
    return _DiceRollerState();
  }
}
class _DiceRollerState extends State<DiceRoller> {

# setState
setState가 실행되면 build가 한번 더 실행된다

# 정렬
세로 정렬에 가운데 맞추기
    return Column(
      mainAxisSize: MainAxisSize.min,

# 버튼
TextButton(
    onPressed: rollDice,
    style: TextButton.styleFrom(
        padding: EdgeInsets.only(top: 24),
        foregroundColor: Colors.white,
        textStyle: TextStyle(fontSize: 28)),
    child: const Text('Roll Dice'),
)

# 속성 초기화
class StartScreen extends StatelessWidget {
  const StartScreen(this.startQuiz, {super.key});
  final void Function() startQuiz;
startQuiz를 매개변수로 받고 startQuiz 매개변수를 StartScreen 클래스의 startQuiz 속성에 할당하는 과정이다. 
이것을 해주지 않으면 startQuiz는 생성자에서만 존재하고 사라진다->build에서사용불가

# const FirstProject({super.key, required this.colors})와 const FirstProject(this.colors,{super.key});의 차이점
{ }안에 매개변수가 선언되어 있으면 required를 달아야 하고 아니면 required를 달지 않아도 된다. 변수가 선언된 것 만으로 필수값이라는 것을 의미하기 때문이다 

# 사진에 투명도를 추가하기
Image.asset(
    'assets/images/quiz-logo.png',
    width: 300,
    color: Color.fromARGB(150, 255, 255, 255),
),

# 버튼에 아이콘 넣고싶을때
OutlinedButton.icon(
onPressed: () {
    startQuiz();
},
style: OutlinedButton.styleFrom(foregroundColor: Colors.white),
icon: const Icon(
    Icons.arrow_right_alt,
    color: Colors.white,
),
label: Text('Click!!?'),
)

# 상속받은 부모의 함수를 사용하기
onSelectAnswer를 부모로부터 상속 받았고 이것을 쓰고 값을 주기 위해
widget. ~ 으로 접근했다.
State 클래스에서는 해당 위젯의 상태를 변경할 수 있지만,
State 객체 내에서는 StatefulWidget의 프로퍼티나 메서드에 직접 접근할 수 없습니다.
그래서 widget이라는 객체를 통해 StatefulWidget 인스턴스에 접근한다

ex)
class QuestionsScreen extends StatefulWidget {
  const QuestionsScreen({super.key, required this.onSelectAnswer});

  final void Function(String answer) onSelectAnswer;

  @override
  State<QuestionsScreen> createState() {
    return _QuestionsScreenState();
  }
}
class _QuestionsScreenState extends State<QuestionsScreen> {
  var currentQuestionIndex = 0;

  void answerQuestion(String selecteAnswer) {
    widget.onSelectAnswer(selecteAnswer);
    setState(() {
      currentQuestionIndex += 1;
    });
  } ...

# 컨테이너 넓이, 마진 설정하기
return SizedBox(
    width: double.infinity,
    child: Container(
    margin: EdgeInsets.all(40),

# map() 사용법
...(spread operator)를 써야 하는 이유
Flutter의 Column 위젯에서 children 속성은
**위젯 리스트(List<Widget>)**를 받습니다.
하지만 .map() 함수는 Iterable을 반환하므로,
이를 리스트로 변환해 주어야 합니다. ...를 사용하면
Iterable<Widget>을 List<Widget>로 펼쳐서(spread)
전달할 수 있습니다.
ex)
    ...currentQuestion.getShuffledAnswers().map((answer) {
        return AnswerButton(
            answer: answer,
            onTap: () {
            answerQuestion(answer);
            });
    }),

# Uuid 쓰기
다운로드: import 'package:uuid/uuid.dart';
dependencies:
  flutter:
    sdk: flutter
  uuid: ^3.0.6  # 최신 버전으로 설정하세요.
그 다음
flutter pub get
사용방법:
class Expenses {
  Expenses({required this.title, required this.amount, required this.date})
      : id = uuid.v4();
} => 초기화 할때마다 id가 고유하게 생긴다
다시 빌드
flutter run

# 애뮬레이터에서 키보드 올라오게 키는 방법
command + shift + K 하면 된다.

# 크롬에서 플러터 디버깅
Shift command p -> open dev tools in browser 클릭

# RiverPod다운받기
flutter pub add flutter_riverpod

!세번째 프로젝트!
# 테마 적용하기 
ColorScheme.fromSeed() : 
지정한 색상(seedColor)을 기반으로 다양한 색상이 자동 생성된다
두가지를 만들어야 한다. 밝은 모드와 어두운 모드.
ex)
var kColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 96, 59, 181),
);
이고 사용은 MaterialApp 안에 theme:을 선언한다
ex)
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData().copyWith(
        colorScheme: kColorScheme,
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: kColorScheme.onPrimaryContainer,
          foregroundColor: kColorScheme.primaryContainer,
        ),
        
그리고 앱 안에서 colorScheme을 사용할 때는

ThemeData() → Flutter의 기본 테마 설정
.copyWith({...}) → 기본 테마를 유지하면서 일부만 변경

그리고 colorScheme사용법은
ex)
    return ListView.builder(
        itemCount: expenses.length,
        itemBuilder: (ctx, index) => Dismissible(
              key: ValueKey(expenses[index]),
              background: Container(
                color: Theme.of(context).colorScheme.error.withOpacity(0.75),
이다.

# 쓸 수 있는 ColorScheme
ColorScheme에는 총 13가지 색상 속성이 있어.
속성명	설명	라이트 모드	다크 모드
- primary:	기본 색상 (앱의 주요 색상)	seedColor 기반	seedColor 기반
- onPrimary:	primary 위에 표시되는 텍스트/아이콘 색상	흰색(보통)	검은색(보통)
- primaryContainer:	primary보다 연한 배경 색상	연한  primary	어두운 primary
- onPrimaryContainer:	primaryContainer 위에 표시되는 텍스트/아이콘 색상	primary	연한 primary
- secondary:	보조 색상	seedColor 기반	seedColor 기반
- onSecondary:	secondary 위에 표시되는 텍스트/아이콘 색상	흰색(보통)	검은색(보통)
- secondaryContainer:	secondary보다 연한 배경 색상	연한 - secondary:	어두운 secondary
- onSecondaryContainer:	secondaryContainer 위에 표시되는 텍스트/아이콘 색상	secondary	연한 secondary
- error:	에러 색상 (보통 빨간색)	빨강 (#B00020)	밝은 빨강 (#CF6679)
- onError:	error 위에 표시되는 텍스트/아이콘 색상	흰색(보통)	검은색(보통)
- background:	기본 배경 색상	seedColor 기반	seedColor 기반
- onBackground:	background 위에 표시되는 텍스트 색상	검은색	흰색
- surface:	카드, 다이얼로그 같은 표면 색상	연한 회색 (#FFFFFF)	어두운 회색 (#121212)
onSurface:	surface 위에 표시되는 텍스트 색상	검은색	흰색

# 테마 변수를 지정하기(titleLarge)
textTheme에 titleLarge 라는 테마변수를 저장했다. 

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: textTheme: ThemeData().textTheme.copyWith(
              titleLarge: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: kColorScheme.onSecondaryContainer,
                  fontSize: 16),
            ),
      ),
이 titleLarge 를 적용하기 위해 style: Theme.of(context).textTheme.titleLarge 이렇게 사용한다. 
ex)
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              expense.title,
              style: Theme.of(context).textTheme.titleLarge,
              // theme을 쓰지만 그외 다른거는 내가 커스터마이징 하고싶을 때 copyWith을 쓴다
            ),

# theme 안에 cardTheme을 정의하면 그 밑의 모든 Card위젯에 적용된다
ex)
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData().copyWith(
        cardTheme: CardTheme().copyWith(
          color: kColorScheme.secondaryContainer,
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
      ),

# theme을 쓰지만 그외 다른거는 내가 커스터마이징 하고싶을 때 copyWith을 쓴다


# 어두운 모드일때와 밝을때 테마정의 MaterialApp에서 진행하기
return MaterialApp(
  darkTheme: ThemeData.dark().copyWith(
    ...
  ),
  theme: ThemeData().copyWith(
    ...
  )
)

# 다크/라이트모드 적용하는 것은 MaterialApp에서 정의한다
themeMode: ThemeMode.dark,로 쓰면 다크모드만
themeMode: ThemeMode.light로 쓰면 라이트모드임
ex)
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.system, // 시스템의 설정에 맞춘 밝기테마
      home: const Expenses(),
    );

# 모달 열기
버튼을 누르면 모달이 열리게 하는 버튼을 만든다
ex)
return Scaffold(
  appBar: AppBar(
    title: Text('Flutter Expense Tracker'),
    actions: [
      IconButton(
          onPressed: _openAddExpenseOverlay, icon: const Icon(Icons.add))
    ],
아래가 열리는 함수이다 
  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      useSafeArea: true, // -->  이거를 설정하면 위의 시간이나 배터리를 나타내는 상태바에 침범하지 않고 그 밑에부터 화면이 나옴
      isScrollControlled: true, // --> 모달이 전체화면을 차지하도록
      context: context,
      builder: (ctx) => NewExpense(addNewList: addNewList), // ctx: 모달의 컨텍스트이다
    );
    // showModalBottomSheet 함수는 내부적으로 현재 위젯 트리에서 제공된 context를 사용하여 모달을 표시합니다.
    // context는 위젯이 트리에서 어디에 위치하는지를 나타내는 역할을 하고,
    // 이를 이용해 모달, 테마, 네비게이션 등을 조작할 수 있다
  }

# 모달 닫기
ex)
  TextButton(
      onPressed: () {
        Navigator.pop(context);
        // 모달접기
      },
      child: const Text('Cancel')),

# context란?
BuildContext는 위젯 트리에서 특정 위젯의 위치를 나타내는 객체이다
함수들이 현재 위젯이 속한 BuildContext를 사용해서 부모 요소의 데이터를 찾을 때 사용된다. 

# 리스트로 쓰이는 위젯
1. ListView.builder: 길이를 알수없는 리스트는 이걸 쓴다(보이기 직전에만 생성되어 메모리를 아낄 수 있음)

# 왼쪽으로 밀어서 지우는것 구현하기
Dismissible위젯을 사용한다
그리고 삭제하는 부분은 onDismissed에 정의한다
ex) 
@override
Widget build(BuildContext context) {
  return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (ctx, index) => Dismissible(
        key: ValueKey(expenses[index]),
        onDismissed: (direction) {
          onRemoveExpense(expenses[index]);
        },
      ) ...

# 폼에 text input 사용하기
1. TextEditingController 선언하기 
final _titleController = TextEditingController();
2. dispose 선언하기
하는이유: TextEditingController 같은 객체는 위젯이 없어져도 자동으로 정리되지 않아!
따라서 직접 dispose()를 호출해서 메모리에서 해제해 줘야 해
ex)
@override
void dispose() {
  _titleController.dispose();
  super.dispose();
}
3. TextField 위젯에 적용
child: TextField(
  controller: _titleController,
  maxLength: 50,
  decoration:
      const InputDecoration(label: Text('Title')),
),
4. _titleController.text와 같이 값을 불러와서 사용한다
widget.addNewList(Expense(
    title: _titleController.text,
    amount: enteredAmount,
    date: DateTime.now(),
    category: _selectedCategory));

# 부모의 함수를 자식이 사용해서 값을 부모 위젯으로 올릴 때 
addNewList를 상속 받았다면 
상속받을 때는 아래와 같이 쓰고
class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.addNewList});
  final void Function(Expense answer) addNewList;

이거를 진짜 사용하는 부분에서는 widget.으로 받아서 값을 전달한다
widget.addNewList(Expense(
    title: _titleController.text,
    amount: enteredAmount,
    date: DateTime.now(),
    category: _selectedCategory));

# 팝업창
쓰기 위해 import 'package:flutter/cupertino.dart' 이거를 임포트 해야한다

ios와 android로 나뉨
if (Platform.isIOS) {
  showCupertinoDialog()
} else {
  showDialog()}

# ios인지 안드로인지 아는 방법
Platform.isIOS

# 핸드폰의 넓이, 높이 아는 방법
LayoutBuilder를 선언해야 쓸수있다
constraints가 바뀔때마다 실행이 된다

return LayoutBuilder(builder: (ctx, constraints) {
print(constraints.minWidth); // 세로: 0.0 / 가로 : 0
print(constraints.maxWidth); // 세로: 430.0 / 가로 : 640
print(constraints.minHeight); // 세로: 0.0 / 가로: 0
print(constraints.maxHeight); // 세로: 873.0 / 가로 430

이것을 사용하는 방법
child: Column(
  children: [
    if (width >= 600)
      // width > 600일때 실행됨
      Row(
        
# 키보드 밑에 화면을 스크롤링 되게 하기!
1. 키보드의 높이를 구하는 방법
final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;

2. SingleChildScrollView로 감싼다
SingleChildScrollView는 자식 위젯이 필요한 만큼만 공간을 차지하도록 동작한다. 그렇기 때문에 height: double.infinity,를 적용해야 한다
키보드가 올라와도 입력 필드를 가리지 않고 스크롤해서 볼 수 있게 해줌
ex)
@override
Widget build(BuildContext context) {
  final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;

  return LayoutBuilder(builder: (ctx, constraints) {
    final width = constraints.maxWidth;
    final height = constraints.maxHeight;

    return SizedBox(
      height: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(16, 48, 16, keyboardSpace + 16),

# Expanded
Expanded는 Row, Column, Flex 내부에서 가용 공간을 최대한 차지하도록 함.
Expanded를 사용하지 않으면 Row 내부에서 크기 문제로 UI가 깨질 수 있음.

# 날짜 선택하는 위젯

Expanded(
  child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(_selectedDate == null
            ? 'Selected Date'
            : formatter.format(_selectedDate!)),
        // 무조건 null이 아니기에 !를 추가함
        IconButton(
            onPressed: _presentDatePicker,
            icon: const Icon(Icons.calendar_month))
      ]),
)

달력이 열리는 함수
여기서 context는 NewExpense 위젯의 컨텍스트를 의미한다
  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: firstDate,
        lastDate: now);

    setState(() {
      _selectedDate = pickedDate;
    });
  }

# 날짜 포맷터 쓰기
날짜를 "연/월/일 (Year/Month/Day)" 형식으로 변환하는 formatter를 생성한다
다운로드: 설치방법: flutter pub add intl
예제)
import 'package:intl/intl.dart'; // intl 패키지를 임포트해야 함
void main() {
  final formatter = DateFormat.yMd(); // yMd() 형식 (예: 2024/3/8)
  DateTime now = DateTime.now(); // 현재 날짜
  String formattedDate = formatter.format(now); // 날짜를 문자열로 변환
  print(formattedDate); // 예: "3/8/2024" (디바이스 로캘에 따라 다름)
}

# 날짜 selectbox에서 없을수도 있는 날짜를 받는 방법
1. 변수 선언
  DateTime? _selectedDate;
2. 사용부 :에서는 변수 뒤에 !를 붙인다 
  Text(_selectedDate == null
      ? 'Selected Date'
      : formatter.format(_selectedDate!)),

# 드롭다운 사용하기
  DropdownButton(
      value: _selectedCategory,
      items: Category.values
          .map((category) => DropdownMenuItem(
              value: category,
              child: Text(category.name.toUpperCase())))
          .toList(),
      onChanged: (value) {
        setState(() {
          if (value == null) {
            return;
          }
          setState(() {
            _selectedCategory = value;
          });
        });
      }),
카테고리 변수는 아래와 같음
enum Category { food, travel, leisure, work }

# enum
enum Category { food, travel, leisure, work }

# 클래스를 정의
객체(인스턴스)를 만들 때 사용된다
ex)
class Expense {
  Expense(
      {required this.title,
      required this.amount,
      required this.date,
      required this.category})
      : id = uuid.v4();

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  get formattedDate {
    return formatter.format(date);
  }
}

  Expense 생성자로 Expense 객체를 만들 때 4개의 데이터를 필수로 받아야 함:
    title (지출 이름)
    amount (금액)
    date (날짜)
    category (카테고리)
  
  : id = uuid.v4();
  id는 외부에서 받지 않고 자동으로 생성됨
  uuid.v4()를 사용해 고유한 ID(UUID) 를 생성

  final 키워드를 사용해서 변경할 수 없는 데이터(불변 데이터)를 선언하여 Expense 객체가 생성될 때 값이 설정되고, 이후 변경되지 않는다

  formattedDate는 getter이다
  사용방법:
  print("Expense Date (formatted): ${myExpense.formattedDate}"); 
  formattedDate의 값은 인스턴스를 만들 때 넣은 date 값이 있기 때문에 getter에서 반환할 수 있다.


# 하나의 파일에 두 개의 클래스를 정의
class Expense {

} 밑에
class ExpenseBucket {

}이 선언되어있다. 

같은 파일에 등록이 되어있는 이유는 Expense개수만큼
ExpenseBucket가 생기기 때문이다. 

# 이름있는 생성자(Named Constructor)
ExpenseBucket.forCategory가 이름있는 생성자이고 forCategory가 그 이름이다
역할: 특정 카테고리의 Expense만 필터링해서 생성한다

ex)
class ExpenseBucket {
  const ExpenseBucket({required this.category, required this.expenses});
  ExpenseBucket.forCategory(List<Expense> allExpenses, this.category)
      : expenses = allExpenses
            .where((expense) => expense.category == category)
            .toList();

사용: 
ExpenseBucket.forCategory(expenses, Category.food),

.toList() 쓰는 이유:
  ➡ where()는 Iterable<Expense>을 반환합니다.
  ➡ 하지만 expenses 변수는 List<Expense> 타입입니다.
  ➡ 그래서 Iterable을 List로 변환하기 위해 .toList()를 사용한 것이다

# 세로 모드만 가능하도록 바꾸기
void main() {
  WidgetsFlutterBinding
      .ensureInitialized(); // setPreferredOrientations 하기전에 바인딩 시켜줘야 한다
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp, // 세로 모드만 가능하도록
  ]).then((fn) {
    runApp(const MyApp()); // 그리고 then안에 runApp을 넣는다
  });
}

// 4. 네번째 프로젝트

# 리버팟 사용(StatefulWidget 일때)
임포트: 
import 'package:flutter_riverpod/flutter_riverpod.dart';
1. Riverpod을 사용하려면 ProviderScope로 앱을 감싸야한다
ex)
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(
    child: App(),
  ));
}

2. provider를 선언한다

dummyMeals는 다음과 같은 배열이다
const dummyMeals = [
//   Meal(),
//   Meal(),
//   Meal(),
// ]

import 'package:first_app/4fourth_project/data/dummy_data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final mealsProvider = Provider((ref) {
  return dummyMeals;
});

리턴으로 dummyMeals를 반환해준다 

3. ref.watch()로 쓴다
프로바이더 임포트
import 'package:first_app/4fourth_project/providers/meals_provider.dart';

final filteredMealsProvider = Provider((ref) {
  final meals = ref.watch(mealsProvider);

ref.watch는 Provider가 관리하는 상태를 "구독"하는 함수이다. 
특정 Provider의 값을 계속 감시(watch)하고, 그 값이 변경되면 자동으로 다시 빌드되게 만든다. 
즉, mealsProvider의 값이 바뀌면 자동으로 filteredMealsProvider 도 다시 계산됨

4. StatefulWidget 대신 ConsumerStatefulWidget를 써야함
class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

5. createState 를 ConsumerState로 변경한다
State<TabsScreen> createState() { => 
ConsumerState<TabsScreen> createState() {


6. State를 ConsumerState로 바꾼다
class _TabsScreenState extends State<TabsScreen> { 
-> class _TabsScreenState extends ConsumerState<TabsScreen> {


# 리버팟 사용(StatelessWidget 일때)
임포트: 
import 'package:flutter_riverpod/flutter_riverpod.dart';
1. Riverpod을 사용하려면 ProviderScope로 앱을 감싸야한다
ex)
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(
    child: App(),
  ));
}

2. provider를 선언한다
import 'package:first_app/4fourth_project/providers/filters_provider.dart';

3. StatelessWidget 대신 ConsumerWidget를 써야함
class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

4. Widget build 부분을 선언한다
WidgetRef ref은 ConsumerWidget으로 변경했기 때문에 써야한다
  @override
  Widget build(BuildContext context, WidgetRef ref) {

5. ref.watch()로 쓴다
  final activeFilters = ref.watch(filtersProvider);

6. 상태를 변경하는 메서드를 사용한다.
filtersProvider의 상태를 변경할 수 있도록 filtersProvider.notifier를
사용해서 FilterNotifier(클래스 이름임) 인스턴스를 가져오는 것
ex)
  SwitchListTile(
    value: activeFilters[Filter.glutenFree]!,
    onChanged: (isChecked) {
      ref
          .read(filtersProvider.notifier)
          .setFilter(Filter.glutenFree, isChecked);
    },

7. 상태를 변경하는 메서드인 setFilters는 프로바이더에 있다
ex)
  class FilterNotifier extends StateNotifier<Map<Filter, bool>> {
    FilterNotifier();
    void setFilters(Map<Filter, bool> chosenFilters) {
      state = chosenFilters;
    }


# 밑에 탭바를 만들기
카테고리와 즐겨찾기 두개의 탭바가 있다
ex)
  bottomNavigationBar: BottomNavigationBar(
    onTap: _selectPage,
    currentIndex: _selectedPageIndex,
    items: const [
      BottomNavigationBarItem(
          icon: Icon(Icons.set_meal), label: 'Categories'),
      BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favorites'),
    ],
  ),

# 드로어 만들기
1. tabs안에 drawer를 만든다
ex)
  return Scaffold(
    appBar: AppBar(title: Text(activePageTitle)),
    drawer: MainDrawer(
      onSelectScreen: _setScreen,
    ),

2. Drawer 위젯을 만든다
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(

# 화면을 아래에서 위로 올라오는 애니메이션 (animation) 을 추가하기
1. Stateless -> StatefulWidget 로 바꿔야 한다
2. SingleTickerProviderStateMixin로 감싼다
3. initState를 추가한다 
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this, // ✅ TickerProviderStateMixin을 사용해서 vsync 설정
      duration: Duration(milliseconds: 300),
      lowerBound: 0, // 애니메이션의 최소값 (기본값: 0)
      upperBound: 1, // 애니메이션의 최대값 (기본값: 1)
    );
    _animationController.forward();
  }
  vsync: 애니메이션 리소스 최적화
  duration: 애니메이션 지속 시간 300ms
  lowerBound: 애니메이션 최소 값
  upperBound: 애니메이션 최대 값
  _animationController.forward(); // 애니메이션 실행 (0 -> 1)

4. controller를 선언한다
  late AnimationController _animationController;
5. 메모리 누수를 방지하기 위해 dispose()에서 에니메이션을 정리
  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
6. animation을 AnimatedBuilder에 선언한다
ex)
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      child: GridView(

7. builder는 애니메이션 값이 변경될 때마다 다시 실행된다
Tween은 애니메이션의 시작과 끝 값을 정하는 역할이다.

return AnimatedBuilder(
  animation: _animationController, // 애니메이션 컨트롤러
  child: GridView( ... ), // 이미 그리드뷰가 있음
  builder: (context, child) => SlideTransition( // child를 감싸서 애니메이션 적용
    position: Tween(
      begin: const Offset(0, 0.3), // 처음 위치 (아래에서 시작)
      //  y축 기준으로 아래쪽 30% 위치에서 시작
      end: const Offset(0, 0), // 최종 위치 (제자리)
    ).animate(CurvedAnimation(
        parent: _animationController, curve: Curves.easeInOut)), // 부드럽게 이동
    child: child, // 여기서 child는 위의 GridView
  ),
);

# Navigator.of(context).pushReplacement와 Navigator.of(context).push의 차이점
🔹 Navigator.of(context).push(): 
1. 새로운 화면을 **스택(Stack)**에 추가하여 이전 화면을 유지
2. 사용자가 뒤로 가기 버튼을 누르면 이전 화면으로 돌아갈 수 있음
3. push()를 계속 호출하면 화면이 계속 쌓이게 됨.

🔹 Navigator.of(context).pushReplacement()
1. 새로운 화면을 열면서 이전 화면을 스택에서 제거합니다.
2. 사용자가 뒤로 가기 버튼을 눌러도 이전 화면으로 돌아갈 수 없음.
3. 기존 화면을 대체하는 방식이므로, 메모리 관리 측면에서 유리할 수 있음.


# PopScope으로 뒤로가기 시 데이터 이전 screen으로 보내기
Column을 PopScope로 감싸서 사용자가 뒤로 가기를 눌렀을 때
특정 로직을 실행할 수 있도록 한다
Navigator.of(context).pop(newFilters) -> 에서
뒤로가기를 하며 newFilters를 이전 화면으로 돌려준다

ex)
  body: PopScope(
    canPop: false,
    onPopInvokedWithResult: (bool didPop, dynamic result) {
      if (didPop) return; // -> 사용자가 이미 pop을 수행했다면 아무것도 하지 않음
      // 상태 관리 로직 실행 (필터 저장)
      final newFilters = {
        Filter.glutenFree: _glutenFreeFilterSet,
        Filter.lactoseFree: _lactoseFreeFilterSet,
        Filter.vegetarian: _vegetarianFilterSet,
        Filter.vegan: _veganFilterSet,
      };
      ref.read(filtersProvider.notifier).setFilters(newFilters);
      // 현재 화면을 닫고 데이터 반환
      Navigator.of(context).pop(newFilters);
    },

이렇게 보내면 그 전스크린(TabsScreen)의 _setScreen에서 await을 사용해서 데이터를 받는다
result라는 변수로 받아서 출력하는 코드이다
ex)
  void _setScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == 'filters') {
      final result = await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: (ctx) => const FiltersScreen(),
        ),
      );

      if (result != null) {
        print('받은 필터 데이터: $result'); // 콘솔 출력
      }
    }
  }

# 토글버튼 만들기
SwitchListTile 를 사용해서 만든다
ex)
  SwitchListTile(
    value: activeFilters[Filter.glutenFree]!,
    onChanged: (isChecked) {
      ref
          .read(filtersProvider.notifier)
          .setFilter(Filter.glutenFree, isChecked);
    },
    title: Text(
      'Gluten-free',
      style: Theme.of(context).textTheme.titleLarge!.copyWith(
            color: Theme.of(context).colorScheme.onBackground,
          ),
    ),
    subtitle: Text(
      'Only include gluten-free meals.',
      style: Theme.of(context).textTheme.labelMedium!.copyWith(
            color: Theme.of(context).colorScheme.onBackground,
          ),
    ),
    activeColor: Theme.of(context).colorScheme.tertiary,
    contentPadding: const EdgeInsets.only(left: 34, right: 22),
  ),

# StateNotifier의 의미
notifier: 프로바이더의 상태를 변경하는 것이다
Riverpod에서 "상태 변경이 필요한 경우" 사용된다. 
Provider를 상속하여 프로바이더를 선언하면 읽기만 가능하고 
StateNotifier를 상속받아 프로바이더를 선언하면 변경이 가능하다

아래의 경우 <Map<Filter, bool>>을 상속받아 Riverpod에서 필터 상태를 관리하는 클래스이다. 
초기 값은 super뒤에 선언하는 것이다

ex)
class FilterNotifier extends StateNotifier<Map<Filter, bool>> {
  FilterNotifier()
      : super({
          Filter.glutenFree: false,
          Filter.lactoseFree: false,
          Filter.vegetarian: false,
          Filter.vegan: false,
        });

# StateNotifierProvider 의 의미
📌 StateNotifierProvider<T, S>란 T는 상태를 관리하는 클래스 (StateNotifier), 
S는 실제 상태값의 타입이다. 

아래와 같이 선언하면 filtersProvider는 전역적으로 필터 상태를 관리하는 프로바이더 역할을 함.
즉, filtersProvider를 통해 UI에서 필터 상태를 읽고(watch), 변경(notifier)할 수 있음.
ex)
final filtersProvider =
    StateNotifierProvider<FilterNotifier, Map<Filter, bool>>(
        (ref) => FilterNotifier());

그리고 사용은
ex)
final filteredMealsProvider = Provider((ref) {
  final meals = ref.watch(mealsProvider);
  final activeFilters = ref.watch(filtersProvider);
  return meals.where((meal) {
    if (activeFilters[Filter.glutenFree]! && !meal.isGlutenFree) {
      return false;
    }
    if (activeFilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
      return false;
    }
    if (activeFilters[Filter.vegetarian]! && !meal.isVegetarian) {
      return false;
    }
    if (activeFilters[Filter.vegan]! && !meal.isVegan) {
      return false;
    }
    return true;
  }).toList();
});

이 filteredMealsProvider는 다른 파일에서 아래와 같이 쓰인다.
ex)
 @override
  Widget build(BuildContext context) {
    final availableMeals = ref.watch(filteredMealsProvider);

# InkWell
tap을 가능하게 하는 위젯이다
ex)
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onSelectCategory,
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(16),


# Text 위젯에서 두줄 이상 넘어가면 잘라내고 ...처리하기
ex)
  children: [
    Text(
      meal.title,
      maxLines: 2,
      textAlign: TextAlign.center,
      softWrap: true,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white),
    ),

# 인터넷에서 가져온 이미지를 보여주기
art pub add transparent_image해서 설치한다
NetworkImage: 인터넷에서 사진을 불러온다

ex)
  FadeInImage(
    placeholder: MemoryImage(kTransparentImage),
    image: NetworkImage(meal.imageUrl),
    // dart pub add transparent_image해서 설치한다
    // NetworkImage: 인터넷에서 사진을 불러온다
    fit: BoxFit.cover,
    height: 200,
    width: double.infinity,
  ),

# 카드 모양 둥글게 하고 이상 되는거는 자르기
Card(
  margin: const EdgeInsets.all(8),
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
  clipBehavior: Clip.hardEdge,
  elevation: 2,
  child: InkWell(
    ...

# Implicit Animations 적용하기
AnimatedSwitcher 위젯을 사용하면 된다.
한 위젯에서 다른 위젯으로 변경될 때 애니메이션을 제공함.
AnimatedSwitcher로 감싸고 나서 transitionBuilder에 어떤 애니메이션을
줄지 선언한다

ex)
이렇게만 쓰면 애니메이션이 적용되지 않는다. 왜냐면 Icon은 한번만 선언되었고 그안에서 
isFavorite ? Icons.star : Icons.star_border가 되는것뿐이기 때문이다. 
ex)
  icon: AnimatedSwitcher(
    duration: const Duration(milliseconds: 300),
    transitionBuilder: (){},
    child: Icon(isFavorite ? Icons.star : Icons.star_border),
  ),

그래서 key를 추가해주어야 한다. 
이전과 다른 위젯임을 알려주기 위해. 
ex)
  icon: AnimatedSwitcher(
    duration: const Duration(milliseconds: 300),
    transitionBuilder: (child, animation) {
      return RotationTransition(
        turns: animation,
        child: child,
      );
    },
    child: Icon(
      isFavorite ? Icons.star : Icons.star_border,
      key: ValueKey(isFavorite),
    ),
  ),
Tween을 사용할수도 있다.
ex)
  icon: AnimatedSwitcher(
    duration: const Duration(milliseconds: 300),
    transitionBuilder: (child, animation) {
      return RotationTransition(
        turns:
            Tween<double>(begin: 0.8, end: 1.0).animate(animation),
        child: child,
      );
    },
    child: Icon(
      isFavorite ? Icons.star : Icons.star_border,
      key: ValueKey(isFavorite),
    ),
  ),

# 리스트 -> 디테일 페이지로 이동할 때 같은 사진이라면 이동되는 애니메이션 주기
1. list에서 대표사진 부분을 Hero 위젯으로 감싼다
ex)
  Hero(
    tag: meal.id,
    child: FadeInImage(
      placeholder: MemoryImage(kTransparentImage),
      image: NetworkImage(meal.imageUrl),
      fit: BoxFit.cover,
      height: 200,
      width: double.infinity,
    ),
  ),

2. detail에서 대표 사진 부분을 또 Hero 위젯으로 감싼다
ex)
  body: SingleChildScrollView(
    child: Column(
      children: [
        Hero(
          tag: meal.id,
          child: Image.network(
            meal.imageUrl,
            height: 300,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),

# location 관련 에러 해결방법
If that should be the case, try editing your android/settings.gradle file and make sure the following line:

id "org.jetbrains.kotlin.android" version "1.9.21" apply false
reflects your current Kotlin version (you find that version in the build.gradle file).

Also see this Q&A thread (and the threads linked in there) for further context: https://www.udemy.com/course/learn-flutter-dart-to-build-ios-android-apps/learn/lecture/37130520#questions/21453790/

# Location 
1. 패키지 추가하기
flutter pub add location
2. Ios의 경우 Info.plist에서 
<key>NSLocationWhenInUseUsageDescription</key> 추가했음.
3. 내 구글맵 API KEY: AIzaSyDLuI361e6q0PXtUKfxPY0YGCYDYHYZKWY
4. 지오코딩: 위도, 경도를 사람에게 의미있는 주소로 변경하는 것
참조:
https://developers.google.com/maps/documentation/geocoding/requests-reverse-geocoding?hl=ko
5. 


# 구글맵스패키지 이용하기 (Google Maps Package)
패키지 다운: flutter pub add google_maps_flutter

1. 안드로이드에서
android/app/build.gradle 파일 수정 필요

2. 메타데이터 추가함
안드로이드
<meta-data android:name="com.google.android.geo.API_KEY"
        android:value="YOUR KEY HERE"/>
ios
AppDelegate.swift 변경함.


# 







