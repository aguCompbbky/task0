abstract class SolanaRepository {
  Future<String> createWallet(); //tamam
  Future<int> getBalance(String publicKey); //bu
  Future<void> transferSol({
    required String fromPrivateKey,
    required String toPublicKey,
    required double amount,
  });
}
