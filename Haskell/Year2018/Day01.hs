
split :: Eq a => a -> [a] -> [[a]]
split _ [] = []
split separator list = head : split separator (drop 1 tail)
    where (head,tail) = span (/= separator) list

remove :: Eq a => a -> [a] -> [a]
remove _ [] = []
remove character list = head tail : remove character (drop 1 tail)
    where (_, tail) = span (== character) list

toInt xs = [ read x :: Int | x <- xs ]

calculate string = sum (toInt (split ',' (remove ' ' (remove '+' string))))

test1 = (calculate "+1, +1, +1") == 3
test2 = (calculate "+1, +1, -2") == 0
test3 = (calculate "-1, -2, -3") == -6

output = [test1, test2, test3]

main = print (output)
