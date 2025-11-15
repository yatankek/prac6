import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:prac6/features/profile/data/bloc/profile_cubit.dart';
import 'package:prac6/app_state.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit()..loadUserData(),
      child: const ProfileView(),
    );
  }
}

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = AppState.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Профиль'),
        backgroundColor: const Color(0xFFD32F2F),
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.pop();
          },
        ),
      ),
      body: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return ListView(
            children: [
              UserAccountsDrawerHeader(
                accountName: Text(state.userName),
                accountEmail: Text(state.userEmail),
                currentAccountPicture: const CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, size: 40, color: Color(0xFFD32F2F)),
                ),
                decoration: const BoxDecoration(color: Color(0xFFD32F2F)),
              ),
              ListTile(
                leading: const Icon(Icons.favorite, color: Color(0xFFD32F2F)),
                title: const Text('Избранное'),
                onTap: () {
                  context.push('/favorites');
                },
              ),
              ListTile(
                leading: const Icon(Icons.settings, color: Color(0xFFD32F2F)),
                title: const Text('Настройки'),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.help, color: Color(0xFFD32F2F)),
                title: const Text('Помощь'),
                onTap: () {},
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.logout, color: Colors.red),
                title: const Text(
                  'Выйти',
                  style: TextStyle(color: Colors.red),
                ),
                onTap: () {
                  context.read<ProfileCubit>().logout();
                  context.go('/auth');
                },
              ),
            ],
          );
        },
      ),
    );
  }
}