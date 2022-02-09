import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modles/categories_model.dart';
import 'package:shop_app/modles/home_model.dart';
import 'package:shop_app/modules/info_products/info_products_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';
import 'package:shop_app/shared/styles/colors.dart';
class ProductsScreen extends StatelessWidget{
  int?index;
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (BuildContext context, state) {
        if(state is ChangeFavoritesSuccessState){
          if(state.model!.status==false){
showToast(
    text:'${state.model!.message}',
  state: ToastStates.ERROR,
);
          }
          else{
            showToast(
                text:'${state.model!.message}',
                state:ToastStates.SUCCESS,
            );
          }
        }
      },
      builder: (BuildContext context,  state) {
        return ConditionalBuilder(
            condition:ShopCubit.get(context).homeModel!=null && ShopCubit.get(context).categoriesModel!=null,
            builder:(context)=>itemBuilder(ShopCubit.get(context).homeModel,ShopCubit.get(context).categoriesModel,context, index) ,
            fallback:(context)=>Center(child: CircularProgressIndicator(
              color:Colors.white,
            )) ,
          );

      },
    );
  }

  Widget itemBuilder(HomeModel?model , CategoriesModel?categoryModel,context,index){
    return SingleChildScrollView(
      physics:BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment:CrossAxisAlignment.start,
        children: [
          Container(
            color:Colors.indigo,
            child: CarouselSlider(
              items:model!.data!.banners!.map((e) =>Container(
                decoration:BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft:Radius.circular(40.0),
                    bottomRight:Radius.circular(40.0),
                    topLeft:Radius.circular(40.0),
                    topRight:Radius.circular(40.0),
                  ),
                  image:DecorationImage(
                    image:NetworkImage(
                      '${e.image}',
                    ),
                    fit:BoxFit.cover,//بيزوم علي الصورة بشكل حلو ومتناسق
                  ),
                ),
              ),
              ).toList() ,
              options:CarouselOptions(
                height:250.0,//ارتفاع الصورة في الاسكرينة
                initialPage:0,//بداية الصورة او الصفحة اليبدا منها حسب ال index
                viewportFraction:1.0,// بيكبرلك الصورة بعرض الاسكرينة بظبط بيعمل زوم يعني وكل ما تزود هيزوم اكتر
                enableInfiniteScroll:true,// ان هو يقعد يعيد في نفسة كل ما اقلب لما يوصل للاخر واقلب تاني يرجعني من الاول وهكذا لو خلتها false يعني بقفل الخاصية دي و اول ما اوصل للاخر واقلب مش هيرضي يخليني ارجع من الاول
                reverse:false,// بيسمحلي ان اعرف اقلب العكس بردو
                autoPlay:true,// دي بتخلية يقلب لوحدة اوتوماتيك
                autoPlayInterval:Duration(seconds:3), //  دي المدة الزمنية البعدها يبدا يتحرك و يقلب لوحدة
                autoPlayAnimationDuration:Duration(seconds:1),//  دي المدة الزمنية البيستغرقها في تحركة للصورة البعدها الصورة تتحرك وتمشي بسرعة في ثانية ولا تبطء شوية في تحركها وهكذا
                autoPlayCurve:Curves.fastOutSlowIn,// دي شكل طريقة او اسلوب الحركة
                scrollDirection:Axis.horizontal,// اتجاة التحريك خلناة افقي
              ),
            ),
          ),
          Container(
            decoration:BoxDecoration(
              color:Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(0),
                bottomRight: Radius.circular(0),
                topLeft: Radius.circular(0),
                topRight: Radius.circular(0),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal:10.0,
              ),
              child: Column(
                crossAxisAlignment:CrossAxisAlignment.start,
                children: [
                  Text(
                    '   Categories',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.indigo.withOpacity(0.7)),
                  ),
                  Container(
                    height:100,
                    child: ListView.separated(
                      physics:BouncingScrollPhysics(),
                      scrollDirection:Axis.horizontal,
                      itemBuilder:(context,index)=>buildCategoryItem(categoryModel!.data!.dataList[index]),
                      separatorBuilder:(context,index)=> SizedBox(width:10.0,),
                      itemCount:categoryModel!.data!.dataList.length,
                    ),
                  ),
                  SizedBox(
                    height:20.0,
                  ),
                  Text(
                    'Products',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.indigo.withOpacity(0.7)),
                  ),
                ],
              ),
            ),
          ),
          Container(
            color:Colors.grey[300],
            child: GridView.count(
              shrinkWrap: true,//بقولة سيح مع باقي الصفحة كلها كلكو علي بعضوكو كونوا حاجة واحدة
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 2,//الشبكة علي شكل مربعين جنب بعض كل ما هتزود كل ما عدد المربعات هتزيد
              mainAxisSpacing: 1.0,
              crossAxisSpacing: 1.0,
              childAspectRatio: 1/ 1.54, //   العرض/الطول
              children:List.generate(
                model.data!.products!.length,
                    (index) =>buildGridProduct(model.data!.products![index],context,index) ,
              ) ,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCategoryItem(DataModel model)=>Container(
    height:110,
    child: Stack(
      alignment:AlignmentDirectional.bottomCenter,
      children: [
        Image(
          image:NetworkImage('${model.image}'),
          width:100.0,
          height:100.0,
          fit:BoxFit.cover,
        ),
        Container(
          color:Colors.black.withOpacity(0.8),
          width:100,
          child: Text(
            '${model.name}',
            textAlign:TextAlign.center,
            maxLines:1,
            overflow:TextOverflow.ellipsis,

            style:TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ],
    ),
  );

  Widget buildGridProduct(ProductsModel model,context, index) => InkWell(
    onTap:(){
      navigateTo(context, InfoProductScreen(index));
    },
    child: Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage('${model.image}'),
                width: double.infinity,
                height: 200.0,
              ),
              if (model.discount != 0)
                Container(
                  color: Colors.red,
                  padding: EdgeInsets.symmetric(
                    horizontal: 5.0,
                  ),
                  child: Text(
                    'DISCOUNT',
                    style: TextStyle(
                      fontSize: 8.0,
                      color: Colors.white,
                    ),
                  ),
                ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  ' ${model.name}',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14.0,
                    height: 1.3,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      '${model.price.round()}',
                      style: TextStyle(
                        fontSize: 12.0,
                        color:Colors.grey,
                      ),
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    if (model.discount != 0)
                      Text(
                        '${model.oldPrice.round()}',
                        style: TextStyle(
                          fontSize: 10.0,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    Spacer(),
                    CircleAvatar(
                      radius:15.0,
                      backgroundColor:ShopCubit.get(context).favorites[model.id]?defaultColor:Colors.grey,
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        icon: Icon(
                          Icons.favorite_border,
                          size: 14.0,
                          color:Colors.white,
                        ),
                        onPressed: () {
                          ShopCubit.get(context).changeFavorites(model.id);
                       print(model.id);
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );


}
