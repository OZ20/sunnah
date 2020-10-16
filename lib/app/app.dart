import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sunnah/common/bloc/connectivity/index.dart';
import 'package:sunnah/common/constant/env.dart';
import 'package:sunnah/common/http/api_provider.dart';
import 'package:sunnah/common/route/route_generator.dart';
import 'package:sunnah/common/route/routes.dart';
import 'package:sunnah/common/util/internet_check.dart';
import 'package:sunnah/feature/authentication/bloc/index.dart';
import 'package:sunnah/feature/authentication/resource/user_repository.dart';
import 'package:sunnah/generated/i18n.dart';

import 'theme.dart';

class App extends StatelessWidget {
  final Env env;

  App({Key key, @required this.env}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
        providers: [
          RepositoryProvider<Env>(
            create: (dynamic context) => env,
            lazy: true,
          ),
          RepositoryProvider<InternetCheck>(
            create: (dynamic context) => InternetCheck(),
            lazy: true,
          ),
          RepositoryProvider<UserRepository>(
            create: (dynamic context) => UserRepository(),
            lazy: true,
          ),
          RepositoryProvider<ApiProvider>(
            create: (dynamic context) => ApiProvider(),
            lazy: true,
          ),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider<ConnectivityBloc>(
              create: (dynamic context) {
                return ConnectivityBloc(context);
              },
            ),
            BlocProvider<AuthenticationBloc>(
              create: (dynamic context) {
                return AuthenticationBloc(
                    userRepository:
                        RepositoryProvider.of<UserRepository>(context))
                  ..add(AuthStarted());
              },
            ),
          ],
          child: MaterialApp(
            localizationsDelegates: const <
                LocalizationsDelegate<WidgetsLocalizations>>[
              S.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,
            localeResolutionCallback:
                S.delegate.resolution(fallback: const Locale('en', '')),
            localeListResolutionCallback:
                S.delegate.listResolution(fallback: const Locale('en', '')),
            title: 'Flutter Demo',
            theme: basicTheme,
            onGenerateRoute: RouteGenerator.generateRoute,
            initialRoute: Routes.landing,
          ),
        ));
  }
}
