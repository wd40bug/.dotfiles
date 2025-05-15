## Linking Philosophy:
# I don't anticipate adding that many configs, so I should just be able to handle it this way
import os
import sys
from pathlib import Path
import ctypes

is_admin = ctypes.windll.shell32.IsUserAnAdmin() != 0
if not is_admin:
    print("This script requires admin")
    exit(1)

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
test = False
if len(sys.argv) <= 3:
    out_file = Path()
    for arg in sys.argv[1:]:
        if arg == "test":
            test = True
        else:
            out_file = Path(arg)
else:
    print("Too many command line args")

stow_list_path = "stow-list.txt" if not test else "stow-list-test.txt"
f = open(stow_list_path, "r")
exists_dir = Path( "EXISTS/" )

contents: list[str] = f.read().splitlines()

for line in contents:
    src, dest = map(lambda x: Path( x.strip() ).expanduser(), line.split('->'))
    is_dir = os.path.isdir(src)
    if not os.path.exists(dest.parent):
        if not confirm(f"{dest} doesn't exist, create it?", defaultTrue=True):
            print("Ok, skipping", dest)
            continue
        dest.parent.mkdir(parents=True)
    if dest.exists():
        if dest.resolve() != src.absolute():
            if not confirm(f"{dest} exists, move it to {exists_dir}?", defaultTrue=True):
                print("Ok, skipping", dest)
                continue
            os.renames(dest, exists_dir.joinpath(dest.name))
        else:
            # Symlink already exists to the right place
            os.remove(dest)
    print(src.absolute(), dest, sep="           ")
    os.symlink(src.absolute(),dest, is_dir) 
    
