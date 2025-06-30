import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/wallet/data/repositories/solana_repo_impl.dart';
import 'features/wallet/domain/repositories/solana_repository.dart';
import 'features/wallet/domain/usecases/create_wallet.dart';
import 'features/wallet/presentation/cubit/wallet_cubit.dart';
import 'features/wallet/presentation/pages/create_wallet_page.dart';

void main() {
  runApp(const MyApp());
}
final SolanaRepository repository = SolanaRepositoryImpl();

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
  create: (context) => WalletCubit(CreateWallet(repository)), 
  child: MaterialApp(home: CreateWalletPage()), // UI
);
  }
}

