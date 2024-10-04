import 'package:flutter/material.dart';
import 'package:pgroom/main.dart';
import 'package:pgroom/src/utils/Constants/colors.dart';

class NewSearch extends StatefulWidget {
  @override
  _NewSearchState createState() => _NewSearchState();
}

class _NewSearchState extends State<NewSearch> {


  final FocusNode _focusNode = FocusNode();
  final TextEditingController _searchController = TextEditingController();
  String searchText = "";

  int selectedButtonIndex = -1; // -1 means no button is selected initially


  void _onButtonSelected(int index) {
    setState(() {
      selectedButtonIndex = index; // Update selected button index
    });
  }



  bool _isUserChosen = false; // Track if the user is chosen

  List<String> _searchHistory = [];

  void _chooseUser() {
    setState(() {
      _isUserChosen = true; // After choosing the user, show sub-buttons
    });
  }

  void _onSearchSubmitted(String searchText) {
    if (searchText.isNotEmpty) {
      setState(() {
        _searchHistory.add(searchText); // Add search text to the search history
        _searchController.clear(); // Clear the search field
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();  // Automatically focus when the page opens
    });

    // Listen for changes in the text field
    _searchController.addListener(() {
      setState(() {
        searchText = _searchController.text;
      });
    });

  }


  @override
  void dispose() {
    _focusNode.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                height: 250,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF133157),
                      Color(0xFF1A426D),
                      Color(0xFF2A5C99),
                      Colors.white.withOpacity(0.9),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
              Opacity(
                opacity: 0.2,
                child: Image(
                  image: AssetImage('assets/images/searchBackground.png'),
                ),
              ),

              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back,color: Colors.white,), // Back arrow
                        onPressed: () {
                          Navigator.pop(context); // Go back to the previous screen
                        },
                      ),

                      Text("You are looking to rent in",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500,color: Colors.white),),
                      const Row(
                        children: [
                          Text("Select Locality or Landmark in ",style: TextStyle(fontSize: 14,color: Colors.white),),
                          Text("Bilaspur",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: Color.fromRGBO(
                              24, 255, 238, 1.0)),),
                          Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.white,
                            size: 18,
                          )              ],
                      ),

                      SizedBox(height: 10,),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child:   Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              CustomButton(
                                label: 'Room',
                                icon: Icons.bedroom_parent_outlined,
                                gradientColors: [Colors.blueAccent.withOpacity(0.3), Colors.blue.withOpacity(0.5)], // Light color when unselected
                                selectedGradientColors: [Colors.blue, Colors.blueAccent], // Darker colors when selected
                                isSelected: selectedButtonIndex == 0, // Check if this button is selected
                                onTap: () => _onButtonSelected(0), // Set selected index to 0
                              ),
                              CustomButton(
                                label: 'Food',
                                icon: Icons.fastfood_outlined,
                                gradientColors: [Colors.greenAccent.withOpacity(0.2), Colors.green.withOpacity(0.5)], // Light color when unselected
                                selectedGradientColors: [Colors.green, Colors.greenAccent], // Darker colors when selected
                                isSelected: selectedButtonIndex == 1, // Check if this button is selected
                                onTap: () => _onButtonSelected(1), // Set selected index to 1
                              ),
                              CustomButton(
                                label: 'Buy/Sell',
                                icon: Icons.archive_outlined,
                                gradientColors: [Colors.orangeAccent.withOpacity(0.3), Colors.deepOrange.withOpacity(0.3)], // Light color when unselected
                                selectedGradientColors: [Colors.deepOrange, Colors.orange], // Darker colors when selected
                                isSelected: selectedButtonIndex == 2, // Check if this button is selected
                                onTap: () => _onButtonSelected(2), // Set selected index to 2
                              ),
                              CustomButton(
                                label: 'Service',
                                icon: Icons.room_service_outlined,
                                gradientColors: [Colors.black.withOpacity(0.3), Colors.purple.withOpacity(0.3)], // Light color when unselected
                                selectedGradientColors: [Colors.purple[900]!, Colors.purpleAccent], // Darker colors when selected
                                isSelected: selectedButtonIndex == 3, // Check if this button is selected
                                onTap: () => _onButtonSelected(3), // Set selected index to 3
                              ),
                            ],
                          ),
                        ),
                      ),

                      selectedButtonIndex == 0
                      ? Text('$selectedButtonIndex ')
                         : selectedButtonIndex == 1
                              ?  Text('$selectedButtonIndex ')
                           :   selectedButtonIndex == 2
                          ?  Text('$selectedButtonIndex ')
                                  :  Text('$selectedButtonIndex'),

                      SizedBox(height: 10,),
                      TextFormField(
                        controller: _searchController,  // Manages the text inside the search field
                        focusNode: _focusNode,
                        onTapOutside: (e)=>FocusScope.of(context).unfocus(),// Handles focusing the field
                        onFieldSubmitted: _onSearchSubmitted,  // Trigger search on enter/submit
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          hintText: "Find what you need—just search here",
                          hintStyle: const TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.w400,
                          ),
                          prefixIcon: const Icon(
                            Icons.search_rounded,
                            color: AppColors.primary,
                            size: 24,
                          ),
                          suffixIcon: searchText.isNotEmpty
                              ? IconButton(
                            icon: const Icon(Icons.clear,color: Colors.black,),
                            onPressed: () {
                              _searchController.clear();  // Clear the search field
                            },
                          )
                              : null,  // Show a clear button if text is not empty
                          isDense: true,
                          contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100),
                            borderSide: const BorderSide(
                              color: Colors.transparent, // No border color
                              width:0.0,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100),
                            borderSide: const BorderSide(
                              color: Colors.transparent,
                              width: 0.0,
                            ),
                          ),
                        ),
                        keyboardType: TextInputType.text,  // Keyboard suited for text search
                        textInputAction: TextInputAction.search,  // Show "Search" button on keyboard
                      ),




                    ],
                  ),
                ),
              )

            ],
          ),





          // Sub-buttons after user is chosen
          if (_isUserChosen) ...[
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Add functionality for sub-button 1
                  },
                  child: Text('Sub-Button 1'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Add functionality for sub-button 2
                  },
                  child: Text('Sub-Button 2'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Add functionality for sub-button 3
                  },
                  child: Text('Sub-Button 3'),
                ),
              ],
            ),
          ],

          SizedBox(height: 20),



          // Show search history
          if (_searchHistory.isNotEmpty) ...[
            Text(
              'Search History:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: _searchHistory.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Icon(Icons.history),
                    title: Text(_searchHistory[index]),
                  );
                },
              ),
            ),
          ]
        ],
      ),
    );


  }



}



class CustomButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final List<Color> gradientColors;
  final List<Color> selectedGradientColors; // Dark colors when selected
  final bool isSelected; // Track whether the button is selected
  final VoidCallback onTap;

  CustomButton({
    required this.label,
    required this.icon,
    required this.gradientColors,
    required this.selectedGradientColors,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // Tap event triggers selection
      child: Container(
        margin: EdgeInsets.only(right: 5),
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isSelected ? selectedGradientColors : gradientColors, // Switch colors based on state
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            // BoxShadow(
            //   color: Colors.black.withOpacity(0.3),
            //   blurRadius: 2,
            //   offset: Offset(1, 1),
            // ),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.white, size: 18),
            SizedBox(width: 5),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


