import subprocess

def stow():
    result = subprocess.run(["stow", ".", "--adopt"], capture_output=True, text=True, check=False)
    if result.stdout != "":
        print("STDOUT:")
        print(result.stdout)
    if result.stderr != "":
        print("STDERR:")
        print(result.stderr)

    if result.returncode != 0:
        raise Exception("stow failed, see stdout and stderr for details")
