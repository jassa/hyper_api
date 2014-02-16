require 'spec_helper'

describe HyperAPI do

  describe '.new_class' do
    it 'inherits HyperAPI::Base' do
      foo = HyperAPI.new_class
      expect(foo.superclass).to eq(HyperAPI::Base)
    end
  end

  it 'loads attributes from html string'do
    person = HyperAPI.new_class do
      string name: 'div#name'
      integer imdb_id: 'div#imdb'
    end

    bob = person.new('<div id="name">Bob</div><div id="imdb">111999</div>')

    expect(bob.name).to eq('Bob')
    expect(bob.imdb_id).to eq(111999)
  end

  it 'takes a block to extract complex attributes' do
    SomeLinkClass = HyperAPI.new_class do
      string url: 'a' do
        attribute('href').text
      end
    end

    google = SomeLinkClass.new('<a href="http://google.com">Google</a>')

    expect(google.url).to eq('http://google.com')
  end

  it 'supports custom classes' do
    class Person < HyperAPI::Base
      integer imdb_id: 'div#imdb'
      string name: 'div#name'
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
