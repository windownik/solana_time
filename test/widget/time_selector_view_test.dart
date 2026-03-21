import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:solana_time/generated/l10n.dart';
import 'package:solana_time/presentation/features/bloc/state/state_types.dart';
import 'package:solana_time/presentation/features/widgets/time_selector/time_selector_view.dart';

void main() {
  group('TimeSelectorView', () {
    late List<TimeSource> selectedSources;

    Widget buildTestWidget({
      TimeSource activeTimeSource = TimeSource.solana,
    }) {
      return MaterialApp(
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        locale: const Locale('en'),
        home: Scaffold(
          body: TimeSelectorView(
            activeTimeSource: activeTimeSource,
            onChangeSource: (source) => selectedSources.add(source),
          ),
        ),
      );
    }

    setUp(() {
      selectedSources = [];
    });

    testWidgets('displays three buttons: Solana, Local, Both',
        (WidgetTester tester) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pumpAndSettle();

      expect(find.text('Solana'), findsOneWidget);
      expect(find.text('Local'), findsOneWidget);
      expect(find.text('Both'), findsOneWidget);
    });

    testWidgets('calls onChangeSource with TimeSource.solana when Solana is tapped',
        (WidgetTester tester) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pumpAndSettle();

      await tester.tap(find.text('Solana'));
      await tester.pumpAndSettle();

      expect(selectedSources, [TimeSource.solana]);
    });

    testWidgets('calls onChangeSource with TimeSource.local when Local is tapped',
        (WidgetTester tester) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pumpAndSettle();

      await tester.tap(find.text('Local'));
      await tester.pumpAndSettle();

      expect(selectedSources, [TimeSource.local]);
    });

    testWidgets('calls onChangeSource with TimeSource.both when Both is tapped',
        (WidgetTester tester) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pumpAndSettle();

      await tester.tap(find.text('Both'));
      await tester.pumpAndSettle();

      expect(selectedSources, [TimeSource.both]);
    });

    testWidgets('can tap multiple buttons in sequence',
        (WidgetTester tester) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pumpAndSettle();

      await tester.tap(find.text('Solana'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Local'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Both'));
      await tester.pumpAndSettle();

      expect(selectedSources, [
        TimeSource.solana,
        TimeSource.local,
        TimeSource.both,
      ]);
    });

    testWidgets('displays active button with green background',
        (WidgetTester tester) async {
      await tester.pumpWidget(buildTestWidget(
        activeTimeSource: TimeSource.local,
      ));
      await tester.pumpAndSettle();

      final localButton = tester.widget<ElevatedButton>(
        find.ancestor(
          of: find.text('Local'),
          matching: find.byType(ElevatedButton),
        ),
      );

      expect(localButton.style?.backgroundColor?.resolve({}), Colors.green);
    });

    testWidgets('displays inactive button with grey background',
        (WidgetTester tester) async {
      await tester.pumpWidget(buildTestWidget(
        activeTimeSource: TimeSource.solana,
      ));
      await tester.pumpAndSettle();

      final localButton = tester.widget<ElevatedButton>(
        find.ancestor(
          of: find.text('Local'),
          matching: find.byType(ElevatedButton),
        ),
      );

      expect(localButton.style?.backgroundColor?.resolve({}), Colors.grey);
    });
  });
}
