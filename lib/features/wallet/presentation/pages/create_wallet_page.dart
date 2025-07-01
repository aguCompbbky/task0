import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallet1/features/wallet/data/models/wallet_model.dart';
import '../cubit/wallet_cubit.dart';

class CreateWalletPage extends StatelessWidget {
  const CreateWalletPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Wallet')),
      body: Center(
        child: BlocBuilder<WalletCubit, WalletModel?>(
          builder: (context, state) {
            print("ui WalletCubit state -> $state");
            if (state != null) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Public Key: ${state.publicKey}"),
                  Text("Private Key: ${state.privateKey}"),
                ],
              );
            } else {
              return const Text("Cüzdan oluşturulmadı");
            }
          },
        ),
      ),
    );
  }
}
