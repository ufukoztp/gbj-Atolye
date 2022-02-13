import 'package:gbjatolye/features/domain/entities/product/productOld.dart';
import 'package:gbjatolye/utils/applocalization.dart';
import 'package:gbjatolye/utils/theme.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future asyncSpecsDialog(
    {BuildContext context, List<SpecificationGroup> specslist}) async {
  return showDialog<double>(
    context: context,
    barrierDismissible: true,
    // dialog is dismissible with a tap on the barrier
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(50))),
        backgroundColor: AppTheme.white[50],
        title: Column(
          children: <Widget>[
            Container(
              child: Text(
                  AppLocalizations.of(context).txtLblChooseSpecs.toUpperCase(),
                  style: Theme.of(context).textTheme.headline6,
                  textAlign: TextAlign.center),
            ),
            Container(
              padding: EdgeInsets.only(top: 10.0),
              child: Text(AppLocalizations.of(context).txtLblChooseSpecsDesc,
                  style: Theme.of(context).textTheme.headline4,
                  textAlign: TextAlign.center),
            )
          ],
        ),
        contentPadding:
            EdgeInsets.only(top: 20.0, bottom: 0.0, right: 0.0, left: 0.0),
        content: Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            Container(
                width: 300,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 50.0),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(),
                    child: ExpandableTheme(
                      data: const ExpandableThemeData(
                        iconColor: Colors.blue,
                        useInkWell: false,
                      ),
                      child: ListView(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        children: getList(specslist),
                      ),
                    ),
                  ),
                )),
            InkWell(
              child: Container(
                height: 50,
                decoration: new BoxDecoration(
                    gradient: LinearGradient(colors: <Color>[
                      AppTheme.aqua[50],
                      AppTheme.azureRadiance[50],
                    ]),
                    borderRadius: new BorderRadius.only(
                      bottomLeft: const Radius.circular(50.0),
                      bottomRight: const Radius.circular(50.0),
                    )),
                child: Center(
                  child: Text(AppLocalizations.of(context).txtBtnSave,
                      style: Theme.of(context).textTheme.button,
                      textAlign: TextAlign.center),
                ),
              ),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
    },
  );
}

List<Widget> getList(List<SpecificationGroup> specslist) {

  List<Widget> widgets = List<Widget>();

  for (int i = 0; i < specslist.length; i++)
    widgets.add(_ExpandableHeaderList(specificationGroup: specslist[i]));

  return widgets;

}

class _ExpandableHeaderList extends StatefulWidget {
  final SpecificationGroup specificationGroup;

  const _ExpandableHeaderList({Key key, this.specificationGroup})
      : super(key: key);

  @override
  _ExpandableHeaderListState createState() => _ExpandableHeaderListState();
}

class _ExpandableHeaderListState extends State<_ExpandableHeaderList>
    with SingleTickerProviderStateMixin {

  int selectedRadioSpecId;

  @override
  Widget build(BuildContext context) {
    return ExpandableNotifier(
        child: Padding(
      padding: const EdgeInsets.only(left: 15.0,right: 10.0,bottom: 15.0),
      child: Column(
        children: <Widget>[
          ScrollOnExpand(
            scrollOnExpand: true,
            scrollOnCollapse: false,
            child: ExpandablePanel(
              theme: const ExpandableThemeData(
                  headerAlignment: ExpandablePanelHeaderAlignment.center,
                  tapBodyToCollapse: false,
                  iconColor: Color(0xff1b2d48)),
              header: Container(
                child: Text(widget.specificationGroup.titlename.toUpperCase(),
                    style: Theme.of(context).textTheme.headline6),
              ),
              expanded: Column(
                children: <Widget>[
                  for (int i = 0;
                  i < widget.specificationGroup.specifications.length;
                  i++)
                    _content(i)
                ],
              ),
              builder: (_, collapsed, expanded) {
                return Expandable(
                  collapsed: collapsed,
                  expanded: expanded,
                  theme: const ExpandableThemeData(crossFadePoint: 0),
                );
              },
            ),
          ),
        ],
      ),
    ));
  }

  Widget _content(i) {
    if (widget.specificationGroup.multiselect) {
      return Row(
        children: <Widget>[
          Visibility(
            visible: widget.specificationGroup.specifications[i].icon != null
                ? true
                : false,
            child: Padding(
              padding: EdgeInsets.only(left: 15.0),
              child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  child: CachedNetworkImage(
                    imageUrl:
                    widget.specificationGroup.specifications[i].icon != null
                        ? widget.specificationGroup.specifications[i].icon
                        : '',
                    width: 20.0,
                    height: 20.0,
                    fit: BoxFit.contain,
                  )) ,
            )
         ,
          ),
          Expanded(
            child: CheckboxListTile(
                dense: false,
                title: Text(
                  widget.specificationGroup.specifications[i].name.toString(),
                  style: Theme.of(context).textTheme.headline4,
                ),
                value: widget.specificationGroup.specifications[i].selected,
                selected: widget.specificationGroup.specifications[i].selected,
                activeColor: AppTheme.azureRadiance[50],
                onChanged: (bool value) {
                  setState(() {
                    widget.specificationGroup.specifications[i].selected =
                        !widget.specificationGroup.specifications[i].selected;
                  });
                }),
          )
        ],
      );
    } else {

      if (widget.specificationGroup.specifications[i].selected)
        selectedRadioSpecId = widget.specificationGroup.specifications[i].id;

      return Row(
        children: <Widget>[
          Visibility(
            visible: widget.specificationGroup.specifications[i].icon != null
                ? true
                : false,
            child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  child: CachedNetworkImage(
                    imageUrl:
                        widget.specificationGroup.specifications[i].icon != null
                            ? widget.specificationGroup.specifications[i].icon
                            : '',
                    width: 20.0,
                    height: 20.0,
                    fit: BoxFit.contain,
                  )),
          ),
          Expanded(
            child: RadioListTile(
              dense: false,
              value: widget.specificationGroup.specifications[i].id,
              groupValue: selectedRadioSpecId,
              controlAffinity: ListTileControlAffinity.trailing,
              title: Text(
                widget.specificationGroup.specifications[i].name.toString(),
                style: Theme.of(context).textTheme.headline4,
              ),
              onChanged: (val) {
                setState(() {
                  widget.specificationGroup.specifications.forEach((item) {
                    item.selected = false;
                  });
                  widget.specificationGroup.specifications[i].selected = true;
                  selectedRadioSpecId = val;
                });
              },
              activeColor: AppTheme.azureRadiance[50],
              selected: widget.specificationGroup.specifications[i].id ==
                  selectedRadioSpecId,
            ),
          )
        ],
      );
    }
  }

}

/*

class _StickyHeaderList extends StatefulWidget {
  final SpecificationGroup specificationGroup;

  const _StickyHeaderList({Key key, this.specificationGroup}) : super(key: key);

  @override
  _StickyHeaderListState createState() => _StickyHeaderListState();
}

class _StickyHeaderListState extends State<_StickyHeaderList>
    with SingleTickerProviderStateMixin {
  int selectedRadioSpecId;

  @override
  Widget build(BuildContext context) {
    return SliverStickyHeader(
      header: _header(),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, i) => _content(i),
          childCount: widget.specificationGroup.specifications.length,
        ),
      ),
    );
  }

  Widget _header() {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.0),
      child: Card(
          margin: EdgeInsets.only(top: 0.0, right: 0.0, left: 0.0),
          color: AppTheme.riverBed[50],
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0.0),
          ),
          child: Padding(
            padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
            child: Text(
              widget.specificationGroup.titlename.toUpperCase(),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.button,
            ),
          )),
    );
  }

  Widget _content(i) {
    if (widget.specificationGroup.multiselect) {
      return Row(
        children: <Widget>[
          Visibility(
            visible: widget.specificationGroup.specifications[i].icon != null
                ? true
                : false,
            child: Padding(
              padding: EdgeInsets.only(left: 15.0),
              child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  child: CachedNetworkImage(
                    imageUrl:
                        widget.specificationGroup.specifications[i].icon != null
                            ? widget.specificationGroup.specifications[i].icon
                            : '',
                    width: 20.0,
                    height: 20.0,
                    fit: BoxFit.contain,
                  )),
            ),
          ),
          Expanded(
            child: CheckboxListTile(
                title: Text(
                  widget.specificationGroup.specifications[i].name.toString(),
                  style: Theme.of(context).textTheme.display1,
                ),
                value: widget.specificationGroup.specifications[i].selected,
                selected: widget.specificationGroup.specifications[i].selected,
                activeColor: AppTheme.azureRadiance[50],
                onChanged: (bool value) {
                  setState(() {
                    widget.specificationGroup.specifications[i].selected =
                        !widget.specificationGroup.specifications[i].selected;
                  });
                }),
          )
        ],
      );
    } else {
      if (widget.specificationGroup.specifications[i].selected)
        selectedRadioSpecId = widget.specificationGroup.specifications[i].id;

      return Row(
        children: <Widget>[
          Visibility(
            visible: widget.specificationGroup.specifications[i].icon != null
                ? true
                : false,
            child: Padding(
              padding: EdgeInsets.only(left: 15.0),
              child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  child: CachedNetworkImage(
                    imageUrl:
                        widget.specificationGroup.specifications[i].icon != null
                            ? widget.specificationGroup.specifications[i].icon
                            : '',
                    width: 20.0,
                    height: 20.0,
                    fit: BoxFit.contain,
                  )),
            ),
          ),
          Expanded(
            child: RadioListTile(
              value: widget.specificationGroup.specifications[i].id,
              groupValue: selectedRadioSpecId,
              controlAffinity: ListTileControlAffinity.trailing,
              title: Text(
                widget.specificationGroup.specifications[i].name.toString(),
                style: Theme.of(context).textTheme.display1,
              ),
              onChanged: (val) {
                setState(() {
                  widget.specificationGroup.specifications.forEach((item) {
                    item.selected = false;
                  });
                  widget.specificationGroup.specifications[i].selected = true;
                  selectedRadioSpecId = val;
                });
              },
              activeColor: AppTheme.darkTangerine[50],
              selected: widget.specificationGroup.specifications[i].id ==
                  selectedRadioSpecId,
            ),
          )
        ],
      );
    }
  }
}
*/
