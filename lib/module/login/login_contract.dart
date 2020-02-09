import 'package:flutter_mvp/model/i_model.dart';
import 'package:flutter_mvp/presenter/i_presenter.dart';
import 'package:flutter_mvp/view/i_view.dart';
import 'package:wuhan/common/common_contract.dart';


abstract class View implements ICommonView {}

abstract class Presenter implements ICommonPresenter {}

abstract class Model implements ICommonModel {}
