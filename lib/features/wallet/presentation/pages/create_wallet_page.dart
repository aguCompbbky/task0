import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/wallet_cubit.dart';

class CreateWalletPage extends StatelessWidget {
  const CreateWalletPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Wallet')),
      body: Center(
        child: BlocBuilder<WalletCubit, WalletState>(
          builder: (context, state) {
            if (state is WalletInitial) {
              return ElevatedButton(
                onPressed: () {
                  context.read<WalletCubit>().generate();
                },
                child: const Text('Create Wallet'),
              );
            } else if (state is WalletLoading) {
              return const CircularProgressIndicator();
            } else if (state is WalletCreated) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Wallet Created!'),
                  const SizedBox(height: 10),
                  SelectableText(
                    state.publicKey,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      context.read<WalletCubit>().generate();
                    },
                    child: const Text('Generate Again'),
                  ),
                ],
              );
            } else if (state is WalletError) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Error: ${state.message}', style: const TextStyle(color: Colors.red)),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      context.read<WalletCubit>().generate();
                    },
                    child: const Text('Try Again'),
                  ),
                ],
              );
            } else {
              return const Text('Unexpected State 😅');
            }
          },
        ),
      ),
    );
  }
}
