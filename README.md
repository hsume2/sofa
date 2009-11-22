# Sofa

A simple Ruby library for the TVRage API (viewable [here](http://services.tvrage.com/index.php?page=public)).

## Shows

    Sofa::TVRage::Show.by_name("Chuck")    # => #<Sofa::TVRage::Show:0x101360d38 @name="Chuck", @show_id="15614", ...>
    OR
    show = Sofa::TVRage::Show.new("15614") # => #<Sofa::TVRage::Show:0x1012ec3c0 @name="Chuck", @show_id="15614", ...>

#### Eager loading Season and Episode info

    Sofa::TVRage::Show.by_name("Chuck", :greedy => true)
    Sofa::TVRage::Show.new("15614", :greedy => true)

#### Attributes

    show.show_id        # => "15614"
    show.name           # => "Chuck"
    show.show_link      # => "http://tvrage.com/Chuck"
    show.started        # => "2007"
    show.network        # => "NBC"
    show.air_time       # => "20:00"
    show.time_zone      # => "GMT-5 -DST"
    show.run_time       # => "60"
    show.origin_country # => "US"
    show.air_day        # => "Monday"
    show.ended          # => nil
    show.classification # => "Scripted"
    show.seasons        # => "3"
    show.start_date     # => "Sep/24/2007"
    show.status         # => "Returning Series"
    show.genres         # => ["Action", "Comedy", "Drama"]
    show.akas           # => "Chuck"

## Seasons

    show.season_list                # => [#<Sofa::TVRage::Season:0x1022d0f98 @no="1", @episodes=[...]>, 
                                          #<Sofa::TVRage::Season:0x1022c88c0 @no="2", @episodes=[...]>, 
                                          ...]
    season = show.season_list.first # => #<Sofa::TVRage::Season:0x1022d0f98 @no="1", @episodes=[...]>

#### Attributes

    season.episodes                 # => [#<Sofa::TVRage::Episode:0x1022d07a0 @title="Pilot", ...>,
                                          #<Sofa::TVRage::Episode:0x1022cf148 @title="Chuck Versus the Helicopter", ...>,
                                          ...]
    season.no                       # => "1"

## Episodes

    show.episode_list                 # => [#<Sofa::TVRage::Episode:0x1022d07a0 @title="Pilot", ...>,
                                            #<Sofa::TVRage::Episode:0x1022cf148 @title="Chuck Versus the Helicopter", ...>,
                                            ...]
    episode = show.episode_list.first # => #<Sofa::TVRage::Episode:0x1022d07a0 @title="Pilot", ...> 

#### Attributes

    episode.title         # => "Pilot"
    episode.air_date      # => "2007-09-24"
    episode.num_in_season # => "01"
    episode.num           # => "1"
    episode.prod_num      # => "101"
    episode.link          # => "http://www.tvrage.com/Chuck/episodes/579282"

## Contributing
 
* Feel free to send feature/pull requests.

## Copyright

Copyright (c) 2009 Henry Hsu. See LICENSE for details.
