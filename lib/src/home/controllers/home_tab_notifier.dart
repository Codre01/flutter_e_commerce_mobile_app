import 'package:flutter/material.dart';
import 'package:minified_commerce/common/utils/enums.dart';

class HomeTabNotifier with ChangeNotifier{
  QueryType queryType = QueryType.all;
  String _index = 'All';

  String get index => _index;
  void setIndex(String index){
    _index = index;

    switch(index){
      case 'All':
        setQueryType(QueryType.all);
        break;
      case 'Popular':
        setQueryType(QueryType.popular);
        break;
      case 'Unisex':
        setQueryType(QueryType.unisex);
        break;
      case 'Men':
        setQueryType(QueryType.men);
        break;
      case 'Women':
       setQueryType(QueryType.women);
        break;
      case 'Kids':
        setQueryType(QueryType.kids);
        break;
      default:
        setQueryType(QueryType.all);
    }
    notifyListeners();
  }


  void setQueryType(QueryType queryType){
    this.queryType = queryType;
    notifyListeners();
  }
}