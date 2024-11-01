# Yisp
This is the Yisp Interpreter written in Swift. 

## Running

To read a file and execute it, run: 

```
swift run -c release Yisp [path_to_file]
```

To run the interpreter interactively, run: 

```
swift run -c release Yisp
```

## Testing
The test input file is input_example.txt. To run it and put the result in the output_example.txt file, run: 

```
swift run -c release LoxCLI input_example.txt > output_example.text
```

Another way to run the test for the six sprints is by going to the main.swift file and comment out the code like this: 
![](https://github.com/ttdo19/Lotties/blob/main/Run%20Test.png)

Then you can run: 
```
swift run -c release Yisp > testingOutput.txt
```

## Supported Commands / Builtin names (not case sensitive)

* Required

    - SET
        - (set name expr)
        - The symbol name is associated with the value of expr. This returns the value of the expr as an acknowledgement that the symbol name has been associated with the value of expr.

    - ADD (PLUS, +)
        - ( + expr1 expr2 expr3 ... exprN)
        - Returns the sum of expressions. The expressions must be numbers. 

    - SUB (-)
        - ( - expr1 expr2 expr3 ... exprN)
        - Returns the expr1 - expr2 - expr3 - ... - exprN. The expressions must be numbers. 

    - MUL (*)
        - ( \* expr1 expr2 expr3 ... exprN)
        - Returns the product of expressions. The expressions must be numbers. 

    - DIV (/)
        - ( / expr1 expr2 expr3 ... exprN)
        - Returns the expr1 / expr2 / expr3 / ... / exprN. The expressions must be numbers. 

    - EQ? (=)
        - (= expr1 expr2)
        - Compares the values of two atoms. Returns () when either expression is a larger list.

    - LT (<)
        - (< expr1 expr2)
        - Return T when expr1 is less than expr2. Expr1 and expr2 must be numbers.

    - GT (>)
        - (> expr1 expr2)
        - Return T when expr1 is greater than expr2. Expr1 and expr2 must be numbers.

    - LTE (<=)
        - (<= expr1 expr2)
        - Return T when expr1 is less than or equal to expr2. Expr1 and expr2 must be numbers.

    - GTE (>=)
        - (>= expr1 expr2)
        - Return T when expr1 is greater than or equal to expr2. Expr1 and expr2 must be numbers.

    - CONS 
        - (cons expr1 expr2)
        - Create a cons cell with expr1 as car and expr2 and cdr: ie: (exp1 . expr2)

    - CAR
        - (car expr)
        - Expr should be a non empty list. Car returns the car cell of the first cons cell

    - CDR 
        - (cdr expr)
        - Expr should be a non empty list. Cdr returns the cdr cell of the first cons cell

    - NUMBER?
        - (number? expr)
        - Returns T if the expr is numeric, () otherwise

    - SYMBOL?
        - (symbol? Expr)
        - Returns T if the expr is a name, () otherwise

    - LIST?
        - (list? Expr)
        - Returns T iff Expr is not an atom, () otherwise

    - NIL? (NULL?)
        - (nil? Expr)
        - Return T iff Expr is (), () otherwise

    - AND?
        - (AND? exp1 exp2)
        - Return () if either expression is (). Return T otherwise

    - OR?
        - (OR? exp1 exp2)
        - Return () if both expressions are (). Return T otherwise

    - DEFINE ( DEF, FUN, FN, FUNC, DEFUN )
        - (define name (arg1 .. argN) expr)
        - Defines a function, name. Args is a list of formal parameters. When called the expression will be evaluated with the actual parameters replacing the formal parameters.

    - Informative: call syntax
        - (funname expr1 ... exprN)
        - Calling of function defined by funname. The expressions are evaluated and passed as arguments to the function.

    - EVAL 
        - ( eval expr)
        - Eval the expr and return the result.

* Optional

    - MOD
        - (mod expr1 expr2)
        - Return the result of expr1 mod expr2. Expr1 and expr2 must be numbers.

    - IF
        - (if exp1 expT expF) 
        - Depending on the result of exp1 either expT or expF is evaluated and returned. If exp1 is () then expF is evaluated, otherwise, expT is evaluated.

    - COND
        - (cond t1 r1 t2 r2 t3 r3 .. tN rN)
        - if t1 is true returns r1...if t2 is true return r2...

    - NOT 
        - (not expr)
        - if expr is (), return T. Otherwise, return ().

    - QUOTE (')
        - ('expr)
        - The quote function prevents its argument from being evaluated, treating it as literal data rather than code.

    - CADR
        - (cadr expr)
        - This function takes a list and return the second element of the list.

    - CADDR
        - (caddr expr)
        - This function takes a list and return the third element of the list.

    - CADDDR
        - (cadddr expr)
        - This function takes a list and return the fourth element of the list. 

    - EQLIST?
        - (eqlist? expr1 expr2)
        - This function takes 2 lists and compares if they are equal. If true, return T. Otherwise, return (). 

    - ATOM?
        - (atom? expr)
        - This function check if an expr is an atom. If true, return T. Otherwise, return ().

    - LAMBDA
        - ((lambda (expr1 expr2 ... exprN) expr) arg1 arg2 ... argN)
        - lambda: define anonymous function. This function evals arg1 and sets the value to expr1, evals arg2 and sets the value to expr2...
        - Then, it evals the expr based on expr1, expr2, ..., exprN and returns the result. 





