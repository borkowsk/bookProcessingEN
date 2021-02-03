// HSB color model (hue, saturation, brightness) 
// or HSL (hue, saturation, lightness) or HSV (hue, saturation, value)
// https://en.wikipedia.org/wiki/HSL_and_HSV 
// https://pl.wikipedia.org/wiki/HSL
size(256,256);
noStroke();
colorMode(HSB);//256 is a default size of scale

// Note the different style of inserting the curly braces
for (int i = 0; i < 256; i++) {
  for (int j = 0; j < 256; j++) {
    stroke(i, j, 256);
    point(i, j);
  }
}

//http://processingwedukacji.blogspot.com
