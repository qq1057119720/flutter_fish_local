import 'package:fish_redux/fish_redux.dart';

class TestListviewState implements Cloneable<TestListviewState> {

  @override
  TestListviewState clone() {
    return TestListviewState();
  }
}

TestListviewState initState(Map<String, dynamic> args) {
  return TestListviewState();
}
