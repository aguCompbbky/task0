import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallet1/features/wallet/data/models/wallet_model.dart';
import 'package:wallet1/features/wallet/domain/usecases/create_wallet.dart';

class WalletCubit extends Cubit<WalletModel?> {
  final CreateWallet _createWallet;

  WalletCubit(this._createWallet) : super(null);
  

  Future<void> create() async {
   print("🔵 WalletCubit: create() çağrıldı");
  final wallet = await _createWallet();
  print("🟢 WalletCubit: wallet sonucu -> $wallet");
  emit(wallet); // burası null olabilir
  }
}
