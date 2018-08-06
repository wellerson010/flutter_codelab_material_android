import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'model/product.dart';

const double _kFlingVelocity = 2.0;

class _FrontLayer extends StatelessWidget {
  const _FrontLayer({Key key, this.child, this.onTap}):super(key: key);

  final Widget child;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context){
    return Material(
      elevation: 16.0,
      shape: BeveledRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(46.0))
       //   borderRadius: BorderRadius.all(Radius.circular(46.0))
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
       /*   GestureDetector(
              behavior: HitTestBehavior.opaque,
            onTap: onTap,
            child: Container(
              height: 40.0,
              alignment: AlignmentDirectional.centerStart,
              color: Colors.transparent
            )
          ), */
          Expanded(
            child: child
          )
        ]
      )
    );
  }
}

class Backdrop extends StatefulWidget {
  final Category category;
  final Widget frontLayer;
  final Widget backLayer;
  final Widget frontTitle;
  final Widget backTitle;

  Backdrop({
    @required this.category,
    @required this.frontLayer,
    @required this.backLayer,
    @required this.frontTitle,
    @required this.backTitle,
  });

  @override
  _BackdropState createState() => _BackdropState();
}

class _BackdropState extends State<Backdrop> with SingleTickerProviderStateMixin{
  AnimationController _animationController;
  final GlobalKey _backdropKey = GlobalKey(debugLabel: "bakdrop");

  @override
  void didUpdateWidget(Backdrop old){
    super.didUpdateWidget(old);
    
    if (widget.category != old.category){
      _toggleBackdropLayerVisibility();
    }
    else if (_frontLayerVisible){
      _animationController.fling(velocity: _kFlingVelocity);
    }
  }

  @override
  void initState(){
    super.initState();

    _animationController = AnimationController(
      duration: Duration(milliseconds: 300),
      value: 1.0,
      vsync: this
    );
  }

  @override
  void dispose(){
    _animationController.dispose();
    super.dispose();
  }

  bool get _frontLayerVisible {
    final AnimationStatus status = _animationController.status;
    
    return status == AnimationStatus.completed || status == AnimationStatus.forward;
  }
  
  void _toggleBackdropLayerVisibility(){
    _animationController.fling(velocity: _frontLayerVisible ? -_kFlingVelocity : _kFlingVelocity);
  }


  Widget _buildStack(BuildContext context, BoxConstraints constraints){
    const double layerTitleHeight = 48.0;
    final Size layerSize = constraints.biggest;
    final double layerTop = layerSize.height - layerTitleHeight;

    Animation<RelativeRect> layerAnimation = RelativeRectTween(
      begin: RelativeRect.fromLTRB(0.0, layerTop, 0.0, layerTop - layerSize.height),
      end: RelativeRect.fromLTRB(0.0, 0.0, 0.0, 0.0)
    ).animate(_animationController);

    return Stack(
      key: _backdropKey,
      children: <Widget>[
        widget.backLayer,
        PositionedTransition(
          rect: layerAnimation,
          child: _FrontLayer(child: widget.frontLayer,
            onTap: _toggleBackdropLayerVisibility,),
        )

      ],
    );
  }

  @override
  Widget build(BuildContext context){
    var appBar = AppBar(
      brightness: Brightness.light,
      elevation: 0.0,
      leading: IconButton(
        icon: Icon(Icons.menu, semanticLabel: 'menu',),
        onPressed: _toggleBackdropLayerVisibility,
      ),
      title: widget.frontTitle,
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.search, semanticLabel: 'search',),
          onPressed: (){},
        ),
        IconButton(
          icon: Icon(Icons.tune, semanticLabel: 'filter',),
          onPressed: (){},
        ),
      ],
    );

    return Scaffold(
      appBar: appBar,
      body: LayoutBuilder(builder: _buildStack)
    );
  }
}