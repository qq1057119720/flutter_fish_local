import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class TestThemePage extends Page<TestThemeState, Map<String, dynamic>> {
  TestThemePage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<TestThemeState>(
                adapter: null,
                slots: <String, Dependent<TestThemeState>>{
                }),
            middleware: <Middleware<TestThemeState>>[
            ],);

}
