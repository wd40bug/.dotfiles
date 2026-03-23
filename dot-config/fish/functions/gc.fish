function gc
    # Create a temporary file for the commit message
    set tmpfile (mktemp /tmp/git-commit-msg.XXXXXX)

    # Get the diff, send it to crush, and save to the temp file
    # We use --quiet or similar flags if available to keep the output clean
    git diff --cached | crush run --model llama3.1:latest "write a conventional git commit message for these changes. Respond with only a commit message, your response is being piped into a file. Additionally, don't use tags like \"feat\" and don't wrap the response in quotations" > $tmpfile

    # Check if the file is empty (crush failed)
    if not test -s $tmpfile
        echo "Error: Crush failed to generate a message."
        rm $tmpfile
        return 1
    end

    # Open the generated message in your editor
    # This allows you to review/edit before finishing the commit
    eval $EDITOR $tmpfile

    # If the editor exits successfully, commit using that file
    if test $status -eq 0
        git commit -F $tmpfile
    else
        echo "Commit aborted."
    end

    # Clean up
    rm $tmpfile
end
