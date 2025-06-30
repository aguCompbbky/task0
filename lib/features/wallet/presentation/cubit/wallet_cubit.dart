
import 'package:bloc/bloc.dart';
import '../../domain/usecases/create_wallet.dart';
part 'wallet_state.dart';

class WalletCubit extends Cubit<WalletState> {
  final CreateWallet createWallet;

  WalletCubit(this.createWallet) : super(WalletInitial());

  Future<void> generate() async {
    emit(WalletLoading());
    try {
      final pubkey = await createWallet();
      emit(WalletCreated(pubkey));
    } catch (e) {
      emit(WalletError(e.toString()));
    }
  }
}
