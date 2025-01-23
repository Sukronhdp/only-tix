import 'dart:io';

import 'package:only_tix/presentation/extensions/build_context_extension.dart';
import 'package:only_tix/presentation/pages/movie_page/movie_page.dart';
import 'package:only_tix/presentation/pages/profile_page/profile_page.dart';
import 'package:only_tix/presentation/pages/ticket_page/ticket_page.dart';
import 'package:only_tix/presentation/widgets/bottom_navbar.dart';
import 'package:only_tix/presentation/widgets/bottom_navbar_item.dart';
import 'package:only_tix/presentation/providers/router/router_provider.dart';
import 'package:only_tix/presentation/providers/user_data/user_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/entities/user.dart';

class MainPage extends ConsumerStatefulWidget {
  final File? imageFile;

  const MainPage({this.imageFile, Key? key}) : super(key: key);

  @override
  ConsumerState<MainPage> createState() => _MainPageState();
}

class _MainPageState extends ConsumerState<MainPage> {
  PageController pageController = PageController();
  int selectedPage = 0;

  @override
  void initState() {
    super.initState();

    User? user = ref.read(userDataProvider).valueOrNull;

    if (widget.imageFile != null && user != null) {
      ref
          .read(userDataProvider.notifier)
          .uploadProfilePicture(user: user, imageFile: widget.imageFile!);
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(
      userDataProvider,
      (previous, next) {
        if (previous != null && next is AsyncData && next.value == null) {
          ref.read(routerProvider).goNamed('login');
        } else if (next is AsyncError) {
          context.showSnackBar(next.error.toString());
        }
      },
    );
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          PageView(
            controller: pageController,
            onPageChanged: (value) => setState(() {
              selectedPage = value;
            }),
            children: const [
              Center(
                child: MoviePage(),
              ),
              Center(
                child: TicketPage(),
              ),
              Center(
                child: ProfilePage(),
              ),
            ],
          ),
          BottomNavbar(
              items: [
                BottomNavbarItem(
                    index: 0,
                    isSelected: selectedPage == 0,
                    title: 'Home',
                    image: 'assets/movie.png',
                    selectedImage: 'assets/movie-selected.png'),
                BottomNavbarItem(
                    index: 1,
                    isSelected: selectedPage == 1,
                    title: 'Ticket',
                    image: 'assets/ticket.png',
                    selectedImage: 'assets/ticket-selected.png'),
                BottomNavbarItem(
                    index: 2,
                    isSelected: selectedPage == 2,
                    title: 'Profile',
                    image: 'assets/profile.png',
                    selectedImage: 'assets/profile-selected.png'),
              ],
              onTap: (index) {
                selectedPage = index;
                pageController.jumpToPage(selectedPage);
              },
              selectedIndex: 0)
        ],
      ),
    );
  }
}
