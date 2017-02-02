# If we modify an array while iterating over it, the iterator method keeps counting
# indexes (up to the original length) but the elements at those indexes are 
# constantly changing. Often it results in skipping over some elements.

# Example 1 output: 
# 1
# 3
# nil
# nil

# Example 2 output:
# 1
# 2
# nil
# nil