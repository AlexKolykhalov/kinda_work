import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:kinda_work/models.dart';
import 'package:meta/meta.dart';

part 'search_result_event.dart';
part 'search_result_state.dart';

class SearchResultBloc extends Bloc<SearchResultEvent, SearchResultState> {
  SearchResultBloc() : super(SearchResultInitial());

  @override
  Stream<SearchResultState> mapEventToState(
    SearchResultEvent event,
  ) async* {
    if (event is SearchResultFetched) {
      yield SearchResultLoadInProgress();
      await Future.delayed(Duration(seconds: 2));
      Map result = {
        'prices': [
          Price(
            type: 'Ресторан',
            name: 'Суши-Kventin',
            discount: 50,
            rate: 9.5,
            adress: 'г. Минск, ул. Лобанка, 105',
            menu: [
              Menu(
                img: 'assets/png/grid/1.png',
                name: 'Суши Калифорния',
                newPrice: 240,
                oldPrice: 275,
              ),
              Menu(
                img: 'assets/png/grid/2.png',
                name: 'Суши Филадельфия',
                newPrice: 240,
                oldPrice: 275,
              ),
              Menu(
                img: 'assets/png/grid/3.png',
                name: 'Суши Ням-Ням',
                newPrice: 240,
                oldPrice: 275,
              )
            ],
          ),
          Price(
            type: 'Ресторан',
            name: 'Джомалунгма-Суши Супер-пупер бар и лаундж',
            discount: 45,
            rate: 9.0,
            adress: 'г. Минск, ул. Иванова, 99',
            menu: [
              Menu(
                img: 'assets/png/grid/3.png',
                name: 'Суши',
                newPrice: 240,
                oldPrice: 275,
              ),
              Menu(
                img: 'assets/png/grid/2.png',
                name: 'Филадельфия',
                newPrice: 240,
                oldPrice: 275,
              ),
              Menu(
                img: 'assets/png/grid/1.png',
                name: 'BigBon',
                newPrice: 240,
                oldPrice: 275,
              )
            ],
          )
        ],
        'promotions': [
          Promotion(
            img: 'assets/png/grid/1.png',
            discount: 50,
            discription:
                'Романтичный ужин "В Баку" и ассорти шашлык и овощи от кафе "Апшерон" за пол цены!',
            rate: 4.2,
            newPrice: 12540,
            oldPrice: 13265,
          ),
          Promotion(
            img: 'assets/png/grid/1.png',
            discount: 50,
            discription:
                'Романтичный ужин "В Баку" и ассорти шашлык и овощи от кафе "Апшерон" за пол цены!',
            rate: 4.2,
            newPrice: 12540,
            oldPrice: 13265,
          ),
          Promotion(
            img: 'assets/png/grid/1.png',
            discount: 35,
            discription:
                'Романтичный ужин "В Баку" и ассорти шашлык и овощи от кафе "Апшерон" за пол цены!',
            rate: 8.2,
            newPrice: 400,
            oldPrice: 500,
          ),
        ],
        'companies': [
          Company(
            img: 'assets/png/grid/1.png',
            name: 'Суши&-Kve&ntin',
            type: 'Ресторан',
            adress: 'г. Минск, ул. Лобанка, 105',
            rate: 9.5,
          ),
          Company(
            img: 'assets/png/grid/1.png',
            name: '&Суши&-Kventin',
            type: 'Ресторан',
            adress: 'г. Минск, ул. Лобанка, 105',
            rate: 9.5,
          ),
          Company(
            img: 'assets/png/grid/1.png',
            name: 'Джомалунгма Су&ши&',
            type: 'Ресторан',
            adress: 'г. Минск, ул. Кульмана, 9',
            rate: 1.0,
          )
        ],
        'type_companies': [
          '&Суши&',
          '&Суши&-ресторан',
          'Доставка &суши&',
          '&Суши&-ресторан',
          'Доставка &суши&',
        ],
      };
      yield SearchResultLoadSuccess(result: result);
    }
    if (event is SearchResultCleared) {
      yield SearchResultInitial();
    }
  }
}
