## `prompt()` "called" inside `setup()`.
#*##====================================

def prompt():
    '''What should this code below do? Is it any global variable used inside? '''
    line(0,0,5,5)
    line(0,10,5,5);    


def setup(): # It is executed once - after starting
    '''What should this code below do? Is it any global variable used inside? '''
    prompt()  # Call `prompt()`!


# https://github.com/borkowsk/bookProcessingEN
