require "bundler/gem_tasks"
require 'cucumber/rake/task'
require 'cane/rake_task'
require 'tailor/rake_task'
require "open-uri"

namespace :robot do

  url = "https://github.com/robotframework/robotframework/archive/master.tar.gz"
  tarball = "tmp/robot-master.tar.gz"
  vendor = "vendor/robot"

  desc "Vendors robot latest source code into gem codebase"
  task :vendor => "#{vendor}/VERSION.txt"

  directory File.dirname(tarball)
  directory vendor

  file tarball => File.dirname(tarball) do |t|
    begin
      src = open(url).binmode
      dst = open(t.name, "wb")
      IO.copy_stream(src, dst)
    ensure
      src.close
      dst.close
    end
  end

  file "#{vendor}/VERSION.txt" => [vendor, tarball] do |t|
    abs_tarball = File.expand_path(tarball)
    Dir.chdir(vendor) { sh "tar xzf #{abs_tarball} --strip-components=1" }
    rm_rf "#{vendor}/test"
    IO.write(t.name, url + "\n")
  end

  desc "Clean up a vendored robot in preparation for a new vendored version"
  task :clean do
    rm_rf [vendor, tarball]
  end
end

Cucumber::Rake::Task.new(:features) do |t|
  t.cucumber_opts = ['features', '-x', '--format progress']
end

desc "Run all test suites"
task :test => [:features]

desc "Run cane to check quality metrics"
Cane::RakeTask.new do |cane|
  cane.canefile = './.cane'
end

Tailor::RakeTask.new

desc "Display LOC stats"
task :stats do
  puts "\n## Production Code Stats"
  sh "countloc -r lib"
  puts "\n## Test Code Stats"
  sh "countloc -r features"
end

desc "Run all quality tasks"
task :quality => [:cane, :tailor, :stats]

task :default => [:test, :quality]
