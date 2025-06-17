require 'zeitwerk'

loader = Zeitwerk::Loader.new
loader.push_dir("#{__dir__}/models/")
loader.push_dir("#{__dir__}/services/")
loader.setup

libs = %w[
  bigdecimal
  json
  ostruct
]

libs.each { |lib| require lib }
