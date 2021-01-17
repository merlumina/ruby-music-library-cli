require 'pry'

class Genre
    extend Concerns::Findable

    attr_accessor :name, :songs
    @@all = []

    def initialize(name)
        @name = name
        @songs = []
    end

    def save
        @@all << self
    end

    def self.all
        @@all
    end

    def self.destroy_all
        @@all.clear
    end

    def self.create(name)
        new_instance = Genre.new(name)
        # binding.pry
        new_instance.save
        new_instance
    end

    def add_song(song)
        song.genre = self if song.genre == nil
        songs << song unless songs.include?(song)
    end

    def artists
        genres_artist = songs.collect {|s| s.artist}
        genres_artist.uniq
    end

end