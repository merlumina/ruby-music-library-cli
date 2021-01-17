require 'pry'

class Artist
    extend Concerns::Findable

    attr_accessor :name, :genres
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
        new_instance = Artist.new(name)
        # binding.pry
        new_instance.save
        new_instance
    end

    def songs
        @songs
    end

    def add_song(song)
        song.artist = self if song.artist == nil
        songs << song unless songs.include?(song)
    end

    def genres
        artists_genre = songs.collect {|s| s.genre}
        artists_genre.uniq
    end

end