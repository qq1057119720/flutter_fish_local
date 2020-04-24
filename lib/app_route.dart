import 'package:fish_redux/fish_redux.dart';
import 'package:local/pages/listview_page/page.dart';
import 'package:local/pages/textedit_page/page.dart';
import 'package:local/pages/themedemo/page.dart';
import 'package:local/pages/themedemo/testtheme/page.dart';


import 'global_store/state.dart';
import 'global_store/store.dart';

///定义一个全局的route
class AppRoute {
  static AbstractRoutes _global;

  static AbstractRoutes get global {
    if (_global == null) {
      _global = PageRoutes(
        pages: <String, Page<Object, dynamic>>{
          RoutePath.TEST_INTL: ThemeDemoPage(),
          RoutePath.TEST_THEME: TestThemePage(),
          RoutePath.TEXT_EDIT: TextEditPage(),
          RoutePath.TEST_LIST: TestListviewPage(),
        },
        visitor: (String path, Page<Object, dynamic> page) {
          /// 只有特定的范围的Page才需要建立和AppStore的连接关系
          /// 满足Page<T> T 是GlobalBaseState的之类
          if (page.isTypeof<GlobalBaseState>()) {
            /// 建立AppStore驱动PageStore的单项数据连接
            /// 1. 参数1 AppStore
            /// 2. 参数2 当 AppStore.state 变化时, PageStore.state 该如何变化
            page.connectExtraStore<GlobalState>(
              GlobalStore.store,
              (Object pagestate, GlobalState appState) {
                final GlobalBaseState p = pagestate;
                if (p.theme != appState.theme) {
                  if (pagestate is Cloneable) {
                    final Object copy = pagestate.clone();
                    final GlobalBaseState newState = copy;
                    newState.theme = appState.theme;
                    return newState;
                  }
                }
                if (p.languageLocale != appState.languageLocale) {
                  if (pagestate is Cloneable) {
                    final Object copy = pagestate.clone();
                    final GlobalBaseState newState = copy;
                    newState.languageLocale = appState.languageLocale;
                    return newState;
                  }
                }

                return pagestate;
              },
            );
          }

          /// AOP
          /// 页面可以有一些私有的AOP的增强， 但往往会有一些AOP是整个应用下，所有页面都会有的。
          /// 这些公共的通用AOP，通过遍历路由页面的形式统一加入。
          page.enhancer.append(
            /// View AOP
            viewMiddleware: <ViewMiddleware<dynamic>>[
              safetyView<dynamic>(),
              _pageViewMiddleware<dynamic>(tag: path),
            ],

            /// Adapter AOP
            adapterMiddleware: <AdapterMiddleware<dynamic>>[
              safetyAdapter<dynamic>()
            ],

            /// Effect AOP
            effectMiddleware: [
              _pageAnalyticsMiddleware<dynamic>(tag: path),
            ],

            /// Store AOP
            middleware: <Middleware<dynamic>>[
              logMiddleware<dynamic>(tag: page.runtimeType.toString()),
            ],
          );
        },
      );
    }
    return _global;
  }
}

class RoutePath {
  static const TEST_INTL = "test_intl";
  static const TEST_THEME = "test_theme";
  static const TEXT_EDIT = "text_edit";
  static const TEST_LIST = "test_list";

}

/// 简单的Effect AOP
/// 只针对页面的生命周期进行打印
EffectMiddleware<T> _pageAnalyticsMiddleware<T>({String tag = 'redux'}) {
  return (AbstractLogic<dynamic> logic, Store<T> store) {
    return (Effect<dynamic> effect) {
      return (Action action, Context<dynamic> ctx) {
        if (logic is Page<dynamic, dynamic> && action.type is Lifecycle) {
//          println("所以打印的是什么呢");
          println(logic.toString());
          print('${logic.runtimeType} ${action.type.toString()}');
        }
        return effect?.call(action, ctx);
      };
    };
  };
}

ViewMiddleware<T> _pageViewMiddleware<T>({String tag = 'redux'}) {
  return (AbstractLogic<dynamic> logic, Store<T> store) {
    return (ViewBuilder<dynamic> effect) {
//      println("这个是什时候执行-------------");
      //UnifiedThemeStyles.setStatusBarWhiteForeground(false);
    };
  };
}
