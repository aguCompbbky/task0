
part of 'wallet_cubit.dart';

abstract class WalletState {}

class WalletInitial extends WalletState {}

class WalletLoading extends WalletState {}

class WalletCreated extends WalletState {
  final String publicKey;

  WalletCreated(this.publicKey);
}

class WalletError extends WalletState {
  final String message;

  WalletError(this.message);
}




