require 'rubygems'
require 'rake'

task :default => :build

pygments_css = "_pygments.scss"

file pygments_css do
  sh "pygmentize -S default -f html > #{pygments_css}"
end

task :build => pygments_css do
  system "jekyll"
end

task :minify => :build do
  sh "rm -rf _site.min/"
  sh "cp -r _site/ _site.min/"

  options = "--recursive --remove-intertag-spaces --remove-quotes --simple-doctype --remove-style-attr --remove-link-attr --remove-script-attr --remove-form-attr --remove-input-attr --simple-bool-attr --remove-js-protocol --remove-http-protocol --remove-https-protocol --remove-surrounding-spaces max --compress-js --compress-css"
  sh "htmlcompressor #{options} --type html -o _site.min/ _site/"
  sh "htmlcompressor #{options} --type xml -o _site.min/ _site/"
  sh "htmlcompressor #{options} -o _site.min/style.css _site/style.css"
end

task :deploy => :minify do
  sh "rsync --rsh=ssh --recursive --times --delete --delete-after --delay-updates --compress --human-readable --stats _site.min/ www:/var/www/jekyll/"
end
