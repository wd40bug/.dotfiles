## Linking Philosophy:
# I don't anticipate adding that many configs, so I should just be able to handle it this way
import os
from pathlib import Path
import ctypes

class StowException(Exception):
    """Stow Failed"""

def stow(test = False, exists_dir = Path("windows/EXISTS/")):
    is_admin = ctypes.windll.shell32.IsUserAnAdmin() != 0
    if not is_admin:
        raise StowException("Run me with admin")

    def confirm(q: str, defaultTrue) -> bool:
        while True:
            print(q)
            print("[Y/n]" if defaultTrue else "[y/N]")
            user_in = input().lower()
            if user_in in ["yes", "y", "c", "confirm", ""]:
                return True
            elif user_in in ["no", "n"]:
                return False
            else:
                print("Invalid Input")


    stow_list_path = "stow_files/stow-list.txt" if not test else "stow_files/stow-list-test.txt"
    f = open(stow_list_path, "r")

    contents: list[str] = f.read().splitlines()

    for line in contents:
        src, dest = map(lambda x: Path(x.strip()).expanduser(), line.split("->"))
        is_dir = os.path.isdir(src)
        if not os.path.exists(dest.parent):
            if not confirm(f"{dest} doesn't exist, create it?", defaultTrue=True):
                print("Ok, skipping", dest)
                continue
            dest.parent.mkdir(parents=True)
        if dest.exists():
            if dest.resolve() != src.absolute():
                if not confirm(
                    f"{dest} exists, move it to {exists_dir}?", defaultTrue=True
                ):
                    print("Ok, skipping", dest)
                    continue
                os.renames(dest, exists_dir.joinpath(dest.name))
            else:
                # Symlink already exists to the right place
                os.remove(dest)
        print(src.absolute(), dest, sep="           ")
        os.symlink(src.absolute(), dest, is_dir)
