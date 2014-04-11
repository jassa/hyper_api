require 'spec_helper'

describe HyperAPI do

  describe '.new_class' do
    it 'inherits HyperAPI::Base' do
      foo = HyperAPI.new_class
      expect(foo.superclass).to eq(HyperAPI::Base)
    end
  end

  it 'loads attributes from html string' do
    person = HyperAPI.new_class do
      string name: 'div#name'
      integer imdb_id: '//div[@id="imdb"]'
    end

    bob = person.new('<div id="name">Bob</div><div id="imdb">111999</div>')

    expect(bob.name).to eq('Bob')
    expect(bob.imdb_id).to eq(111999)
  end

  it 'takes a block to extract complex attributes' do
    SomeLinksClass = HyperAPI.new_class do
      string google_url: 'a' do
        first.attribute('href').text
      end

      string facebook_url: '//a[2]' do
        attribute('href').text
      end
    end

    some_links = SomeLinksClass.new('<a href="http://google.com">Google</a>' +
      '<a href="http://facebook.com">Facebook</a>')

    expect(some_links.google_url).to eq('http://google.com')
    expect(some_links.facebook_url).to eq('http://facebook.com')
  end

  it 'supports custom methods' do
    class Person < HyperAPI::Base
      integer imdb_id: 'div#imdb'
      string name: '//div[@id="name"]'
      string url: 'a' do
        attribute('href').value
      end

      def some_method
        "#{name}: #{url}"
      end
    end

    b = '<div id="name">B</div><div id="imdb">1</div><a href="http://google.com">G</a>'
    bob = Person.new(b)

    expect(bob.name).to eq('B')
    expect(bob.url).to eq('http://google.com')
    expect(bob.imdb_id).to eq(1)
    expect(bob.some_method).to eq('B: http://google.com')
  end

end
