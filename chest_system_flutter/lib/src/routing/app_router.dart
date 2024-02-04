import 'package:chest_system_flutter/src/features/chests/presentation/details/chest_details_screen.dart';
import 'package:chest_system_flutter/src/features/items/presentation/details/item_details_screen.dart';
import 'package:chest_system_flutter/src/features/items/presentation/items_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

// import '../features/counter/presentation/counter_screen.dart';
// import '../features/chests/domain/chest.dart';
import '../features/chests/presentation/chests_screen.dart';
// import '../features/chests/presentation/people_screen.dart';
import 'scaffold_with_navigation.dart';
part 'app_router.g.dart';
// general ideas on navigation see https://m2.material.io/design/navigation/understanding-navigation.html#forward-navigation

// shell routes, appear in the bottom navigation
// see https://pub.dev/documentation/go_router/latest/go_router/ShellRoute-class.html
enum TopLevelDestinations { chests, items }

// GlobalKey is a factory, hence each call creates a key
//this is root, even if it navigates to people, it needs a separate key!!!
final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _chestsNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: TopLevelDestinations.chests.name);
final _itemsNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: TopLevelDestinations.items.name);
// final _counterNavigatorKey =
//     GlobalKey<NavigatorState>(debugLabel: TopLevelDestinations.counter.name);

// other destinations, reachable from a top level destination
enum SubRoutes { itemDetails, chestDetails }

enum Parameter { id }

//https://github.com/flutter/packages/blob/main/packages/go_router/example/lib/stateful_shell_route.dart

@Riverpod(keepAlive: true)
GoRouter goRouter(GoRouterRef ref) {
  return GoRouter(
    initialLocation: '/${TopLevelDestinations.chests.name}',
    navigatorKey: _rootNavigatorKey,
    debugLogDiagnostics: true,
    routes: [
      // Stateful navigation based on:
      // https://github.com/flutter/packages/blob/main/packages/go_router/example/lib/stateful_shell_route.dart
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return ScaffoldWithNavigation(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            navigatorKey: _chestsNavigatorKey,
            routes: [
              // base route people
              GoRoute(
                path: '/${TopLevelDestinations.chests.name}', // path: /people
                name: TopLevelDestinations.chests.name,
                pageBuilder: (context, state) => NoTransitionPage(
                  key: state.pageKey,
                  child: const ChestsScreen(),
                ),
                routes: [
                  GoRoute(
                    path:
                        '${SubRoutes.chestDetails.name}/:${Parameter.id.name}',
                    name: SubRoutes.chestDetails.name,
                    builder: (BuildContext context, GoRouterState state) {
                      final id =
                          int.parse(state.pathParameters[Parameter.id.name]!);
                      return ChestDetailsScreen(id: id);
                      // final person = _extractPersonFromExtra(state.extra);
                      // return DetailsScreen(id: id, person: person);
                    },
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _itemsNavigatorKey,
            routes: [
              GoRoute(
                path: '/${TopLevelDestinations.items.name}',
                name: TopLevelDestinations.items.name,
                pageBuilder: (context, state) => NoTransitionPage(
                  key: state.pageKey,
                  child: const ItemsScreen(),
                ),
                routes: [
                  GoRoute(
                    path: '${SubRoutes.itemDetails.name}/:${Parameter.id.name}',
                    name: SubRoutes.itemDetails.name,
                    builder: (BuildContext context, GoRouterState state) {
                      final id =
                          int.parse(state.pathParameters[Parameter.id.name]!);
                      return ItemDetailsScreen(id: id);
                    },
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ],
  );
}

// Person? _extractPersonFromExtra(Object? extra) {
//   return extra == null
//       ? null
//       : extra is Person
//           ? extra
//           : extra is Map // if you come back from bottom navigation, e.g. look
//               // at details of a person, go to counter via bottom navigation,
//               // use bottom navigation to go to people/home
//               ? Person.fromJson(
//                   extra as Map<String, Object?>,
//                 )
//               : null;
// }
