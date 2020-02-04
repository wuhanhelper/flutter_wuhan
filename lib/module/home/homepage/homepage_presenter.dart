import 'package:wuhan/common/common_presenter.dart';
import 'package:wuhan/module/home/homepage/homepage_contract.dart';
import 'package:wuhan/module/home/homepage/homepage_model.dart';

/// @desc TODO
/// @time 2020/02/04 20:50
/// @author lizubing1992
class HomepagePresenter extends CommonPresenter<View, Model>
    implements Presenter {
  @override
  Model createModel() {
    return HomepageModel();
  }
}
