import 'package:wallet1/features/wallet/data/models/wallet_model.dart';

import '../repositories/solana_repository.dart';

class CreateWallet {
  final SolanaRepository repository;

  CreateWallet(this.repository);

    Future<WalletModel?> call() async {
    print("🟡 CreateWallet usecase çalışıyor...");
    final result = await repository.createWallet();
    print("🟢 CreateWallet sonucu: $result");
    return result;
  }
}
