class InsertDefaultAttractions < ActiveRecord::Migration

  def up
    Attraction.create(:name => "Magic Mountain", :opened_from => 12)
    Attraction.create(:name => "Ramses", :opened_from => 11)
    Attraction.create(:name => "Sequoia Adventure", :opened_from => 11)
    Attraction.create(:name => "Mammut", :opened_from => 10)
    Attraction.create(:name => "Jungle Rapids", :opened_from => 10)
    Attraction.create(:name => "Raptor", :opened_from => 10)
    Attraction.create(:name => "Ortobruco Tour", :opened_from => 12)
    Attraction.create(:name => "Blue Tornado", :opened_from => 10)
    Attraction.create(:name => "Fuga da Atlantide", :opened_from => 10)
    Attraction.create(:name => "Magic House", :opened_from => 10)
    Attraction.create(:name => "Volaplano", :opened_from => 10)
    Attraction.create(:name => "Colorado Boat", :opened_from => 11)
    Attraction.create(:name => "Oblivion", :opened_from => 10)
  end

  def down
    Attraction.destroy_all
  end

end
