#!/usr/bin/env rake
require 'rake/clean'
require 'rake/testtask'
require "bundler/gem_tasks"

Bundler::GemHelper.install_tasks

task :default => :test

Rake::TestTask.new do |t|
  t.test_files = FileList['test/test*.rb']
end
