module Seed
  def self.run
    10.times do
      game = Game.new
      rand(2..7).times do
        game.players << Player.create(name: Faker::Name.first_name)
      end
      sesh = game.player_sessions.sample
      sesh.update_attribute("player_won", true)
      game.save
    end
  end
end