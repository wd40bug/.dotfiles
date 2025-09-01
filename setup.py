from typing import assert_never, cast, Literal, get_args
import inquirer
from windows import windows
from ubuntu import ubuntu
from termux import termux

System = Literal["windows", "ubuntu", "termux"]

questions = [
    inquirer.List(
        "system",
        message="Which system?",
        choices=get_args(System),
    ),
]

answers = cast(dict[str, str], inquirer.prompt(questions))

system: System = cast(System, answers['system'])

match system:
    case "windows":
        windows()
    case "termux":
        termux()
    case "ubuntu":
        ubuntu()
    case _: 
        assert_never(system)
