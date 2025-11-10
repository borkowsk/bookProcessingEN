## Mean of some random numbers.
#*##===========================

'''constant int'''
N=20  # How many numbers?
numbers=[0.0]*(N) # table storing values

# Draw numbers randomly:
for i in range(0,N,1): # 'i' keeps int
    numbers[i]=random(0,10)
  
# Print numbers:
for i in range(0,N,1): # 'i' keeps int
    print i,":",numbers[i]

# Sum up the numbers:
sum=0
for i in range(0,N,1): # 'i' keeps int
     sum=sum+numbers[i]  # <=> sum+=numbers[i]; 

# Print sum:
print "Sum =",sum

# Calculate and write the average:
print "Average =",sum/N,

# Reasonable appearance of the graphics window after calculations are completed.
textAlign(CENTER,CENTER);text("Done!\nPress ESC\nor click [x]",width/2,height/2)



## @date 2025-11-10 (https://github.com/borkowsk/bookProcessingEN)

