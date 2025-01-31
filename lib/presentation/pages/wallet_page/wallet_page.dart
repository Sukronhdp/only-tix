import 'package:only_tix/presentation/misc/methods.dart';
import 'package:only_tix/presentation/pages/wallet_page/methods/wallet_card.dart';
import 'package:only_tix/presentation/providers/router/router_provider.dart';
import 'package:only_tix/presentation/widgets/back_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:only_tix/presentation/pages/wallet_page/methods/recent_transactions.dart';

class WalletPage extends ConsumerWidget {
  const WalletPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
            child: Column(
              children: [
                BackNavigationBar(
                  'Dompet',
                  onTap: () => ref.read(routerProvider).pop(),
                ),
                verticalSpace(24),
                walletCard(ref),
                verticalSpace(24),
                ...recentTransactions(ref),
              ],
            ),
          )
        ],
      ),
    );
  }
}
