require 'rubygems'
require 'rake'

task :default => :generate

pygments = '_pygments.scss'
css = 'style.css'
scss = FileList['*.scss']
site = '_site'
site_min = '_site.min'
dizzy = "_posts/2007-02-27-making-dizzy-shine-with-ajax.html"

file pygments do
  sh "pygmentize -S default -f html > #{pygments}"
end

file css => FileList['*.scss'] do
  sh "sass --style compressed style.scss #{css}"
end

file dizzy => '_posts/_2007-02-27-making-dizzy-shine-with-ajax.asciidoc' do
  #
  sh "(echo \"---\nlayout: article\ntitle: Making Dizzy Shine With Ajax\n---\"; asciidoctor _posts/_2007-02-27-making-dizzy-shine-with-ajax.asciidoc --no-header-footer --out-file -) > #{dizzy}"
end

task :generate => [pygments, css, dizzy] do
  sh 'jekyll', 'build'
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
