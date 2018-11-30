NarrativeActions.new(:incident_at_centre) do
  grammar = Calyx::Grammar.new do
    start "{intro}\n\n{computing}\n\n{problem}"
    intro "{scene}. {arrival}. {called}."
    scene "{computer} is housed {on_floors} of a {building_desc}"
    on_floors "across two floors", "on every floor"
    building_desc "{building_adj} {building_noun} in {building_loc}, {concrete}"
    building_adj "dreary grey", "spare grey"
    building_noun "tower", "tower block", "building"
    building_loc "the Hutt Valley suburbs", "central Porirua"
    concrete "its concrete stippled {standard}"
    standard "to the Ministry of Works standard", "according to Ministry of Works specifications"
    arrival "{technician} waits in the foyer below {interior}"
    interior "{$interior_detail} and {$interior_detail}"
    interior_detail "elevated wooden beams", "an enormous acrylic painting of a woman leaping across a landscape", "a row of Tukutuku panels"
    called "He’s soon called in, passing through locked doors and security screens to the control room deep in the {heart} of the building, with the machinery of {computer} surrounding him on all sides"
    heart "bowels", "heart"
    problem "{still_running}. {spooling}."
    still_running "The system is still running. He had expected silence but instead, {hundreds} of {sounds} {overlap}: {list_of_sounds}"
    system "system", "mainframe", "giant computer"
    hundreds "hundreds", "a cacophony"
    sounds "layered sounds", "distinct sounds"
    overlap "overlap", "swirl and clash", "compete for attention"
    list_of_sounds "{$sound}, {$sound} and {$sound}"
    sound "{@tapes_adj} magnetic tapes", "the {@fans_adj} cooling fans", "{@relays_adj} power relays", "the {@cards_adj} of punch card readers"
    tapes_adj "spinning", "whirring"
    fans_adj "roaring of", "rushing air from the"
    relays_adj "rasping", "buzzing"
    cards_adj "frenzied clattering", "frenetic rattle"
    spooling "And rising above it all is the screaming, grinding printer spool. This is it. This is what they wanted him to see"
    computing "{computing_1} {chaotic_thoughts} {computing_2}"
    chaotic_thoughts Corpora.pulp.generate
    computing_1 Corpora.computing.generate
    computing_2 Corpora.computing.generate
  end
  grammar.generate(StoryEntities.map)
end
