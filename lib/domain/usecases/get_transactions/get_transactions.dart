import 'package:only_tix/data/repositories/transaction_repository.dart';
import 'package:only_tix/domain/entities/result.dart';
import 'package:only_tix/domain/entities/transaction.dart';
import 'package:only_tix/domain/usecases/get_transactions/get_transactions_param.dart';
import 'package:only_tix/domain/usecases/usecase.dart';

class GetTransactions
    implements UseCase<Result<List<Transaction>>, GetTransactionsParam> {
  final TransactionRepository _transactionRepository;

  GetTransactions({required TransactionRepository transactionRepository})
      : _transactionRepository = transactionRepository;

  @override
  Future<Result<List<Transaction>>> call(GetTransactionsParam params) async {
    var transactionListResult =
        await _transactionRepository.getUserTransaction(uid: params.uid);

    return switch (transactionListResult) {
      Success(value: final transactionList) => Result.success(transactionList),
      Failed(:final message) => Result.failed(message)
    };
  }
}
