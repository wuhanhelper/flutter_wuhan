import 'package:flutter/material.dart';
import 'package:flutter_mvp/presenter/i_presenter.dart';
import 'package:flutter_mvp/view/abstract_view.dart';
import 'package:wuhan/common/common_contract.dart';

/// @desc  公用 widget
/// @time 2019/05/31 15:22
/// @author chenyun
abstract class Common extends AbstractView {
  Common({Key key}) : super(key: key);
}

abstract class CommonState<P extends IPresenter, M extends Common>
    extends AbstractViewState<P, M> implements ICommonView {}
