import '../repositories/solana_repository.dart';

class CreateWallet {
  final SolanaRepository repository;

  CreateWallet(this.repository);

  Future<String> call() => repository.createWallet();
}
