import 'package:flutter/material.dart';
import 'package:user_app/driver/global/global.dart';
import '../splashScreen/splash_screen.dart';
import '/driver/tabPages/earning_tab.dart';
import '/driver/tabPages/home_tab.dart';
import '/driver/tabPages/profile_tab.dart';
import '/driver/tabPages/ratings_tab.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  TabController? tabController;
  int selectedIndex = 0;

  onItemClicked(int index) {
    setState(() {
      selectedIndex = index;
      tabController!.index = index;
    });
  }
  bool driverDataloading = true;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 4, vsync: this);
    getData();
  }

  Future<void> getData() async {
    driverdata = await getUserDetails(currentUid);
    setState(() {
      driverDataloading = false;
    });
  }



  @override
  Widget build(BuildContext context) {
    /*return Scaffold(
      body: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        children: const [
          HomeTabPage(),
          EarningsTabPage(),
          RatingsTabPage(),
          ProfileTabPage()
        ],
        controller: tabController,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.credit_card), label: "Earnings"),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: "Ratings"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Account"),
        ],

        unselectedItemColor: Colors.white54,
        selectedItemColor: Colors.white,
        backgroundColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: const TextStyle(fontSize: 14),
        showUnselectedLabels: true,
        currentIndex: selectedIndex,
        onTap: onItemClicked,
      ),
    );*/
    return !driverDataloading
        ? Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.green,
              title: Text('Share Ride'),
              // This hold array of widgets
              actions: [
                IconButton(onPressed: () {}, icon: Icon(Icons.search)),
                IconButton(onPressed: () {}, icon: Icon(Icons.more_vert))
              ],
            ),
            body: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              children: const [
                HomeTabPage(),
                EarningsTabPage(),
                RatingsTabPage(),
                ProfileTabPage()
              ],
              controller: tabController,
            ),
            bottomNavigationBar: BottomNavigationBar(
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.credit_card), label: "Current Rides"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.star), label: "Search Rides"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person), label: "My Profile"),
              ],
              unselectedItemColor: Colors.white54,
              selectedItemColor: Colors.white,
              backgroundColor: Colors.black,
              type: BottomNavigationBarType.fixed,
              selectedLabelStyle: const TextStyle(fontSize: 14),
              showUnselectedLabels: true,
              currentIndex: selectedIndex,
              onTap: onItemClicked,
            ),
            drawer: Drawer(
              backgroundColor: Colors.white,
              elevation: 16.0,
              child: Column(
                children: [
                  UserAccountsDrawerHeader(
                    decoration: BoxDecoration(
                      color: Colors.green,
                    ),
                    accountName: Text('${driverdata!['name']}'),
                    accountEmail: Text('${driverdata!['email']}'),
                    currentAccountPicture: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Text(
                          '${driverdata!['name']}'.substring(0, 2).toUpperCase()),
                    ),
                  ),
                  ListTile(
                    title: Text('All Inbox'),
                    leading: Icon(Icons.mail),
                  ),
                  Divider(
                    height: 0.1,
                  ),
                  ListTile(
                    title: Text('Primary'),
                    leading: Icon(Icons.inbox),
                  ),
                  Divider(
                    height: 0.1,
                  ),
                  ListTile(
                    title: Text('Social'),
                    leading: Icon(Icons.people),
                  ),
                  Divider(
                    height: 0.1,
                  ),
                  ListTile(
                      title: Text('Promotions'),
                      leading: Icon(Icons.local_offer)),
                  Divider(
                    height: 0.1,
                  ),
                  ListTile(
                      onTap: () {
                        fAuth.signOut();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (c) => const DriverSplashScreen(),
                            ));
                      },
                      title: Text('Log out'),
                      leading: Icon(Icons.logout)),
                  Divider(
                    height: 0.1,
                  ),
                ],
              ),
            ))
        : Center(child: CircularProgressIndicator());
  }
  
   
}
