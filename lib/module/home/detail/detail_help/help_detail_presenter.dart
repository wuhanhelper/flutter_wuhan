import 'package:wuhan/common/common_presenter.dart';
import 'package:wuhan/module/home/detail/detail_help/help_detail_contract.dart';
import 'package:wuhan/module/home/detail/detail_help/help_detail_model.dart';

/// @desc TODO
/// @time 2020/02/09 13:27
/// @author lizubing1992
class HelpDetailPresenter extends CommonPresenter<View, Model>
    implements Presenter {
  @override
  Model createModel() {
    return HelpDetailModel();
  }
}
