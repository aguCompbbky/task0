import 'package:wallet1/features/wallet/data/models/wallet_model.dart';

abstract class SolanaRepository {
  Future<WalletModel?> createWallet(); 
  Future<int> getBalance(String publicKey); 
  Future<void> transferSol({
    required String fromPrivateKey,
    required String toPublicKey,
    required double amount,
  });
}
