import 'package:gbjatolye/features/domain/entities/ticket/ticket.dart';
import 'package:gbjatolye/features/domain/usecases/usecases.dart';
import 'package:gbjatolye/features/presentation/widgets/snackbar_errors.dart';
import 'package:gbjatolye/utils/statics.dart';
import 'package:flutter/cupertino.dart';

abstract class TicketProviderUseCases {

  bool getAbleTicket();

  Future getTicketList(int page);

}

class TicketProvider with ChangeNotifier implements TicketProviderUseCases {

  BuildContext _context;
  UseCases _useCases;
  ScrollController _scrollController;
  int _currentPage = 1;
  int _pageCount=1;
  List<Ticket> _tickets;


  ///Getter
  ///

  List<Ticket> get tickets => _tickets;

  int get pageCount => _pageCount;

  BuildContext get context => _context;

  UseCases get useCases => _useCases;

  ScrollController get scrollController => _scrollController;

  int get currentPage => _currentPage;


  ///Setters
  ///

  set tickets(List<Ticket> value) {
    _tickets = value;
    notifyListeners();
  }

  set pageCount(int value) {
    _pageCount = value;
    notifyListeners();
  }

  set currentPage(int value) {
    _currentPage = value;
    notifyListeners();
  }

  set scrollController(ScrollController value) {
    _scrollController = value;
    notifyListeners();
  }



  set context(BuildContext value) {
    _context = value;
    notifyListeners();
  }

  set useCases(UseCases value) {
    _useCases = value;
    notifyListeners();
  }

  TicketProvider() {
    scrollController = ScrollController();
    tickets = List<Ticket>();
    currentPage = 1;
    pageCount=1;
    notifyListeners();
  }

  reTicketProvider() {
    scrollController = ScrollController();
    tickets = List<Ticket>();
    currentPage = 1;
    pageCount=1;
    notifyListeners();
  }

  @override
  Future getTicketList(int page) async{

    List<Ticket> tmpTickets=List<Ticket>();

    var result = await useCases.getTicketList(
        AppApi.getRequestUrl(AppApi.GETTICKETLIST_API));
    result.fold((exception) {
      SnackbarErrors(context: context, exp: exception);
    }, (model) async {
      currentPage += 1;
      for (Ticket item in model.ticketlist) tmpTickets.add(item);
      tickets=tmpTickets;
    });

  }

  @override
  bool getAbleTicket() {
    if(currentPage==1) return true;
    return currentPage<=pageCount;
  }

}
