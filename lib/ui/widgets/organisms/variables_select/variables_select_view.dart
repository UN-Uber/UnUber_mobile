import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:unuber_mobile/ui/widgets/atoms/car_select_card.dart';
import 'package:unuber_mobile/ui/widgets/atoms/submit_button.dart';
import 'package:unuber_mobile/ui/widgets/organisms/variables_select/variables_select_viewmodel.dart';
import 'package:unuber_mobile/utils/colors.dart' as appColors;

class VariablesSelectView extends StatelessWidget {
  VariablesSelectView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      builder: (context, VariablesSelectViewModel model, child) => SafeArea(
          child: CustomScrollView(
        slivers: [
          SliverAppBar(
            collapsedHeight: 400,
            expandedHeight: 30,
            flexibleSpace: Container()
          ),
          SliverAppBar(
              collapsedHeight: 100,
              expandedHeight: 20,
              flexibleSpace: Container(
                  color: appColors.white,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child:
                      SubmitButton(text: 'Pedir Servicio', onPressed: () {}))),
          SliverFillRemaining(
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: model.titles.length,
                  itemBuilder: (BuildContext context, int position) {
                    return InkWell(
                        onTap: () {
                          model.selectedIndex = position;
                          model.update();
                        },
                        child: Container(
                          width: 150,
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: Card(
                              color: model.selectedIndex == position
                                  ? appColors.primaryVariant
                                  : appColors.secondary,
                              shape: model.selectedIndex == position
                                  ? RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      side:
                                          BorderSide(color: appColors.primary))
                                  : null,
                              elevation: 5,
                              child: CarSelectCard(
                                  title: model.titles[position],
                                  price: model.prices[position])),
                        ));
                  }))
        ],
      )),
      viewModelBuilder: () => VariablesSelectViewModel(),
    );
  }
}
