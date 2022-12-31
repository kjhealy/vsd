# VSD deploy
PUBLIC_DIR='_site/'
SSH_USER='kjhealy@kjhealy.co'
DOCUMENT_ROOT='~/public/visualizingsociety.com/public_html'

echo "Uploading changes to remote server..."
echo "Dry run: (Not doing anything for real)"
echo "rsync --dry-run --exclude='.DS_Store' -Prvzce 'ssh -p 22'" $PUBLIC_DIR $SSH_USER:$DOCUMENT_ROOT "--delete-after"
#rsync --dry-run --exclude='.DS_Store' -Prvzce 'ssh -p 22' $PUBLIC_DIR $SSH_USER:$DOCUMENT_ROOT --delete-after
