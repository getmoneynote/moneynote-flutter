import 'package:awesome_select/awesome_select.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/commons/index.dart';
import '/components/index.dart';
import '/login/index.dart';
import '/books/index.dart';
import '/note_days/index.dart';
import '/my/index.dart';

class MyPage extends StatelessWidget {

  const MyPage({super.key});

  @override
  Widget build(BuildContext context) {
    final initState = context.watch<AuthBloc>().state.initState;
    final languageState = context.watch<LanguageBloc>().state.selectedLanguage;
    return Scaffold(
        appBar: AppBar(
          title: const Text('我的'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ListTile(
                  title: const Text('登录用户名：'),
                  trailing: Text(initState['user']['username'])
              ),
              ListTile(
                  title: const Text('当前默认账本：'),
                  trailing: Text(initState['book']['name'])
              ),
              ListTile(
                  title: const Text('账户概览：'),
                  subtitle: BlocBuilder<AccountOverviewBloc, AccountOverviewState>(
                    builder: (context, state) {
                      if (state.status == LoadDataStatus.success) {
                        return Text(
                          '资产：${state.data[0]}，负债：${state.data[1]}，净资产：${state.data[2]}。',
                          style: const TextStyle(fontSize: 12)
                        );
                      }
                      return const Text('Loading...');
                    }
                  ),
                trailing: IconButton(
                    onPressed: () {
                      BlocProvider.of<AccountOverviewBloc>(context).add(AccountOverviewReloaded());
                    },
                    icon: const Icon(Icons.refresh)
                )
              ),
              const Divider(),
              ListTile(
                title: const Text('账本管理'),
                trailing: const Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  navigateTo(context, const BooksPage());
                },
              ),
              // const Divider(),
              // SmartSelect<String?>.single(
              //   title: '当前语言',
              //   selectedValue: languageState.text,
              //     modalType: S2ModalType.bottomSheet,
              //     onChange: (selected) { },
              //   choiceItems: [
              //     S2Choice<String>(value: 'and', title: 'Android'),
              //     S2Choice<String>(value: 'ios', title: 'IOS'),
              //     S2Choice<String>(value: 'mac', title: 'Macintos'),
              //     S2Choice<String>(value: 'tux', title: 'Linux'),
              //     S2Choice<String>(value: 'win', title: 'Windows'),
              //   ]
              // ),
              const Divider(),
              ListTile(
                  title: const Text('提醒事项'),
                  trailing: const Icon(Icons.keyboard_arrow_right),
                  onTap: () {
                    navigateTo(context, const NoteDaysPage());
                  }
              ),
              const Divider(),
              ListTile(
                  title: const Text('使用指南'),
                  trailing: const Icon(Icons.keyboard_arrow_right),
                  onTap: () {
                    navigateTo(context, const WebViewPage(title: '使用指南', url: 'https://help.moneywhere.com'));
                  }
              ),
              const Divider(),
              const ListTile(
                  title: Text('当前版本号：'),
                  trailing: Text('1.0.14')
              ),
              const Divider(),
              Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: DialogConfirm(
                      child: AbsorbPointer(
                        child: ElevatedButton(
                          onPressed: () { },
                          child: const Text('退出登录'),
                        ),
                      ),
                      onConfirm: () {
                        BlocProvider.of<AuthBloc>(context).add(LoggedOut());
                      }
                  )
              ),
              const SizedBox(height: 30),
            ],
          ),
        )
    );
  }
}