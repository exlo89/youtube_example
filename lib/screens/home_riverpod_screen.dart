import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube/bloc/home/home_bloc.dart';
import 'package:youtube/models/cocktail_model.dart';
import 'package:youtube/riverpod/future_cocktail_provider.dart';

class HomeRiverpodScreen extends ConsumerStatefulWidget {
  static const String routeName = 'home-riverpod';

  const HomeRiverpodScreen({super.key});

  @override
  ConsumerState<HomeRiverpodScreen> createState() => _HomeRiverpodScreenState();
}

class _HomeRiverpodScreenState extends ConsumerState<HomeRiverpodScreen> {
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
    final weatherAsync = ref.watch(cocktailFutureProvider);
    ref.listen(cocktailFutureProvider, (previous, next) {
      if(!next.hasError && !next.isLoading){
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Alle Cocktails geladen'),
          ),
        );
      }
    });
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Riverpod'),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              weatherAsync.when(
                skipLoadingOnRefresh: false,
                loading: () {
                  return const Expanded(
                    child: Center(child: CircularProgressIndicator()),
                  );
                },
                error: (error, stack) {
                  return Expanded(
                    child: Center(child: Text('Error: $error')),
                  );
                },
                data: (cocktails) {
                  return Flexible(
                    child: SingleChildScrollView(
                      child: Column(
                        children: List<Widget>.generate(
                          cocktails.length,
                          (index) {
                            CocktailModel cocktail = cocktails[index];
                            return ListTile(
                              title: Text(cocktail.strDrink.toString()),
                              subtitle: Text(cocktail.strCategory.toString()),
                            );
                          },
                        ),
                      ),
                    ),
                  );
                },
              ),
              ElevatedButton(
                onPressed: () {
                  ref.refresh(cocktailFutureProvider);
                  ref.read(cocktailFutureProvider.future);
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
