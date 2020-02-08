import 'package:wuhan/common/common_presenter.dart';
import 'package:wuhan/module/home/homepage/homepage_help/homepage_help_contract.dart';
import 'package:wuhan/module/home/homepage/homepage_help/homepage_help_model.dart';

/// @desc TODO
/// @time 2020/02/06 16:33
/// @author lizubing1992
class HomepageHelpPresenter extends CommonPresenter<View, Model>
    implements Presenter {
  @override
  Model createModel() {
    return HomepageHelpModel();
  }
}
