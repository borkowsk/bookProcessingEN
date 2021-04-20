//Processing 3+ reference html, as StringDict(-ionary)
//https://processing.github.io/processing-javadocs/core/processing/data/StringDict.html#StringDict-java.lang.String:A:A-
StringDict reference=new StringDict(
new String[][] {
  {"()"   ,  "https://processing.org/reference/parentheses.html"},// (parentheses)
  {"("    ,  "https://processing.org/reference/parentheses.html"},// (parentheses)
  {")"    ,  "https://processing.org/reference/parentheses.html"},// (parentheses)
  {","    ,  "https://processing.org/reference/comma.html"},// (comma)
  {"."    ,  "https://processing.org/reference/dot.html"},// (dot)
  {"/*"   ,  "https://processing.org/reference/multilinecomment.html"},// (multiline comment)
  {"*/"   ,  "https://processing.org/reference/multilinecomment.html"},// (multiline comment)
  {"/**"  ,  "https://processing.org/reference/doccomment.html"},//(doc comment)
  {"//"   ,  "https://processing.org/reference/comment.html"},// (comment)
  {";"    ,  "https://processing.org/reference/semicolon.html"},// (semicolon)
  {"="    ,  "https://processing.org/reference/assign.html"},// (assign)
  {"[]"   ,  "https://processing.org/reference/arrayaccess.html"},// (array access)
  {"["    ,  "https://processing.org/reference/arrayaccess.html"},// (array access)
  {"]"    ,  "https://processing.org/reference/arrayaccess.html"},// (array access)
  {"{}"   ,  "https://processing.org/reference/curlybraces.html"},// (curly braces)
  {"{"    ,  "https://processing.org/reference/curlybraces.html"},// (curly braces)
  {"}"    ,  "https://processing.org/reference/curlybraces.html"},// (curly braces)
  
  {"catch"    ,  "https://processing.org/reference/catch.html"},
  {"class"    ,  "https://processing.org/reference/class.html"},
  {"draw"     ,  "https://processing.org/reference/draw_.html"},
  {"exit"     ,  "https://processing.org/reference/exit_.html"},
  {"extends"  ,  "https://processing.org/reference/extends.html"},
  {"false"    ,  "https://processing.org/reference/false.html"},
  {"final"    ,  "https://processing.org/reference/final.html"},
  {"implements"  ,  "https://processing.org/reference/implements.html"},
  {"import"      ,  "https://processing.org/reference/import.html"},
  {"loop"    ,  "https://processing.org/reference/loop_.html"},
  {"new"     ,  "https://processing.org/reference/new.html"},
  {"noLoop"  ,  "https://processing.org/reference/noLoop_.html"},
  {"null"    ,  "https://processing.org/reference/null.html"},
  {"pop"     ,  "https://processing.org/reference/pop_.html"},
  {"popStyle"  ,  "https://processing.org/reference/popStyle_.html"},
  {"private"   ,  "https://processing.org/reference/private.html"},
  {"public"    ,  "https://processing.org/reference/public.html"},
  {"push"      ,  "https://processing.org/reference/push_.html"},
  {"pushStyle" ,  "https://processing.org/reference/pushStyle_.html"},
  {"redraw"    ,  "https://processing.org/reference/redraw_.html"},
  {"return"    ,  "https://processing.org/reference/return.html"},
  {"setLocation"   ,  "https://processing.org/reference/setLocation_.html"},
  {"setResizable"  ,  "https://processing.org/reference/setResizable_.html"},
  {"setTitle"      ,  "https://processing.org/reference/setTitle_.html"},
  {"setup"    ,  "https://processing.org/reference/setup_.html"},
  {"static"   ,  "https://processing.org/reference/static.html"},
  {"super"    ,  "https://processing.org/reference/super.html"},
  {"this"     ,  "https://processing.org/reference/this.html"},
  {"thread"   ,  "https://processing.org/reference/thread_.html"},
  {"true"     ,  "https://processing.org/reference/true.html"},
  {"try"      ,  "https://processing.org/reference/try.html"},
  {"void"     ,  "https://processing.org/reference/void.html"},
  {"cursor"   ,  "https://processing.org/reference/cursor_.html"},
  {"delay"    ,  "https://processing.org/reference/delay_.html"},
  {"displayDensity"  ,  "https://processing.org/reference/displayDensity_.html"},
  {"focused"  ,  "https://processing.org/reference/focused.html"},
  {"frameCount"  ,  "https://processing.org/reference/frameCount.html"},
  {"frameRate"   ,  "https://processing.org/reference/frameRate_.html"},
  {"frameRate"   ,  "https://processing.org/reference/frameRate.html"},
  {"fullScreen"  ,  "https://processing.org/reference/fullScreen_.html"},
  {"height"      ,  "https://processing.org/reference/height.html"},
  {"noCursor"    ,  "https://processing.org/reference/noCursor_.html"},
  {"noSmooth"    ,  "https://processing.org/reference/noSmooth_.html"},
  {"pixelDensity"  ,  "https://processing.org/reference/pixelDensity_.html"},
  {"pixelHeight"   ,  "https://processing.org/reference/pixelHeight.html"},
  {"pixelWidth"    ,  "https://processing.org/reference/pixelWidth.html"},
  {"settings"      ,  "https://processing.org/reference/settings_.html"},

  {"size"    ,  "https://processing.org/reference/size_.html"},
  {"smooth"  ,  "https://processing.org/reference/smooth_.html"},
  {"width"   ,  "https://processing.org/reference/width.html"},
  
  {"boolean" ,  "https://processing.org/reference/boolean.html"},
  {"Boolean" ,  "https://processing.org/reference/boolean.html"},
  
  {"byte"    ,  "https://processing.org/reference/byte.html"},
  {"char"    ,  "https://processing.org/reference/char.html"},
  {"color"   ,  "https://processing.org/reference/color_datatype.html"},
  {"double"  ,  "https://processing.org/reference/double.html"},
  {"float"   ,  "https://processing.org/reference/float.html"},
  {"int"     ,  "https://processing.org/reference/int.html"},
  {"long"    ,  "https://processing.org/reference/long.html"},
      
  {"Array"      ,  "https://processing.org/reference/Array.html"},
  {"ArrayList"  ,  "https://processing.org/reference/ArrayList.html"},
  {"FloatDict"  ,  "https://processing.org/reference/FloatDict.html"},
  {"FloatList"  ,  "https://processing.org/reference/FloatList.html"},
  {"HashMap"    ,  "https://processing.org/reference/HashMap.html"},
  {"IntDict"    ,  "https://processing.org/reference/IntDict.html"},
  {"IntList"    ,  "https://processing.org/reference/IntList.html"},
  {"JSONArray"  ,  "https://processing.org/reference/JSONArray.html"},
  {"JSONObject" ,  "https://processing.org/reference/JSONObject.html"},
  {"Object"     ,  "https://processing.org/reference/Object.html"},
  {"String"     ,  "https://processing.org/reference/String.html"},
  {"StringDict" ,  "https://processing.org/reference/StringDict.html"},
  {"StringList" ,  "https://processing.org/reference/StringList.html"},
  {"Table"      ,  "https://processing.org/reference/Table.html"},
  {"TableRow"   ,  "https://processing.org/reference/TableRow.html"},

  {"XML"      ,  "https://processing.org/reference/XML.html"},
      
  {"binary"   ,  "https://processing.org/reference/binary_.html"},
//  {"boolean"  ,  "https://processing.org/reference/booleanconvert_.html"},
//  {"byte"     ,  "https://processing.org/reference/byteconvert_.html"},
//  {"char"     ,  "https://processing.org/reference/charconvert_.html"},
//  {"float"    ,  "https://processing.org/reference/floatconvert_.html"},
  {"hex"      ,  "https://processing.org/reference/hex_.html"},
//  {"int"      ,  "https://processing.org/reference/intconvert_.html"},
  {"str"      ,  "https://processing.org/reference/strconvert_.html"},
  {"unbinary" ,  "https://processing.org/reference/unbinary_.html"},
  {"unhex"    ,  "https://processing.org/reference/unhex_.html"},
      
  {"join"     ,  "https://processing.org/reference/join_.html"},
  {"match"    ,  "https://processing.org/reference/match_.html"},
  {"matchAll" ,  "https://processing.org/reference/matchAll_.html"},
  {"nf"       ,  "https://processing.org/reference/nf_.html"},
  {"nfc"      ,  "https://processing.org/reference/nfc_.html"},
  {"nfp"      ,  "https://processing.org/reference/nfp_.html"},
  {"nfs"      ,  "https://processing.org/reference/nfs_.html"},
  {"split"    ,  "https://processing.org/reference/split_.html"},
  {"splitTokens"    ,  "https://processing.org/reference/splitTokens_.html"},
  {"trim"     ,  "https://processing.org/reference/trim_.html"},
      
  {"append"     ,  "https://processing.org/reference/append_.html"},
  {"arrayCopy"  ,  "https://processing.org/reference/arrayCopy_.html"},
  {"concat"     ,  "https://processing.org/reference/concat_.html"},
  {"expand"     ,  "https://processing.org/reference/expand_.html"},
  {"reverse"    ,  "https://processing.org/reference/reverse_.html"},
  {"shorten"    ,  "https://processing.org/reference/shorten_.html"},
  {"sort"       ,  "https://processing.org/reference/sort_.html"},
  {"splice"     ,  "https://processing.org/reference/splice_.html"},
  {"subset"     ,  "https://processing.org/reference/subset_.html"},
      
  {"!="  ,  "https://processing.org/reference/inequality.html"},// (inequality)
  {"<"  ,  "https://processing.org/reference/lessthan.html"},// (less than)
  {"<="  ,  "https://processing.org/reference/lessthanorequalto.html"},// (less than or equal to)
  {"=="  ,  "https://processing.org/reference/equality.html"},// (equality)
  {">"  ,  "https://processing.org/reference/greaterthan.html"},// (greater than)
  {">="  ,  "https://processing.org/reference/greaterthanorequalto.html"},// (greater than or equal to)
      
  {"for"    ,  "https://processing.org/reference/for.html"},
  {"while"  ,  "https://processing.org/reference/while.html"},
      
  {"?:"  ,  "https://processing.org/reference/conditional.html"},// (conditional)
  {"?"  ,  "https://processing.org/reference/conditional.html"},// (conditional)
  {":"  ,  "https://processing.org/reference/conditional.html"},// (conditional)
  
  {"break"     ,  "https://processing.org/reference/break.html"},
  {"case"      ,  "https://processing.org/reference/case.html"},
  {"continue"  ,  "https://processing.org/reference/continue.html"},
  {"default"   ,  "https://processing.org/reference/default.html"},
  {"else"      ,  "https://processing.org/reference/else.html"},
  {"if"        ,  "https://processing.org/reference/if.html"},
  {"switch"    ,  "https://processing.org/reference/switch.html"},
      
  {"!"   ,  "https://processing.org/reference/logicalNOT.html"},// (logical NOT)
  {"&&"  ,  "https://processing.org/reference/logicalAND.html"},// (logical AND)
  {"||"  ,  "https://processing.org/reference/logicalOR.html"},// (logical OR)
      
  {"createShape"  ,  "https://processing.org/reference/createShape_.html"},
  {"loadShape"    ,  "https://processing.org/reference/loadShape_.html"},
  {"PShape"       ,  "https://processing.org/reference/PShape.html"},
      
  {"arc"       ,  "https://processing.org/reference/arc_.html"},
  {"circle"    ,  "https://processing.org/reference/circle_.html"},
  {"ellipse"   ,  "https://processing.org/reference/ellipse_.html"},
  {"line"      ,  "https://processing.org/reference/line_.html"},
  {"point"     ,  "https://processing.org/reference/point_.html"},
  {"quad"      ,  "https://processing.org/reference/quad_.html"},
  {"rect"      ,  "https://processing.org/reference/rect_.html"},
  {"square"    ,  "https://processing.org/reference/square_.html"},
  {"triangle"  ,  "https://processing.org/reference/triangle_.html"},

  {"bezier"        ,  "https://processing.org/reference/bezier_.html"},
  {"bezierDetail"  ,  "https://processing.org/reference/bezierDetail_.html"},
  {"bezierPoint"   ,  "https://processing.org/reference/bezierPoint_.html"},
  {"bezierTangent" ,  "https://processing.org/reference/bezierTangent_.html"},

  {"curve"         ,  "https://processing.org/reference/curve_.html"},
  {"curveDetail"   ,  "https://processing.org/reference/curveDetail_.html"},
  {"curvePoint"    ,  "https://processing.org/reference/curvePoint_.html"},
  {"curveTangent"  ,  "https://processing.org/reference/curveTangent_.html"},
  {"curveTightness",  "https://processing.org/reference/curveTightness_.html"},
      
  {"box"           ,  "https://processing.org/reference/box_.html"},
  {"sphere"        ,  "https://processing.org/reference/sphere_.html"},
  {"sphereDetail"  ,  "https://processing.org/reference/sphereDetail_.html"},
      
  {"ellipseMode"   ,  "https://processing.org/reference/ellipseMode_.html"},
  {"rectMode"      ,  "https://processing.org/reference/rectMode_.html"},
  {"strokeCap"     ,  "https://processing.org/reference/strokeCap_.html"},
  {"strokeJoin"    ,  "https://processing.org/reference/strokeJoin_.html"},
  {"strokeWeight"  ,  "https://processing.org/reference/strokeWeight_.html"},
      
  {"beginContour"  ,  "https://processing.org/reference/beginContour_.html"},
  {"beginShape"    ,  "https://processing.org/reference/beginShape_.html"},
  {"bezierVertex"  ,  "https://processing.org/reference/bezierVertex_.html"},
  {"curveVertex"   ,  "https://processing.org/reference/curveVertex_.html"},
  {"endContour"    ,  "https://processing.org/reference/endContour_.html"},
  {"endShape"      ,  "https://processing.org/reference/endShape_.html"},
  {"quadraticVertex"  ,  "https://processing.org/reference/quadraticVertex_.html"},
  {"vertex"        ,  "https://processing.org/reference/vertex_.html"},
  {"shape"         ,  "https://processing.org/reference/shape_.html"},
  {"shapeMode"     ,  "https://processing.org/reference/shapeMode_.html"},
  {"mouseButton"   ,  "https://processing.org/reference/mouseButton.html"},
  {"mouseClicked"  ,  "https://processing.org/reference/mouseClicked_.html"},
  {"mouseDragged"  ,  "https://processing.org/reference/mouseDragged_.html"},
  {"mouseMoved"    ,  "https://processing.org/reference/mouseMoved_.html"},
  {"mousePressed"  ,  "https://processing.org/reference/mousePressed_.html"},
  {"mousePressed"  ,  "https://processing.org/reference/mousePressed.html"},
  {"mouseReleased" ,  "https://processing.org/reference/mouseReleased_.html"},
  {"mouseWheel"    ,  "https://processing.org/reference/mouseWheel_.html"},
  {"mouseX"        ,  "https://processing.org/reference/mouseX.html"},
  {"mouseY"        ,  "https://processing.org/reference/mouseY.html"},
  {"pmouseX"       ,  "https://processing.org/reference/pmouseX.html"},
  {"pmouseY"       ,  "https://processing.org/reference/pmouseY.html"},
  {"key"           ,  "https://processing.org/reference/key.html"},
  {"keyCode"       ,  "https://processing.org/reference/keyCode.html"},
  {"keyPressed"    ,  "https://processing.org/reference/keyPressed_.html"},
  {"keyPressed"    ,  "https://processing.org/reference/keyPressed.html"},
  {"keyReleased"   ,  "https://processing.org/reference/keyReleased_.html"},
  {"keyTyped"      ,  "https://processing.org/reference/keyTyped_.html"},
  {"BufferedReader",  "https://processing.org/reference/BufferedReader.html"},
  {"createInput"   ,  "https://processing.org/reference/createInput_.html"},
  {"createReader"  ,  "https://processing.org/reference/createReader_.html"},
  {"launch"        ,  "https://processing.org/reference/launch_.html"},
  {"loadBytes"     ,  "https://processing.org/reference/loadBytes_.html"},
  {"loadJSONArray" ,  "https://processing.org/reference/loadJSONArray_.html"},
  {"loadJSONObject",  "https://processing.org/reference/loadJSONObject_.html"},
  {"loadStrings"   ,  "https://processing.org/reference/loadStrings_.html"},
  {"loadTable"     ,  "https://processing.org/reference/loadTable_.html"},
  {"loadXML"       ,  "https://processing.org/reference/loadXML_.html"},
  {"parseJSONArray",  "https://processing.org/reference/parseJSONArray_.html"},
  {"parseJSONObject"  ,  "https://processing.org/reference/parseJSONObject_.html"},
  {"parseXML"      ,  "https://processing.org/reference/parseXML_.html"},
  {"selectFolder"  ,  "https://processing.org/reference/selectFolder_.html"},
  {"selectInput"   ,  "https://processing.org/reference/selectInput_.html"},
  {"day"           ,  "https://processing.org/reference/day_.html"},
  {"hour"          ,  "https://processing.org/reference/hour_.html"},
  {"millis"        ,  "https://processing.org/reference/millis_.html"},
  {"minute"        ,  "https://processing.org/reference/minute_.html"},
  {"month"         ,  "https://processing.org/reference/month_.html"},
  {"second"        ,  "https://processing.org/reference/second_.html"},
  {"year"          ,  "https://processing.org/reference/year_.html"},
  {"print"         ,  "https://processing.org/reference/print_.html"},
  {"printArray"    ,  "https://processing.org/reference/printArray_.html"},
  {"println"       ,  "https://processing.org/reference/println_.html"},
  {"save"          ,  "https://processing.org/reference/save_.html"},
  {"saveFrame"     ,  "https://processing.org/reference/saveFrame_.html"},
  {"beginRaw"      ,  "https://processing.org/reference/beginRaw_.html"},
  {"beginRecord"   ,  "https://processing.org/reference/beginRecord_.html"},
  {"createOutput"  ,  "https://processing.org/reference/createOutput_.html"},
  {"createWriter"  ,  "https://processing.org/reference/createWriter_.html"},
  {"endRaw"        ,  "https://processing.org/reference/endRaw_.html"},
  {"endRecord"     ,  "https://processing.org/reference/endRecord_.html"},
  {"PrintWriter"   ,  "https://processing.org/reference/PrintWriter.html"},
  {"saveBytes"     ,  "https://processing.org/reference/saveBytes_.html"},
  {"saveJSONArray"   ,  "https://processing.org/reference/saveJSONArray_.html"},
  {"saveJSONObject"  ,  "https://processing.org/reference/saveJSONObject_.html"},
  {"saveStream"      ,  "https://processing.org/reference/saveStream_.html"},
  {"saveStrings"     ,  "https://processing.org/reference/saveStrings_.html"},
  {"saveTable"       ,  "https://processing.org/reference/saveTable_.html"},
  {"saveXML"         ,  "https://processing.org/reference/saveXML_.html"},
  {"selectOutput"    ,  "https://processing.org/reference/selectOutput_.html"},
  {"applyMatrix"     ,  "https://processing.org/reference/applyMatrix_.html"},
  {"popMatrix"       ,  "https://processing.org/reference/popMatrix_.html"},
  {"printMatrix"     ,  "https://processing.org/reference/printMatrix_.html"},
  {"pushMatrix"      ,  "https://processing.org/reference/pushMatrix_.html"},
  {"resetMatrix"     ,  "https://processing.org/reference/resetMatrix_.html"},
  {"rotate"    ,  "https://processing.org/reference/rotate_.html"},
  {"rotateX"   ,  "https://processing.org/reference/rotateX_.html"},
  {"rotateY"   ,  "https://processing.org/reference/rotateY_.html"},
  {"rotateZ"   ,  "https://processing.org/reference/rotateZ_.html"},
  {"scale"     ,  "https://processing.org/reference/scale_.html"},
  {"shearX"    ,  "https://processing.org/reference/shearX_.html"},
  {"shearY"    ,  "https://processing.org/reference/shearY_.html"},
  {"translate" ,  "https://processing.org/reference/translate_.html"},
  {"ambientLight"      ,  "https://processing.org/reference/ambientLight_.html"},
  {"directionalLight"  ,  "https://processing.org/reference/directionalLight_.html"},
  {"lightFalloff"      ,  "https://processing.org/reference/lightFalloff_.html"},
  {"lights"            ,  "https://processing.org/reference/lights_.html"},
  {"lightSpecular"     ,  "https://processing.org/reference/lightSpecular_.html"},
  {"noLights"          ,  "https://processing.org/reference/noLights_.html"},
  {"normal"       ,  "https://processing.org/reference/normal_.html"},
  {"pointLight"   ,  "https://processing.org/reference/pointLight_.html"},
  {"spotLight"    ,  "https://processing.org/reference/spotLight_.html"},
  {"beginCamera"  ,  "https://processing.org/reference/beginCamera_.html"},
  {"camera"       ,  "https://processing.org/reference/camera_.html"},
  {"endCamera"    ,  "https://processing.org/reference/endCamera_.html"},
  {"frustum"      ,  "https://processing.org/reference/frustum_.html"},
  {"ortho"        ,  "https://processing.org/reference/ortho_.html"},
  {"perspective"  ,  "https://processing.org/reference/perspective_.html"},
  {"printCamera"  ,  "https://processing.org/reference/printCamera_.html"},
  {"printProjection"  ,  "https://processing.org/reference/printProjection_.html"},
  {"modelX"    ,  "https://processing.org/reference/modelX_.html"},
  {"modelY"    ,  "https://processing.org/reference/modelY_.html"},
  {"modelZ"    ,  "https://processing.org/reference/modelZ_.html"},
  {"screenX"   ,  "https://processing.org/reference/screenX_.html"},
  {"screenY"   ,  "https://processing.org/reference/screenY_.html"},
  {"screenZ"   ,  "https://processing.org/reference/screenZ_.html"},
  {"ambient"   ,  "https://processing.org/reference/ambient_.html"},
  {"emissive"  ,  "https://processing.org/reference/emissive_.html"},
  {"shininess" ,  "https://processing.org/reference/shininess_.html"},
  {"specular"  ,  "https://processing.org/reference/specular_.html"},
  {"background",  "https://processing.org/reference/background_.html"},
  {"clear"     ,  "https://processing.org/reference/clear_.html"},
  {"colorMode" ,  "https://processing.org/reference/colorMode_.html"},
  {"fill"      ,  "https://processing.org/reference/fill_.html"},
  {"noFill"    ,  "https://processing.org/reference/noFill_.html"},
  {"noStroke"  ,  "https://processing.org/reference/noStroke_.html"},
  {"stroke"    ,  "https://processing.org/reference/stroke_.html"},
  {"alpha"     ,  "https://processing.org/reference/alpha_.html"},
  {"blue"      ,  "https://processing.org/reference/blue_.html"},
  {"brightness",  "https://processing.org/reference/brightness_.html"},
  {"color"     ,  "https://processing.org/reference/color_.html"},
  {"green"     ,  "https://processing.org/reference/green_.html"},
  {"hue"       ,  "https://processing.org/reference/hue_.html"},
  {"lerpColor" ,  "https://processing.org/reference/lerpColor_.html"},
  {"red"       ,  "https://processing.org/reference/red_.html"},
  {"saturation",  "https://processing.org/reference/saturation_.html"},
  {"createImage"   ,  "https://processing.org/reference/createImage_.html"},
  {"PImage"    ,  "https://processing.org/reference/PImage.html"},
  {"image"     ,  "https://processing.org/reference/image_.html"},
  {"imageMode" ,  "https://processing.org/reference/imageMode_.html"},
  {"loadImage" ,  "https://processing.org/reference/loadImage_.html"},
  {"noTint"    ,  "https://processing.org/reference/noTint_.html"},
  {"requestImage" ,  "https://processing.org/reference/requestImage_.html"},
  {"tint"         ,  "https://processing.org/reference/tint_.html"},
  {"texture"      ,  "https://processing.org/reference/texture_.html"},
  {"textureMode"  ,  "https://processing.org/reference/textureMode_.html"},
  {"textureWrap"  ,  "https://processing.org/reference/textureWrap_.html"},
  {"blend"        ,  "https://processing.org/reference/blend_.html"},
  {"copy"         ,  "https://processing.org/reference/copy_.html"},
  {"filter"       ,  "https://processing.org/reference/filter_.html"},
  {"get"          ,  "https://processing.org/reference/get_.html"},
  {"loadPixels"   ,  "https://processing.org/reference/loadPixels_.html"},
  {"pixels"       ,  "https://processing.org/reference/pixels.html"},
  {"set"          ,  "https://processing.org/reference/set_.html"},
  {"updatePixels" ,  "https://processing.org/reference/updatePixels_.html"},
  {"blendMode"    ,  "https://processing.org/reference/blendMode_.html"},
  {"clip"         ,  "https://processing.org/reference/clip_.html"},
  {"createGraphics"  ,  "https://processing.org/reference/createGraphics_.html"},
  {"hint"         ,  "https://processing.org/reference/hint_.html"},
  {"noClip"       ,  "https://processing.org/reference/noClip_.html"},
  {"PGraphics"    ,  "https://processing.org/reference/PGraphics.html"},
  {"loadShader"   ,  "https://processing.org/reference/loadShader_.html"},
  {"PShader"      ,  "https://processing.org/reference/PShader.html"},
  {"resetShader"  ,  "https://processing.org/reference/resetShader_.html"},
  {"shader"       ,  "https://processing.org/reference/shader_.html"},
  {"PFont"        ,  "https://processing.org/reference/PFont.html"},
  {"createFont"   ,  "https://processing.org/reference/createFont_.html"},
  {"loadFont"     ,  "https://processing.org/reference/loadFont_.html"},
  {"text"         ,  "https://processing.org/reference/text_.html"},
  {"textFont"     ,  "https://processing.org/reference/textFont_.html"},
  {"textAlign"    ,  "https://processing.org/reference/textAlign_.html"},
  {"textLeading"  ,  "https://processing.org/reference/textLeading_.html"},
  {"textMode"     ,  "https://processing.org/reference/textMode_.html"},
  {"textSize"     ,  "https://processing.org/reference/textSize_.html"},
  {"textWidth"    ,  "https://processing.org/reference/textWidth_.html"},
  {"textAscent"   ,  "https://processing.org/reference/textAscent_.html"},
  {"textDescent"  ,  "https://processing.org/reference/textDescent_.html"},
  {"PVector"      ,  "https://processing.org/reference/PVector.html"},
  
  {"%"   ,  "https://processing.org/reference/modulo.html"},// (modulo)
  {"*"   ,  "https://processing.org/reference/multiply.html"},// (multiply)
  {"*="  ,  "https://processing.org/reference/multiplyassign.html"},// (multiply assign)
  {"+"   ,  "https://processing.org/reference/addition.html"},// (addition)
  {"++"  ,  "https://processing.org/reference/increment.html"},// (increment)
  {"+="  ,  "https://processing.org/reference/addassign.html"},// (add assign)
  {"-"   ,  "https://processing.org/reference/minus.html"},// (minus)
  {"--"  ,  "https://processing.org/reference/decrement.html"},// (decrement)
  {"-="  ,  "https://processing.org/reference/subtractassign.html"},// (subtract assign)
  {"/"   ,  "https://processing.org/reference/divide.html"},// (divide)
  {"/="  ,  "https://processing.org/reference/divideassign.html"},// (divide assign)
  
  {"&"   ,  "https://processing.org/reference/bitwiseAND.html"},// (bitwise AND)
  {"<<"  ,  "https://processing.org/reference/leftshift.html"},// (left shift)
  {">>"  ,  "https://processing.org/reference/rightshift.html"},// (right shift)
  {"|"   ,  "https://processing.org/reference/bitwiseOR.html"},// (bitwise OR)

  {"abs"        ,  "https://processing.org/reference/abs_.html"},
  {"ceil"       ,  "https://processing.org/reference/ceil_.html"},
  {"constrain"  ,  "https://processing.org/reference/constrain_.html"},
  {"dist"       ,  "https://processing.org/reference/dist_.html"},
  {"exp"        ,  "https://processing.org/reference/exp_.html"},
  {"floor"      ,  "https://processing.org/reference/floor_.html"},
  {"lerp"       ,  "https://processing.org/reference/lerp_.html"},
  {"log"        ,  "https://processing.org/reference/log_.html"},
  {"mag"        ,  "https://processing.org/reference/mag_.html"},
  {"map"        ,  "https://processing.org/reference/map_.html"},
  {"max"        ,  "https://processing.org/reference/max_.html"},
  {"min"        ,  "https://processing.org/reference/min_.html"},
  {"norm"       ,  "https://processing.org/reference/norm_.html"},
  {"pow"        ,  "https://processing.org/reference/pow_.html"},
  {"round"      ,  "https://processing.org/reference/round_.html"},
  {"sq"         ,  "https://processing.org/reference/sq_.html"},
  {"sqrt"       ,  "https://processing.org/reference/sqrt_.html"},
  {"acos"       ,  "https://processing.org/reference/acos_.html"},
  {"asin"       ,  "https://processing.org/reference/asin_.html"},
  {"atan"       ,  "https://processing.org/reference/atan_.html"},
  {"atan2"      ,  "https://processing.org/reference/atan2_.html"},
  {"cos"        ,  "https://processing.org/reference/cos_.html"},
  {"degrees"    ,  "https://processing.org/reference/degrees_.html"},
  {"radians"    ,  "https://processing.org/reference/radians_.html"},
  {"sin"        ,  "https://processing.org/reference/sin_.html"},
  {"tan"        ,  "https://processing.org/reference/tan_.html"},
  {"noise"      ,  "https://processing.org/reference/noise_.html"},
  {"noiseDetail",  "https://processing.org/reference/noiseDetail_.html"},
  {"noiseSeed"  ,  "https://processing.org/reference/noiseSeed_.html"},
  {"random"     ,  "https://processing.org/reference/random_.html"},
  {"randomGaussian"  ,  "https://processing.org/reference/randomGaussian_.html"},
  {"randomSeed" ,  "https://processing.org/reference/randomSeed_.html"},
  {"HALF_PI"    ,  "https://processing.org/reference/HALF_PI.html"},
  {"PI"         ,  "https://processing.org/reference/PI.html"},
  {"QUARTER_PI" ,  "https://processing.org/reference/QUARTER_PI.html"},
  {"TAU"        ,  "https://processing.org/reference/TAU.html"},
  {"TWO_PI"     ,  "https://processing.org/reference/TWO_PI.html"}
});
