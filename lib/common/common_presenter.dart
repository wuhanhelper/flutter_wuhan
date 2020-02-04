import 'package:flutter_mvp/presenter/abstract_presenter.dart';
import 'package:wuhan/common/common_contract.dart';

/// @desc 能用 presneter
/// @time 2019/05/31 15:22
/// @author chenyun
abstract class CommonPresenter<V extends ICommonView, M extends ICommonModel>
    extends AbstractPresenter<V, M> implements ICommonPresenter {}
