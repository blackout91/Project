/*Authored by: Apostolos Bantis, 2018*/
/*--Clickdown drop menu javascript based on https://www.w3schools.com/howto/howto_js_dropdown.asp */
/* When the user clicks on the button, this function is enabled to 
toggle between hiding and showing the dropdown content */
function showMenuItems() {
	//add class "show" to menu items. "show" in css file has display: block enabled so now menu items will appear on screen
    document.getElementById("hiddenMenu").classList.toggle("show");
}

// Close the dropdown menu if the user clicks outside of it
window.onclick = function(event) {
  if (!event.target.matches('.dropbtn')) {
    //get menu items classified as dropdown-content and store them in array menuList
    var menuList = document.getElementsByClassName("dropdown-content");
    var i;
    for (i = 0; i < menuList.length; i++) {
      var menuItem = menuList[i];
	  //remove class "show" from every menu item that contains it 
	  //because we don't want them to appear onscreen anymore
      if (menuItem.classList.contains('show')) {
         menuItem.classList.remove('show');
      }
    }
  }
}