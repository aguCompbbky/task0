import 'package:solana/base58.dart';
import 'package:solana_web3/programs.dart';
import 'package:solana_web3/solana_web3.dart' as web3;
import 'package:wallet1/features/wallet/domain/repositories/solana_repository.dart';
import 'package:solana_web3/solana_web3.dart';
import 'dart:typed_data';




class SolanaRepositoryImpl implements SolanaRepository {
  final connection = web3.Connection(web3.Cluster.devnet);

  @override
  Future<String> createWallet() async {
    final wallet = web3.Keypair.generateSync();
    await connection.requestAndConfirmAirdrop(wallet.pubkey, web3.solToLamports(1).toInt());
    return wallet.pubkey.toBase58(); // örnek dönüş
  }

  @override
  Future<int> getBalance(String publicKey) async {
    final pubKey = Pubkey.fromBase58(publicKey);//Pubkey solana web3ten geliyor Ed25519HDPublicKey bu solanadan geliyor
    return await connection.getBalance(pubKey);
  }

  @override
  Future<void> transferSol({
    required String fromPrivateKey,
    required String toPublicKey,
    required double amount,
  }) async {
    final receiver = Pubkey.fromBase58(toPublicKey);
    final sender = Keypair.fromSeckeySync(Uint8List.fromList(base58decode(fromPrivateKey)));

    final blockhash = await connection.getLatestBlockhash();

    final tx = web3.Transaction.v0(
      payer: sender.pubkey,
      recentBlockhash: blockhash.blockhash,
      instructions: [
        SystemProgram.transfer(
          fromPubkey: sender.pubkey,
          toPubkey: receiver,
          lamports: web3.solToLamports(amount),
        ),
      ],
    );

    tx.sign([sender]);
    await connection.sendAndConfirmTransaction(tx);
  }
}
