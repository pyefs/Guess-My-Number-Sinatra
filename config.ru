require File.expand_path(File.join('config', 'application'))
map('/') { run ApplicationController }
