describe Pieces::RouteCompiler do
  let(:compiler) { described_class.new(path: 'examples/original/') }

  context 'when compiling index.html from Mustache templates' do
    let(:content) do
      [{ 'header' => {} },
       { 'posts/post' => { title: 'About Author',
                           content: '<p>He is a cool dude.</p>' } },
       { 'footer' => {} }]
    end

    let(:route_config) do
      { '_global' => { 'title' => 'About' },
        '_pieces' => [{ 'layouts/layout' => { '_pieces' => content } }] }
    end

    subject do
      compiler.compile({}, :about, route_config)['about.html'][:contents]
    end

    it { is_expected.to include('<h1 class="post__title">About Author</h1>') }
    it { is_expected.to include('<div class="post__content">') }
    it { is_expected.to include('<p>He is a cool dude.</p>') }
  end
end
