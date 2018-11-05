var locator = arguments[0];
var xoffset = arguments[2];
var yoffset = arguments[3];
var result = true;

if(arguments[1] === 'black'){
	var expcolor = [0,0,0];
}else{
	var expcolor = [255,255,255];
}

var image = document.getElementById(locator);
    
var canvas = document.createElement( 'canvas' );
canvas.width = image.width;
canvas.height = image.height;

var context = canvas.getContext( '2d' );
context.drawImage( image, 0, 0 ,image.width, image.height);

var imagedata = context.getImageData( 0, 0, image.width, image.height );
    
var data = imagedata.data;
    
for(var x = xoffset; x <= yoffset; x++){
   for(var y = xoffset; y <= yoffset; y++){
       var position = ( x + imagedata.width * y ) * 4; 
       var color = [data[ position], data[ position + 1],data[position + 2]];
         if(color.length !== expcolor.length){
        	 result = false;
         }
         for(var i = color.length; i--;) {
            if(color[i] !== expcolor[i])
            	result = false;
         }
     }
}

return result;
