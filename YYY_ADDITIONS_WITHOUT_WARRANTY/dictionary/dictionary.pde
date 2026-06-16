// IntDict is a simple class to use a String as a lookup 
// for an int value. String "keys" are associated with integer values.
// From Processing.org

IntDict inventory;

void setup() 
{
  size(200, 200);
  inventory = new IntDict();
  inventory.set("cd", 84);
  inventory.set("tapes", 15);
  inventory.set("records", 102);
  println(inventory);
  noLoop();
  fill(0);
  textAlign(CENTER);
}

void draw() 
{
  int numRecords = inventory.get("records");
  text(numRecords, width/2, height/2);
}

// https://github.com/borkowsk/bookProcessingEN
