import 'dart:async';
import 'package:drift/drift.dart';
import 'package:signals/signals.dart';
import 'package:ice_shield/data_layer/DataSources/local_database/Database.dart';
import 'package:ice_shield/data_layer/Protocol/User/FinanceProtocols.dart';

class FinanceBlock {
  final accounts = listSignal<FinancialAccountProtocol>([]);
  final assets = listSignal<AssetProtocol>([]);
  final transactions = listSignal<TransactionData>([]);

  StreamSubscription? _accountsSubscription;
  StreamSubscription? _assetsSubscription;
  StreamSubscription? _transactionsSubscription;

  late FinanceDAO _dao;
  late int _personId;

  void updateAccounts(List<FinancialAccountProtocol> data) {
    accounts.value = data;
  }

  void updateAssets(List<AssetProtocol> data) {
    assets.value = data;
  }

  /// Total savings amount
  late final totalSavings = computed(() {
    return transactions.value
        .where((t) => t.type == 'savings')
        .fold(0.0, (sum, t) => sum + t.amount);
  });

  /// Monthly spending for the current month
  late final monthlySpending = computed(() {
    final now = DateTime.now();
    return transactions.value
        .where(
          (t) =>
              t.type == 'expense' &&
              t.transactionDate.month == now.month &&
              t.transactionDate.year == now.year,
        )
        .fold(0.0, (sum, t) => sum + t.amount);
  });

  /// Monthly income for the current month
  late final monthlyIncome = computed(() {
    final now = DateTime.now();
    return transactions.value
        .where(
          (t) =>
              t.type == 'income' &&
              t.transactionDate.month == now.month &&
              t.transactionDate.year == now.year,
        )
        .fold(0.0, (sum, t) => sum + t.amount);
  });

  /// Spending grouped by category this month
  late final spendingByCategory = computed(() {
    final now = DateTime.now();
    final monthExpenses = transactions.value.where(
      (t) =>
          t.type == 'expense' &&
          t.transactionDate.month == now.month &&
          t.transactionDate.year == now.year,
    );
    final Map<String, double> map = {};
    for (final t in monthExpenses) {
      map[t.category] = (map[t.category] ?? 0) + t.amount;
    }
    return map;
  });

  void init(FinanceDAO dao, int personId) {
    _dao = dao;
    _personId = personId;

    _accountsSubscription?.cancel();
    _accountsSubscription = dao.watchAccounts(personId).listen((data) {
      final protocols = data
          .map(
            (e) => FinancialAccountProtocol(
              financialAccountID: e.accountID,
              personID: e.personID,
              accountName: e.accountName,
              accountType: e.accountType,
              balance: e.balance,
              currency: e.currency.name,
              isPrimary: e.isPrimary,
              isActive: e.isActive,
            ),
          )
          .toList();
      updateAccounts(protocols);
    });

    _assetsSubscription?.cancel();
    _assetsSubscription = dao.watchAssets(personId).listen((data) {
      final protocols = data
          .map(
            (e) => AssetProtocol(
              id: e.assetID,
              personId: e.personID,
              assetName: e.assetName,
              assetCategory: e.assetCategory,
              purchaseDate: e.purchaseDate,
              purchasePrice: e.purchasePrice,
              currentEstimatedValue: e.currentEstimatedValue,
              currency: e.currency.name,
              condition: e.condition,
              location: e.location,
              notes: e.notes,
              isInsured: e.isInsured,
            ),
          )
          .toList();
      updateAssets(protocols);
    });

    _transactionsSubscription?.cancel();
    _transactionsSubscription = dao.watchAllTransactions(personId).listen((
      data,
    ) {
      transactions.value = data;
    });
  }

  Future<void> addTransaction({
    required String category,
    required String type,
    required double amount,
    String? description,
    DateTime? date,
  }) async {
    await _dao.insertTransaction(
      TransactionsTableCompanion.insert(
        personID: _personId,
        category: category,
        type: type,
        amount: amount,
        description: Value(description),
        transactionDate: Value(date ?? DateTime.now()),
      ),
    );
  }

  Future<void> deleteTransaction(int transactionID) async {
    await _dao.deleteTransaction(transactionID);
  }

  void dispose() {
    _accountsSubscription?.cancel();
    _assetsSubscription?.cancel();
    _transactionsSubscription?.cancel();
  }
}
