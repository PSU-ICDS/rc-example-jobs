(* Find and print all prime numbers in the first 100 numbers *)

primeNumbers = Select[Range[1, 100], PrimeQ];

Print["Prime numbers between 1 and 100: ", primeNumbers];

Quit[0];

