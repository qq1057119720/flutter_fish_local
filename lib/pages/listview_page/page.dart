import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class TestListviewPage extends Page<TestListviewState, Map<String, dynamic>> {
  TestListviewPage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<TestListviewState>(
                adapter: null,
                slots: <String, Dependent<TestListviewState>>{
                }),
            middleware: <Middleware<TestListviewState>>[
            ],);

}
