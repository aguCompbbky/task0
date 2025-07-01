import 'package:solana/base58.dart';
import 'package:solana/solana.dart';
import 'package:solana_web3/programs.dart';
import 'package:solana_web3/solana_web3.dart' as web3;
import 'package:wallet1/features/wallet/data/models/wallet_model.dart';
import 'package:wallet1/features/wallet/domain/repositories/solana_repository.dart';
import 'package:solana_web3/solana_web3.dart' hide lamportsPerSol;
import 'dart:typed_data';

class SolanaRepositoryImpl implements SolanaRepository {
  final RpcClient client = RpcClient(
    'http://10.0.2.2:8899',
  ); // Android emulator için localhost
  final Ed25519HDKeyPair? _cachedWallet = null;

  @override
  Future<WalletModel?> createWallet() async {
  try {
    print("🟠 createWallet başladım");

    final wallet = await Ed25519HDKeyPair.random();
    print("🔑 Wallet oluşturuldu: ${wallet.address}");

    await client.requestAirdrop(wallet.address, lamportsPerSol.toInt());
    print("💰 Airdrop tamamlandı");

    final extracted = await wallet.extract();
    print("📦 Private key extract edildi");

    return WalletModel(
      publicKey: wallet.address,
      privateKey: base58encode(extracted.bytes),
    );
  } catch (e) {
    print("❌ createWallet error: $e");
    return null;
  }
  }

  @override
  Future<int> getBalance(String address) async {
    try {
      final result = await client.getBalance(address);
      return result.value; // BalanceResult içinden değeri alıyoruz
    } catch (e) {
      print("getBalance error: $e");
      return 0;
    }
  }

  @override
  Future<void> transferSol({
    required String fromPrivateKey,
    required String toPublicKey,
    required double amount,
  }) async {
    final RpcClient client = RpcClient(
      'http://10.0.2.2:8899',
    ); // veya localhost
    final sender = await Ed25519HDKeyPair.fromPrivateKeyBytes(
      privateKey: Uint8List.fromList(base58decode(fromPrivateKey)),
    );
    final receiver = Ed25519HDPublicKey.fromBase58(toPublicKey);

    final lamports = (amount * lamportsPerSol).toInt();

    final signature = await client.requestAirdrop(
      receiver.toBase58(),
      lamports,
    );

    print('Transfer completed. Signature: $signature');
  }
}
