import 'package:only_tix/data/firebase/firebase_transaction_repository.dart';
import 'package:only_tix/data/repositories/transaction_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'transaction_repository_provider.g.dart';

@riverpod
TransactionRepository transactionRepository(TransactionRepositoryRef ref) =>
    FirebaseTransactionRepository();
