# Ditaa

A simple wrapper around [ditaa](http://ditaa.sourceforge.net) to produce pngs out of ascii art

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ditaarb'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ditaarb

## Usage

```ruby
require 'ditaarb'

File.open('diagram.png', 'w+') do |f|
  f.write Ditaa.render(<<-ASCII)
                                  /-------+
                                  |Cluster|<----------------------------------+
                                  +-------/                                   |
                                      ^                                       |
                                      |                                       |
            +-------------------------+-------------------------+             |
            :                         :                         :             |
        /---+---+                 /---+---+                 /---+---+         |
        |Session|                 |Session|                 |Session|         |
        +-------/                 +-------/                 +-------/         |
            ^                         ^                         ^             |
            |                         |                         |             |
     +------+-----+            +------+-----+            +------+-----+       |
     :            :            :            :            :            :       |
/----+-----+ /----+-----+ /----+-----+ /----+-----+ /----+-----+ /----+-----+ |
|Connection| |Connection| |Connection| |Connection| |Connection| |Connection| |
+----+-----/ +----+-----/ +----+-----/ +----+-----/ +----+-----/ +----+-----/ |
     :            :            :            :            :            :       |
     +------------+-=----------+------+-----+-=----------+------------+       |
                                      |                                       |
                                      v                                       |
                                /----------+                                  |
                                |IO Reactor|                                  |
                                +-----+----/                                  |
                                      :                                       |
                                      +---------------------------------------+
ASCII
end
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/ditaarb/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
