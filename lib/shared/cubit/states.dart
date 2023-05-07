class StockStates{}
class StockInitialState extends StockStates{}

class StockSuccessMostGainer extends StockStates{}
class StockLoadingMostGainer extends StockStates{}
class StockErrorMostGainer extends StockStates{
  final String error;
  StockErrorMostGainer({required this.error});
}

class StockSuccessMostLosers extends StockStates{}
class StockLoadingMostLosers extends StockStates{}
class StockErrorMostLosers extends StockStates{
  final String error;
  StockErrorMostLosers({required this.error});
}

class StockSuccessMostActives extends StockStates{}
class StockLoadingMostActives extends StockStates{}
class StockErrorMostActives extends StockStates{
  final String error;
  StockErrorMostActives({required this.error});
}