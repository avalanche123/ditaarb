require 'tempfile'

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
    ditaa_jar  = File.expand_path(File.dirname(__FILE__) + '/../vendor/ditaa0_9.jar')
    ditaa_jar << ' -A' if options[:antialiasing]
    ditaa_jar << ' -d' if options[:debug]
    ditaa_jar << ' -E' if options[:separation] == false
    ditaa_jar << ' -r' if options[:rounded_corneres]
    ditaa_jar << " -s #{options[:scale]}" if options[:scale]
    ditaa_jar << ' -S' if options[:shadows] == false
    ditaa_jar << ' -t' if options[:tabs]

    input_file = Tempfile.new('ditaa.input')
    input_file.write(ascii_art)
    input_file.flush

    output_file = Tempfile.new('ditaa.output')

    pid = Process.spawn("java -jar #{ditaa_jar} -v #{input_file.path} #{output_file.path}", [:err, :out] => '/dev/null')
    Process.wait(pid)
    File.read(output_file.path)
  ensure
    input_file.close!
    output_file.close!
  end
end

require 'ditaarb/version'
