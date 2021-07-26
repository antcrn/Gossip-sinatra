require 'bundler'
Bundler.require

class Gossip
    attr_accessor :id, :author, :content
    def initialize(id, author, content)
        @id = id
        @content = content
        @author = author
    end

        
    def save
        CSV.open("db/gossip.csv", 'a+') do |csv|
            csv << [@id, @content, @author]
        end
    end

    def self.all
        all_gossips = []
        file = CSV.read("db/gossip.csv", converters: :all)
        file.each do |gossip|
            all_gossips << Gossip.new(gossip[0],gossip[1], gossip[2])
        end
        return all_gossips
    end

    def self.find(id)
        gossips = []  
          CSV.read("./db/gossip.csv").each_with_index do |gossip, index|
          if (id == index+1)  
            gossips << Gossip.new(gossip[0], gossip[1],gossip[2])
            break
              end
            end
            return gossips
        end

    def self.delete(id)
       all_gossips = self.all
       CSV.open("db/gossip.csv", "w") { |csv| all_gossips.each { |gossip| gossip.save unless gossip.id == (id-1)}}
    end

    def self.update(id, content, author)
        id -=1
        all_gossips = self.all
        all_gossips[id].content= content
        all_gossips[id].author=author
        CSV.open("db/gossip.csv", "w") { |csv| all_gossips.each { |gossip| gossip.save }}
    end
end
