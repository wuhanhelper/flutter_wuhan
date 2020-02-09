import 'package:wuhan/common/common_presenter.dart';
import 'package:wuhan/module/home/detail/detail_need/need_detail_contract.dart';
import 'package:wuhan/module/home/detail/detail_need/need_detail_model.dart';

/// @desc TODO
/// @time 2020/02/09 14:26
/// @author lizubing1992
class NeedDetailPresenter extends CommonPresenter<View, Model>
    implements Presenter {
  @override
  Model createModel() {
    return NeedDetailModel();
  }
}
