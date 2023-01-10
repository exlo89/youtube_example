import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youtube/bloc/home/home_bloc.dart';
import 'package:youtube/models/cocktail_model.dart';

class Home extends StatefulWidget {
  static const String routeName = 'home';

  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late HomeBloc _homeBloc;

  @override
  void initState() {
    _homeBloc = HomeBloc();
    super.initState();
  }

  @override
  void dispose() {
    _homeBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Bloc'),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              BlocConsumer<HomeBloc, HomeState>(
                bloc: _homeBloc,
                listener: (context, state) {
                  if (state is HomeSuccessState) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Alle Cocktails geladen'),
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  if (state is HomeInProgressState) {
                    return const Expanded(
                        child: Center(child: CircularProgressIndicator()));
                  }
                  if (state is HomeSuccessState) {
                    return Column(
                      children: List<Widget>.generate(
                        state.cocktails.length,
                        (index) {
                          CocktailModel cocktail = state.cocktails[index];
                          return ListTile(
                            title: Text(cocktail.strDrink.toString()),
                            subtitle: Text(cocktail.strCategory.toString()),
                          );
                        },
                      ),
                    );
                  }
                  return Container();
                },
              ),
              ElevatedButton(
                onPressed: () {
                  _homeBloc.add(HomeFetchedCocktails());
                },
                child: const Text('Alle Cocktails'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
