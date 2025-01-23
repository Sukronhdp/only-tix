import 'package:only_tix/presentation/extensions/int_extension.dart';
import 'package:only_tix/presentation/misc/methods.dart';
import 'package:only_tix/presentation/providers/router/router_provider.dart';
import 'package:only_tix/presentation/providers/user_data/user_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Widget userInfo(WidgetRef ref) => Padding(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
      child: Row(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
                width: 1,
              ),
              shape: BoxShape.circle,
              image: DecorationImage(
                image: ref.watch(userDataProvider).valueOrNull?.photoUrl != null
                    ? NetworkImage(
                            ref.watch(userDataProvider).valueOrNull!.photoUrl!)
                        as ImageProvider
                    : const AssetImage('assets/pp-placeholder.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          horizontalSpace(16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${getGreeting()}, ${ref.watch(userDataProvider).when(
                      data: (user) => user?.name.split(' ').first ?? '',
                      error: (error, stackTrace) => '',
                      loading: () => 'loading....',
                    )}!',
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const Text(
                "Pesan film kesukaanmu",
                style: TextStyle(fontSize: 12),
              ),
              verticalSpace(10),
              GestureDetector(
                onTap: () {
                  // go to wallet page
                  ref.read(routerProvider).pushNamed('wallet');
                },
                child: Row(
                  children: [
                    SizedBox(
                      width: 18,
                      height: 18,
                      child: Image.asset('assets/wallet.png'),
                    ),
                    horizontalSpace(10),
                    Text(
                      ref.watch(userDataProvider).when(
                          data: (user) =>
                              (user?.balance ?? 0).toIDRCurrencyFormat(),
                          error: (error, stackTrace) => 'IDR 0',
                          loading: () => 'Loading...'),
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );

String getGreeting() {
  return 'Halo';
}
