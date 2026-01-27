import 'dart:async';
import 'package:signals/signals.dart';
import 'package:ice_shield/data_layer/DataSources/local_database/Database.dart';
import 'package:ice_shield/data_layer/Protocol/User/FinanceProtocols.dart';

class FinanceBlock {
  final accounts = listSignal<FinancialAccountProtocol>([]);
  final assets = listSignal<AssetProtocol>([]);

  StreamSubscription? _accountsSubscription;
  StreamSubscription? _assetsSubscription;

  void updateAccounts(List<FinancialAccountProtocol> data) {
    accounts.value = data;
  }

  void updateAssets(List<AssetProtocol> data) {
    assets.value = data;
  }

  void init(FinanceDAO dao, int personId) {
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
  }

  void dispose() {
    _accountsSubscription?.cancel();
    _assetsSubscription?.cancel();
  }
}
