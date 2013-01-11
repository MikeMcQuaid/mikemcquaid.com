require 'rubygems'
require 'rake'

task :default => :generate

pygments = '_pygments.scss'
css = 'style.css'
scss = FileList['*.scss']
site = '_site'
site_min = '_site.min'

file pygments do
  sh "pygmentize -S default -f html > #{pygments}"
end

file css => FileList['*.scss'] do
  sh "sass --style compressed style.scss #{css}"
end

task :generate => [pygments, css] do
  # Same as GitHub Pages
  # https://help.github.com/articles/using-jekyll-with-pages#troubleshooting
  sh 'jekyll', '--pygments', '--no-lsi', '--safe'
end

task :minify => :generate do
  sh "rm -rf #{site_min}"
  sh "cp -r #{site} #{site_min}"

  options = '--recursive --remove-intertag-spaces --remove-quotes --simple-doctype --remove-style-attr --remove-link-attr --remove-script-attr --remove-form-attr --remove-input-attr --simple-bool-attr --remove-js-protocol --remove-http-protocol --remove-https-protocol --remove-surrounding-spaces max --compress-js --compress-css'
  sh "htmlcompressor #{options} --type html -o #{site_min} #{site}"
  sh "htmlcompressor #{options} --type xml -o #{site_min} #{site}"
  sh "htmlcompressor #{options} -o #{site_min}/#{css} #{site}/#{css}"
end

task :deploy => :minify do
  sh 'rsync --rsh=ssh --recursive --times --delete --delete-after --delay-updates --compress --human-readable --stats _site.min/ www:/var/www/'
end

task :clean do
  File.delete css
  File.delete pygments
  FileUtils.rm_rf site
  FileUtils.rm_rf site_min
end
