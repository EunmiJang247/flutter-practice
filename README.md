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

# 




