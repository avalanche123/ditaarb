require 'tempfile'
require 'tmpdir'
require 'digest'

module Ditaa
  # @param ascii_art [String] original ascii diagram to render as image.
  # @option options [Boolean] :antialiasing (true) Turns anti-aliasing on/off.
  # @option options [Boolean] :debug (false) Renders the debug grid over the
  #   resulting image.
  # @option options [Boolean] :separation (true) Prevents the separation of
  #   common edges of shapes.
  # @option options [Boolean] :rounded_corneres (false) Causes all corners to
  #   be rendered as round.
  # @option options [Numeric] :scale (1.0) A natural number that determines the
  #   size of the rendered image. The units are fractions of the default size
  #   (2.5 renders 1.5 times bigger than the default).
  # @option options [Boolean] :shadows (true) Turns shadows on/off.
  # @option options [Boolean] :tabs (false) Tabs are normally interpreted as 8
  #   spaces but it is possible to change that using this option. It is not
  #   advisable to use tabs in your diagrams.
  # @return [String] processed image
  def self.render(ascii_art, options = {})
    filename = File.join(Dir.tmpdir, 'ditaarb-' + Digest::MD5.hexdigest(ascii_art) + '.tmp')

    return File.read(filename) if File.exists?(filename)

    begin
      input_file = Tempfile.new('ditaa.input')
      input_file.write(ascii_art)
      input_file.flush

      args  = ['java', '-jar']
      args << File.expand_path(__FILE__ + '/../../vendor/ditaa0_9.jar')
      args << '-A' if options[:antialiasing]
      args << '-d' if options[:debug]
      args << '-E' if options[:separation] == false
      args << '-r' if options[:rounded_corneres]
      args << '-s' << options[:scale] if options[:scale]
      args << '-S' if options[:shadows] == false
      args << '-t' if options[:tabs]
      args << '-v'
      args << input_file.path
      args << filename
      args << { [:err, :out] => '/dev/null' }

      system(*args)
    ensure
      input_file.close!
    end

    File.read(filename)
  end
end

require 'ditaarb/version'

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
