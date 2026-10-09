import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/blood_banks_provider.dart';
import '../widgets/bank_card.dart';
import '../widgets/filter_bar.dart';
import '../widgets/blood_type_filter.dart';
import '../../../shared/widgets/loading_widget.dart';
import '../../../shared/widgets/app_bottom_nav.dart';

class BloodBanksScreen extends StatelessWidget {
  const BloodBanksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => BloodBanksProvider(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Blood Banks')),
        body: Consumer<BloodBanksProvider>(
          builder: (context, provider, child) {
            return Column(
              children: [
                FilterBar(
                  selectedGov: provider.selectedGov,
                  onGovChanged: (gov) => provider.setFilter(gov, provider.selectedBloodType),
                ),
                BloodTypeFilter(
                  selectedType: provider.selectedBloodType,
                  onTypeChanged: (type) => provider.setFilter(provider.selectedGov, type),
                ),
                Expanded(
                  child: provider.isLoading
                      ? const LoadingWidget()
                      : ListView.builder(
                          itemCount: provider.banks.length,
                          itemBuilder: (context, index) {
                            return BankCard(bank: provider.banks[index]);
                          },
                        ),
                ),
              ],
            );
          },
        ),
        bottomNavigationBar: const AppBottomNav(),
      ),
    );
  }
}
