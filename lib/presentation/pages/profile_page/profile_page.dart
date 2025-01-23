import 'package:only_tix/presentation/misc/methods.dart';
import 'package:only_tix/presentation/pages/profile_page/methods/profile_item.dart';
import 'package:only_tix/presentation/pages/profile_page/methods/user_info.dart';
import 'package:only_tix/presentation/providers/router/router_provider.dart';
import 'package:only_tix/presentation/providers/user_data/user_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:only_tix/presentation/misc/constants.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              verticalSpace(20),
              ...userInfo(ref),
              const Divider(),
              verticalSpace(20),
              profileItem('Update Profile'),
              verticalSpace(20),
              profileItem(
                'Dompet',
                onTap: () => ref.read(routerProvider).pushNamed('wallet'),
              ),
              verticalSpace(20),
              profileItem('Ganti Password'),
              verticalSpace(20),
              profileItem('Ganti Bahasa'),
              verticalSpace(20),
              const Divider(),
              verticalSpace(20),
              profileItem('Contact Us'),
              verticalSpace(20),
              profileItem('Kebijakan Privasi'),
              verticalSpace(20),
              profileItem('Syarat dan Ketentuan'),
              verticalSpace(60),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    ref.read(userDataProvider.notifier).logout();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: brightCyan,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: const Text('Logout'),
                ),
              ),
              verticalSpace(100)
            ],
          ),
        )
      ],
    );
  }
}
