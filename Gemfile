source "https://rubygems.org"

git_source(:github) {|repo_name| "https://github.com/#{repo_name}" }

# Specify your gem's dependencies in motocross_gear.gemspec
gemspec

local_gemfile = File.expand_path("Gemfile-local.rb", __dir__)
eval_gemfile(local_gemfile) if File.readable?(local_gemfile)
