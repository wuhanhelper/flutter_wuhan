import 'package:wuhan/common/common_presenter.dart';
import 'package:wuhan/module/home/publish/publish_contract.dart';
import 'package:wuhan/module/home/publish/publish_model.dart';

/// @desc TODO
/// @time 2020/02/04 20:38
/// @author lizubing1992
class PublishPresenter extends CommonPresenter<View, Model>
    implements Presenter {
  @override
  Model createModel() {
    return PublishModel();
  }
}
