--- 
name: matriarch
company: RubyWorks
title: Matriarch
contact: Trans <transfire@gmail.com>
requires: 
- group: 
  - build
  name: syckle
  version: 0+
resources: 
  code: http://github.com/rubyworks/matriarch
  mail: http://groups.google.com/group/rubyworks-mailinglist
  home: http://rubyworks.github.com/matriarch
pom_verison: 1.0.0
manifest: 
- .ruby
- lib/matriarch/traits.rb
- lib/matriarch.rb
- test/test2.rb
- test/test3.rb
- PROFILE
- NOTES
- README
- Syckfile
- VERSION
- COPYING
version: 0.2.0
copyright: Copyright (c) 2009 Thomas Sawyer
licenses: 
- Apache 2.0
description: Matriarch is traits system for Ruby that sections a class into a matrix of Method and Precedence.
summary: Matrix Traits
authors: 
- Thomas Sawyer
created: 2009-10-03
