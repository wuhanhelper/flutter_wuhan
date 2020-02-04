import 'package:wuhan/common/common_presenter.dart';
import 'package:wuhan/module/home/home_contract.dart';
import 'package:wuhan/module/home/home_model.dart';

/// @desc TODO
/// @time 2020/02/03 21:08
/// @author lizubing1992
class HomePresenter extends CommonPresenter<View, Model> implements Presenter {
  @override
  Model createModel() {
    return HomeModel();
  }
}
