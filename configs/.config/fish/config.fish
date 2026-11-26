if status is-interactive
    # Commands to run in interactive sessions can go here
    
    function run_after_command --on-event fish_postexec
        history merge
    end

    zoxide init fish --cmd cd | source
end
