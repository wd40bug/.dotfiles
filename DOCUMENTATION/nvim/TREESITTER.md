# Treesitter controls

## Textobjects

### Selection

| Key       | Selection                                              |
|:----------|:-------------------------------------------------------|
|ap         |Outside of parameter                                    |
|ip         |Inside of parameter                                     |
|l          |lhs of assignment                                       |
|r          |rhs of assignment                                       |

### Move

| Key | Movement              |
|:----|:----------------------|
|]f   | next function         |
|]t   | next type             |
|]p   | next parameter        |
|]r   | next return           |
|[f   | previous function     |
|[t   | previous type         |
|[p   | previous parameter    |
|[r   | previous return       |
|]F   | next function end     |
|]T   | next type end         |
|]P   | next parameter end    |
|]R   | next return end       |                                  
|[F   | previous function end |
|[T   | previous type end     |
|[P   | previous parameter end|
|[R   | previous return end   |                                  

## Treesitter Textsubjects Motions
:h nvim-treesitter-textsubjects
| Key       | Selection                                              |
|:----------|:-------------------------------------------------------|
|.          |Smart selection, selects whatever textobject cursor in  |
|;          |Outside of container                                    |
|i;         |Inside of container                                     |

## Treesitter Targets Motions
[Cheat Sheet](https://github.com/wellle/targets.vim/blob/master/cheatsheet.md)

| Key       | Selection                                              |
|:----------|:-------------------------------------------------------|
|i{,(,[,<,t |Select inside provided pair                             |
|I{,(,[,<,t |Select inside provided pair, excluding whitespace       |
|a{,(,[,<,t |Select around provided pair                             |
|A{,(,[,<,t |Select around provided pair, excluding whitespace       |

Provide a number before i,I,a,A to select multiple blocks
Provide an 'l' or 'n' after i,I,a,A to distinguish (n)ext or (l)ast pairs
Provide a separator, ", . ; : + - = ~ _ * # / | \ & $" to select inside/around separators
Provide a 'b' to select any block and a q to select any quotes
