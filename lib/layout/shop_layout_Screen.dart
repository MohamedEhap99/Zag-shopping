import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/edit_profile/edit_profile_screen.dart';
import 'package:shop_app/modules/search/search_screen.dart';
import 'package:shop_app/modules/settings/settings_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';
import 'package:shop_app/shared/networks/local/cache_helper.dart';

class ShopLayoutScreen extends StatelessWidget {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  bool isBottomSheetChanged=false;
  bool?image=CacheHelper.getData(key:'image');
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener:(context,state){},
      builder: (context,state){
        var cubit=ShopCubit.get(context);
        late Widget showFloatingButtonIf;
        if(
        cubit.bottomNavBarCurrentIndex==0 ||
            cubit.bottomNavBarCurrentIndex == 1 ||
            cubit.bottomNavBarCurrentIndex == 2
        ){
          showFloatingButtonIf=FloatingActionButton(
            elevation:10,
              heroTag:'f11',
              onPressed:(){
if(cubit.isBottomSheetShown==true){
  Navigator.pop(context);
  cubit.changeBottomSheetShown(false);
  cubit.changeFabIcon(Icons.shopping_cart_sharp);
}
else{
  cubit.isBottomSheetShown=true;
  cubit.changeFabIcon(Icons.check);
  if(
  cubit.bottomNavBarCurrentIndex==0 ||
    cubit.bottomNavBarCurrentIndex == 1 ||
    cubit.bottomNavBarCurrentIndex == 2
  ){
scaffoldKey.currentState!.showBottomSheet((context)=>bottomSheetArea(context)
).closed.then((value){
  cubit.changeBottomSheetShown(false);
  cubit.changeFabIcon(Icons.shopping_cart_sharp);
});
  }
}
    },
            backgroundColor:Colors.indigo[400],
            child:Icon(
              cubit.fabIcon,
              color:Colors.white,
            ),
          );
        }
        else{
          showFloatingButtonIf=Container();

        }
        ////////////////////////////////////
        return Scaffold(
          key:scaffoldKey,
          backgroundColor:Colors.indigo,
          drawer:Drawer(
            child:ListView(
              physics:BouncingScrollPhysics(),
              children: [
                if(cubit.userModel!=null)
                DrawerHeader(
                  decoration: BoxDecoration(
                      color: Colors.indigo
                  ),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius:40.0,
                            backgroundImage:NetworkImage('${image}'),
                          ),
                          SizedBox(
                            width:15.0,
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${cubit.userModel!.data!.name}',
                                  maxLines:2,
                                  overflow:TextOverflow.ellipsis,
                                  style:TextStyle(
                                    fontSize:17,
                                    fontWeight:FontWeight.w600,
                                    color:Colors.white,
                                  ),
                                ),
                                SizedBox(
                                  height:5.0,
                                ),
                                Text(
                                  '${cubit.userModel!.data!.email}',
                                  maxLines:1,
                                  overflow:TextOverflow.ellipsis,
                                  style:TextStyle(
                                    fontSize: 10.0,
                                    color:Colors.white,
                                  ),
                                ),


                              ],
                            ),
                          ),
                          CircleAvatar(
                            child:IconButton(
                              onPressed: () {
                                navigateTo(context, UpdateProfileScreen());
                              },
                              icon:Icon(
                                  Icons.edit
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height:10.0,
                      ),
                      Row(
                        mainAxisAlignment:MainAxisAlignment.end,
                        children: [
                          Text(
                            'Credit:${cubit.userModel!.data!.credit}',
                            style:TextStyle(
                              color:Colors.white,
                            ),
                          ),
                          SizedBox(
                            width:10.0,
                          ),
                          Text(
                            'Points:${cubit.userModel!.data!.points}',
                            style:TextStyle(
                              color:Colors.white,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                ListTile(
                  title:Text(
                    'Home',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  onTap:() {
                    Navigator.pop(context);
                  },
                  leading:Icon(Icons.home),

                ),
                ListTile(
                  title:Text(
                    'Settings',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  onTap:() {
                    navigateTo(context, SettingsScreen());
                  },
                  leading:Icon(Icons.settings),

                ),
                Container(
                  height:280,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Column(
                      children: [
                        FloatingActionButton(
                          backgroundColor:Colors.indigo,
                          onPressed:(){
                           signOut(context);
                          },
                          child:Icon(
                            Icons.logout,
                          ),
                        ),
                        SizedBox(
                          height:5.0,
                        ),
                        Text(
                            'LOGOUT',
                          style:TextStyle(
                            fontWeight:FontWeight.w800
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 30),
                  ],
                ),
              ],
            ),
          ),
          appBar:AppBar(
            backgroundColor:Colors.indigo,
            centerTitle:true,
            elevation:0.0,
            backwardsCompatibility:false,
            title:Text(
              'ZAG',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            titleSpacing:3.0,
            actions: [
              IconButton(
                onPressed:(){
                  print('search');
                  navigateTo(context, SearchScreen());
                },
                icon:Icon(
                  Icons.search,
                  color:Colors.white,
                ),
              ),
            ],
          ),
          body:cubit.homeModel != null ||
              cubit.categoriesModel != null ||
              cubit.favoritesModel!=null ||
              cubit.userModel!=null ?
          cubit.screen[cubit.bottomNavBarCurrentIndex]
              : Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              )),
          bottomNavigationBar:BottomNavigationBar(
            items: [
              BottomNavigationBarItem(
                icon:Icon(
                  Icons.home_filled,
                ),
                label:'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                    Icons.grid_view
                ),
                label: 'Categories',
              ),
              BottomNavigationBarItem(
                  icon: Icon(
                      Icons.favorite
                  ),
                  label: 'Favorites'
              ),
            ],
            currentIndex:cubit.bottomNavBarCurrentIndex,
            onTap:(int index){
              cubit.changeBottomNavBar(index);
            },
            selectedItemColor: Colors.indigo,
            unselectedItemColor: Colors.black38,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            backgroundColor: Colors.white,
            elevation: 0.0,
            iconSize: 25,
            type: BottomNavigationBarType.fixed,
          ),
          floatingActionButton:showFloatingButtonIf,
        );
      },
    );
  }
}

Widget bottomSheetArea(context)=>Container(
  decoration: BoxDecoration(
    color: Colors.indigo[300],
    borderRadius: BorderRadius.only(
      topRight: Radius.circular(15),
      topLeft: Radius.circular(15),
      bottomRight: Radius.circular(40),
      bottomLeft: Radius.circular(40),
    ),
  ),
  height: 410,
  width: double.infinity,
  child:Column(
    children: [
      SizedBox(
        height:20.0,
      ),
      Text(
          'No Item',
        style: TextStyle(color: Colors.white),
      ),
    ],
  ),

);
