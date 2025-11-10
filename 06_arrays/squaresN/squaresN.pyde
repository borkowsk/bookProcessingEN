## Table of squares of integers.
#*##=============================

'''constant int'''
N = 50

squares = [0]*(N+1)

for i in range(0,N+1,1): # 'i' keeps int
     squares[i] = i * i 

# List these numbers using print!
print "First",N,"squares of integers"
for i in range(0,N+1,1): # 'i' keeps int
     print i,"->",squares[i]

## @date 2025-11-10 (https://github.com/borkowsk/bookProcessingEN)
