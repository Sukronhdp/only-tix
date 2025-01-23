import 'package:only_tix/domain/entities/movie_detail.dart';
import 'package:only_tix/domain/entities/result.dart';
import 'package:only_tix/domain/entities/transaction.dart';
import 'package:only_tix/domain/usecases/create_transaction/create_transaction.dart';
import 'package:only_tix/domain/usecases/create_transaction/create_transaction_param.dart';
import 'package:only_tix/presentation/extensions/build_context_extension.dart';
import 'package:only_tix/presentation/extensions/int_extension.dart';
import 'package:only_tix/presentation/misc/constants.dart';
import 'package:only_tix/presentation/misc/methods.dart';
import 'package:only_tix/presentation/pages/booking_confirmation_page/methods/transaction_row.dart';
import 'package:only_tix/presentation/providers/router/router_provider.dart';
import 'package:only_tix/presentation/providers/transaction_data/transaction_data_provider.dart';
import 'package:only_tix/presentation/providers/usecases/create_transaction_provider.dart';
import 'package:only_tix/presentation/providers/user_data/user_data_provider.dart';
import 'package:only_tix/presentation/widgets/back_navigation_bar.dart';
import 'package:only_tix/presentation/widgets/network_image_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class BookingConfirmationPage extends ConsumerWidget {
  final (MovieDetail, Transaction) transactionDetail;

  const BookingConfirmationPage({required this.transactionDetail, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var (movieDetail, transaction) = transactionDetail;

    transaction = transaction.copyWith(
      total: transaction.ticketAmount! * transaction.ticketPrice! +
          transaction.adminFee,
    );

    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 40),
            child: Column(
              children: [
                BackNavigationBar(
                  'Booking Confirmation',
                  onTap: () => ref.read(routerProvider).pop(),
                ),
                verticalSpace(24),
                NetworkImageCard(
                  width: MediaQuery.of(context).size.width - 48,
                  height: (MediaQuery.of(context).size.width - 48) * 0.6,
                  borderRadius: 15,
                  imageUrl:
                      'https://image.tmdb.org/t/p/w500${movieDetail.backdropPath ?? movieDetail.posterPath}',
                  fit: BoxFit.cover,
                ),
                verticalSpace(24),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 48,
                  child: Text(transaction.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold)),
                ),
                verticalSpace(5),
                const Divider(color: grey),
                verticalSpace(5),
                transactionRow(
                    title: 'Waktu Penayangan',
                    value: DateFormat('EEE, d MMMM y').format(
                        DateTime.fromMillisecondsSinceEpoch(
                            transaction.watchingTime ?? 0)),
                    width: MediaQuery.of(context).size.width - 48),
                transactionRow(
                    title: 'Bioskop',
                    value: '${transaction.theaterName}',
                    width: MediaQuery.of(context).size.width - 48),
                transactionRow(
                    title: 'Nomor Kursi',
                    value: transaction.seats.join(', '),
                    width: MediaQuery.of(context).size.width - 48),
                transactionRow(
                    title: 'Tiket',
                    value: '${transaction.ticketAmount} TIKET',
                    width: MediaQuery.of(context).size.width - 48),
                transactionRow(
                    title: 'Harga Tiket',
                    value: '${transaction.ticketPrice?.toIDRCurrencyFormat()}',
                    width: MediaQuery.of(context).size.width - 48),
                transactionRow(
                    title: 'Biaya Admin',
                    value: transaction.adminFee.toIDRCurrencyFormat(),
                    width: MediaQuery.of(context).size.width - 48),
                const Divider(color: grey),
                transactionRow(
                    title: 'Total Pembayaran',
                    value: transaction.total.toIDRCurrencyFormat(),
                    width: MediaQuery.of(context).size.width - 48),
                verticalSpace(40),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () async {
                        int transactiontime =
                            DateTime.now().millisecondsSinceEpoch;

                        transaction = transaction.copyWith(
                          transactionTime: transactiontime,
                          id: 'only-tix-$transactiontime-${transaction.uid}',
                        );

                        CreateTransaction createTransaction =
                            ref.read(createTransactionProvider);

                        await createTransaction(CreateTransactionParam(
                                //use case untuk nge send data transaksi ke database server
                                transaction: transaction))
                            .then((result) {
                          switch (result) {
                            case Success(value: _):
                              ref
                                  .read(transactionDataProvider.notifier)
                                  .refreshTransactionData();
                              ref
                                  .read(userDataProvider.notifier)
                                  .refreshUserData(); //ketika berhasil bayar, maka refresh saldo pengguna
                              ref.read(routerProvider).goNamed(
                                  'main'); // setelah bayar otomatis ke halaman utama
                            case Failed(:final message):
                              context.showSnackBar(message);
                          }
                        });
                      },
                      style: ElevatedButton.styleFrom(
                          foregroundColor: backgroundPage,
                          backgroundColor: brightCyan,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      child: const Text('Bayar Sekarang')),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
