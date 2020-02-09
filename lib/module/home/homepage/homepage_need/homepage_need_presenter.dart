import 'package:wuhan/common/common_presenter.dart';
import 'package:wuhan/module/home/homepage/homepage_need/homepage_need_contract.dart';
import 'package:wuhan/module/home/homepage/homepage_need/homepage_need_model.dart';

/// @desc TODO
/// @time 2020/02/06 16:32
/// @author lizubing1992
class HomepageNeedPresenter extends CommonPresenter<View, Model>
    implements Presenter {
  @override
  Model createModel() {
    return HomepageNeedModel();
  }
}
