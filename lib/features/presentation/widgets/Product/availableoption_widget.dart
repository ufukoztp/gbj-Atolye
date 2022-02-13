import 'package:after_layout/after_layout.dart';
import 'package:gbjatolye/features/domain/entities/product/RequestId.dart';
import 'package:gbjatolye/features/domain/entities/product/option_groups.dart';
import 'package:gbjatolye/features/domain/entities/product/personalize_options.dart';
import 'package:gbjatolye/features/presentation/provider/productdetail_provider.dart';
import 'package:gbjatolye/utils/applocalization.dart';
import 'package:gbjatolye/utils/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


// ignore: must_be_immutable
class AvailableOptionWidget extends StatefulWidget {
  int selected;
  final ProductDetailProvider _productDetailProvider;

  AvailableOptionWidget(this._productDetailProvider,);

  @override
  State<StatefulWidget> createState() {
    return AvailableOptionWidgetState();
  }
}

class AvailableOptionWidgetState extends State<AvailableOptionWidget>
    with AfterLayoutMixin<AvailableOptionWidget> {
  @override
  void afterFirstLayout(BuildContext context) async {}



  @override
  void initState() {
    super.initState();
    widget._productDetailProvider.chechkBoxValue.clear();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 1,
        itemBuilder: (context, index) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                  children: List.generate(
                      widget._productDetailProvider.optionLoading == false ? widget._productDetailProvider.availableSpects.length : 0, (index) {
                    return widget._productDetailProvider.availableSpects[index].changed==true&&widget._productDetailProvider.availableSpects[index].customize==true?
                    InkWell(
                      onTap: () async {
                        widget.selected = await showDialog<int>(
                          context: context,
                          barrierDismissible: true,
                          // dialog is dismissible with a tap on the barrier
                          builder: (BuildContext context) {
                            return MyDialogOption(
                              spectListRequest: widget._productDetailProvider.spectListRequest,
                              name: widget._productDetailProvider
                                  .availableSpects[index].name,
                              personalizeOptions: widget._productDetailProvider
                                  .availableSpects[index],
                              productDetailProvider:
                              widget._productDetailProvider,
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
                                      .availableSpects[index].name,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: Colors.black54, fontSize: 16),
                                  textAlign: TextAlign.center),
                            ),
                            Expanded(
                              child: Container(
                                child: Wrap(
                                    children:List.generate(widget._productDetailProvider.checkOptionsSelected(index).length, (position)
                                    {
                                      return Text("  "+widget._productDetailProvider.checkOptionsSelected(index)[position]+", ",style: TextStyle(fontSize: 9,color: AppTheme.aqua[50]),);
                                    }
                                    )
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ):Container();

                  })),
               Column(
                children: List.generate(
                    widget._productDetailProvider.optionLoading == false
                        ? widget._productDetailProvider.availableOtherOptions.length
                        : 0, (index) {

                   return widget._productDetailProvider.availableOtherOptions[index].changed==true?
                      InkWell(
                      onTap: ()async{
                        await showDialog<int>(
                          context: context,
                          barrierDismissible: true,
                          // dialog is dismissible with a tap on the barrier
                          builder: (BuildContext context) {
                            return MyDialogOtherOption(
                              productDetailProvider: widget._productDetailProvider,
                              spectListRequest: widget._productDetailProvider.spectListRequest,
                              name: widget._productDetailProvider
                                  .availableOtherOptions[index].name,
                              otherOption: widget._productDetailProvider
                                  .availableOtherOptions[index],
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
                                      .availableOtherOptions[index].name,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: Colors.black54, fontSize: 16),
                                  textAlign: TextAlign.center),
                            ),
                            Expanded(
                              child: Container(
                                child: Wrap(
                                    children:List.generate(widget._productDetailProvider.checkOtherOptionsSelected(index).length, (position)
                                    {
                                      return Text("  "+widget._productDetailProvider.checkOtherOptionsSelected(index,)[position]+", ",style: TextStyle(fontSize: 9,color: AppTheme.aqua[50]),);
                                    }
                                    )),
                              ),
                            ),
//                            CheckIconOtherOptions(widget: widget,index: index,)

                          ],
                        ),
                      ),
                    ):Container();
                  }

          ),
              ),

            ],
          );
        });
  }
}

class CheckIcon extends StatefulWidget {
  const CheckIcon({
    Key key,
    @required this.widget, this.index,
  }) : super(key: key);
  final AvailableOptionWidget widget;
  final int index;

  @override
  _CheckIconState createState() => _CheckIconState();
}

class _CheckIconState extends State<CheckIcon> {
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context){
      if( widget.widget._productDetailProvider.personalizeOptions[widget.index].changed==true){
        return Icon(Icons.check,color: AppTheme.bigStone[50]);
      }
      else{
        return Container();
      }
    });
  }
}

///RadioButton Widgets
class MyDialogOption extends StatefulWidget {
  final String name;
  final PersonalizeOptions personalizeOptions;
  final ProductDetailProvider productDetailProvider;
  final List<IdToJson> spectListRequest;

  MyDialogOption({
    this.productDetailProvider,
    this.name,
    this.personalizeOptions,
    this.spectListRequest
  });

  @override
  _MyDialogState createState() => new _MyDialogState();
}

class _MyDialogState extends State<MyDialogOption> {
  List<bool> chechkBoxValue;
  int selected;

  ///özelliğin kullanılabilirlik durumunu döndürür.
  bool checkUseOptions(int index, bool select) {
    List.generate(widget.spectListRequest.length, (i){
      setState(() {
        widget.spectListRequest[i].id==widget.personalizeOptions.options[index].id?select=true:false;
      });
    });
    return select;
  }



  ///eski listedeki check durumunu geçici listeye atıp eski listede false yapar.
  void checkSelected(int index) {
    if (widget.personalizeOptions.options[index].selected == true) {
      setState(() {
        chechkBoxValue[index]=true;
        widget.personalizeOptions.options[index].selected = false;
      });
    }
  }
  

  itemChangeCheckBox(bool val,int index){
    setState(() {
      chechkBoxValue[index] = val;
    });
  }
  
 
  @override
  void initState() {
    // TODO: implement initState
    chechkBoxValue =  List<bool>();
    for(int i=0;i< widget.personalizeOptions.options.length;i++){
    chechkBoxValue.add(false);
    }
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        contentPadding: EdgeInsets.all(0),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(50))),
        backgroundColor: AppTheme.white[50],
        title: Text(widget.name, style: Theme.of(context).textTheme.headline6, textAlign: TextAlign.center),
        content: Padding(
          padding: const EdgeInsets.only(top: 12.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Expanded(
                child: SingleChildScrollView(child:
                Column(
                  children: List.generate(
                      widget.personalizeOptions.options.length, (index) {
                        
                        bool select=false;
                        
                        select = checkUseOptions(index, select);

                        checkSelected(index);
                      
                      if(select==true){
                      return Padding(
                        padding: const EdgeInsets.only(top:16.0,bottom:16.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: Text(widget
                                      .personalizeOptions.options[index].name,style: TextStyle(color: Colors.grey),),
                                ),
                              ],
                            ),
                            Divider()
                          ],
                        ),
                      );
                    }else{
                      return Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: Column(
                          children: [
                            InkWell(
                              onTap: (){
                                setState(() {
                                  widget.personalizeOptions.multiselect == false?
                                  selected=index:itemChangeCheckBox(
                                      chechkBoxValue[index]==true?false:true
                                      , index);

                                });
                                print(index);
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: Text(widget
                                        .personalizeOptions.options[index].name),
                                  ),
                               Checkbox(activeColor: AppTheme.bigStone[50],value:chechkBoxValue[index],
                                    onChanged: (val){
                                      print(val);
                                      itemChangeCheckBox(val, index);
                                    },
                                  )
                                ],
                              ),
                            ),
                            Divider()
                          ],
                        ),
                      );
                    }
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

                              List.generate(chechkBoxValue.length, (index) {
                                if(chechkBoxValue[index]==true){
                                  widget.personalizeOptions.options[index].selected=false;
                                  chechkBoxValue[index]=false;
                                }
                             //  widget.personalizeOptions.changed=false;
                              });

                              Navigator.of(context).pop(selected);


                          },
                        )),
                    SizedBox(width: 2,),
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
                              Navigator.of(context).pop(selected);

                                List.generate(chechkBoxValue.length, (index) {
                                  // ignore: unnecessary_statements
                               if(chechkBoxValue[index]==true){
                                 widget.personalizeOptions.options[index].selected=true;
                                  widget.personalizeOptions.changed=true;
                                  chechkBoxValue[index]=false;
                               }

                                });



                            }

                        )),
                  ],
                ),
              ),
            ],
          ),
        ));
  }



  
  
}


class MyDialogOtherOption extends StatefulWidget {
  final List<IdToJson> spectListRequest;
  final String name;
  final OptionGroups otherOption;
  final ProductDetailProvider productDetailProvider;

  MyDialogOtherOption({this.name, this.otherOption,this.spectListRequest,this.productDetailProvider});

  @override
  _MyDialogOtherOptionState createState() => new _MyDialogOtherOptionState();
}

class _MyDialogOtherOptionState extends State<MyDialogOtherOption> {
  int selected = -1;
  List<bool> chechkBoxValue2 =  List<bool>();

  changedValue(val) {
    setState(() {
      selected = val;
    });
  }

  itemChangeCheckBox(bool val,int index){
    setState(() {
      chechkBoxValue2[index] = val;
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    chechkBoxValue2 =  List<bool>();
    for(int i=0;i< widget.otherOption.options.length;i++){
      chechkBoxValue2.add(false);
    }
    super.initState();
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
                    bool select=false;

                        if (widget.otherOption.options[index].selected == true) {
                          chechkBoxValue2[index]=true;
                          widget.otherOption.options[index].selected = false;
                        }



                        List.generate(widget.spectListRequest.length, (i){
                          setState(() {
                            widget.spectListRequest[i].id==widget.otherOption.options[index].id?select=true:false;
                          });
                        });

                        if(select==true){
                          return Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10.0),
                                      child: Text(
                                          widget.otherOption.options[index].name,style: TextStyle(color: Colors.grey),),
                                    ),

                                  ],
                                ),
                                Divider()
                              ],
                            ),
                          );

                        }else{
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
                                      Checkbox(activeColor: AppTheme.bigStone[50],value:chechkBoxValue2[index],
                                        onChanged: (val){
                                          print(val);
                                          itemChangeCheckBox(val, index);
                                        },
                                      )
                                    ],
                                  ),
                                ),
                                Divider()
                              ],
                            ),
                          );

                        }
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
                            Navigator.of(context).pop(selected);

                            List.generate(chechkBoxValue2.length, (index) {
                              if(chechkBoxValue2[index]==true){
                                widget.otherOption.options[index].selected=false;
                                chechkBoxValue2[index]=false;
                              }
                         //     widget.otherOption.changed=false;
                            });

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
                            Navigator.of(context).pop();

                            List.generate(chechkBoxValue2.length, (index) {
                              // ignore: unnecessary_statements
                              if(chechkBoxValue2[index]==true){
                                widget.otherOption.options[index].selected=true;
                              widget.otherOption.changed=true;
                              chechkBoxValue2[index]=false;
                              }

                            });

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
  final AvailableOptionWidget widget;
  final int index;

  @override
  _CheckIconOtherOptionsState createState() => _CheckIconOtherOptionsState();
}

class _CheckIconOtherOptionsState extends State<CheckIconOtherOptions> {
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context){
      if(widget.widget._productDetailProvider.availableOtherOptions[widget.index].changed==true){
        return Icon(Icons.check,color: AppTheme.bigStone[50]);
      }else{
        return Container();
      }

    });
  }
}