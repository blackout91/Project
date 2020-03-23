/*Slideshow based on https://www.w3schools.com/w3css/w3css_slideshow.asp--*/
//set sliderIndex to 1, in order to display the first image once the page loads
var sliderIndex = 1;

//show first image in the beginning once the page loads
showImage(sliderIndex);

// function that moves the image being displayed if you click next(add +1 to sliderIndex)
// or previous image (subtract -1 from sliderIndex)
function moveImage(n) {
    showImage(sliderIndex += n);
}

//function that shows only one image in the slideshow and hides the others
function showImage(n) {
    var i;
	//Get image elements classified as SlideImages and store them in an array slides
	//then we access specific images using their sliderIndex
    var slides = document.getElementsByClassName("SlideImages");
	//if you click next and you are at the last image(slideIndex, the index goes back to 1 and the first image is displayed
    if (n > slides.length) {
		sliderIndex = 1;
	} 
	//if you click previous and you are at the first image, the index goes back to the last image
    //and the last image is displayed
    if (n < 1) {
		sliderIndex = slides.length;
	} 
	//every other element other than the one in the front is not displayed(set to display none)
    for (i = 0; i < slides.length; i++) {
        slides[i].style.display = "none"; 
    }
	//set the css display attribute of the image that should be displayed to display block
	//so it appears onscreen
    slides[sliderIndex-1].style.display = "block"; 
}