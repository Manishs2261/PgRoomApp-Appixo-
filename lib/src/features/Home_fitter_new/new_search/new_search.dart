import 'package:flutter/material.dart';
import 'package:pgroom/main.dart';

import 'package:pgroom/src/utils/Constants/colors.dart';
import 'package:pgroom/src/utils/helpers/helper_function.dart';

import '../filter/filter.dart';

class NewSearch extends StatefulWidget {
  @override
  _NewSearchState createState() => _NewSearchState();
}

class _NewSearchState extends State<NewSearch> {


  final FocusNode _focusNode = FocusNode();
  final TextEditingController _searchController = TextEditingController();
  String searchText = "";
  List<String> _searchHistory = [];

  int selectedButtonIndex = -1; // -1 means no button is selected initially
  int selectedButtonIndexChild = -1; // -1 means no button is selected initially
  


  void _onButtonSelected(int index) {
    setState(() {
      selectedButtonIndex = index; // Update selected button index
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
      body:  SingleChildScrollView(
        child: Column(
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
                   padding: const EdgeInsets.only(right: 16,left: 16,),
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [

                       Padding(
                         padding: const EdgeInsets.only(top: 8,bottom: 12),
                         child: Icon(Icons.arrow_back,color: Colors.white,),
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



                       SizedBox(height: 10,),
                       TextFormField(
                         controller: _searchController,  // Manages the text inside the search field
                         focusNode: _focusNode,
                         onTapOutside: (e)=>FocusScope.of(context).unfocus(), // Handles focusing the field
                         onFieldSubmitted:((value){
                           _onSearchSubmitted(value);
                           Navigator.of(context).push(
                             MaterialPageRoute(
                               builder: (context) => FilterScreen(searchItem: selectedButtonIndex,),
                             ),
                           );


                         }),  // Trigger search on enter/submit
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


         Column(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,

           children: [
             Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
               Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: Text(
                   'Search History :-',
                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500,color: AppColors.primary),
                 ),
               ),
               // Show search history
               Container(
                 constraints: BoxConstraints(maxHeight: 270 ),

                 child: ListView.builder(
                   scrollDirection: Axis.vertical,
                   padding: EdgeInsets.zero,
                   itemCount: _searchHistory.length,
                   itemBuilder: (context, index) {
                     return Column(
                       children: [
                         InkWell(
                           onTap: () {
                             // Handle tap on search history item
                             print('Tapped on: ${_searchHistory[index]}');
                           },
                           child: Padding(
                             padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
                             child: Row(
                               children: [
                                 Icon(Icons.history, size: 20),
                                 SizedBox(width: 8), // Adds spacing between icon and text
                                 Expanded(
                                   child: Text(
                                     _searchHistory[index],
                                     style: TextStyle(fontSize: 14),
                                     overflow: TextOverflow.visible,
                                     maxLines: null,
                                     // Handles long text gracefully
                                   ),
                                 ),
                                 IconButton(
                                   icon: Icon(Icons.clear, size: 18),
                                   onPressed: () {
                                     // Handle delete specific search history item
                                     //  _removeFromSearchHistory(index);
                                   },
                                 ),
                               ],
                             ),
                           ),
                         ),
                         Divider(height: 1,color: Colors.grey.shade300,), // Divider between items
                       ],
                     );
                   },
                 ),
               ),
             ],),


             Container(
               margin: EdgeInsets.all(12),
               height: 200,
               decoration:BoxDecoration(
                   color: Colors.yellow
               ),)
           ],
         )

          ],
        ),
      ),
    );


  }



}


class CustomButton extends StatelessWidget {
  final String? label;
  final IconData? icon;
  final List<Color>? gradientColors;
  final List<Color>? selectedGradientColors; // Dark colors when selected
  final bool isSelected; // Track whether the button is selected
  final VoidCallback? onTap;

  CustomButton({
    this.label,
    this.icon,
    this.gradientColors,
    this.selectedGradientColors,
    this.isSelected = false,
    this.onTap,
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
            colors: isSelected
                ? (selectedGradientColors ?? [Colors.black, Colors.black])
                : (gradientColors ?? [Colors.blue, Colors.blue]), // Switch colors based on state
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            if (icon != null) Icon(icon, color: Colors.white, size: 18),
            if (icon != null) SizedBox(width: 5),
            if (label != null)
              Text(
                label!,
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






