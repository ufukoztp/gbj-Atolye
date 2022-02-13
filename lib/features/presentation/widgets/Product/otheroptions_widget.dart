import 'package:after_layout/after_layout.dart';
import 'package:gbjatolye/features/domain/entities/product/option_groups.dart';
import 'package:gbjatolye/features/domain/entities/product/personalize_options.dart';
import 'package:gbjatolye/features/presentation/provider/productdetail_provider.dart';
import 'package:gbjatolye/utils/applocalization.dart';
import 'package:gbjatolye/utils/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

// ignore: must_be_immutable
class OtherOptionWidget extends StatefulWidget {
  int selected;
  final ProductDetailProvider _productDetailProvider;

  OtherOptionWidget(
 this._productDetailProvider);

  @override
  State<StatefulWidget> createState() {
    return OtherOptionWidgetState();
  }
}

class OtherOptionWidgetState extends State<OtherOptionWidget>
    with AfterLayoutMixin<OtherOptionWidget> {
  List<OptionGroups> titleList=[];
  @override
  void afterFirstLayout(BuildContext context) async {


  }



  @override
  void initState() {
    super.initState();
     titleList.clear();
      Set <String> tt=Set<String>();
    if( widget._productDetailProvider
        .otherOptionGroups[0].header!=null){
      widget._productDetailProvider
          .otherOptionGroups.forEach((element) {
        tt.add(element.header);
      });

      tt.forEach((element) {
        titleList.add(OptionGroups(header: element,options: [],name: '',id: 0,changed: false,multiselect: false));
      });
     }
      }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 1,
        itemBuilder: (context, index) {
          return Column(
            children: List.generate(titleList.length, (index2) {
            return Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                     child: Padding(
                       padding: const EdgeInsets.all(16.0),
                       child: Text(titleList[index2].header,style: Theme.of(context).textTheme.headline6),
                     )),
                Column(
                  children: List.generate(
                      widget._productDetailProvider.optionLoading == false
                          ? widget._productDetailProvider.otherOptionGroups.length
                          : 0, (index) {
                    return widget._productDetailProvider.otherOptionGroups[index].header==titleList[index2].header?
                     InkWell(
                      onTap: ()async{
                        print(widget._productDetailProvider
                            .otherOptionGroups[index].changed);
                        await showDialog<bool>(
                          context: context,
                          barrierDismissible: true,
                          // dialog is dismissible with a tap on the barrier
                          builder: (BuildContext context) {
                            return MyDialogOtherOption(
                              name: widget._productDetailProvider
                                  .otherOptionGroups[index].name,
                              otherOption: widget._productDetailProvider
                                  .otherOptionGroups[index],
                            );
                          },
                          // ignore: missing_return
                        ).then((value) {
                          setState(() {

                          });
                        });
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        color: index % 2 == 1
                            ? AppTheme.softGrey[50]
                            : AppTheme.middleGrey[50],
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 10, bottom: 10, top: 10),
                              child: Text(
                                  widget._productDetailProvider
                                      .otherOptionGroups[index].name,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: Colors.black54, fontSize: 16),
                                  textAlign: TextAlign.center),
                            ),
                            Expanded(
                              child: Container(
                                child: Row(
                                    children:List.generate(widget._productDetailProvider.checkOtherOptionsSelected(index).length, (position)
                                    {
                                      return Text("  "+widget._productDetailProvider.checkOtherOptionsSelected(index)[position]+", ",style: TextStyle(fontSize: 9,color: AppTheme.aqua[50]),);
                                    }
                                    )),
                              ),
                            ),

 
                          ],
                        ),
                      ),
                    ) :Container();
                  }),
                ),
              ],
            );


            }),
          );
        });
  }
}


class MyDialogOtherOption extends StatefulWidget {
  final String name;
  final OptionGroups otherOption;
  MyDialogOtherOption({this.name, this.otherOption});

  @override
  _MyDialogOtherOptionState createState() => new _MyDialogOtherOptionState();
}

class _MyDialogOtherOptionState extends State<MyDialogOtherOption> {
  int selected = -1;
  int gecici;

  changedValue(val) {
    setState(() {
      selected = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        contentPadding: EdgeInsets.all(0),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(50))),
        backgroundColor: AppTheme.white[50],
        title: Text(widget.name,
            style: Theme.of(context).textTheme.headline6,
            textAlign: TextAlign.center),
        content: Padding(
          padding: const EdgeInsets.only(top: 12.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Expanded(
                child: SingleChildScrollView(child:
                  Column(
                    children: List.generate(widget.otherOption.options.length,
                        (index) {

                      if (widget.otherOption.options[index].selected == true) {
                        selected = index;
                        widget.otherOption.options[index].selected = false;
                      }
                      return Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: Column(
                          children: [
                            InkWell(
                              onTap: (){
                                setState(() {
                                  selected=index;
                                });
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: Text(
                                        widget.otherOption.options[index].name),
                                  ),
                                  Radio(
                                      activeColor: AppTheme.bigStone[50],
                                      value: index,
                                      groupValue: selected,
                                      onChanged: (value) {
                                        changedValue(value);
                                        print(selected);
                                      })
                                  /* :  Checkbox(value:_ischecked[index], onChanged: (val){
                                       setState(() {
                                         _ischecked[index]=val;
                                         print(_ischecked[index]);

                                       });

                                     })*/
                                ],
                              ),
                            ),
                            Divider()
                          ],
                        ),
                      );
                    }),
                  ),
                ),
              ),

              ///Button
              Container(
                padding: EdgeInsets.only(top: 30.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                        child: InkWell(
                          child: Container(

                            height: 50,
                            decoration: new BoxDecoration(
                                color: Colors.grey,
                                borderRadius: new BorderRadius.only(
                                  bottomLeft: const Radius.circular(50.0),
                                  bottomRight: const Radius.circular(0),
                                )),
                            child: Center(
                              child: Text("KALDIR",
                                  style: Theme.of(context).textTheme.button,
                                  textAlign: TextAlign.center),
                            ),
                          ),
                          onTap: () {
                            Navigator.of(context).pop(false);
                            widget.otherOption.options[selected].selected = false;
                            widget.otherOption.changed=false;
                          },
                        )),
                    SizedBox(
                      width: 2,
                    ),
                    Expanded(
                        child: InkWell(
                          child: Container(
                            height: 50,
                            decoration: new BoxDecoration(
                                gradient: LinearGradient(colors: <Color>[
                                  AppTheme.aqua[50],
                                  AppTheme.azureRadiance[50],
                                ]),
                                borderRadius: new BorderRadius.only(
                                  bottomLeft: const Radius.circular(0),
                                  bottomRight: const Radius.circular(50.0),
                                )),
                            child: Center(
                              child: Text(AppLocalizations.of(context).txtBtnSave,
                                  style: Theme.of(context).textTheme.button,
                                  textAlign: TextAlign.center),
                            ),
                          ),
                          onTap: () {
                            Navigator.of(context).pop(true);
                            widget.otherOption.options[selected].selected = true;
                            widget.otherOption.changed=true;
                          },
                        )),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}

class CheckIconOtherOptions extends StatefulWidget {
  const CheckIconOtherOptions({
    Key key,
    @required this.widget, this.index,
  }) : super(key: key);
  final OtherOptionWidget widget;
  final int index;

  @override
  _CheckIconOtherOptionsState createState() => _CheckIconOtherOptionsState();
}

class _CheckIconOtherOptionsState extends State<CheckIconOtherOptions> {
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context){
      if(widget.widget._productDetailProvider.otherOptionGroups[widget.index].changed==true){
        return Icon(Icons.check,color: AppTheme.bigStone[50]);
      }else{
       return Container();
      }

    });
  }
}

