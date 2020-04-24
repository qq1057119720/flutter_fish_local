import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class TextEditPage extends Page<TextEditState, Map<String, dynamic>> {
  TextEditPage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<TextEditState>(
                adapter: null,
                slots: <String, Dependent<TextEditState>>{
                }),
            middleware: <Middleware<TextEditState>>[
            ],);

}
