/// `prompt()` "called" inside `setup()`.
//*///////////////////////////////////////

void prompt()
{
    line(0,0,5,5);
    line(0,10,5,5);    
}

void setup() // It is executed once - after starting
{
    prompt(); // Call `prompt()`!
}

// https://github.com/borkowsk/bookProcessingEN
