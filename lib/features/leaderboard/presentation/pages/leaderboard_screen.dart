import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizu/core/services/services_locator.dart';
import 'package:quizu/core/utills/enums.dart';
import 'package:quizu/features/leaderboard/presentation/bloc/leaderboard/leaderboard_bloc.dart';

class LeaderboardScreen extends StatelessWidget {
  LeaderboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => sl<LeaderboardBloc>()..add(const GetTop10Event()),
        child: Scaffold(
          body: Center(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8),
                    child: Text("Leaderboard",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.w900),
                        textAlign: TextAlign.center),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  BlocBuilder<LeaderboardBloc, LeaderboardState>(
                      builder: ((context, state) {
                    switch (state.top10State) {
                      case RequestState.loading:
                        return const SizedBox(
                          height: 400.0,
                          child: Center(child: CircularProgressIndicator()),
                        );
                      case RequestState.loaded:
                        return Expanded(
                          child: ListView.separated(
                              itemBuilder: (context, index) => state
                                      .top10[index].name!.isEmpty
                                  ? const SizedBox()
                                  : ListTile(
                                      title: Text(state.top10[index].name!,
                                          style: const TextStyle(fontSize: 20)),
                                      trailing: Text(
                                          state.top10[index].score!.toString(),
                                          style: const TextStyle(fontSize: 16)),
                                    ),
                              separatorBuilder: (context, index) =>
                                  const SizedBox(
                                    height: 8,
                                  ),
                              itemCount: state.top10.length),
                        );
                      case RequestState.error:
                        return SizedBox(
                          height: 400.0,
                          child: Center(
                            child: Text(state.top10Message),
                          ),
                        );
                    }
                  }))
                ],
              ),
            ),
          ),
        ));
  }
}
