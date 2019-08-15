# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


require "database_cleaner"
DatabaseCleaner.strategy = :truncation
DatabaseCleaner.clean
User.delete_all
Playlist.delete_all
Listing.delete_all
Like.delete_all
Dislike.delete_all

User.create(email: "ross@hotmail.com", password: "123456")
User.create(email: "pedro@hotmail.com", password: "123456")

genres= ["Blues" ,"Classical","Country", "Electronic", "Folk","Jazz" ,"New age", "Reggae", "Rock", "Metal", "Other"]

20.times do
  Playlist.create(
    name: "Music to " + Faker::Verb.base + " to",
    description: "#{Faker::Markdown.emphasis}",
    party: [true, false].sample(),
    genre: genres.sample(),
    user_id: User.all.sample().id,
  )
end

songs = ["https://www.youtube.com/watch?v=f8aT9oRp95A&t=105s", "https://www.youtube.com/watch?v=f4RVAct8ZDo", "https://www.youtube.com/watch?v=R2F_hGwD26g", "https://www.youtube.com/watch?v=8jzDnsjYv9A"]



i = 0
20.times do
  playlist_id = Playlist.all[i].id
  i += 1
  x = 0
  10.times do
    Listing.create(
      playlist_id: playlist_id,
      url: songs.sample(),
      suggestion: [true, false].sample(),
      position: x,
      name: Faker::Music::GratefulDead.song,
    )
    x += 1
  end
end

1000.times do
  Like.create(listing_id: Listing.all.sample().id, user_id: User.all.sample().id)
end
500.times do
  Dislike.create(listing_id: Listing.all.sample().id, user_id: User.all.sample().id)
end
