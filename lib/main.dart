import 'package:tracker/Index/index.dart';

void main() {
  runZonedGuarded(
    () async {
      // Ensure Flutter bindings are initialized
      WidgetsFlutterBinding.ensureInitialized();

      // Initialize essential services
      await StorageService().init();

      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
      ]);

      // make navigation bar transparent
      SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          systemNavigationBarColor: Colors.transparent,
        ),
      );
      // make flutter draw behind navigation bar
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

      final appDocumentDir = await getApplicationDocumentsDirectory();
      Hive.init(appDocumentDir.path);
      Hive.registerAdapter(ExpenseAdapter());
      await Hive.openBox<Expense>('expenses');

      initServices();

      runApp(
        ScreenUtilInit(
          designSize: const Size(828, 2013),
          // iPhone 16 Pro Max
          minTextAdapt: true,
          splitScreenMode: true,
          useInheritedMediaQuery: true,
          builder: (context, child) {
            return MultiBlocProvider(
              providers: [
                BlocProvider<AddExpenseBloc>(
                  create: (context) => getIt<AddExpenseBloc>(),
                ),
                BlocProvider<ExpensesBloc>(
                  create: (context) => getIt<ExpensesBloc>(),
                ),
              ],
              child: MyApp(),
            );
          },
        ),
      );
    },
    (dynamic error, dynamic stack) {
      if (kDebugMode) {
        print("error is ${error.toString()}");
      }
    },
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const DashboardScreen(),
      debugShowCheckedModeBanner: false,
      title: 'Expense Tracker Lite',
    );
  }
}
