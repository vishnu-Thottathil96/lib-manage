class CurrencyConfig {
  static CurrencySymbol _currencySymbol =
      CurrencySymbol.rupee; // Default currency symbol

  static void setCurrencySymbol(CurrencySymbol symbol) {
    _currencySymbol = symbol;
  }

  static String get currencySymbol => _currencySymbol.symbol;

  static String formatCurrency(double amount, {int decimalPlaces = 2}) {
    return '${_currencySymbol.symbol}${amount.toStringAsFixed(decimalPlaces)}';
  }
}

//currencies
enum CurrencySymbol {
  rupee('₹'),
  dollar('\$'),
  euro('€'),
  pound('£');

  final String symbol;
  const CurrencySymbol(this.symbol);
}
