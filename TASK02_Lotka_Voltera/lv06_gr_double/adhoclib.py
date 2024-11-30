''' Translating from a pde file sometimes requires 
    defining additional functionalities. They go to this file! '''
  
## https://stackoverflow.com/questions/7267226/range-for-floats  
def frange(x, y, jump):
  ''' Note: We have cumulative effect of errors when working with floats '''
  while x < y:
    yield x
    x += jump
    
