import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../domain/model/joke.dart';
import '../../../resource/styles/app_typographys.dart';
import '../../../share_view/atoms/avatar_view/avatar_view.dart';
import '../../../share_view/atoms/button/button.dart';
import '../view_model/home_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final HomeBloc _homeBloc;

  @override
  void initState() {
    super.initState();
    _homeBloc = BlocProvider.of<HomeBloc>(context)..add(JokesLoad());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const AppBarHeader(),
            const CardQuote(),
            Expanded(child: JokeContentLoader(homeBloc: _homeBloc)),
            const Divider(color: Color(0xffEBEBEB), height: 10),
            const HomeFooter(),
          ],
        ),
      ),
    );
  }
}

class AppBarHeader extends StatelessWidget {
  const AppBarHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset('assets/images/logo.webp', height: 48),
          const AvatarView()
        ],
      ),
    );
  }
}

class CardQuote extends StatelessWidget {
  const CardQuote({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 164,
      width: double.infinity,
      decoration: const BoxDecoration(color: Color(0xff29B363)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "A joke a day keeps the doctor away",
            style: AppTypography.typographyHeader.copyWith(color: Colors.white),
          ),
          const SizedBox(height: 30),
          Text(
            "If you joke wrong way, your teeth have to pay. (Serious)",
            style: AppTypography.typographyCaptionSmall
                .copyWith(color: Colors.white),
          ),
        ],
      ),
    );
  }
}

class JokeContentLoader extends StatelessWidget {
  const JokeContentLoader({required this.homeBloc, super.key});
  final HomeBloc homeBloc;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
      if (state is JokesLoaded) {
        return Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    state.joke.joke ?? "",
                    style: AppTypography.typographyCaptionMedium,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Row(
                children: [
                  Expanded(
                    child: Button(
                      onPressed: () => homeBloc.add(const OnJokeVoted(voteJoke: VoteJoke.funny)),
                      backgroundColor: const Color(0xff2C7EDB),
                      label: "This is Funny!",
                    ),
                  ),
                  const SizedBox(width: 30),
                  Expanded(
                    child: Button(
                      onPressed: () => homeBloc.add(const OnJokeVoted(voteJoke: VoteJoke.notFunny)),
                      label: "This is not Funny.",
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      }

      if (state is JokesLoadFailue) {
        return Center(
          child: Text(state.message,
              style: AppTypography.typographyCaptionSmall
                  .copyWith(color: const Color(0xff646464))),
        );
      }

      return const Center(child: CupertinoActivityIndicator());
    });
  }
}

class HomeFooter extends StatelessWidget {
  const HomeFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Column(
        children: [
          Text(
            "This app is created as part of Hlsolutions program. The materials contained on this website are provided for general information only and do not constitute any form of advice. HLS assumes no responsibility for the accuracy of any particular statement and accepts no liability for any loss or damage which may arise from reliance on the information contained on this site.",
            style: AppTypography.typographyCaptionSmall
                .copyWith(color: const Color(0xff969696)),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 14),
          const Text("Copyright 2021 HLS",
              style: AppTypography.typographyCaptionMedium),
        ],
      ),
    );
  }
}
