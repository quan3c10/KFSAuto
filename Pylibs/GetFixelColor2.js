window.getcolor = function() {
	var locator = "previewImage";
	var black = [0,0,0];
	var xoffset = 10;
	var yoffset = 200;
	var result = true;

	var image = document.getElementById(locator);
		
	var canvas = document.getElementById( 'quan' );
	canvas.getContext('2d').clearRect(0, 0, canvas.width, canvas.height);
	//var canvas = document.createElement( 'canvas' );
	//document.body.appendChild(canvas);
	canvas.width = image.width;
	canvas.height = image.height;
	var context = canvas.getContext( '2d' );
	context.drawImage( image, 0, 0 ,image.width, image.height);

	var imagedata = context.getImageData( 0, 0, image.width, image.height);
		
	var data = imagedata.data;
		
	for(var x = xoffset; x <= yoffset; x++){
	   for(var y = xoffset; y <= yoffset; y++){
		   var position = ( x + imagedata.width * y ) * 4; 
		   var color = [data[ position], data[ position + 1],data[position + 2]];
			 if(color.length !== black.length){
				 result = false;
			 }
			 for(var i = color.length; i--;) {
				if(color[i] !== black[i])
					result = false;
			 }
		 }
	}

	return result;
}