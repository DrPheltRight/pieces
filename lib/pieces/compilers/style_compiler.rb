module Pieces
  class StyleCompiler
    attr_reader :path

    def initialize(config = {})
      @path = config[:path] || Dir.pwd
    end

    def compile(files)
      files.merge('compiled.css' => { contents: '', type: 'css' }).tap do |files|
        files['compiled.css'][:contents] << yield_stylesheets('app/assets/stylesheets/components')
        files['compiled.css'][:contents] << yield_stylesheets('app/views')
      end
    end

    private

    def yield_stylesheets(dir)
      Dir["#{path}/#{dir}/**/*.{css,scss,sass,less}"].reduce('') do |contents, stylesheet|
        contents << ::Tilt.new(stylesheet, load_paths: ["#{path}/app/assets/stylesheets/"]).render
      end
    end
  end
end
