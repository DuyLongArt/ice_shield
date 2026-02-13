import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ice_shield/ui_layer/home_page/MainButton.dart';
import 'package:ice_shield/ui_layer/finance_page/models/FinanceAsset.dart';
import 'package:ice_shield/ui_layer/finance_page/services/FinanceService.dart';

class FinancePage extends StatefulWidget {
  const FinancePage({super.key});

  static Widget icon(BuildContext context, {double? size}) {
    return MainButton(
      type: "finance",
      destination: "/finance",
      size: size,
      icon: Icons.add,
      mainFunction: () {
        print("Finance main button clicked");
      },
      subButtons: [
        SubButton(
          icon: Icons.add_chart_rounded,
          backgroundColor: Colors.blue,
          onPressed: () {},
        ),
        SubButton(
          icon: Icons.account_balance_wallet_rounded,
          backgroundColor: Colors.green,
          onPressed: () {},
        ),
      ],
    );
  }

  @override
  State<FinancePage> createState() => _FinancePageState();
}

class _FinancePageState extends State<FinancePage> {
  final NumberFormat _currencyFormat = NumberFormat.currency(symbol: '\$');
  late List<FinanceAsset> _stocks = [];
  final List<FinanceAsset> _coins = FinanceService.getCoins();

  Future<void> _initWatchlist() async {
    const List<String> myTickers = ['FPT', 'VNM', 'HPG', 'SSI'];

    // Fetch data in the background
    for (String ticker in myTickers) {
      final asset = await FinanceService.fetchVnStock(ticker);

      // Check if the widget is still "alive" before calling setState
      if (mounted && asset != null) {
        setState(() {
          _stocks.add(asset);
        });
      }
    }
  }

  @override
  void initState() {
    super.initState(); // Always call super.initState() first!
    _initWatchlist();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            expandedHeight: 0,
            floating: true,
            pinned: true,
            elevation: 0,
            backgroundColor: colorScheme.surface,
            title: const Text(
              'Finance',
              style: TextStyle(fontWeight: FontWeight.w900),
            ),
            centerTitle: false,
          ),

          // Portfolio Summary
          SliverToBoxAdapter(child: _buildPortfolioHeader(context)),

          // Stocks Section
          _buildSectionHeader(context, 'Stocks', Icons.trending_up_rounded),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => _buildAssetItem(context, _stocks[index]),
                childCount: _stocks.length,
              ),
            ),
          ),

          // Crypto Section
          _buildSectionHeader(
            context,
            'Cryptocurrency',
            Icons.currency_bitcoin_rounded,
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => _buildAssetItem(context, _coins[index]),
                childCount: _coins.length,
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 120)),
        ],
      ),
    );
  }

  Widget _buildPortfolioHeader(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final totalBalance = FinanceService.getTotalBalance();
    final totalChange = FinanceService.getTotalChange();
    final changePercent = FinanceService.getTotalChangePercentage();

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [colorScheme.primary, colorScheme.primary.withOpacity(0.8)],
        ),
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: colorScheme.primary.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'TOTAL BALANCE',
            style: textTheme.labelSmall?.copyWith(
              color: colorScheme.onPrimary.withOpacity(0.8),
              letterSpacing: 1.2,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            _currencyFormat.format(totalBalance),
            style: textTheme.headlineMedium?.copyWith(
              color: colorScheme.onPrimary,
              fontWeight: FontWeight.w900,
              letterSpacing: -1,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: colorScheme.onPrimary.withOpacity(0.15),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.arrow_upward_rounded,
                  color: Colors.greenAccent[400],
                  size: 16,
                ),
                const SizedBox(width: 4),
                Text(
                  '${_currencyFormat.format(totalChange)} ($changePercent%)',
                  style: TextStyle(
                    color: Colors.greenAccent[400],
                    fontWeight: FontWeight.w900,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(
    BuildContext context,
    String title,
    IconData icon,
  ) {
    final colorScheme = Theme.of(context).colorScheme;
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 32, 24, 16),
        child: Row(
          children: [
            Icon(icon, size: 20, color: colorScheme.primary),
            const SizedBox(width: 8),
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w900,
                color: colorScheme.onSurface,
              ),
            ),
            const Spacer(),
            TextButton(
              onPressed: () {},
              child: const Text(
                'See All',
                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAssetItem(BuildContext context, FinanceAsset asset) {
    final colorScheme = Theme.of(context).colorScheme;
    final isPositive = asset.change24h >= 0;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: colorScheme.outlineVariant.withOpacity(0.5)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: asset.color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(asset.icon, color: asset.color, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  asset.symbol,
                  style: const TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 16,
                  ),
                ),
                Text(
                  asset.name,
                  style: TextStyle(
                    color: colorScheme.onSurface.withOpacity(0.5),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                _currencyFormat.format(asset.price),
                style: const TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 16,
                ),
              ),
              Text(
                '${isPositive ? '+' : ''}${asset.change24h}%',
                style: TextStyle(
                  color: isPositive ? Colors.green : Colors.red,
                  fontSize: 12,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
