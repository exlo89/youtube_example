import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youtube/bloc/home/home_bloc.dart';
import 'package:youtube/models/cocktail_model.dart';

class HomeBlocScreen extends StatefulWidget {
  static const String routeName = 'home-bloc';

  const HomeBlocScreen({super.key});

  @override
  State<HomeBlocScreen> createState() => _HomeBlocScreenState();
}

class _HomeBlocScreenState extends State<HomeBlocScreen> {
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
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }
                  if (state is HomeSuccessState) {
                    return Flexible(
                      child: SingleChildScrollView(
                        child: Column(
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
                        ),
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
