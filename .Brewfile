cask_args appdir: '/Applications'

tap 'homebrew/services'
tap 'caskroom/fonts'

if !ARGV.include?("--casks")
    brew 'bash'
    brew 'tree'
    brew 'coreutils'
    brew 'jq'
    brew 'diffutils'
    brew 'vim'
    brew 'node'
    brew 'yarn'
    brew 'gradle'
    brew 'maven'
    brew 'wget'
    brew 'nginx'
    brew 'redis', restart_services: true
    brew 'mysql'
    brew 'bash-completion'
    brew 'terraform'
    brew 'tmux'
    brew 'reattach-to-user-namespace'
    brew 'go'
    brew 'the_silver_searcher'
end

if ARGV.include?("--casks")
    tap 'caskroom/cask'
    cask 'java' unless system "/usr/libexec/java_home --failfast"
    cask 'google-chrome'
    cask 'dropbox'
    cask 'alfred'
    cask 'slack'
    cask 'iterm2'
    cask 'spotify'
    cask 'sourcetree'
    cask 'postman'
    cask 'atom'
    cask 'sip'
    cask 'font-source-code-pro'
    cask 'google-cloud-sdk'
end
