import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";
import "package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart";

PersistentTabConfig tabConfig(int id, Widget screen) => PersistentTabConfig(
      screen: screen,
      item: ItemConfig(title: "Item$id", icon: const Icon(Icons.add)),
    );

Widget defaultScreen(int id) => Text("Screen$id");

Widget screenWithButton(int id, void Function(BuildContext) onTap) => Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        defaultScreen(id),
        Builder(
          builder: (context) => ElevatedButton(
            onPressed: () => onTap(context),
            child: const Text("SubPage"),
          ),
        ),
      ],
    );

void main() {
  Widget wrapTabView(WidgetBuilder builder) => MaterialApp(
        home: Builder(
          builder: (context) => builder(context),
        ),
      );

  group("pushScreen", () {
    testWidgets("pushes with navBar", (tester) async {
      await tester.pumpWidget(
        wrapTabView(
          (context) => PersistentTabView(
            tabs: [1, 2, 3]
                .map(
                  (id) => tabConfig(
                    id,
                    screenWithButton(
                      id,
                      (context) => pushScreen(
                        context,
                        screen: defaultScreen(id * 10 + (id % 10)),
                        withNavBar: true,
                      ),
                    ),
                  ),
                )
                .toList(),
            navBarBuilder: (config) => Style1BottomNavBar(navBarConfig: config),
          ),
        ),
      );

      expect(find.byType(DecoratedNavBar).hitTestable(), findsOneWidget);

      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      expect(find.byType(DecoratedNavBar).hitTestable(), findsOneWidget);
    });

    testWidgets("pushes without navBar", (tester) async {
      await tester.pumpWidget(
        wrapTabView(
          (context) => PersistentTabView(
            tabs: [1, 2, 3]
                .map(
                  (id) => tabConfig(
                    id,
                    screenWithButton(
                      id,
                      (context) => pushScreen(
                        context,
                        screen: defaultScreen(id * 10 + (id % 10)),
                        withNavBar: false,
                      ),
                    ),
                  ),
                )
                .toList(),
            navBarBuilder: (config) => Style1BottomNavBar(navBarConfig: config),
          ),
        ),
      );

      expect(find.byType(DecoratedNavBar).hitTestable(), findsOneWidget);

      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      expect(find.byType(DecoratedNavBar).hitTestable(), findsNothing);
    });
  });

  testWidgets("pushWithNavBar pushes with navBar", (tester) async {
    await tester.pumpWidget(
      wrapTabView(
        (context) => PersistentTabView(
          tabs: [1, 2, 3]
              .map(
                (id) => tabConfig(
                  id,
                  screenWithButton(
                    id,
                    (context) => pushWithNavBar(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            defaultScreen(id * 10 + (id % 10)),
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
          navBarBuilder: (config) => Style1BottomNavBar(navBarConfig: config),
        ),
      ),
    );

    expect(find.byType(DecoratedNavBar).hitTestable(), findsOneWidget);

    await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle();

    expect(find.byType(DecoratedNavBar).hitTestable(), findsOneWidget);
  });

  testWidgets("pushWithoutNavBar pushes without navBar", (tester) async {
    await tester.pumpWidget(
      wrapTabView(
        (context) => PersistentTabView(
          tabs: [1, 2, 3]
              .map(
                (id) => tabConfig(
                  id,
                  screenWithButton(
                    id,
                    (context) => pushWithoutNavBar(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            defaultScreen(id * 10 + (id % 10)),
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
          navBarBuilder: (config) => Style1BottomNavBar(navBarConfig: config),
        ),
      ),
    );

    expect(find.byType(DecoratedNavBar).hitTestable(), findsOneWidget);

    await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle();

    expect(find.byType(DecoratedNavBar).hitTestable(), findsNothing);
  });
}
