import 'package:authentication_repository/authentication_repository.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tally/app/app.dart';
import 'package:tally/theme.dart';
import 'package:tally/widget/widget.dart';

class App extends StatelessWidget {
  const App({
    Key? key,
    required AuthenticationRepository repository,
  })  : _authenticationRepository = repository,
        super(key: key);

  final AuthenticationRepository _authenticationRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _authenticationRepository,
      child: BlocProvider(
        create: (_) => AppBloc(
          authenticationRepository: _authenticationRepository,
        ),
        child: const AppView(),
      ),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      home: FlowBuilder<AppStatus>(
        state: context.select((AppBloc bloc) => bloc.state.status),
        onGeneratePages: onGenerateAppViewPages,
      ),
      debugShowCheckedModeBanner: false,
      builder: (BuildContext context, Widget? child) {
        final MediaQueryData data = MediaQuery.of(context);

        ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
          debugPrint('FlutterErrorDetails $errorDetails');
          return Scaffold(
            appBar: AppBar(title: const Text('ERROR')),
            body: const EmptyView(),
          );
        };
        return MediaQuery(
          data: data.copyWith(textScaleFactor: 1),
          child: child ?? Container(),
        );
      },
    );
  }
}
