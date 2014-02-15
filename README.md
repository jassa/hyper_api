# HyperAPI

Hypertext API. A sweet DSL to create objects off HTML.

## Installation

Add the `hyper_api` gem to your app. For example, using Bundler:

    $ echo "gem 'hyper_api'" >> Gemfile
    $ bundle install

## Usage

The HyperAPI gem uses [Nokogiri](https://github.com/sparklemotion/nokogiri) to parse HTML with CSS selectors.

Create objects on-the-go:

```ruby
tpb_torrent = HyperAPI.new_class('TPB::Torrent') do
  string title: 'div#title'
  string description: 'div.info'
  string hash: '#details dd'
  integer imdb_id: '#details a[title=IMDB]' do
    attribute('href').value
  end
end
# => TPB::Torrent

fringe = tpb_torrent.new(html)
# => #<TPB::Torrent title: 'Fringe Season 1', description: 'The complete season 1 of Fri...', imdb_id: '1119644'>
```

Or create a new class:

```ruby
class TPB::Torrent < HyperApi::Base
  string title: 'div#title'
  string description: 'div.info'
  string hash: '#details dd'
  integer imdb_id: '#details a[title=IMDB]' do
    attribute('href').value
  end
end

fringe = TPB::Torrent.new(html)
# => #<TPB::Torrent title: 'Fringe Season 1', description: 'The complete season 1 of Fri...', imdb_id: '1119644'>
```

## Contributing

If you've found a bug or have a question, please open an issue on the [issue tracker](https://github.com/jassa/hyper_api/issues). Or, clone the HyperAPI repository, write a failing test case, fix the bug, and submit a pull request.

## License

Copyright &copy; 2014 Javier Saldana

Released under the MIT license. See [`LICENSE`](LICENSE) for details.
