# NVIM BASICS
Notes from running `nvim +Tutor`

Use <Enter> to follow links and <Shift>+K to get documentation for items in help 
Close Windows with `:q`

# Modes

## Normal Mode

| Key | Mode  |
|-----|-------|
|i    |Insert |
|R    |Replace|
|v    |Visual |

### Text Editing
| Key | Effect                        |
|:----|:------------------------------|
|x    |Delete Character               |
|A    |Append to end of line          |
|d    |Delete                         |
|dd   |Delete line                    |
|y    |Yank text to register          |
|p    |Put register text after cursor |
|P    |Put register text before cursor|
|r    |Replace character              |
|c    |Change(Delete and Insert)      |
|o    |Open line below and Insert     |
|O    |Open line above and Insert     |
|a    |Insert after cursor            |
|.    |Repeat last aciton             |


### Motions
Motions without operations move cursor
| Key       | Selection                                              |
|:----------|:-------------------------------------------------------|
|w          |Till start of next word                                 |
|$          |Till end of line                                        |
|e          |Till end of current word                                |
|b          |Till beginning of current word                          |
|0          |Till beginning of line                                  |
|G          |Till line number(specify number before i.e. d2G) or EOF |
|gg         |Till beginning of file                                  |
|%          |Till matching ),], or }                                 |
|i          |Select inside provided character                        |


### Undo
| Key     | Effect                     |
|:--------|:---------------------------|
|u        |Undo                        |
|U        |Undo whole line             |
|G+       |Move forward in Undo tree   |
|G-       |Move backward in Undo tree  |
|<ctrl>+r |Redo                        |

### Util
| Key     | Effect                     |
|:--------|:---------------------------|
|<ctrl>+g |See position in buffer      |

### Commands
Use <ctrl>+d and tab for command completion

| Command            | Effect                                                                                                          |
|:-------------------|:----------------------------------------------------------------------------------------------------------------|
|:h                  |Help dialog                                                                                                      |
|:wq                 |Save and quit buffer                                                                                             |
|:q                  |Quit buffer                                                                                                      |
|:q!                 |Quit buffer without saving                                                                                       |
|:!                  |Execute external command                                                                                         |
|:w                  |Save range to file(default whole buffer)                                                                         |
|:r                  |Retrieve contents of register, file, or command and paste into current buffer                                    |
|:n                  |Open file                                                                                                        |
|:vs, :vert          |Create veritcal split with supplied buffer                                                                       |
|:hs, :hori          |Create horizontal split with supplied buffer                                                                     |


#### :s
Substitute(Find and Replace)
| Option | Place | Effect                       | Example        |
|:-------|:------|:-----------------------------|:---------------|
|\g      |end    |substitute all in line        |:s/old/new/g    |
|\c      |end    |prompt for every substitution |:s/old/new/c    |
|\c      |phrase |ignore case                   |:s/old\c/new    |
|\C      |phrase |don't ignore case             |:s/old\c/new    |

#### :set
Sets options
| Option | Effect                           |
|:-------|:---------------------------------|
|ic      |ignore case in searches           |
|hls     |highlight searches                |
|is      |show partial matches              |
|no      |prefix for setting, falsifies it  |
|inv     |prefix for setting, inverts it    |

### Range
see `:h range`
| Key       | Effect                                    |
|:----------|:------------------------------------------|
|{number}   |Line number                                |
|.          |Current line                               |
|$          |Last line                                  |
|/{pattern} |Next line where {pattern} matches          |
|?{pattern} |Previous line where {pattern} matches      |
|\\/        |Next line where search pattern matches     |
|\\?        |Previous line where search pattern matches |
|\\&        |Next line where substitute pattern matches |
|%          |Equivalent to 1,$ the whole buffer         |
|*          |Last visual range                          |

use + and - after all except % to increase or decrease line #
If no number, 1 is used
If there is nothing before + or -, current line is used


## Search
| Key     | Effect                         |
|:--------|:-------------------------------|
|/        |Open search dialog(forward)     |
|?        |Open search dialog(backward)    |
|n        |Next instance of searched       |
|N        |Previous instance of searched   |
|<ctrl>+o |Move back a jump                |
|<ctrl>+i |Move forward a jump             |


## Windows
| Key       | Effect                                    |
|:----------|:------------------------------------------|
|<ctrl>+w   |Enter 'window mode'                        |
|<ctrl>+r   |Swap windows                               |
|arrow keys |Switch to window indicated by direction    |
