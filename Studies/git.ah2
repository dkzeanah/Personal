; This makes an alias for a command
git config --global alias.aliasName "command"

; This is how you change the message of the last commit
git commit --amend -m "new commit message"

; To add files you forgot to to your last commit and recommit it
git add . 
git commit --amend --no-edit ; No edit means you don't want to change the commit message 

; This will push your local code, overwriting the one on your remote repo
git push origin main --force
; Use --force-with-lease to only push if there are no conflicts

; This undoes the commit
git revert commitLogNumber

; Undo your changes
git stash
; Pop them back
git stash pop

; Stash with reference
git stash save name
git stash list
git stash apply indexNumber

; To change the name of your main branch
git branch -M name 

; To merge your different branch commits into the main branch
git rebase --interactive
; Then you have the option to squash some commits using squash instead of pick 
; Fixup — if you don't want the commit messages to be squashed
; Matter of fact, you can use either --fixup of --squash while commiting in the first place 
;Then you rebase using
git rebase -i --autosquash

; To restore code to the state of the remote repo
git fetch origin
git reset --hard origin/main

; If you checked out to a branch and want to go back to it, use
git checkout -

; Change your email
git config --global user.email some_other_address

;DOESN'T WORK
/* 
;Alias for changing the author/email of last commits
git config --global alias.change-commits '!"f() { VAR=\$1; OLD=\$2; NEW=\$3; shift 3; git filter-branch --env-filter \"if [[ \\\"\$\`echo \$VAR\`\\\" = '\$OLD' ]]; then export \$VAR='\$NEW'; fi\" \$@; }; f"'

;To change author name for all last commits:
git change-commits GIT_AUTHOR_NAME "old name" "new name"
;To change email for 10 last commits
git change-commits GIT_AUTHOR_EMAIL "old@email.com" "new@email.com" HEAD~10..HEAD
*/
