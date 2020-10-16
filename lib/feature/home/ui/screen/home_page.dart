import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sunnah/common/constant/env.dart';
import 'package:sunnah/common/http/api_provider.dart';
import 'package:sunnah/common/route/routes.dart';
import 'package:sunnah/common/util/internet_check.dart';
import 'package:sunnah/feature/authentication/bloc/index.dart';
import 'package:sunnah/feature/home/bloc/index.dart';
import 'package:sunnah/feature/home/resource/home_repository.dart';
import 'package:sunnah/feature/home/ui/widget/home_widget.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          title: const Text('Books'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.adjust),
              onPressed: () {
                BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut());
                Navigator.pushReplacementNamed(context, Routes.landing);
              },
            ),
          ],
        ),
        body: BlocProvider(
            create: (dynamic context) => BooksBloc(
                homeRepository: HomeRepository(
                    env: RepositoryProvider.of<Env>(context),
                    apiProvider: RepositoryProvider.of<ApiProvider>(context),
                    internetCheck:
                        RepositoryProvider.of<InternetCheck>(context)))
              ..add(Fetch()),
            child: Container(child: const HomeWidget())));
  }
}
