require 'pry'
class MusicLibraryController

  attr_accessor :path

  def initialize(path='./db/mp3s')
    @path = path
    MusicImporter.new(path).import
  end

  def call
    input = ""
    while input != "exit"
      puts "Welcome to your music library!"
      puts "To list all of your songs, enter 'list songs'."
      puts "To list all of the artists in your library, enter 'list artists'."
      puts "To list all of the genres in your library, enter 'list genres'."
      puts "To list all of the songs by a particular artist, enter 'list artist'."
      puts "To list all of the songs of a particular genre, enter 'list genre'."
      puts "To play a song, enter 'play song'."
      puts "To quit, type 'exit'."
      puts "What would you like to do?"
   

    input = gets.chomp

      case input
      when "list songs"
        list_songs
      when "list artists"
        list_artists
      when "list genres"
        list_genres
      when "list artist"
        list_songs_by_artist
      when "list genre"
        list_songs_by_genre
      when "play song"
        play_song
      end
    end
  end

  def list_songs
    Song.all.sort_by{|song| song.name}.each.with_index(1) do |song, i|
      puts "#{i}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
    end

    #"1. Thundercat - For Love I Come - dance"
  end

  def list_artists
    Artist.all.sort_by{|artist| artist.name}.uniq.each.with_index(1) do |artist, i|
      puts "#{i}. #{artist.name}"
    end
  end

  def list_genres
    Genre.all.sort_by{|genre| genre.name}.uniq.each.with_index(1) do |genre, i|
      puts "#{i}. #{genre.name}"
    end
  end

  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    input = gets.chomp
    artist = Artist.find_by_name(input)
    if !artist.nil?
      artist.songs.sort_by{|song| song.name}.each.with_index(1) do |song, i|
        puts "#{i}. #{song.name} - #{song.genre.name}"
      end
    end

    def list_songs_by_genre
      puts "Please enter the name of a genre:"
      input = gets.chomp
      if genre = Genre.find_by_name(input)
        sorted_songs = genre.songs.sort_by {|s| s.name}
        sorted_songs.each.with_index(1) {|s, i| puts "#{i}. #{s.artist.name} - #{s.name}"}
      end
    end

    def play_song
      puts "Which song number would you like to play?"
      input = gets.chomp.to_i
      if input >= 1 && input <= Song.all.size
        selection = Song.all.sort_by {|s| s.name}[input -= 1]
        puts "Playing #{selection.name} by #{selection.artist.name}" if selection
      end
    end
  end
end 
 
