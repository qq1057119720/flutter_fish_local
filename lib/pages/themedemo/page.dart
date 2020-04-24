import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class ThemeDemoPage extends Page<ThemeDemoState, Map<String, dynamic>> {
  ThemeDemoPage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<ThemeDemoState>(
                adapter: null,
                slots: <String, Dependent<ThemeDemoState>>{
                }),
            middleware: <Middleware<ThemeDemoState>>[
            ],);

}
