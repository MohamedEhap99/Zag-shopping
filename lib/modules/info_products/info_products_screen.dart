import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';

class InfoProductScreen extends StatelessWidget {
  final int index;
  const InfoProductScreen(this.index);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => ShopCubit()..getHomeData(),
        child: BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {
      if (state is ChangeFavoritesSuccessState) {
        if (state.model!.status == false) {
          showToast(
            state: ToastStates.ERROR,
            text:'${ state.model!.message}',
          );
        }
      }

      if (state is ChangeFavoritesErrorState) {
        showToast(
          state: ToastStates.ERROR,
          text: "No Internet Connection",
        );
      }
    },
    builder: (context, state) {
    ShopCubit cubit = ShopCubit.get(context);

    return Scaffold(
    backgroundColor: Colors.indigo,
    appBar: AppBar(
    centerTitle: true,
    systemOverlayStyle: SystemUiOverlayStyle(
    statusBarColor: Colors.indigo,
    statusBarIconBrightness: Brightness.light),
    elevation: 0,
    backgroundColor: Colors.indigo,
    backwardsCompatibility: false,
    leading:
    IconButton(
    onPressed: () {
    print('back');
    Navigator.pop(context);
    },
    icon: Icon(
    Icons.arrow_back_ios,
    color: Colors.white,
    )),

    title: Text(
    'MATGAR',
    style: TextStyle(
    color: Colors.white,
    fontSize: 20,
    fontWeight: FontWeight.w700),
    ),
    titleSpacing: 3,
    ),
    body: cubit.homeModel != null
    ? Container(
    decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(30),
    ),
    child: Padding(
    padding: const EdgeInsets.all(20.0),
    child: Center(
    child: SingleChildScrollView(
    physics: BouncingScrollPhysics(),
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
    SizedBox(
    height: 20,
    ),
    Stack(children: [
    Image(
    image: NetworkImage(
    '${cubit.homeModel!.data!.products![index].image}'),
    width: double.infinity,
    height: 200,
    //fit: BoxFit.cover,
    ),
    cubit.homeModel!.data!.products![index]
        .discount >
    0
    ? Container(
    color:
    Colors.redAccent.withOpacity(0.8),
    child: Padding(
    padding: const EdgeInsets.only(
    left: 0,
    right: 0,
    ),
    child: Text(
    'DISCOUNT',
    style: TextStyle(
    color: Colors.white,
    fontSize: 9,
    ),
    ),
    ),
    )
        : Container(),
    ]),
    SizedBox(
    height: 1,
    ),
    Text(
    '${cubit.homeModel!.data!.products![index].name}',
    maxLines: 2,
    overflow: TextOverflow.ellipsis,
    style: TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 18),
    ),
    SizedBox(
    height: 1,
    ),
    Row(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
    Column(
    crossAxisAlignment:
    CrossAxisAlignment.center,
    children: [
    Text(
    '${cubit.homeModel!.data!.products![index].price.toString()} LE',
    style: TextStyle(
    fontSize: 12,
    color: Colors.indigo,
    fontWeight: FontWeight.w600),
    ),
    SizedBox(
    height: 1,
    ),
    cubit.homeModel!.data!.products![index]
        .discount >
    0
    ? Text(
    '${cubit.homeModel!.data!.products![index].oldPrice.toString()} LE',
    style: TextStyle(
    fontSize: 12,
    color: Colors.grey,
    decoration: TextDecoration
        .lineThrough),
    )
    : Container(),
    ],
    ),
    ],
    ),
      SizedBox(
        height: 20,
      ),
      Text(
          '${cubit.homeModel!.data!.products![index].description}')
    ],
    ),
    ),
    ),
    ),
    )
        : Center(
        child: CircularProgressIndicator(
          color: Colors.white,
        )));
    },
        ),
    );
  }
}