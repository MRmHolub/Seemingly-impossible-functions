def forsome(p):
    return p(find(p))


def foreach(p):
    return not forsome(lambda x: not p(x))


def find(p):
    def inner(): 
        if forsome(lambda x: p((0, x))):
            return (0, find(lambda x: p((0, x)))) 
        else:
            return (1, find(lambda x: p((1, x))))
    return inner


def at_index(seq, i):
    if callable(seq):
        return at_index(seq(), i)
    if i == 0:
        return seq[0]
    if callable(seq[1]): #same as isinstance(seq[1], function)
        return at_index(seq[1](), i - 1)
    else:
        return at_index(seq[1], i - 1)
    
    
def equals(pred_a, pred_b):
    return not forsome(lambda x: pred_a(x) != pred_b(x))


#print(forsome(lambda seq: seq[4] == 0 and seq[2] == 0 and seq[3] > seq[0]))
#would be rewritten like
print(forsome(lambda seq: at_index(seq, 4) == 0 and at_index(seq, 2) == 0 and at_index(seq, 3) > at_index(seq, 0)))

#Should implement also for other values 

print(equals(lambda seq: at_index(seq, 0) == 0, lambda seq: at_index(seq, 0) != 1))
