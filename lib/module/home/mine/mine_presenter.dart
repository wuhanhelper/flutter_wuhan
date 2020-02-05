import 'package:flutter_mvp/view/i_view.dart';
import 'package:wuhan/common/common_presenter.dart';
import 'package:wuhan/module/home/mine/mine_contract.dart';
import 'package:wuhan/module/home/mine/mine_model.dart';

/// @desc TODO
/// @time 2020/02/04 20:32
/// @author lizubing1992
class MinePresenter extends CommonPresenter<View, Model> implements Presenter {
  @override
  Model createModel() {
    return MineModel();
  }
}
