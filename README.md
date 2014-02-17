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
Torrent = HyperAPI.new_class do
  string title: 'div#title'
  string description: 'div.info'
  string hash: '#details dd'
  integer imdb_id: '#details a[title=IMDB]' do
    attribute('href').value
  end
end
# => Torrent

fringe = Torrent.new(html_string)
# => #<TPB::Torrent title: 'Fringe Season 1', description: 'The complete season 1 of Fri...', imdb_id: 1119644>

torrent = HyperAPI.new_class do
  string title: 'div#title'
  string description: 'div.info'
  string hash: '#details dd'
  integer imdb_id: '#details a[title=IMDB]' do
    attribute('href').value
  end
end
# => #<Class:0x007fda34829c48> // (anonymous class)

fringe = torrent.new(html_string)
# => #<Class:0x007fda34829c48 title: 'Fringe Season 1', description: 'The complete season 1 of Fri...', imdb_id: 1119644>

```

Or create a new class:

```ruby
class Torrent < HyperApi::Base
  string title: 'div#title'
  string description: 'div.info'
  string hash: '#details dd'
  integer imdb_id: '#details a[title=IMDB]' do
    attribute('href').value
  end

  def some_calculated_method
    "#{title}: #{hash}"
  end
end

fringe = Torrent.new(html_string)
# => #<TPB::Torrent title: 'Fringe Season 1', description: 'The complete season 1 of Fri...', imdb_id: 1119644>

fringe.some_calculated_method
# => "Fringe Season 1: B4C04A34DD8824C28E9A8A528"
```

## Contributing

If you've found a bug or have a question, please open an issue on the [issue tracker](https://github.com/jassa/hyper_api/issues). Or, clone the HyperAPI repository, write a failing test case, fix the bug, and submit a pull request.

## Version History

**0.1.1** (Feb 17, 2014)

* Allow empty values for attributes when not found in HTML source.

**0.1.0** (Feb 16, 2014)

* Initial public release.

## License

Copyright &copy; 2014 Javier Saldana

Released under the MIT license. See [`LICENSE`](LICENSE) for details.
