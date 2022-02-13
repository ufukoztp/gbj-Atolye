import 'package:after_layout/after_layout.dart';
import 'package:gbjatolye/features/domain/entities/product/options.dart';
import 'package:gbjatolye/features/domain/entities/product/personalize_options.dart';
import 'package:gbjatolye/features/presentation/provider/productdetail_provider.dart';
import 'package:gbjatolye/utils/applocalization.dart';
import 'package:gbjatolye/utils/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


// ignore: must_be_immutable
class OptionWidget extends StatefulWidget {
  int selected;
  final ProductDetailProvider _productDetailProvider;

  OptionWidget(this._productDetailProvider,);

  @override
  State<StatefulWidget> createState() {
    return OptionWidgetState();
  }
}

class OptionWidgetState extends State<OptionWidget>
    with AfterLayoutMixin<OptionWidget> {
  TextEditingController _controller;
  @override
  void afterFirstLayout(BuildContext context) async {}

  @override
  void initState() {
    super.initState();
    widget._productDetailProvider.chechkBoxValue.clear();
    _controller=TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 1,
        itemBuilder: (context, index) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              /*      Row(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(bottom: 12.0, top: 10, left: 20),
                    child: Text(
                      "KİŞİSELLEŞTİR",
                      style: Theme.of(context)
                          .textTheme
                          .display2
                          .copyWith(color: AppTheme.bigStone[50]),
                    ),
                  ),
                ],
              ),*/
              Column(
                  children: List.generate(
                      widget._productDetailProvider.optionLoading == false ?
                      widget._productDetailProvider.personalizeOptions.length
                          : 0, (index) {
                   return InkWell(
                    onTap: () async {
                      for(int i=0;i< widget._productDetailProvider.personalizeOptions[index].options.length;i++){
                        widget._productDetailProvider.chechkBoxValueMap[widget._productDetailProvider.personalizeOptions[index].options[i].id]=false;
                        print( widget._productDetailProvider.chechkBoxValueMap[widget._productDetailProvider.personalizeOptions[index].options[i].id]);
                      }
                      widget.selected = await showDialog<int>(
                        context: context,
                        barrierDismissible: true,
                        // dialog is dismissible with a tap on the barrier
                        builder: (BuildContext context) {
                          return MyDialogOption(
                            controller: _controller,
                            name: widget._productDetailProvider
                                .personalizeOptions[index].name,
                            personalizeOptions: widget._productDetailProvider
                                .personalizeOptions[index],
                            productDetailProvider:
                                widget._productDetailProvider,
                          );
                        },
                      // ignore: missing_return
                      ).then((value) {
                          setState(() {});
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
                                    left: 10, bottom: 10, top: 10,right: 5),
                                child: Text(widget._productDetailProvider.personalizeOptions[index].name,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(color: Colors.black54, fontSize: 16),textAlign: TextAlign.center),
                              ),

                          widget._productDetailProvider
                              .personalizeOptions[index].required==true ?Text("*",style: TextStyle(fontSize: 20,color: AppTheme.bigStone[50])):Container(),


                          Expanded(child: Container(child: Wrap(
                                spacing: 5,
                                  runSpacing: 5,
                                  children:List.generate(widget._productDetailProvider.checkOptionsSelected(index).length,
                                          (position) {
                                    return Text("  "+widget._productDetailProvider.checkOptionsSelected(index)[position]+", ",style: TextStyle(fontSize: 9,color: AppTheme.aqua[50]),);
                                  }
                              )),
                            ),
                          ),
                          CheckIcon(widget: widget,index: index,)
                        ],
                      ),
                    ),
                  );

              })),
              SizedBox(
                height: 30,
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
  final OptionWidget widget;
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
  final TextEditingController controller;
  final String name;
  final PersonalizeOptions personalizeOptions;
  final ProductDetailProvider productDetailProvider;

  MyDialogOption({
    this.controller,
    this.productDetailProvider,
    this.name,
    this.personalizeOptions,
  });

  @override
  _MyDialogState createState() => new _MyDialogState();
}

class _MyDialogState extends State<MyDialogOption> {
  int selected;

  List<PersonalizeOptions> titleList=List<PersonalizeOptions>();
  PersonalizeOptions _options=PersonalizeOptions();
  PersonalizeOptions _gecici=PersonalizeOptions();
  Set<int> filterMultiselectId=Set<int>();
  int  filterSelectId;



  void saveButton() {

    if(widget.personalizeOptions.multiselect==false){
      if(titleList.isEmpty){
        widget.personalizeOptions.options[selected].selected = true;
        widget.personalizeOptions.changed = true;
      }else{
        List.generate(widget.personalizeOptions.options.length, (index) {
          if(widget.personalizeOptions.options[index].id==filterSelectId){
            widget.personalizeOptions.options[index].selected=true;
          }
          widget.personalizeOptions.changed = true;

        });
      }

      print("save button");


    }else{
      ///hepsini false'a çekme işlemi list ve checkbox list
      List.generate(widget.personalizeOptions.options.length, (index) {
        // ignore: unnecessary_statements
        widget.personalizeOptions.options[index].selected = false;
      });
      List.generate(widget.personalizeOptions.options.length, (index) {
        // ignore: unnecessary_statements
        filterMultiselectId.forEach((element) {
          ///id'ler uyuşuyorsa true yap
          if(element==widget.personalizeOptions.options[index].id){
            widget.personalizeOptions.options[index].selected=true;
          }
        });
      //  widget.productDetailProvider.chechkBoxValue[index]==true? widget.personalizeOptions.options[index].selected=true:null;
      });
    }
    widget.personalizeOptions.changed=true;

    ///checkbox value false
    widget.productDetailProvider.chechkBoxValueMap.forEach((key, value) {
      value=false;
    });


  }

  void removeButton() {
    if(widget.personalizeOptions.multiselect==false){

      widget.personalizeOptions.options[selected].selected = false;
      widget.personalizeOptions.changed = false;
    }else{
      widget.productDetailProvider.chechkBoxValueMap.forEach((key, value) {
        value=false;
      });
      widget.personalizeOptions.changed=false;


    }
  }

///item selected check
  void checkSelected(int index) {
    ///seçili options geçici listeye ata asıl listede false yap
    if(widget.personalizeOptions.multiselect==false){
      if (widget.personalizeOptions.options[index].selected == true) {
        selected = index;
        widget.personalizeOptions.options[index].selected = false;
      }
    }else{
      if (widget.personalizeOptions.options[index].selected == true) {
          widget.productDetailProvider.chechkBoxValueMap[widget.personalizeOptions.options[index].id]=true;
          filterMultiselectId.add(widget.personalizeOptions.options[index].id);
          widget.personalizeOptions.options[index].selected = false;
      }else{

      }
    }
  }


  ///checkbox change value
  itemChangeCheckBox(bool val,int index){
    setState(() {
      widget.productDetailProvider.chechkBoxValueMap[_options.options[index].id]=val;
     // _options.options[index];
     // widget.productDetailProvider.chechkBoxValue[index] = val;
      if(val==true){
        filterMultiselectId.add(_options.options[index].id);
        print("eklendi filter list"+_options.options[index].id.toString());
       }
      if(val==false){
        filterMultiselectId.remove(_options.options[index].id);
        print("çıkarıldı"+_options.options[index].name.toString());
      }
    });
  }

  ///radio button change value
  changedValue([val,id]) {
    setState(() {
      if(id!=null){
        filterSelectId=id;
        selected = val;

      }else{
        selected = val;
      }
    });
  }


  @override
  void initState() {
    super.initState();
  widget.controller.text='';
  titleList.clear();
  _options.options=[];

///mapping title
  Set <String> tt=Set<String>();
  if( widget.personalizeOptions.options[0].stoneName!=null){
    widget.personalizeOptions.options.forEach((element) {
      tt.add(element.stoneName);
    });

    tt.forEach((element) {
      titleList.add(PersonalizeOptions(stoneName: element, options:[] ,multiselect: false,name: ''));
    });


    List.generate(widget.personalizeOptions.options.length, (index)
    {


      if(widget.personalizeOptions.options[index].selected==true)
        filterMultiselectId.add(widget.personalizeOptions.options[index].id);



      List.generate(titleList.length, (index2) {

        if(widget.personalizeOptions.options[index].stoneName==titleList[index2].stoneName){
          titleList[index2].options.add(widget.personalizeOptions.options[index]);
          titleList[index2].name=widget.personalizeOptions.name;
          titleList[index2].multiselect=widget.personalizeOptions.multiselect;
          titleList[index2].changed=widget.personalizeOptions.changed;
          titleList[index2].id=widget.personalizeOptions.id;
        }

      });
    }
    );
    ///mapping title
    filterList();
    widget.controller.addListener(() {
      
      if(widget.controller.text.isNotEmpty)
        {

          filterList();
          setState(() {

          });



        }
     // if(widget.controller.text.isEmpty)filterList();


    });
  }

  }

  filterList(){
     if(widget.personalizeOptions.multiselect==true){
       /*
       if(_options.options.length==0){

         for(Options i in widget.personalizeOptions.options){
           if(i.selected==true){
             filterMultiselectId.add(i.id);
           }
           _options.options.add(i);
           print('eklendi hepsi');

         }
       }

        */
      ///eğer options liste boşsa
      if(_options.options.length==0){

        for(Options i in widget.personalizeOptions.options){
          _options.options.add(i);
          print('eklendi hepsi');

        }
      }

      ///eğer options liste boş değilse ve textle uyuşuyorsa
     else if(_options.options.length!=0&&widget.controller.text.isNotEmpty){

        _options.options.clear();

        for(Options i in  widget.personalizeOptions.options){

          if(i.name.toLowerCase().contains(widget.controller.text.toLowerCase()) == true){
            _options.options.add(i);
            print('eklendi2');
          }

        }
      }


      ///eğer options liste boş değilse ve text  boşsa
     else if(_options.options.length!=0&&widget.controller.text.isEmpty){
       /*
       _gecici=_options;
        _options.options.clear();

        for(Options i in  _gecici.options){
          _options.options.add(i);
        }


        */
      }
    }else {
      ///eğer options liste boşsa
      if(_options.options.length==0){

        for(Options i in widget.personalizeOptions.options){
          _options.options.add(i);
          print('eklendi hepsi');

        }
      }

      ///eğer options lite boş değilse ve textle uyuşuyorsa
      if(_options.options.length!=0&&widget.controller.text.isNotEmpty){
        _options.options.clear();

        for(Options i in  widget.personalizeOptions.options){
          if(i.selected==true){
            filterSelectId=i.id;
            selected=i.id;
          }


          if(i.name.toLowerCase().contains(widget.controller.text.toLowerCase()) == true){
            _options.options.add(i);
            print('eklendi2');
          }
          setState(() {

          });
        }
      }

      ///eğer options liste boşsa ve text de boşsa
      if(_options.options.length!=0&&widget.controller.text.isEmpty){

        _options.options.clear();

        for(Options i in  widget.personalizeOptions.options){
          if(i.selected==true){
            filterSelectId=i.id;
            selected=i.id;
            print("seçili");
          }

          _options.options.add(i);
        }

      }
    }




    /*
    if(_options.options.length==0){
      if(widget.controller.text.isNotEmpty){
        for(Options i in widget.personalizeOptions.options){
          if(i.name.toLowerCase().contains(widget.controller.text.toLowerCase()) == true){
            _options.options.add(i);
            print('eklendi');
          }
        }
      }
      if(widget.controller.text.isEmpty){

        for(Options i in widget.personalizeOptions.options){
             _options.options.add(i);
            print('eklendi hepsi');

        }
      }


    }else{

      if(widget.controller.text.isNotEmpty){
        _options.options.clear();
        for(Options i in  widget.personalizeOptions.options){
          if(i.name.toLowerCase().contains(widget.controller.text.toLowerCase()) == true){
            _options.options.add(i);
            print('eklendi2');
          }
        }
      }else if(widget.controller.text.isEmpty){
        print("boş");
        _options.options.clear();
        for(Options i in  widget.personalizeOptions.options){
             _options.options.add(i);
          }

      }
    }

     */

  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        contentPadding: EdgeInsets.all(0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(50))),
        backgroundColor: AppTheme.white[50],
        title: Text(widget.name, style: Theme.of(context).textTheme.headline6, textAlign: TextAlign.center),
        content: Padding(
          padding: const EdgeInsets.only(top: 12.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              /*
              titleList.isNotEmpty==true?  TextField(
                controller: widget.controller,
                decoration: InputDecoration(
                  hintText: 'Ara',
                  icon: Icon(Icons.search,color: AppTheme.bigStone[50],)
                ),
              ):Container(),

               */

              Expanded(
                child: SingleChildScrollView(child:
                  Column(
                    children: [
                      titleList.isEmpty?
                      Column(
                        children: List.generate(widget.personalizeOptions.options.length, (index) {
                          ///seçili options geçici listeye ata asıl listede false yap
                          checkSelected(index);

                          return Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: Column(
                              children: [
                                InkWell(
                                  onTap: (){
                                    widget.personalizeOptions.multiselect == false? changedValue(index,widget.personalizeOptions.options[index].id):
                                    itemChangeCheckBox(widget.productDetailProvider.chechkBoxValue[index]==true?false:true, index);
                                    print(index);
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 10.0),
                                        child: Text(widget.personalizeOptions.options[index].name),),
                                      widget.personalizeOptions.multiselect == false
                                          ? Radio(
                                          activeColor: AppTheme.bigStone[50],
                                          value: index,
                                          groupValue: selected,
                                          onChanged: (value) {

                                            changedValue(value);
                                            print(selected);
                                          })
                                          : Checkbox(activeColor: AppTheme.bigStone[50],value:widget.productDetailProvider.chechkBoxValue[index],
                                        onChanged: (val){itemChangeCheckBox(val, index);},
                                      )
                                    ],
                                  ),
                                ),
                                Divider()
                              ],
                            ),
                          );
                        }),
                      ):
                      Column(
                        children: List.generate(1, (index2)
                        {
                          return
                            Column(
                            children: [
                              Column(
                                children: List.generate(titleList.length, (index1) {
                                  return Column(
                                    children: [
                                      Padding(
                                        padding:  EdgeInsets.symmetric(vertical:15.0),
                                        child: Text(titleList[index1].stoneName,style: Theme.of(context).textTheme.headline6,),
                                      ),
                                      Column(
                                        children: List.generate(_options.options.length, (index) {
                                          ///seçili options geçici listeye ata asıl listede false yap
                                          checkSelected(index);
                                          return   titleList[index1].stoneName==_options.options[index].stoneName?
                                           Padding(
                                            padding: const EdgeInsets.all(0.0),
                                            child: Column(
                                              children: [
                                                InkWell(
                                                  onTap: (){
                                                    widget.personalizeOptions.multiselect == false? changedValue(index,widget.personalizeOptions.options[index].id):
                                                    itemChangeCheckBox(widget.productDetailProvider.chechkBoxValueMap[_options.options[index].id]==true?false:true, index);
                                                    print(index);
                                                  },
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Padding(
                                                        padding: const EdgeInsets.only(left: 10.0),
                                                        child: Text(_options.options[index].name),),
                                                      widget.personalizeOptions.multiselect == false
                                                          ? Radio(
                                                          activeColor: AppTheme.bigStone[50],
                                                          value: _options.options[index].id,
                                                          groupValue: filterSelectId,
                                                          onChanged: (value) {
                                                            print(_options.options[index].name);
                                                            changedValue(value,_options.options[index].id);
                                                           })
                                                          : Checkbox(activeColor: AppTheme.bigStone[50],value:widget.productDetailProvider.chechkBoxValueMap[_options.options[index].id],
                                                        onChanged: (val){
                                                            itemChangeCheckBox(val, index);



                                                            },
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                Divider()
                                              ],
                                            ),
                                          ):Container();
                                        }),
                                      ),

                                    ],
                                  );
                                }),
                              ),

                            ],
                          );

                        }),
                      ),




                ],
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

                        removeButton();

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

                        saveButton();


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
