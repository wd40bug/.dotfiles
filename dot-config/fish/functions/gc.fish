function gc
    # 1. Create a temporary file
    set tmpfile (mktemp /tmp/git-commit-template.XXXXXX)

    # 2. Enhanced Prompt: Explicitly forbid conversational filler
    set prompt "Write a brief, professional conventional git commit message based on this diff. 
    DO NOT include any introductory text, explanations, or 'Here is your message'. 
    Output ONLY the commit message itself"

    echo "Llama is drafting your commit message..."
    
    # 3. Get the diff and generate the message
    git diff --cached | crush run --model llama3.1:latest "$prompt" > $tmpfile

    # 4. Use git commit with the template
    if test -s $tmpfile
        git commit --template $tmpfile
    else
        echo "Error: Llama failed to generate a message."
    end

    # 5. Clean up
    rm $tmpfile
end
