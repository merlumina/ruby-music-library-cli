require 'pry'

class Song
    extend Concerns::Findable

    attr_accessor :name
    attr_reader :artist, :genre
    @@all = []

    def initialize(name, artist = nil, genre = nil)
        @name = name
        self.artist = artist unless artist == nil
        self.genre = genre unless genre == nil
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
        new_instance = Song.new(name)
        # binding.pry
        new_instance.save
        new_instance
    end

    def artist=(artist)
        @artist = artist
        artist.add_song(self)
    end

    def genre=(genre)
        @genre = genre
        genre.add_song(self)
    end

    def self.new_from_filename(filename)
        parsed_filename = filename.split(" - ")
        artist_name, song_name, genre_name = parsed_filename[0], parsed_filename[1], parsed_filename[2].gsub(".mp3", "")
        artist = Artist.find_or_create_by_name(artist_name)
        genre = Genre.find_or_create_by_name(genre_name)

        Song.new(song_name, artist, genre)
    end

    def self.create_from_filename(filename)
        new_from_filename(filename).tap {|song| song.save}
    end

end