Idrinth = {};
Idrinth.activeRounds = 0;
Idrinth.battlesFought = 0;
Idrinth.charactersAssassinated = 0;
Idrinth._dilemmaCooldown = 0;
Idrinth._dilemmaCooldownMode = "medium";
Idrinth._godBlessedItemRequirements = "normal";
Idrinth._characterPanelOpen = false;
Idrinth._names = {
    "Eva",
    "Plyitus",
    "Hagrene",
    "Altharloss",
    "Millen",
    "Sheeld",
    "Venola",
    "Myleere",
    "Kavinna",
    "Fonahir",
    "Waerna",
    "Hulaylian",
    "Felicion",
    "Deloria",
    "Rinda",
    "Alarion",
    "Nasheer",
    "Boudicca",
    "Nightshade",
    "Caladrielle",
    "Sandrina",
    "Enna",
    "Koval",
    "Eldarion",
    "Zubaran",
    "Lorishion",
    "Vayeana",
    "Anarsis",
    "Fernhavest",
    "Saji",
    "Avelorrisas",
    "Kerthinia",
    "Hulaylian",
    "Mantressa",
    "Damien",
    "Myriel",
    "Ramon",
    "Grimziyal",
    "Qintarra",
    "Rethia",
    "Jildou",
    "Bequish",
    "Alondrin",
    "Busscrone",
    "Circya",
    "Ruybiniss",
    "Ylrishen",
    "Morgan",
    "Orilon",
    "Maewhyn",
    "Jayadress",
    "Azirek",
    "Caladrielle",
    "Avelorrisas",
    "Arwenil",
    "Kelici",
    "Elysion",
    "Caydrille",
    "Aeden",
    "Bel-Nenya",
    "Ilona",
    "Elektra",
    "Klendrach",
    "Yr-Kithar",
    "Maudthekan",
    "Elise",
    "Elladan",
    "Hellespher",
    "Fhiron",
    "Relinda",
    "Lorna",
    "Lorelai",
    "Illiarch",
    "Zoltar",
    "Elladan",
    "R'Mal",
    "Lothiul",
    "Gynnash",
    "Velal",
    "Waerna",
    "Azalgorm",
    "Jayadress",
    "Laya-Quinn",
    "Tharket",
    "Ravena",
    "Kilana",
    "Senga",
    "Alizeabeth",
    "Ophillien",
    "Fandhir",
    "Bochra",
    "Omarin",
    "Jornadar",
    "Hextarian",
    "Baine",
    "Velitroth",
    "Felindre",
    "Darfayan",
    "Caydrille",
    "Lothiul",
    "Trillian",
    "Nadraxes",
    "Krogh",
    "Liandra",
    "Parthok",
    "Fortiunis",
    "Lucius",
    "Nathalia",
    "Scorpia",
    "Sabetha",
    "Velicion",
    "Feretulios",
    "Movar",
    "Lolillian",
    "Sheelda",
    "Larian",
    "Pokol-Daka",
    "Laya-Quinn",
    "Jeshia",
    "Jadus",
    "Bel-Harathoi",
    "Velissan",
    "Elliranion",
    "Noegh",
    "Koren-Bahnir",
    "Myrielh",
    "Bel-Sarathai",
    "Kerthinia",
    "Astralla",
    "Menlui-Akar",
    "Argyle",
    "Rautha",
    "Mara",
    "Vanquissh",
    "Cython-Yrel",
    "Hyther",
    "Espellba",
    "Astikar",
    "Driellen",
    "Larian",
    "Prenticly",
    "Westara",
    "Artheus",
    "Rethia",
    "Elreth",
    "Obarmon",
    "Mlendei",
    "Lolillian",
    "Kjeldilon",
    "Rhodar",
    "Sammith",
    "Chechemon",
    "Veraunn",
    "Kerestra",
    "Feniaor",
    "Najjirah",
    "Solkar",
    "Marinh",
    "Aurelius",
    "Wonellinrei",
    "Exarian",
    "Bel-Amy",
    "Fayza",
    "Trillian",
    "Rhama",
    "Omnombah",
    "Murella",
    "Lorishion",
    "Yorian",
    "Lorienne",
    "Zilnilon",
    "Gwendolyn",
    "Bel-Lecai",
    "Fydhion",
    "Elliranion",
    "Prenticly",
    "Tamarith",
    "Eville-Lyn",
    "Sethera",
    "Byre'chull",
    "Selveth",
    "Exarian",
    "Zoram",
    "Yastra",
    "Feniaor",
    "Teneska",
    "Rakal",
    "Polkesha",
    "Teneska",
    "Moransti",
    "Hellinor",
    "Mordis",
    "Yasmijn",
    "Gendalfa",
    "Sakonna",
    "Arden",
    "Ditharastara",
    "Ellendeling",
    "Morlanna",
    "Tevaril",
    "Delynna",
    "Evelyne",
    "Yavandir",
    "Thalos",
    "Arduval",
    "Amendil",
    "Ingmir",
    "Torendil",
    "Yssellal",
    "Tralan",
    "Aesrit",
    "Urdithane",
    "Strathot",
    "Dolwen",
    "Elror",
    "Dodan",
    "Dhulas",
    "Acca",
    "Dottaen",
    "Toltirin",
    "Tala",
    "Agnor",
    "Rana",
    "Vilgin",
    "Gilgalion",
    "Luren",
    "Dalos",
    "Harrond",
    "Tuduthus",
    "Circo",
    "Camring",
    "Kholis",
    "Duluric",
    "Amhas",
    "Alu",
    "Silontol",
    "Isrostot",
    "Narien",
    "Olanis",
    "Ingmir",
    "Singal",
    "Orliaruth",
    "Dhanas",
    "Valahuir",
    "Mylnel",
    "Dhehen",
    "Urdithane",
    "Foros",
    "Felnylsal",
    "Attodaeth",
    "Belaeg",
    "Ara",
    "Othiodi",
    "Catra",
    "Zaltothios",
    "Ikirin",
    "Varcio",
    "Straslaeth",
    "Iscuraa",
    "Thilvokkas",
    "Daertoc",
    "Otrolio",
    "Iarac",
    "Dhada",
    "Dhalsyth",
    "Sesteshal",
    "Selafyn",
    "Finreir",
    "Anaryll",
    "Eldril",
    "Aethis",
    "Harathrel",
    "Arandir",
    "Argalen",
    "Moranion",
    "Ferghal",
    "Antheus",
    "Inrion",
    "Hallar",
    "Cireon",
    "Erethond",
    "Eldarain",
    "Aethenor",
    "Aramir",
    "Cerion",
    "Melanar",
    "Anurell",
    "Thaindor",
    "Illidial",
    "Elon",
    "Sulphunet",
    "Kurl",
    "Vraneth",
    "Galroth",
    "Asperon",
    "Tuern",
    "Corvass",
    "Ruerl",
    "Hargan",
    "Aillion",
    "Gandrell",
    "Urian",
    "Maglan",
    "Dranack",
    "Delekth",
    "Yeurl",
    "Kaleth",
    "Khalek",
    "Girathon",
    "Girathon",
    "Furion",
    "Korhedron",
    "Khalin",
    "Ribath",
    "Sihori",
    "Sareth",
    "Vashas",
    "Lorsitel",
    "Locehon",
    "Arathar",
    "Akhaunet",
    "Velavith",
    "Sabichal",
    "Cagherosh",
    "Mittarah",
    "Virlorel",
    "Tarrerrosh",
    "Thoshelre",
    "Cirsis",
    "Cerirreh",
    "Sokhos",
    "Maveh",
    "Feisha",
    "Fecha",
    "Lecelne",
    "Hohha",
    "Cesirnoh",
    "Corvishish",
    "Massighah",
    "Merosha",
    "Hacaggil",
    "Resara",
    "Neheth",
    "Ravares",
    "Volilosh",
    "Zeloran",
    "Shakkara",
    "Shakkara",
    "Nelosi",
    "Tholre'kai",
    "Rervetoh",
    "Kakaukin",
    "Sothartah",
    "Tothauthrak",
    "Cekhullil",
    "Danoth",
    "Nocrusith",
    "Vukathan",
    "Vegmorlus",
    "Wirtha",
    "Veri'kath",
    "Khalgughun",
    "Decun'kar",
    "Tallirmoth",
    "Tehechish",
    "Werrora",
    "Calnatoth",
    "Bel-Edhanel",
    "Enthaal",
    "Zaathos",
    "Thanlutlin",
    "Deralac",
    "Dydrarus",
    "Bel-Harthur",
    "Gondil",
    "Tharhindrel",
    "Halithyar",
    "Bel-Aethlec",
    "Feyadyin",
    "Miradrin",
    "Assagiere",
    "Illenyadara",
    "Einnilize",
    "Haerrieth",
    "Licumoitta",
    "Agiella",
    "Sophiridrin",
    "Adagia",
    "Itilnae",
    "Hemmara",
    "Haennirmara",
    "Nashanra",
    "Litania",
    "Vanya",
    "Alyssa",
    "Nonens",
    "Nonus",
    "Moksha",
    "Maledicta",
    "Tilly",
    "Taira",
    "Armandis",
    "Azuma",
    "Bael'Sammon",
    "Galag",
    "Weylyn",
    "Melwin",
    "Vera",
    "Amon",
    "Sabioth",
    "Rowan",
    "Gaion",
    "Maktig",
    "Noriv",
    "Mehri",
    "Eydis",
    "Cylas",
    "Gwyndion",
    "Rodir",
    "Kychte",
    "Mychaela",
    "Azriel",
    "Maeron",
    "Shanahan",
    "Thovar",
    "Serra",
    "Leander",
    "Taodin",
    "Aphazel",
    "Aesllanan",
    "Iolair",
    "Tallanquine",
    "Aratt",
    "Arathalle",
    "Arathion",
    "Arhalien",
    "Astra",
    "Anwesu",
    "Banadl",
    "Eliandr",
    "Cuolsh",
    "Bel-Eshain",
    "Darsis",
    "Cynaeaf",
    "Delzus",
    "Tarnig",
    "Fiarel",
    "Fildrigar",
    "Gemariel",
    "Herisan",
    "Eponandilas",
    "Korhian",
    "Loth",
    "Sullandiel",
    "Siaisullainn",
    "Larithiriel",
    "Sikariel",
    "Yrtle",
    "Malmir",
    "Yavathol",
    "Valnal",
    "Valahuir",
    "Valin",
    "Halin",
    "Curufor",
    "Valanduil",
    "Gloringwe",
    "Balthinal",
    "Murdredesa",
    "Ghyrohus",
    "Orinon",
    "Morgula",
    "Merel",
    "Olana",
    "Hultressa",
    "Ceyl-Thakeya",
    "Yullin-Wen",
    "Tressa",
    "Kiriela",
    "Kyriela",
    "Saam",
    "Sharkia",
    "Wendrina",
    "Yenlui-Enyur",
    "Hordahn",
    "Mellindirei",
    "Rovaran",
    "Velissan",
    "Elemire",
    "Ophillien",
    "Yornh",
    "Syd",
    "Laurum",
    "Olfren",
    "Sadrina",
    "Gerzhin",
    "Ichinya",
    "Thina",
    "Yelgren",
    "Segales",
    "Tomalak",
    "Lautaro",
    "Tefari",
    "Bel-Eiline",
    "Yandis",
    "Yorian",
    "Ruybiniss",
    "Molgo",
    "Galdorian",
    "Hydrans",
    "Feretulios",
    "Arwenil",
    "Dorian",
    "Osydin",
    "Kyrian",
    "Jolandya",
    "Leech",
    "Rinmaud",
    "Fernhavest",
    "Alarion",
    "Couladin",
    "Aloisa",
    "Daeves",
    "Scarissa",
    "Edelia",
    "Izual",
    "Driellen",
    "Lovok",
    "Arspeth",
    "Deshenshar",
    "Danar",
    "Zenoria",
    "Jinquella",
    "Ilnyshon",
    "Theron",
    "Borath",
    "Ghyrohus",
    "Keevan",
    "Zamdilla",
    "Killian",
    "Barsathar",
    "Vespa",
    "Kuzu",
    "Jayden",
    "Karorn",
    "Mantressa",
    "Khalin",
    "Siamak",
    "Malarnur",
    "Cyruss",
    "Deloria",
    "Tifeon",
    "Amrifor",
    "Altharloss",
    "Luaran",
    "Scitilla",
    "Yurichmur",
    "Galathon",
    "Pardek",
    "Seraph",
    "Uriel",
    "Elena",
    "Vigilo"
};
Idrinth.place_of_interest = {
    drakenhof = {
        key = "idrinth_story_dilemma_drakenhof",
        triggered = false,
        region = "wh3_main_combi_region_castle_drakenhof"
    },
    temple_of_khaine = {
        key = "idrinth_story_dilemma_temple_of_khaine",
        triggered = false,
        region = "wh3_main_combi_region_temple_of_khaine"
    },
    shrine_of_khaine = {
        key = "idrinth_story_dilemma_shrine_of_khaine",
        triggered = false,
        region = "wh3_main_combi_region_shrine_of_khaine"
    },
    temple_of_asuryan = {
        key = "idrinth_story_dilemma_temple_of_asuryan",
        triggered = false,
        region = "wh3_main_combi_region_shrine_of_asuryan"
    },
    temple_of_kurnous = {
        key = "idrinth_story_dilemma_temple_of_kurnous",
        triggered = false,
        region = "wh3_main_combi_region_shrine_of_kurnous"
    },
    shrine_of_loec = {
        key = "idrinth_story_dilemma_shrine_of_loec",
        triggered = false,
        region = "wh3_main_combi_region_shrine_of_loec"
    },
    hel_fenn = {
        key = "idrinth_story_dilemma_hel_fenn",
        triggered = false,
        region = "wh3_main_combi_region_waldenhof"
    },
    black_pyramid = {
        key = "idrinth_story_dilemma_black_pyramid",
        triggered = false,
        region = "wh3_main_combi_region_black_pyramid_of_nagash"
    },
    vauls_anvil_ulthuan = {
        key = "idrinth_story_dilemma_vauls_anvil_ulthuan",
        triggered = false,
        region = "wh3_main_combi_region_vauls_anvil_ulthuan"
    },
    vauls_anvil_naggaroth = {
        key = "idrinth_story_dilemma_vauls_anvil_naggaroth",
        triggered = false,
        region = "wh3_main_combi_region_vauls_anvil_naggaroth"
    },
    vauls_anvil_loren = {
        key = "idrinth_story_dilemma_vauls_anvil_loren",
        triggered = false,
        region = "wh3_main_combi_region_vauls_anvil_loren"
    },
    tower_of_hoeth = {
        key = "idrinth_story_dilemma_tower_of_hoeth",
        triggered = false,
        region = "wh3_main_combi_region_white_tower_of_hoeth"
    },
    blood_keep = {
        key = "idrinth_story_dilemma_blood_keep",
        triggered = false,
        region = ""
    },
    oak_of_ages = {
        key = "idrinth_story_dilemma_oak_of_ages",
        triggered = false,
        region = "wh3_main_combi_region_the_oak_of_ages"
    },
    the_galleons_graveyard = {
        key = "idrinth_story_dilemma_the_galleons_graveyard",
        triggered = false,
        region = "wh3_main_combi_region_the_galleons_graveyard"
    },
    sartosa = {
        key = "idrinth_story_dilemma_sartosa",
        triggered = false,
        region = "wh3_main_combi_region_sartosa"
    },
    lahmia = {
        key = "idrinth_story_dilemma_lahmia",
        triggered = false,
        region = "wh3_main_combi_region_lahmia"
    },
    ghrond = {
        key = "idrinth_story_dilemma_ghrond",
        triggered = false,
        region = "wh3_main_combi_region_ghrond"
    }
};
Idrinth._self = nil;
Idrinth._lastSelectionAgent = nil;
Idrinth._levelAdjustment = {
    null = 0,
    one = 1,
    three = 3,
    six = 6
};
Idrinth.dilemmas = {
    high_elves = {
        min_rounds = 15,
        min_battles_fought = 10,
        min_assassinations = 0,
        min_level = 0,
        key = "idrinth_dilemma_high_elves",
        triggered = false,
        chance = 0.01,
        chances = {
            wh2_main_hef_high_elves = 0.5,
            wh_dlc05_wef_wood_elves = 0.3,
            wh_main_emp_empire = 0.15,
            wh3_main_ksl_kislev = 0.1,
            wh_main_vmp_vampire_counts = 0.05,
        }
    },
    wood_elves = {
        min_rounds = 15,
        min_battles_fought = 10,
        min_assassinations = 0,
        min_level = 0,
        key = "idrinth_dilemma_wood_elves",
        triggered = false,
        chance = 0.01,
        chances = {
            wh2_main_hef_high_elves = 0.3,
            wh_dlc05_wef_wood_elves = 0.5,
            wh_main_emp_empire = 0.15,
            wh3_main_ksl_kislev = 0.1,
            wh_main_vmp_vampire_counts = 0.05,
        }
    },
    kislev = {
        min_rounds = 15,
        min_battles_fought = 10,
        min_assassinations = 0,
        min_level = 0,
        key = "idrinth_dilemma_kislev",
        triggered = false,
        chance = 0.01,
        chances = {
            wh2_main_hef_high_elves = 0.1,
            wh_dlc05_wef_wood_elves = 0.05,
            wh_main_emp_empire = 0.3,
            wh3_main_ksl_kislev = 0.5,
            wh_main_vmp_vampire_counts = 0.15,
        }
    },
    empire = {
        min_rounds = 15,
        min_battles_fought = 10,
        min_assassinations = 0,
        min_level = 0,
        key = "idrinth_dilemma_empire",
        triggered = false,
        chance = 0.01,
        chances = {
            wh2_main_hef_high_elves = 0.1,
            wh_dlc05_wef_wood_elves = 0.05,
            wh_main_emp_empire = 0.5,
            wh3_main_ksl_kislev = 0.3,
            wh_main_vmp_vampire_counts = 0.15,
        }
    },
    vampire_counts = {
        min_rounds = 15,
        min_battles_fought = 10,
        min_assassinations = 0,
        min_level = 0,
        key = "idrinth_dilemma_vampire_counts",
        triggered = false,
        chance = 0.01,
        chances = {
            wh2_main_hef_high_elves = 0.1,
            wh_dlc05_wef_wood_elves = 0.05,
            wh_main_emp_empire = 0.3,
            wh3_main_ksl_kislev = 0.15,
            wh_main_vmp_vampire_counts = 0.5,
        }
    },
    dwarves = {
        min_rounds = 20,
        min_battles_fought = 10,
        min_assassinations = 0,
        min_level = 0,
        key = "idrinth_dilemma_dwarves",
        triggered = false,
        chance = 0.01,
        chances = {
            wh2_main_hef_high_elves = 0.15,
            wh_dlc05_wef_wood_elves = 0.15,
            wh_main_emp_empire = 0.25,
            wh3_main_ksl_kislev = 0.2,
            wh_main_vmp_vampire_counts = 0.1,
        }
    }
};
Idrinth._item_dilemmas = {
    weapon = {
        min_battles_fought = 0,
        min_assassinations = 9,
        min_level = 0,
        key = "idrinth_dilemma_weapon",
        triggered = false,
    },
    armour = {
        min_battles_fought = 15,
        min_assassinations = 0,
        min_level = 0,
        key = "idrinth_dilemma_armour",
        triggered = false,
    },
    talisman = {
        min_battles_fought = 0,
        min_assassinations = 0,
        min_level = 15,
        key = "idrinth_dilemma_talisman",
        triggered = false,
    }
};
Idrinth._godFavourDilemmas = {
    khaine_large = {
        khaine = 300,
        kurnous = 0,
        asuryan = 0,
        effect = "idrinth_dilemma_god_favour_khaine_large",
        duration = 15,
        cooldown = 0,
        maxCooldown = 25,
    },
    kurnous_large = {
        khaine = 0,
        kurnous = 300,
        asuryan = 0,
        effect = "idrinth_dilemma_god_favour_kurnous_large",
        duration = 15,
        cooldown = 0,
        maxCooldown = 25,
    },
    asuryan_large = {
        khaine = 0,
        kurnous = 0,
        asuryan = 300,
        effect = "idrinth_dilemma_god_favour_asuryan_large",
        duration = 15,
        cooldown = 0,
        maxCooldown = 25,
    },
    khaine_medium = {
        khaine = 200,
        kurnous = 0,
        asuryan = 0,
        effect = "idrinth_dilemma_god_favour_khaine_medium",
        duration = 10,
        cooldown = 0,
        maxCooldown = 17,
    },
    kurnous_medium = {
        khaine = 0,
        kurnous = 200,
        asuryan = 0,
        effect = "idrinth_dilemma_god_favour_kurnous_medium",
        duration = 10,
        cooldown = 0,
        maxCooldown = 17,
    },
    asuryan_medium = {
        khaine = 0,
        kurnous = 0,
        asuryan = 200,
        effect = "idrinth_dilemma_god_favour_asuryan_medium",
        duration = 10,
        cooldown = 0,
        maxCooldown = 17,
    },
    khaine_small = {
        khaine = 100,
        kurnous = 0,
        asuryan = 0,
        effect = "idrinth_dilemma_god_favour_khaine_small",
        duration = 5,
        cooldown = 0,
        maxCooldown = 10,
    },
    kurnous_small = {
        khaine = 0,
        kurnous = 100,
        asuryan = 0,
        effect = "idrinth_dilemma_god_favour_kurnous_small",
        duration = 5,
        cooldown = 0,
        maxCooldown = 10,
    },
    asuryan_small = {
        khaine = 0,
        kurnous = 0,
        asuryan = 100,
        effect = "idrinth_dilemma_god_favour_asuryan_small",
        duration = 5,
        cooldown = 0,
        maxCooldown = 10,
    },
};
Idrinth._uniqueAncillaries = {
    "idrinth_anc_talisman_stone_of_dried_blood",
    "idrinth_anc_talisman_talisman_of_souls",
    "idrinth_anc_talisman_forest_berry_wine",
    "idrinth_anc_weapon_kurnous_blessed_hunting_bow",
    "idrinth_anc_armour_khaines_visage",
    "idrinth_anc_weapon_khaines_thirsting_sword",
    "idrinth_anc_weapon_asuryans_perfection_sword",
    "idrinth_anc_armour_kurnous_forest_cloak",
    "idrinth_anc_armour_asuryans_destiny"
};
Idrinth._unlockMissions = {
    ["wh2_main_hef_high_elves"] = "idrinth_unlock_wh2_main_hef_high_elves",
    ["wh_main_vmp_vampire_counts"] = "idrinth_unlock_wh_main_vmp_vampire_counts",
    ["wh_main_emp_empire"] = "idrinth_unlock_wh_main_emp_empire",
    ["wh_dlc05_wef_wood_elves"] = "idrinth_unlock_wh_dlc05_wef_wood_elves",
    ["wh3_main_ksl_kislev"] = "idrinth_unlock_wh3_main_ksl_kislev",

    ["mixer_nag_nagash"] = "idrinth_unlock_mixer_nag_nagash",
    ["wh2_main_def_dark_elves"] = "idrinth_unlock_wh2_main_def_dark_elves",
    ["wh2_dlc11_cst_vampire_coast"] = "idrinth_unlock_wh2_dlc11_cst_vampire_coast",
    ["wh_main_brt_bretonnia"] = "idrinth_unlock_wh_main_brt_bretonnia",
    ["wh3_main_cth_cathay"] = "idrinth_unlock_wh3_main_cth_cathay",
};
Idrinth._unlockAIRank = {
    ["wh2_main_hef_high_elves"] = 21,
    ["wh_main_vmp_vampire_counts"] = 26,
    ["wh_main_emp_empire"] = 23,
    ["wh_dlc05_wef_wood_elves"] = 20,
    ["wh3_main_ksl_kislev"] = 22,

    ["mixer_nag_nagash"] = 29,
    ["wh2_main_def_dark_elves"] = 24,
    ["wh2_dlc11_cst_vampire_coast"] = 27,
    ["wh_main_brt_bretonnia"] = 25,
    ["wh3_main_cth_cathay"] = 28,
};
Idrinth._unlockDilemma = "idrinth_unlock_choice";
Idrinth._unlockDilemmas = {
    ["wh2_main_hef_high_elves"] = "idrinth_dilemma_unlock_high_elves",
    ["wh_main_vmp_vampire_counts"] = "idrinth_dilemma_unlock_vampire_counts",
    ["wh_main_emp_empire"] = "idrinth_dilemma_unlock_empire",
    ["wh_dlc05_wef_wood_elves"] = "idrinth_dilemma_unlock_wood_elves",
    ["wh3_main_ksl_kislev"] = "idrinth_dilemma_unlock_kislev",

    ["mixer_nag_nagash"] = "idrinth_dilemma_unlock_nagash",
    ["wh2_main_def_dark_elves"] = "idrinth_dilemma_unlock_dark_elves",
    ["wh2_dlc11_cst_vampire_coast"] = "idrinth_dilemma_unlock_vampire_coast",
    ["wh_main_brt_bretonnia"] = "idrinth_dilemma_unlock_bretonnia",
    ["wh3_main_cth_cathay"] = "idrinth_dilemma_unlock_cathay",
};
Idrinth._faction = nil;
Idrinth._idrinth = nil;
Idrinth._type = "champion";
Idrinth._type2 = "general";
Idrinth._culture = nil;
Idrinth._subtype = "idrinth_hev_high_elf_vampires_idrinth";
Idrinth._cultures = {
    "wh2_main_hef_high_elves",
    "wh3_main_ksl_kislev",
    "wh_main_emp_empire",
    "wh_main_vmp_vampire_counts",
    "wh_dlc05_wef_wood_elves",
};
Idrinth._expandedCultures = {
    "mixer_nag_nagash",
    "wh2_main_def_dark_elves",
    "wh2_dlc11_cst_vampire_coast",
    "wh_main_brt_bretonnia",
    "wh3_main_cth_cathay"
};
Idrinth._unlockLevelAdjustment = nil;
Idrinth._expandedCulturesActive = nil;
Idrinth._unlockLevelAdjustmentDilemma = "idrinth_levelMinimum_choice";
Idrinth._enableChapelsDilemma = "idrinth_chapels_choice";
Idrinth._enableStoryMissionsDilemma = "idrinth_story_choice";
Idrinth._unlockMissionStarted = {};
Idrinth._enableChapels = nil;
Idrinth._enableStoryEvents = nil;
Idrinth.currentVersion = {
    main = 1,
    feature = 0,
    bug = 0,
};
Idrinth._hasModConfig = false;
Idrinth._unlockInstantly = (common.filesystem_lookup("/script/", "enable_idrinth_instant") ~= "");
Idrinth.get = function()
    for pos0, culture in pairs(Idrinth._cultures) do
        local factions = cm:get_factions_by_culture(culture);
        if factions then
            for pos, faction in pairs(factions) do
                local idrinth = cm:get_most_recently_created_character_of_type(faction:name(), Idrinth._type, Idrinth._subtype .. Idrinth._type);
                if idrinth then
                    Idrinth._idrinth = idrinth;
                    Idrinth._faction = faction;
                    Idrinth._culture = culture;
                    return idrinth, faction, culture;
                end;
            end;
        end;
    end;
    for pos0, culture in pairs(Idrinth._cultures) do 
        local factions = cm:get_factions_by_culture(culture);
        if factions then
            for pos, faction in pairs(factions) do
                local idrinth = cm:get_most_recently_created_character_of_type(faction:name(), Idrinth._type2, Idrinth._subtype .. Idrinth._type2);
                if idrinth then
                    Idrinth._idrinth = idrinth;
                    Idrinth._faction = faction;
                    Idrinth._culture = culture;
                    return idrinth, faction, culture;
                end;
            end;
        end;
    end;
    if Idrinth._expandedCulturesActive or Idrinth._unlockInstantly then
        for pos0, culture in pairs(Idrinth._expandedCultures) do        local factions = cm:get_factions_by_culture(culture);
            if factions then
                for pos, faction in pairs(factions) do
                    local idrinth = cm:get_most_recently_created_character_of_type(faction:name(), Idrinth._type, Idrinth._subtype .. Idrinth._type);
                    if idrinth then
                        Idrinth._idrinth = idrinth;
                        Idrinth._faction = faction;
                        Idrinth._culture = culture;
                        return idrinth, faction, culture;
                    end;
                end;
            end;
        end;
    end;
    if Idrinth._expandedCulturesActive or Idrinth._unlockInstantly then
        for pos0, culture in pairs(Idrinth._expandedCultures) do
            local factions = cm:get_factions_by_culture(culture);
            if factions then
                for pos, faction in pairs(factions) do
                    local idrinth = cm:get_most_recently_created_character_of_type(faction:name(), Idrinth._type2, Idrinth._subtype .. Idrinth._type2);
                    if idrinth then
                        Idrinth._idrinth = idrinth;
                        Idrinth._faction = faction;
                        Idrinth._culture = culture;
                        return idrinth, faction, culture;
                    end;
                end;
            end;
        end;
    end;
    return nil, nil, nil;
end;
Idrinth.isCurrentVersionNewerThan = function(main, feature, bug)
    if main < Idrinth.currentVersion.main then
        return true;
    elseif main > Idrinth.currentVersion.main then
        return false;
    end;
    if feature < Idrinth.currentVersion.feature then
        return true;
    elseif feature > Idrinth.currentVersion.feature then
        return false;
    end;
    return bug < Idrinth.currentVersion.bug;
end;

core:add_listener(
    "idrinth_unlock_DilemmaChoiceMadeEvent",
    "DilemmaChoiceMadeEvent",
    function(context)
        return context:dilemma() == Idrinth._unlockDilemma;
    end,
    function(context)
        out("IDRINTH DEBUG: ===== START DILEMMA CHOICE CHECK =====");
        if context:choice() == 1 then
            out("    Decided against Idrinth");
            return;
        end
        if context:choice() == 2 then
            out("    Decided for Idrinth general");
            if context:faction():faction_leader():has_region() then
                local x, y = cm:find_valid_spawn_location_for_character_from_position(
                    context:faction():name(),
                    context:faction():faction_leader():logical_position_x(),
                    context:faction():faction_leader():logical_position_y(),
                    true
                );
                cm:create_force_with_general(
                    context:faction():name(),
                    "idrinth_hev_high_elf_vampires_chapel_mixed",
                    context:faction():faction_leader():region():name(),
                    x,
                    y,
                    Idrinth._type2,
                    Idrinth._subtype .. Idrinth._type2,
                    "names_name_99990999999990",
                    "names_name_99990999999992",
                    "names_name_99990999999991",
                    "",
                    false,
                    function(cqi)
                        local character = cm:get_character_by_cqi(cqi);
                        cm:change_character_custom_name(
                            character,
                            "Idrinth",
                            "Thalui",
                            "Knight-Scholar",
                            ""
                        );
                        cm:set_character_unique(cm:char_lookup_str(character), true);
                        cm:set_character_immortality(cm:char_lookup_str(character), true);
                    end
                );
            elseif context:faction():has_home_region() then
                local x, y = cm:find_valid_spawn_location_for_character_from_position(
                    context:faction():name(),
                    context:faction():home_region():settlement():logical_position_x(),
                    context:faction():home_region():settlement():logical_position_y(),
                    true
                );
                cm:create_force_with_general(
                    context:faction():name(),
                    "idrinth_hev_high_elf_vampires_chapel_mixed",
                    context:faction():home_region():name(),
                    x,
                    y,
                    Idrinth._type2,
                    Idrinth._subtype .. Idrinth._type2,
                    "names_name_99990999999990",
                    "names_name_99990999999992",
                    "names_name_99990999999991",
                    "",
                    false,
                    function(cqi)
                        local character = cm:get_character_by_cqi(cqi);
                        cm:change_character_custom_name(
                            character,
                            "Idrinth",
                            "Thalui",
                            "Knight-Scholar",
                            ""
                        );
                        cm:set_character_unique(cm:char_lookup_str(character), true);
                        cm:set_character_immortality(cm:char_lookup_str(character), true);
                    end
                );
            end;
        elseif context:choice() == 0 then
            out("    Decided for Idrinth hero");            
            if context:faction():faction_leader():has_region() then
                cm:spawn_unique_agent_at_character(
                    context:faction():command_queue_index(),
                    Idrinth._subtype .. Idrinth._type,
                    context:faction():faction_leader():command_queue_index(),
                    true
                );
            elseif context:faction():has_home_region() then
                cm:spawn_unique_agent_at_region(
                    context:faction():cqi(),
                    Idrinth._subtype .. Idrinth._type,
                    context:faction():home_region():cqi(),
                    true
                );
            end;
        end;
        idrinth = Idrinth.get();
        if not idrinth then
            out("Failed to spawn Idrinth");
            return;
        end;
        cm:replenish_action_points(cm:char_lookup_str(idrinth));
        out("IDRINTH DEBUG: ==== CREATING UI ====");
        local parent = find_uicomponent(core:get_ui_root(), "hud_campaign", "resources_bar_holder", "resources_bar");
        core:get_or_create_component("idrinth_pooled_resource_asuryan", "ui/idrinth/idrinth_pooled_resource_asuryan.twui.xml", parent);
        core:get_or_create_component("idrinth_pooled_resource_kurnous", "ui/idrinth/idrinth_pooled_resource_kurnous.twui.xml", parent);
        core:get_or_create_component("idrinth_pooled_resource_khaine", "ui/idrinth/idrinth_pooled_resource_khaine.twui.xml", parent);
        campaign_manager:add_pooled_resource_changed_listener_by_faction(
            "idrinth_PooledResourceListener",
            context:faction():name(),
            function(context)
                if context:amount() == 0 then
                    return;
                end;
                local parent = find_uicomponent(core:get_ui_root(), "hud_campaign", "resources_bar_holder", "resources_bar");
                if context:resource():key() == "idrinth_asuryan" then
                    local asuryan = core:get_or_create_component(
                        "idrinth_pooled_resource_asuryan",
                        "ui/idrinth/idrinth_pooled_resource_asuryan.twui.xml",
                        parent
                    );
                    UIComponent(asuryan:Find(0)):SetText(context:resource():value());
                end;
                if context:resource():key() == "idrinth_kurnous" then
                    local kurnous = core:get_or_create_component(
                        "idrinth_pooled_resource_kurnous",
                        "ui/idrinth/idrinth_pooled_resource_kurnous.twui.xml",
                        parent
                    );        
                    UIComponent(kurnous:Find(0)):SetText(context:resource():value());            
                end;
                if context:resource():key() == "idrinth_khaine" then
                    local khaine = core:get_or_create_component(
                        "idrinth_pooled_resource_khaine",
                        "ui/idrinth/idrinth_pooled_resource_khaine.twui.xml",
                        parent
                    );
                    UIComponent(khaine:Find(0)):SetText(context:resource():value());
                end;
            end,
            true
        );
        out("IDRINTH DEBUG: ==== DISABLING OTHER MISSIONS ====");
        for pos1, culture in pairs(Idrinth._cultures) do
            for pos2, faction in pairs(cm:get_factions_by_culture(culture)) do
                if faction:is_human() and Idrinth._unlockMissionStarted[faction:name()] and not faction == context:faction() then
                    cm:cancel_custom_mission(faction, Idrinth._unlockMissions[culture]);
                    Idrinth._unlockMissionStarted[faction:name()] = false;
                elseif faction:is_human() and faction == context:faction() then
                    cm:trigger_dilemma(
                        faction:name(),
                        Idrinth._unlockDilemmas[culture]
                    );
                end;
            end;
        end;
        for pos1, culture in pairs(Idrinth._expandedCultures) do
            for pos2, faction in pairs(cm:get_factions_by_culture(culture)) do
                if faction:is_human() and Idrinth._unlockMissionStarted[faction:name()] and not faction == context:faction() then
                    cm:cancel_custom_mission(faction, Idrinth._unlockMissions[culture]);
                    Idrinth._unlockMissionStarted[faction:name()] = false;
                elseif faction:is_human() and faction == context:faction() then
                    cm:trigger_dilemma(
                        faction:name(),
                        Idrinth._unlockDilemmas[culture]
                    );
                end;
            end;
        end;
    end,
    true
);
core:add_listener(
    "idrinth_enableTypeDisplayInRecruitingPanel_action",
    "ComponentLClickUp",
    function(context)
        local idrinth = Idrinth.get();
        if not idrinth then
            return false;
        end;
        out(context.string);
        return context.string == "legendary_lords" and Idrinth._characterPanelOpen;
    end,
    function(context)
        local parent = find_uicomponent(core:get_ui_root(), "character_panel", "character_panel_info_holder", "general_selection_panel", "main_holder", "character_list_parent", "character_list", "listview", "list_clip", "list_box");
        if not parent then
            out("Couldn't find character recruitment panel.")
            return;
        end;
        if parent:ChildCount() == 0 then
            return;
        end;
        for i = 1, parent:ChildCount() - 1 do
            local child = parent:Find(i);
            if child then
                if UIComponent(child):Visible() then
                    local subtype = find_uicomponent(UIComponent(child), "info_holder", "details_holder", "dy_subtype");
                    if subtype and not subtype:Visible() then
                        set_component_visible_with_parent(true, UIComponent(child), "info_holder", "details_holder", "dy_subtype");
                        subtype:SetText("High Elf Vampire");
                    end;
                    return;
                end;
            end;
        end;
        cm:callback(
            function()
                local parent = find_uicomponent(core:get_ui_root(), "character_panel", "character_panel_info_holder", "general_selection_panel", "main_holder", "character_list_parent", "character_list", "listview", "list_clip", "list_box");
                if not parent then
                    out("Couldn't find character recruitment panel.")
                    return;
                end;
                if parent:ChildCount() == 0 then
                    return;
                end;
                for i = 1, parent:ChildCount() - 1 do
                    local child = parent:Find(i);
                    if child then
                        if UIComponent(child):Visible() then
                            local subtype = find_uicomponent(UIComponent(child), "info_holder", "details_holder", "dy_subtype");
                            if subtype and not subtype:Visible() then
                                set_component_visible_with_parent(true, UIComponent(child), "info_holder", "details_holder", "dy_subtype");
                                subtype:SetText("High Elf Vampire");
                            end;
                            return;
                        end;
                    end;
                end;
            end,
            1
        )
    end,
    true
);
core:add_listener(
    "idrinth_enableTypeDisplayInRecruitingPanel_stop",
    "PanelClosedCampaign",
    function(context)
        local idrinth = Idrinth.get();
        if not idrinth then
            return false;
        end;
        return context.string == "character_panel";
    end,
    function(context)
        out("LEFT CHARACTER PANEL")
        Idrinth._characterPanelOpen = false;
    end,
    true
);
core:add_listener(
    "idrinth_enableTypeDisplayInRecruitingPanel_start",
    "PanelOpenedCampaign",
    function(context)
        local idrinth = Idrinth.get();
        if not idrinth then
            return false;
        end;
        return context.string == "character_panel";
    end,
    function(context)
        out("ENTERED CHARACTER PANEL")
        Idrinth._characterPanelOpen = true;
        local parent = find_uicomponent(core:get_ui_root(), "character_panel", "character_panel_info_holder", "general_selection_panel", "main_holder", "character_list_parent", "character_list", "listview", "list_clip", "list_box");
        if not parent then
            out("Couldn't find character recruitment panel.")
            return;
        end;
        if parent:ChildCount() == 0 then
            return;
        end;
        for i = 1, parent:ChildCount() - 1 do
            local child = parent:Find(i);
            if child then
                if UIComponent(child):Visible() then
                    local subtype = find_uicomponent(UIComponent(child), "info_holder", "details_holder", "dy_subtype");
                    if subtype and not subtype:Visible() then
                        set_component_visible_with_parent(true, UIComponent(child), "info_holder", "details_holder", "dy_subtype");
                        subtype:SetText("High Elf Vampire");
                    end;
                    return;
                end;
            end;
        end;
        cm:callback(
            function()
                local parent = find_uicomponent(core:get_ui_root(), "character_panel", "character_panel_info_holder", "general_selection_panel", "main_holder", "character_list_parent", "character_list", "listview", "list_clip", "list_box");
                if not parent then
                    out("Couldn't find character recruitment panel.")
                    return;
                end;
                if parent:ChildCount() == 0 then
                    return;
                end;
                for i = 1, parent:ChildCount() - 1 do
                    local child = parent:Find(i);
                    if child then
                        if UIComponent(child):Visible() then
                            local subtype = find_uicomponent(UIComponent(child), "info_holder", "details_holder", "dy_subtype");
                            if subtype and not subtype:Visible() then
                                set_component_visible_with_parent(true, UIComponent(child), "info_holder", "details_holder", "dy_subtype");
                                subtype:SetText("High Elf Vampire");
                            end;
                            return;
                        end;
                    end;
                end;
            end,
            1
        )
    end,
    true
);
Idrinth._selectedUnits = nil;

core:add_listener(
    "idrinth_enableWAAAGHUpgradesPanel_unitHandling",
    "RefreshUnitSelection",
    function(context)
        local idrinth = Idrinth.get();
        if not idrinth then
            return false;
        end;
        return true;
    end,
    function(context)
        -- test
        out("context:RefreshUnitSelection")
    end,
    true
);
core:add_listener(
    "idrinth_enableWAAAGHUpgradesPanel",
    "ComponentLClickUp",
    function(context)
        local idrinth = Idrinth.get();
        if not idrinth then
            return false;
        end;
        return context.string == "idrinth_units_panel_blessings_button";
    end,
    function(context)
        local parent = find_uicomponent(core:get_ui_root(), "units_panel", "main_units_panel");
        if not parent then
            return;
        end;
        local element = core:get_or_create_component(
            "idrinth_units_panel_blessings",
            "ui/idrinth/idrinth_units_panel_blessings.twui.xml",
            parent
        );
        element:SetDockingPoint(8);-- Bottom Center
        element:SetDockOffset(0, -300);-- 300 up
        local army = cm:get_campaign_ui_manager():get_mf_selected_cqi()
        if army then
            local force = cm:get_military_force_by_cqi(army);
            if force then
                --element:SetContextObject(cco(force));
            end;
        end;
    end,
    true
);
core:add_listener(
    "idrinth_enableWAAAGHUpgrades",
    "ComponentLClickUp",
    function(context)
        local idrinth = Idrinth.get();
        if not idrinth then
            return false;
        end;
        return context.string == "tab_transported_army";
    end,
    function(context)
        if not Idrinth._self then
            out("IDRINTH DEBUG: opening waaagh view for someone else than Idrinth")
            return;
        end;
        out("IDRINTH DEBUG: opening waaagh view")
        local parent = find_uicomponent(core:get_ui_root(), "hud_campaign", "hud_center_docker", "hud_center", "small_bar", "button_subpanel_parent", "button_subpanel", "button_group_army");
        if not parent then
            return;
        end;
        core:get_or_create_component(
            "idrinth_units_panel_blessings_button",
            "ui/idrinth/idrinth_units_panel_blessings_button.twui.xml",
            parent
        );
        for i = 1, parent:ChildCount() - 1 do
            local child = parent:Find(i);
            if child then
                UIComponent(child):SetVisible(false);
            end;
        end;
        set_component_visible_with_parent(true, core:get_ui_root(), "hud_campaign", "hud_center_docker", "hud_center", "small_bar", "button_subpanel_parent", "button_subpanel")
        set_component_visible_with_parent(true, core:get_ui_root(), "hud_campaign", "hud_center_docker", "hud_center", "small_bar", "button_subpanel_parent", "button_subpanel", "button_group_army")
        set_component_visible_with_parent(true, core:get_ui_root(), "hud_campaign", "hud_center_docker", "hud_center", "small_bar", "button_subpanel_parent", "button_subpanel", "button_group_army", "idrinth_units_panel_blessings_button")
        set_component_visible_with_parent(true, core:get_ui_root(), "units_panel", "main_units_panel", "tabgroup", "tab_horde_buildings")
        set_component_visible_with_parent(false, core:get_ui_root(), "units_panel", "main_units_panel", "unit_count_frame_holder", "frame")
        set_component_visible_with_parent(true, core:get_ui_root(), "units_panel", "main_units_panel", "icon_list", "dy_upkeep")
        find_uicomponent(core:get_ui_root(), "units_panel", "main_units_panel", "header", "button_focus", "dy_txt"):SetText("Knight-Scholar Idrinth Thalui")
        set_component_visible_with_parent(true, core:get_ui_root(), "hud_campaign", "info_panel_holder", "primary_info_panel_holder", "info_panel_background", "CharacterInfoPopup", "horde_growth")
        set_component_visible_with_parent(true, core:get_ui_root(), "hud_campaign", "info_panel_holder", "primary_info_panel_holder", "info_panel_background", "CharacterInfoPopup", "character_info_parent", "equipment")
        set_component_visible_with_parent(true, core:get_ui_root(), "hud_campaign", "info_panel_holder", "primary_info_panel_holder", "info_panel_background", "CharacterInfoPopup", "character_info_parent", "subpanel_effect_bundles")
        set_component_visible_with_parent(true, core:get_ui_root(), "hud_campaign", "info_panel_holder", "primary_info_panel_holder", "info_panel_background", "CharacterInfoPopup", "character_info_parent", "rank")
        cm:callback(
            function()
                set_component_visible_with_parent(true, core:get_ui_root(), "hud_campaign", "hud_center_docker", "hud_center", "small_bar", "button_subpanel_parent", "button_subpanel")
                set_component_visible_with_parent(true, core:get_ui_root(), "hud_campaign", "hud_center_docker", "hud_center", "small_bar", "button_subpanel_parent", "button_subpanel", "button_group_army")
                set_component_visible_with_parent(true, core:get_ui_root(), "hud_campaign", "hud_center_docker", "hud_center", "small_bar", "button_subpanel_parent", "button_subpanel", "button_group_army", "idrinth_units_panel_blessings_button")
                set_component_visible_with_parent(true, core:get_ui_root(), "units_panel", "main_units_panel", "tabgroup", "tab_horde_buildings")
                set_component_visible_with_parent(false, core:get_ui_root(), "units_panel", "main_units_panel", "unit_count_frame_holder", "frame")
                set_component_visible_with_parent(true, core:get_ui_root(), "units_panel", "main_units_panel", "icon_list", "dy_upkeep")
                find_uicomponent(core:get_ui_root(), "units_panel", "main_units_panel", "header", "button_focus", "dy_txt"):SetText("Knight-Scholar Idrinth Thalui")
                set_component_visible_with_parent(true, core:get_ui_root(), "hud_campaign", "info_panel_holder", "primary_info_panel_holder", "info_panel_background", "CharacterInfoPopup", "horde_growth")
                set_component_visible_with_parent(true, core:get_ui_root(), "hud_campaign", "info_panel_holder", "primary_info_panel_holder", "info_panel_background", "CharacterInfoPopup", "character_info_parent", "equipment")
                set_component_visible_with_parent(true, core:get_ui_root(), "hud_campaign", "info_panel_holder", "primary_info_panel_holder", "info_panel_background", "CharacterInfoPopup", "character_info_parent", "subpanel_effect_bundles")
                set_component_visible_with_parent(true, core:get_ui_root(), "hud_campaign", "info_panel_holder", "primary_info_panel_holder", "info_panel_background", "CharacterInfoPopup", "character_info_parent", "rank")
            end,
            1
        );
    end,
    true
);
core:add_listener(
    "idrinth_enableArmyWaaghUpgrades",
    "ComponentLClickUp",
    function(context)
        local idrinth = Idrinth.get();
        if not idrinth then
            return false;
        end;
        return context.string == "idrinth_units_panel_warband_button";
    end,
    function(context)
    
    end,
    true
);
core:add_listener(
    "idrinth_enableArmyUpgrades",
    "ComponentLClickUp",
    function(context)
        local idrinth = Idrinth.get();
        if not idrinth then
            return false;
        end;
        return context.string == "tab_army";
    end,
    function(context)
        if not Idrinth._self then
            out("IDRINTH DEBUG: opening army view for someone else than Idrinth")
            return;
        end;
        out("IDRINTH DEBUG: opening army view")
        local parent = find_uicomponent(core:get_ui_root(), "hud_campaign", "hud_center_docker", "hud_center", "small_bar", "button_subpanel_parent", "button_subpanel", "button_group_army");
        if not parent then
            return;
        end;
        set_component_visible_with_parent(true, core:get_ui_root(), "hud_campaign", "hud_center_docker", "hud_center", "small_bar", "button_subpanel_parent", "button_subpanel")
        set_component_visible_with_parent(true, core:get_ui_root(), "hud_campaign", "hud_center_docker", "hud_center", "small_bar", "button_subpanel_parent", "button_subpanel", "button_group_army")
        core:get_or_create_component(
            "idrinth_units_panel_warband_button",
            "ui/idrinth/idrinth_units_panel_warband_button.twui.xml",
            parent
        );
        set_component_visible_with_parent(true, core:get_ui_root(), "hud_campaign", "hud_center_docker", "hud_center", "small_bar", "button_subpanel_parent", "button_subpanel", "button_group_army", "button_warbands_upgrade")
        cm:callback(
            function()
                set_component_visible_with_parent(true, core:get_ui_root(), "hud_campaign", "hud_center_docker", "hud_center", "small_bar", "button_subpanel_parent", "button_subpanel")
                set_component_visible_with_parent(true, core:get_ui_root(), "hud_campaign", "hud_center_docker", "hud_center", "small_bar", "button_subpanel_parent", "button_subpanel", "button_group_army")
                core:get_or_create_component(
                    "idrinth_units_panel_warband_button",
                    "ui/idrinth/idrinth_units_panel_warband_button.twui.xml",
                    parent
                );
                set_component_visible_with_parent(true, core:get_ui_root(), "hud_campaign", "hud_center_docker", "hud_center", "small_bar", "button_subpanel_parent", "button_subpanel", "button_group_army", "button_warbands_upgrade")
            end,
            1
        );
    end,
    true
);
core:add_listener(
    "idrinth_checkIfIdrinthIsSelected",
    "CharacterSelected",
    true,
    function(context) 
        out("IDRINTH DEBUG: is idrinth?")
        local isIdrinth = context:character():character_subtype_key() == "idrinth_hev_high_elf_vampires_idrinthchampion" or context:character():character_subtype_key() == "idrinth_hev_high_elf_vampires_idrinthgeneral";
        if isIdrinth then
            Idrinth._self = context:character();            
            set_component_visible_with_parent(true, core:get_ui_root(), "character_details_panel", "character_context_parent", "TabGroup", "idrinth_character_details_panel_idrinths_paths_button")
            local subtype = find_uicomponent(core:get_ui_root(), "character_details_panel", "character_context_parent", "character_name", "panel_subtitle", "dy_subtype");
            if subtype then
                subtype:SetText("High Elf Vampire");
            end;
            cm:callback(
                function()
                    if not Idrinth._self then
                        return;
                    end;
                    set_component_visible_with_parent(true, core:get_ui_root(), "character_details_panel", "character_context_parent", "TabGroup", "idrinth_character_details_panel_idrinths_paths_button")
                    local subtype = find_uicomponent(core:get_ui_root(), "character_details_panel", "character_context_parent", "character_name", "panel_subtitle", "dy_subtype");
                    if subtype then
                        subtype:SetText("High Elf Vampire");
                    end;
                end,
                1
            );
        else
            Idrinth._self = nil;            
            set_component_visible_with_parent(false, core:get_ui_root(), "character_details_panel", "character_context_parent", "TabGroup", "idrinth_character_details_panel_idrinths_paths_button")            
            set_component_visible_with_parent(true, core:get_ui_root(), "character_details_panel", "character_context_parent", "tab_panels", "stats_effects_holder");
            set_component_visible_with_parent(false, core:get_ui_root(), "character_details_panel", "character_context_parent", "tab_panels", "idrinth_character_details_panel_idrinths_paths");
        end;
        local initiative_sets = context:character():character_details():character_initiative_sets();
        local has_actual_initiative_sets = false;
        if initiative_sets then
            for i = 0, initiative_sets:num_items() -1 do
                local initiative_set = initiative_sets:item_at(i)
                if initiative_set then
                    local local_initiatives = initiative_set:all_initiatives();
                    if local_initiatives then
                        for j = 0, local_initiatives:num_items() -1 do
                            local initiative = local_initiatives:item_at(j);
                            if initiative then
                                local initiative_key = initiative:record_key();
                                out(initiative_key);
                                if (initiative_key == "idrinth_khaine_pledge") or (initiative_key == "idrinth_kurnous_pledge") or (initiative_key == "idrinth_asuryan_pledge") or (initiative_key == "idrinth_khaine_prayer") or (initiative_key == "idrinth_kurnous_prayer") or (initiative_key == "idrinth_asuryan_prayer") then
                                    --idrinth is the only one who gets his initiatives
                                else
                                    has_actual_initiative_sets = true;
                                end;
                            end;
                        end;
                    end;
                end;
            end;
        end;
        if not has_actual_initiative_sets then
            set_component_visible_with_parent(false, core:get_ui_root(), "character_details_panel", "character_context_parent", "TabGroup", "character_initiatives")
        end;
        Idrinth._lastSelectionAgent = context:character();
        cm:callback(
            function()
                local initiative_sets = Idrinth._lastSelectionAgent:character_details():character_initiative_sets();
                local has_actual_initiative_sets = false;
                if initiative_sets then
                    for i = 0, initiative_sets:num_items() -1 do
                        local initiative_set = initiative_sets:item_at(i)
                        if initiative_set then
                            local local_initiatives = initiative_set:all_initiatives();
                            if local_initiatives then
                                for j = 0, local_initiatives:num_items() -1 do
                                    local initiative = local_initiatives:item_at(j);
                                    if initiative then
                                        local initiative_key = initiative:record_key()
                                        if (initiative_key == "idrinth_khaine_pledge") or (initiative_key == "idrinth_kurnous_pledge") or (initiative_key == "idrinth_asuryan_pledge") or (initiative_key == "idrinth_khaine_prayer") or (initiative_key == "idrinth_kurnous_prayer") or (initiative_key == "idrinth_asuryan_prayer") then
                                            --idrinth is the only one who gets his initiatives
                                        else
                                            has_actual_initiative_sets = true;
                                        end;
                                    end;
                                end;
                            end;
                        end;
                    end;
                end;
                if not has_actual_initiative_sets then
                    set_component_visible_with_parent(false, core:get_ui_root(), "character_details_panel", "character_context_parent", "TabGroup", "character_initiatives")
                end;
            end,
            1
        );
    end,
    true
);
core:add_listener(
    "idrinth_unlockLevel_DilemmaChoiceMadeEvent",
    "DilemmaChoiceMadeEvent",
    function(context)
        local idrinth = Idrinth.get();
        if idrinth then
            return false;
        end;
        return context:dilemma() == Idrinth._unlockLevelAdjustmentDilemma;
    end,
    function(context)
        out("IDRINTH DEBUG: ===== LEVEL DILEMMA CHOICE CHECK =====");
        if context:choice() == 1 then
            Idrinth._unlockLevelAdjustment = 0;
            return;
        end
        if context:choice() == 2 then
            Idrinth._unlockLevelAdjustment = 1;
            return;
        end
        if context:choice() == 3 then
            Idrinth._unlockLevelAdjustment = 3;
            return;
        end
        if context:choice() == 4 then
            Idrinth._unlockLevelAdjustment = 6;
            return;
        end
    end,
    true
);
core:add_listener(
    "idrinth_chapelMode_DilemmaChoiceMadeEvent",
    "DilemmaChoiceMadeEvent",
    function(context)
        local idrinth = Idrinth.get();
        if idrinth then
            return false;
        end;
        return context:dilemma() == Idrinth._enableChapelsDilemma;
    end,
    function(context)
        out("IDRINTH DEBUG: ===== CHAPEL CHOICE CHECK =====");
        Idrinth._enableChapels = (context:choice() == 1);
    end,
    true
);
core:add_listener(
    "idrinth_storyEventMode_DilemmaChoiceMadeEvent",
    "DilemmaChoiceMadeEvent",
    function(context)
        local idrinth = Idrinth.get();
        if idrinth then
            return false;
        end;
        return context:dilemma() == Idrinth._enableStoryMissionsDilemma;
    end,
    function(context)
        out("IDRINTH DEBUG: ===== CHAPEL CHOICE CHECK =====");
        Idrinth._enableStoryEvents = (context:choice() == 1);
    end,
    true
);
core:add_listener(
    "idrinth_unlock_FactionTurnStart",
    "FactionTurnStart",
    function(context)
        local idrinth = Idrinth.get();
        if idrinth then
            return false;
        end;
        local rankShift = Idrinth._unlockLevelAdjustment;
        if rankShift == nil then
            rankShift = 0;
        end;
        for pos1, culture in pairs(Idrinth._cultures) do
            for pos2, faction in pairs(cm:get_factions_by_culture(culture)) do
                if faction == context:faction() then
                    local general = cm:get_highest_ranked_general_for_faction(context:faction());
                    if not general then
                        return false;
                    end;
                    local maxRank = general:rank();
                    if maxRank < 5 + rankShift then
                        return false;
                    end;
                    return context:faction():is_human();
                end;
            end;
        end;
        if Idrinth._expandedCulturesActive then
            for pos1, culture in pairs(Idrinth._expandedCultures) do
                for pos2, faction in pairs(cm:get_factions_by_culture(culture)) do
                    if faction == context:faction() then
                        local general = cm:get_highest_ranked_general_for_faction(context:faction());
                        if not general then
                            return false;
                        end;
                        local maxRank = general:rank();
                        if maxRank < 5 + rankShift then
                            return false;
                        end;
                        return context:faction():is_human();
                    end;
                end;
            end;
        end;
        return false;
    end,
    function(context)
        out("IDRINTH DEBUG: ===== START MISSION =====");
        if Idrinth._unlockMissionStarted[context:faction():name()] then
            out(Idrinth._unlockMissions[context:faction():culture()] .. "  already running");
            return;
        end;
        Idrinth._unlockMissionStarted[context:faction():name()] = true;
        cm:trigger_mission(
            context:faction():name(),
            Idrinth._unlockMissions[context:faction():culture()],
            true
        );
        out(Idrinth._unlockMissions[context:faction():culture()] .. "  now running");
    end,
    true
);
core:add_listener(
    "idrinth_mode_FactionTurnStart",
    "FactionTurnStart",
    function(context)
        if Idrinth._hasModConfig then
            return false;
        end;
        local idrinth = Idrinth.get();
        if idrinth then
            return false;
        end;
        return context:faction():is_human() and nil == Idrinth._expandedCulturesActive and not Idrinth._unlockInstantly;
    end,
    function(context)
        out("IDRINTH DEBUG: ===== START MODE DILEMMA =====");
        cm:trigger_dilemma(context:faction():name(), "idrinth_mode_choice");
    end,
    false
);
core:add_listener(
    "idrinth_storyEventMode_FactionTurnStart",
    "FactionTurnStart",
    function(context)
        if Idrinth._hasModConfig then
            return false;
        end;
        return context:faction():is_human() and Idrinth._enableStoryEvents == nil;
    end,
    function(context)
        out("IDRINTH DEBUG: ===== START MODE DILEMMA =====");
        cm:trigger_dilemma(context:faction():name(), Idrinth._enableStoryMissionsDilemma);
    end,
    false
);
core:add_listener(
    "idrinth_modeLevel_FactionTurnStart",
    "FactionTurnStart",
    function(context)
        if Idrinth._hasModConfig then
            return false;
        end;
        local idrinth = Idrinth.get();
        if idrinth then
            return false;
        end;
        return context:faction():is_human() and nil == Idrinth._unlockLevelAdjustment and not Idrinth._unlockInstantly;
    end,
    function(context)
        out("IDRINTH DEBUG: ===== START LEVEL DILEMMA =====");
        cm:trigger_dilemma(context:faction():name(), Idrinth._unlockLevelAdjustmentDilemma);
    end,
    false
);
core:add_listener(
    "idrinth_modeChapels_FactionTurnStart",
    "FactionTurnStart",
    function(context)
        if Idrinth._hasModConfig then
            return false;
        end;
        local idrinth = Idrinth.get();
        if idrinth then
            return false;
        end;
        return context:faction():is_human() and nil == Idrinth._enableChapels and not Idrinth._unlockInstantly;
    end,
    function(context)
        out("IDRINTH DEBUG: ===== CHAPEL DILEMMA =====");
        cm:trigger_dilemma(context:faction():name(), Idrinth._enableChapelsDilemma);
    end,
    false
);
core:add_listener(
    "idrinth_unlock_DilemmaChoiceMadeEvent",
    "DilemmaChoiceMadeEvent",
    function(context)
        return context:dilemma() == "idrinth_mode_choice";
    end,
    function(context)
        Idrinth._expandedCulturesActive = (context:choice() == 1);
    end,
    false
);
core:add_listener(
    "idrinth_unlockAI_FactionTurnStart",
    "FactionTurnStart",
    function(context)
        local idrinth = Idrinth.get();
        if idrinth then
            return false;
        end;
        local rankShift = Idrinth._unlockLevelAdjustment;
        if rankShift == nil then
            rankShift = 0;
        end;
        for pos1, culture in pairs(Idrinth._cultures) do
            for pos2, faction in pairs(cm:get_factions_by_culture(culture)) do
                if faction == context:faction() then
                    local general = cm:get_highest_ranked_general_for_faction(context:faction());
                    if not general then
                        return false;
                    end;
                    local maxRank = general:rank();
                    if maxRank < Idrinth._unlockAIRank[culture] + rankShift then
                        return false;
                    end;
                    return cm:random_number(100) > 95 and not faction:is_human();
                end;
            end;
        end;
        if Idrinth._expandedCulturesActive then
            for pos1, culture in pairs(Idrinth._expandedCultures) do
                for pos2, faction in pairs(cm:get_factions_by_culture(culture)) do
                    if faction == context:faction() then
                        local general = cm:get_highest_ranked_general_for_faction(context:faction());
                        if not general then
                            return false;
                        end;
                        local maxRank = general:rank();
                        if maxRank < Idrinth._unlockAIRank[culture] + rankShift then
                            return false;
                        end;
                        return cm:random_number(100) >95 and not faction:is_human();
                    end;
                end;
            end;
        end;
        return false;
    end,
    function(context)
        out("IDRINTH DEBUG: ==== SPAWNING FOR AI ====");
        cm:spawn_unique_agent_at_character(
            context:faction():command_queue_index(),
            Idrinth._subtype,
            context:faction():faction_leader():command_queue_index(),
            true
        );
        idrinth = Idrinth.get();
        cm:replenish_action_points(cm:char_lookup_str(idrinth));
        out("IDRINTH DEBUG: ==== DISABLING OTHER MISSIONS ====");
        for pos1, culture in pairs(Idrinth._cultures) do
            for pos2, faction in pairs(cm:get_factions_by_culture(culture)) do
                if faction:is_human() and Idrinth._unlockMissionStarted[faction:name()] then
                    cm:cancel_custom_mission(faction, Idrinth._unlockMissions[culture]);
                    Idrinth._unlockMissionStarted[faction:name()] = false;
                end;
            end;
        end;
        for pos1, culture in pairs(Idrinth._expandedCultures) do
            for pos2, faction in pairs(cm:get_factions_by_culture(culture)) do
                if faction:is_human() and Idrinth._unlockMissionStarted[faction:name()] then
                    cm:cancel_custom_mission(faction, Idrinth._unlockMissions[culture]);
                    Idrinth._unlockMissionStarted[faction:name()] = false;
                end;
            end;
        end;
    end,
    true
);

core:add_listener(
    "idrinth_unlockHumanDebug_FactionTurnStart",
    "FactionTurnStart",
    function(context)
        local idrinth = Idrinth.get();
        if idrinth then
            return false;
        end;
        return context:faction():is_human() and Idrinth._unlockInstantly;
    end,
    function(context)
        out("IDRINTH DEBUG: ==== SPAWNING FOR DEBUG ====");
        cm:spawn_unique_agent_at_character(
            context:faction():command_queue_index(),
            Idrinth._subtype,
            context:faction():faction_leader():command_queue_index(),
            true
        );
        cm:apply_effect_bundle(
            "idrinth_vampiric_priests",
            context:faction():name(),
            -1
        );
        idrinth = Idrinth.get();
        cm:replenish_action_points(cm:char_lookup_str(idrinth));
    end,
    true
);
core:add_listener(
    "idrinth_unlock_MissionSucceeded",
    "MissionSucceeded",
    function(context)
        out("IDRINTH DEBUG: ===== START MISSION CHECKS =====");
        local idrinth = Idrinth.get();
        if idrinth then
            return false;
        end;
        for pos, mission in pairs(Idrinth._unlockMissions) do
            if context:mission():mission_record_key() == mission then
                return true;
            end;
        end;
        return false;
    end,
    function(context)
        cm:trigger_dilemma(context:faction():name(), Idrinth._unlockDilemma);
    end,
    true
);
core:add_listener(
    "idrinth_FactionTurnStart",
    "FactionTurnStart",
    function(context)
        local idrinth, faction = Idrinth.get();
        if context:faction() == faction then
            return true;
        end;
        return false;
    end,
    function(context)    
        out("IDRINTH DEBUG FUNCTION: FactionTurnStart");
        local addResource = function(name, faction)
            local amount = cm:random_number(35);
            if amount == 0 then
                cm:apply_effect_bundle(
                    "idrinth_" .. name .. "_god_favour_minus5",
                    faction:name(),
                    1
                );
            elseif amount < 3 then
                cm:apply_effect_bundle(
                    "idrinth_" .. name .. "_god_favour_minus4",
                    faction:name(),
                    1
                );
            elseif amount < 6 then
                cm:apply_effect_bundle(
                    "idrinth_" .. name .. "_god_favour_minus3",
                    faction:name(),
                    1
                );
            elseif amount < 10 then
                cm:apply_effect_bundle(
                    "idrinth_" .. name .. "_god_favour_minus2",
                    faction:name(),
                    1
                );
            elseif amount < 15 then
                cm:apply_effect_bundle(
                    "idrinth_" .. name .. "_god_favour_minus1",
                    faction:name(),
                    1
                );
            elseif amount < 21 then
                -- 0 change
            elseif amount < 26 then
                cm:apply_effect_bundle(
                    "idrinth_" .. name .. "_god_favour_plus1",
                    faction:name(),
                    1
                );
            elseif amount < 30 then
                cm:apply_effect_bundle(
                    "idrinth_" .. name .. "_god_favour_plus2",
                    faction:name(),
                    1
                );
            elseif amount < 33 then
                cm:apply_effect_bundle(
                    "idrinth_" .. name .. "_god_favour_plus3",
                    faction:name(),
                    1
                );
            elseif amount < 35 then
                cm:apply_effect_bundle(
                    "idrinth_" .. name .. "_god_favour_plus4",
                    faction:name(),
                    1
                );
            else
                cm:apply_effect_bundle(
                    "idrinth_" .. name .. "_god_favour_plus5",
                    faction:name(),
                    1
                );
            end;
        end;
        local faction_key = context:faction():name();
        local idrinth, faction = Idrinth.get();
        out("    Faction: " .. faction_key);
        if idrinth:is_wounded() then
            out("IDRINTH DEBUG: ===== IDRINTH WOUNDED =====");
            return;
        end;
        if idrinth:has_military_force() and not idrinth:is_carrying_troops() then
            cm:spawn_transported_force_at_military_force(idrinth:military_force():command_queue_index(), "idrinth_hev_high_elf_vampires_idrinth_support", 1)
        end;
        
        out("IDRINTH DEBUG: ===== START BUILDING SPAWN CHECKS =====");
        local buildingSpawnChance = idrinth:rank();
        if idrinth:is_embedded_in_military_force() then
            if idrinth:embedded_in_military_force():has_general() and idrinth:embedded_in_military_force():general_character():in_settlement() then
                buildingSpawnChance = buildingSpawnChance * 2;
            end;
        else
            buildingSpawnChance = buildingSpawnChance * 1.5;
        end;
        if Idrinth._enableChapels and buildingSpawnChance > cm:random_number(500) and idrinth:region() and idrinth:has_region() then
            local foreignSlotManager = idrinth:region():foreign_slot_manager_for_faction(faction_key);
            if foreignSlotManager and not foreignSlotManager:is_null_interface() then
                local found = false;
                if foreignSlotManager:slots() and not foreignSlotManager:slots():is_empty() then
                    for i = 0, foreignSlotManager:slots():num_items() -1 do
                        local slot = foreignSlotManager:slots():item_at(i);
                        if slot and slot:template_key() == "idrinth_hev_high_elf_vampires_chapel" then
                            found = true;
                        end;
                    end;
                end;
                if not found then
                    if idrinth:region():is_province_capital() then
                        cm:add_foreign_slot_set_to_region_for_faction(faction:command_queue_index(), idrinth:region():cqi(), "idrinth_slot_set_chapel_capital");
                    else
                        cm:add_foreign_slot_set_to_region_for_faction(faction:command_queue_index(), idrinth:region():cqi(), "idrinth_slot_set_chapel");
                    end;
                end;
            elseif not foreignSlotManager or foreignSlotManager:is_null_interface() then
                if idrinth:region():is_province_capital() then
                    cm:add_foreign_slot_set_to_region_for_faction(faction:command_queue_index(), idrinth:region():cqi(), "idrinth_slot_set_chapel_capital");
                else
                    cm:add_foreign_slot_set_to_region_for_faction(faction:command_queue_index(), idrinth:region():cqi(), "idrinth_slot_set_chapel");
                end;
            end;
        end;

        out("IDRINTH DEBUG: ===== START RESOURCE MODIFICATION =====");
        addResource("asuryan", faction);
        addResource("kurnous", faction);
        addResource("khaine", faction);
        out("    Resources Added");
        Idrinth.activeRounds = Idrinth.activeRounds + 1;
        for pos, ancillary in pairs(Idrinth._uniqueAncillaries) do
            if faction:ancillary_exists(ancillary) and not idrinth:has_ancillary(ancillary) then
                cm:force_remove_ancillary_from_faction(
                    faction,
                    ancillary
                )
                cm:force_add_ancillary(
                    idrinth,
                    ancillary,
                    true,
                    true
                );
                out("Attached ancillary to Idrinth.");
            end;
        end;
        out("    Check God Favour Effects");
        local eventTriggered = false;
        local khaineUsed = 0;
        local kurnousUsed = 0;
        local asuryanUsed = 0;
        out("IDRINTH DEBUG: ===== START GOD FAVOUR CHECKS =====");
        out("IDRINTH DEBUG: Khaine: " .. tostring(faction:pooled_resource_manager():resource("idrinth_khaine"):value()) .. 
            ", Kurnous: " .. tostring(faction:pooled_resource_manager():resource("idrinth_kurnous"):value()) .. 
            ", Asuryan: " .. tostring(faction:pooled_resource_manager():resource("idrinth_asuryan"):value()));
        for pos, event in pairs(Idrinth._godFavourDilemmas) do
            out("    Checking " .. pos);
            if event.cooldown > 0 then
                event.cooldown = event.cooldown -1;
            elseif cm:random_number(100) > 95 and faction:pooled_resource_manager():resource("idrinth_khaine"):value() >= event.khaine + khaineUsed and faction:pooled_resource_manager():resource("idrinth_kurnous"):value() >= event.kurnous + kurnousUsed and faction:pooled_resource_manager():resource("idrinth_asuryan"):value() >= event.asuryan + asuryanUsed then
                out("     Triggered " .. pos);
                cm:apply_effect_bundle(
                    event.effect,
                    faction_key,
                    event.duration
                );
                cm:apply_effect_bundle(
                    event.effect .. "_cost",
                    faction_key,
                    1
                );
                asuryanUsed = asuryanUsed + event.asuryan;
                kurnousUsed = kurnousUsed + event.kurnous;
                khaineUsed = khaineUsed + event.khaine;
                event.cooldown = event.maxCooldown;
                eventTriggered = true;
            end;
        end;
        if eventTriggered == true then
            cm:trigger_dilemma(faction_key, "idrinth_dilemma_god_favour");
        end;
        out("IDRINTH DEBUG: ===== START GOD ITEM DILEMMA CHECKS =====");
        local level = idrinth:rank();
        out("IDRINTH DEBUG: Battles: " .. tostring(Idrinth.battlesFought) .. 
            ", Assassinations: " .. tostring(Idrinth.charactersAssassinated) .. 
            ", Level: " .. tostring(level));
        for item, data in pairs(Idrinth._item_dilemmas) do
            local factor = 1;
            if Idrinth._godBlessedItemRequirements == "low" then
                factor = 2/3;
            elseif Idrinth._godBlessedItemRequirements == "high" then
                factor = 4/3;
            end;
            out("IDRINTH DEBUG: Checking " .. item .. " dilemma - " ..
                "Triggered: " .. tostring(data.triggered) .. 
                ", Min Rounds: " .. tostring(data.min_rounds) .. 
                ", Min Battles: " .. tostring(data.min_battles_fought) .. 
                ", Min Assassinations: " .. tostring(data.min_assassinations) .. 
                ", Min Level: " .. tostring(data.min_level) .. 
                ", Factor: " .. tostring(factor));
            if not data.triggered and Idrinth.battlesFought >= data.min_battles_fought * factor and Idrinth.charactersAssassinated >= data.min_assassinations * factor and level >= data.min_level * factor then
                if (cm:random_number(100) <= 25) then
                    data.triggered = true;
                    cm:trigger_dilemma(faction_key, data.key);
                end;
            end;
        end;
        out("    Story Events");
        if Idrinth._enableStoryEvents and idrinth:region() and idrinth:has_region() then
            out("        Current Region: "..idrinth:region():name())
            for region, data in pairs(Idrinth.place_of_interest) do
                if data.region == idrinth:region():name() and not data.triggered then
                    cm:trigger_dilemma(faction_key, data.key);
                    Idrinth.place_of_interest[region].triggered = true;
                    return;
                end;            
            end;
        end;
        out("    Check Dilemma Cooldown");
        if Idrinth._dilemmaCooldown > 0 then
            Idrinth._dilemmaCooldown = Idrinth._dilemmaCooldown - 1;
            return;
        end;
        out("    Dilemmas");
        local digit_bonus = 0;
        local battlesFought = Idrinth.battlesFought;
        local increment = 1;
        while battlesFought > 0 do
            digit_bonus = digit_bonus + increment;
            battlesFought = math.floor(battlesFought / 10);
            increment = increment + 1;
        end;
        out("   BattlesFoughtBonus" .. digit_bonus);
        local activeRounds = Idrinth.activeRounds;
        increment = 1;
        while activeRounds > 0 do
            digit_bonus = digit_bonus + increment;
            activeRounds = math.floor(activeRounds / 10);
            increment = increment + 1;
        end;
        out("   ActiveRoundsBonus" .. digit_bonus);
        local assassinationsDone = Idrinth.charactersAssassinated;
        increment = 1;
        while assassinationsDone > 0 do
            digit_bonus = digit_bonus + increment;
            assassinationsDone = math.floor(assassinationsDone / 10);
            increment = increment + 1;
        end;
        out("   AssasinationsBonus" .. digit_bonus);
        local dilemmasTriggered = 0;
        for factionName, data in pairs(Idrinth.dilemmas) do
            if data.triggered then
                dilemmasTriggered = dilemmasTriggered + 1;
            end;
        end;
        out("IDRINTH DEBUG: ===== START DILEMMA CHECKS =====");
        out("IDRINTH DEBUG: Culture: " .. tostring(Idrinth._culture) .. 
            ", Rounds: " .. tostring(Idrinth.activeRounds) .. 
            ", Battles: " .. tostring(Idrinth.battlesFought) .. 
            ", Assassinations: " .. tostring(Idrinth.charactersAssassinated) .. 
            ", Level: " .. tostring(level));
        for factionName, data in pairs(Idrinth.dilemmas) do
            out("IDRINTH DEBUG: Checking " .. factionName .. " dilemma - " ..
                "Triggered: " .. tostring(data.triggered) .. 
                ", Min Rounds: " .. tostring(data.min_rounds) .. 
                ", Min Battles: " .. tostring(data.min_battles_fought) .. 
                ", Min Assassinations: " .. tostring(data.min_assassinations) .. 
                ", Min Level: " .. tostring(data.min_level));
            if not data.triggered and Idrinth.activeRounds >= data.min_rounds and Idrinth.battlesFought >= data.min_battles_fought and Idrinth.charactersAssassinated >= data.min_assassinations and level >= data.min_level then
                local chance = data.chances[Idrinth._culture];
                if not chance then
                    chance = data.chance;
                end;
                out("IDRINTH DEBUG: " .. factionName .. " dilemma eligible. " ..
                    "Base chance: " .. tostring(chance) .. 
                    ", Bonus: " .. tostring(digit_bonus/100) .. 
                    ", Penalty: " .. tostring(dilemmasTriggered/100) .. 
                    ", Final chance: " .. tostring(chance + digit_bonus/100 - dilemmasTriggered/100))
                if chance and (cm:random_number(100) / 100 <= chance + digit_bonus/100 - dilemmasTriggered/100) then
                    data.triggered = true;
                    cm:trigger_dilemma(faction_key, data.key);
                    if Idrinth._godBlessedItemRequirements == "low" then
                        Idrinth._dilemmaCooldown = cm:random_number(2) + 1;
                    elseif Idrinth._godBlessedItemRequirements == "long" then
                        Idrinth._dilemmaCooldown = cm:random_number(3) + 2;
                    else
                        Idrinth._dilemmaCooldown = cm:random_number(4) + 3;
                    end;
                    return;
                end;
            end;
        end;
    end,
    true
);
core:add_listener(
    "idrinth_RegionFactionChangeEvent",
    "RegionFactionChangeEvent",
    function(context)
        local idrinth = Idrinth.get();
        if not idrinth then
            return false;
        end;
        return true;
    end,
    function(context)
        out("IDRINTH DEBUG FUNCTION: RegionFactionChangeEvent");
        local idrinth, faction = Idrinth.get();
        local foreignSlotManager = context:region():foreign_slot_manager_for_faction(faction:name());
        if foreignSlotManager and not foreignSlotManager:is_null_interface() then
            if foreignSlotManager:slots() and not foreignSlotManager:slots():is_empty() then
                for i = 0, foreignSlotManager:slots():num_items() -1 do
                    local slot = foreignSlotManager:slots():item_at(i);
                    if slot and slot:template_key() == "idrinth_hev_high_elf_vampires_chapel" then
                        cm:remove_faction_foreign_slots_from_region(faction:command_queue_index(), context:region():cqi());
                        return;
                    end;
                end;
            end;
        end;
    end,
    true
);
core:add_listener(
    "idrinth_CharacterAncillaryGained",
    "CharacterAncillaryGained",
    function(context)
        local idrinth = Idrinth.get();
        if not idrinth then
            return false;
        end;
        return true;
    end,
    function(context)
        out("IDRINTH DEBUG FUNCTION: CharacterAncillaryGained");
        local idrinth, faction = Idrinth.get();
        for pos, ancillary in pairs(Idrinth._uniqueAncillaries) do
            if context:ancillary() == ancillary and not idrinth:has_ancillary(ancillary) then
                cm:force_remove_ancillary_from_faction(
                    faction,
                    ancillary
                )
                cm:force_add_ancillary(
                    idrinth,
                    ancillary,
                    true,
                    true
                );
                out("Attached ancillary to Idrinth.");
            end;
        end;
    end,
    true
);
core:add_listener(
    "idrinth_CharacterCharacterTargetAction",
    "CharacterCharacterTargetAction",
    function(context)
        local idrinth = Idrinth.get();
        if not idrinth then
            return false;
        end;
        return (context:character() == idrinth);
    end,
    function(context)    
        out("IDRINTH DEBUG FUNCTION: CharacterCharacterTargetAction");
        local ability = context:ability();
        local idrinth = Idrinth.get();

        if ability == "hinder_army" then
            if context:mission_result_critial_failure() then
                cm:pooled_resource_factor_transaction(context:character():faction():pooled_resource_manager(), "idrinth_asuryan_other", -5);
            elseif context:mission_result_success() then
                cm:pooled_resource_factor_transaction(context:character():faction():pooled_resource_manager(), "idrinth_asuryan_other", 5);
                cm:apply_effect_bundle_to_character("idrinth_successful_action_army", idrinth, 2);
            elseif context:mission_result_critial_success() then
                cm:pooled_resource_factor_transaction(context:character():faction():pooled_resource_manager(), "idrinth_asuryan_other", 15);
                cm:replenish_action_points(cm:char_lookup_str(idrinth));
                cm:apply_effect_bundle_to_character("idrinth_successful_action_army_critical", idrinth, 5);
            end;
        elseif ability == "hinder_character" or ability == "hinder_agent" then
            if context:mission_result_critial_failure() then
                cm:pooled_resource_factor_transaction(context:character():faction():pooled_resource_manager(), "idrinth_kurnous_other", -5);
            elseif context:mission_result_success() then
                Idrinth.charactersAssassinated = Idrinth.charactersAssassinated + 1;
                cm:pooled_resource_factor_transaction(context:character():faction():pooled_resource_manager(), "idrinth_kurnous_other", 5);
                cm:apply_effect_bundle_to_character("idrinth_successful_action_character", idrinth, 2);
            elseif context:mission_result_critial_success() then
                Idrinth.charactersAssassinated = Idrinth.charactersAssassinated + 1;
                cm:pooled_resource_factor_transaction(context:character():faction():pooled_resource_manager(), "idrinth_kurnous_other", 15);
                cm:replenish_action_points(cm:char_lookup_str(idrinth));
                cm:apply_effect_bundle_to_character("idrinth_successful_action_character_critical", idrinth, 5);
            end;
        end;
    end,
    true
);
core:add_listener(
    "idrinth_CharacterInfoPanelOpened",
    "PanelOpenedCampaign",
    function(context)
        return context.string == "character_details_panel";
    end,
    function(context)
        out("IDRINTH DEBUG: ===== CREATING CHARACTER DETAIL UI =====");
        local paths = core:get_or_create_component(
            "idrinth_character_details_panel_idrinths_paths",
            "ui/idrinth/idrinth_character_details_panel_idrinths_paths.twui.xml",
            find_uicomponent(core:get_ui_root(), "character_details_panel", "character_context_parent", "tab_panels")
        );
        UIComponent(paths:Parent()):Adopt(paths:Address(), 3);
        core:get_or_create_component(
            "idrinth_character_details_panel_idrinths_paths_button",
            "ui/idrinth/idrinth_character_details_panel_idrinths_paths_button.twui.xml",
            find_uicomponent(core:get_ui_root(), "character_details_panel", "character_context_parent", "TabGroup")
        );
        set_component_visible_with_parent(false, core:get_ui_root(), "character_details_panel", "character_context_parent", "tab_panels", "idrinth_character_details_panel_idrinths_paths")
        set_component_visible_with_parent(false, core:get_ui_root(), "character_details_panel", "character_context_parent", "TabGroup", "idrinth_character_details_panel_idrinths_paths_button")
        if Idrinth._lastSelectionAgent then
            if not Idrinth._self then
                local initiative_sets = Idrinth._lastSelectionAgent:character_details():character_initiative_sets();
                local has_actual_initiative_sets = false;
                if initiative_sets then
                    for i = 0, initiative_sets:num_items() -1 do
                        local initiative_set = initiative_sets:item_at(i)
                        if initiative_set then
                            local local_initiatives = initiative_set:all_initiatives();
                            if local_initiatives then
                                for j = 0, local_initiatives:num_items() -1 do
                                    local initiative = local_initiatives:item_at(j);
                                    if initiative then
                                        local initiative_key = initiative:record_key();
                                        out(initiative_key);
                                        if (initiative_key == "idrinth_khaine_pledge") or (initiative_key == "idrinth_kurnous_pledge") or (initiative_key == "idrinth_asuryan_pledge") or (initiative_key == "idrinth_khaine_prayer") or (initiative_key == "idrinth_kurnous_prayer") or (initiative_key == "idrinth_asuryan_prayer") then
                                            --idrinth is the only one who gets his initiatives
                                        else
                                            has_actual_initiative_sets = true;
                                        end;
                                    end;
                                end;
                            end;
                        end;
                    end;
                end;
                if not has_actual_initiative_sets then
                    set_component_visible_with_parent(false, core:get_ui_root(), "character_details_panel", "character_context_parent", "TabGroup", "character_initiatives")
                end;
                cm:callback(
                    function()
                        local initiative_sets = Idrinth._lastSelectionAgent:character_details():character_initiative_sets();
                        local has_actual_initiative_sets = false;
                        if initiative_sets then
                            for i = 0, initiative_sets:num_items() -1 do
                                local initiative_set = initiative_sets:item_at(i)
                                if initiative_set then
                                    local local_initiatives = initiative_set:all_initiatives();
                                    if local_initiatives then
                                        for j = 0, local_initiatives:num_items() -1 do
                                            local initiative = local_initiatives:item_at(j);
                                            if initiative then
                                                local initiative_key = initiative:record_key()
                                                if (initiative_key == "idrinth_khaine_pledge") or (initiative_key == "idrinth_kurnous_pledge") or (initiative_key == "idrinth_asuryan_pledge") or (initiative_key == "idrinth_khaine_prayer") or (initiative_key == "idrinth_kurnous_prayer") or (initiative_key == "idrinth_asuryan_prayer") then
                                                    --idrinth is the only one who gets his initiatives
                                                else
                                                    has_actual_initiative_sets = true;
                                                end;
                                            end;
                                        end;
                                    end;
                                end;
                            end;
                        end;
                        if not has_actual_initiative_sets then
                            set_component_visible_with_parent(false, core:get_ui_root(), "character_details_panel", "character_context_parent", "TabGroup", "character_initiatives")
                        end;
                    end,
                    1
                );
            end;
            return;
        end;
        set_component_visible_with_parent(true, core:get_ui_root(), "character_details_panel", "character_context_parent", "TabGroup", "idrinth_character_details_panel_idrinths_paths_button")
        set_component_visible_with_parent(false, core:get_ui_root(), "character_details_panel", "character_context_parent", "TabGroup", "character_initiatives")
        find_uicomponent(core:get_ui_root(), "character_details_panel", "character_context_parent", "character_name", "panel_subtitle", "dy_subtype"):SetText("High Elf Vampire")
    end,
    true
);
core:add_listener(
    "idrinth_enableIdrinthsPaths",
    "ComponentLClickUp",
    function(context)
        local idrinth = Idrinth.get();
        if not idrinth then
            return false;
        end;
        return context.string == "idrinth_character_details_panel_idrinths_paths_button";
    end,
    function(context)
        set_component_visible_with_parent(true, core:get_ui_root(), "character_details_panel", "character_context_parent", "tab_panels", "idrinth_character_details_panel_idrinths_paths");      
        set_component_visible_with_parent(false, core:get_ui_root(), "character_details_panel", "character_context_parent", "tab_panels", "character_details_subpanel");
        set_component_visible_with_parent(false, core:get_ui_root(), "character_details_panel", "character_context_parent", "tab_panels", "skills_subpanel");
        set_component_visible_with_parent(false, core:get_ui_root(), "character_details_panel", "character_context_parent", "tab_panels", "sla_eternal_dance_subpanel");
        set_component_visible_with_parent(false, core:get_ui_root(), "character_details_panel", "character_context_parent", "tab_panels", "quests_subpanel");
        set_component_visible_with_parent(false, core:get_ui_root(), "character_details_panel", "character_context_parent", "tab_panels", "character_initiatives_holder");
        set_component_visible_with_parent(false, core:get_ui_root(), "character_details_panel", "character_context_parent", "tab_panels", "fragments_subpanel");
        set_component_visible_with_parent(false, core:get_ui_root(), "character_details_panel", "character_context_parent", "tab_panels", "vows_subpanel");
        set_component_visible_with_parent(false, core:get_ui_root(), "character_details_panel", "character_context_parent", "TabGroup", "character_initiatives")
    end,
    true
);
core:add_listener(
    "idrinth_disableIdrinthsPaths",
    "ComponentLClickUp",
    function(context)
        local idrinth = Idrinth.get();
        if not idrinth then
            return false;
        end;
        return true;
    end,
    function(context)
        if context.string == "idrinth_character_details_panel_idrinths_paths_button" then
            return;
        end;
        if context.string == "details" then
            set_component_visible_with_parent(false, core:get_ui_root(), "character_details_panel", "character_context_parent", "tab_panels", "idrinth_character_details_panel_idrinths_paths");
            set_component_visible_with_parent(true, core:get_ui_root(), "character_details_panel", "character_context_parent", "tab_panels", "stats_effects_holder");
            set_component_visible_with_parent(true, core:get_ui_root(), "character_details_panel", "character_context_parent", "tab_panels", "character_details_subpanel");
        elseif context.string == "skills" then
            set_component_visible_with_parent(false, core:get_ui_root(), "character_details_panel", "character_context_parent", "tab_panels", "idrinth_character_details_panel_idrinths_paths");
            set_component_visible_with_parent(true, core:get_ui_root(), "character_details_panel", "character_context_parent", "tab_panels", "stats_effects_holder");
            set_component_visible_with_parent(true, core:get_ui_root(), "character_details_panel", "character_context_parent", "tab_panels", "skills_subpanel");
        elseif context.string == "eternal_dance" then
            set_component_visible_with_parent(false, core:get_ui_root(), "character_details_panel", "character_context_parent", "tab_panels", "idrinth_character_details_panel_idrinths_paths");
            set_component_visible_with_parent(true, core:get_ui_root(), "character_details_panel", "character_context_parent", "tab_panels", "sla_eternal_dance_subpanel");
        elseif context.string == "quests" then
            set_component_visible_with_parent(false, core:get_ui_root(), "character_details_panel", "character_context_parent", "tab_panels", "idrinth_character_details_panel_idrinths_paths");
            set_component_visible_with_parent(true, core:get_ui_root(), "character_details_panel", "character_context_parent", "tab_panels", "quests");
        elseif context.string == "fragments" then
            set_component_visible_with_parent(false, core:get_ui_root(), "character_details_panel", "character_context_parent", "tab_panels", "idrinth_character_details_panel_idrinths_paths");
            set_component_visible_with_parent(true, core:get_ui_root(), "character_details_panel", "character_context_parent", "tab_panels", "fragments_subpanel");
        elseif context.string == "vows" then
            set_component_visible_with_parent(false, core:get_ui_root(), "character_details_panel", "character_context_parent", "tab_panels", "idrinth_character_details_panel_idrinths_paths");
            set_component_visible_with_parent(true, core:get_ui_root(), "character_details_panel", "character_context_parent", "tab_panels", "vows_subpanel");
        elseif context.string == "changeling" then
            set_component_visible_with_parent(false, core:get_ui_root(), "character_details_panel", "character_context_parent", "tab_panels", "idrinth_character_details_panel_idrinths_paths");
            set_component_visible_with_parent(true, core:get_ui_root(), "character_details_panel", "character_context_parent", "tab_panels", "formless_horror_subpanel");
        end;
    end,
    true
);
Idrinth._lastClicked = "";
core:add_listener(
    "idrinth_OpenChapelView",
    "ComponentLClickUp",
    function(context)
        local idrinth = Idrinth.get();
        if not idrinth then
            return false;
        end;
        return context.string == "button_default_view" or context.string == "button_ally_view" or context.string == "button_player_foreign_view" or context.string == "button_player_foreign_trap_view" or context.string == "button_discovered_view" or context.string == "idrinth_settlement_panel_button";
    end,
    function(context)
        Idrinth._lastClicked = context.string;
        cm:callback(
            function()
                if Idrinth._lastClicked == "idrinth_settlement_panel_button" then
                    local parent = find_uicomponent(core:get_ui_root(), "settlement_panel", "settlement_list");
                    if not parent then
                        return;
                    end;
                    for i = 0, parent:ChildCount() - 1 do
                        local buttons = find_uicomponent(UIComponent(parent:Find(i)), "settlement_view", "toggle_button_holder", "button_list");
                        if UIComponent(buttons:Find("idrinth_settlement_panel_button")):VisibleFromRoot() and UIComponent(buttons:Find("idrinth_settlement_panel_button")):CurrentState() == "selected" then
                            for j = 0, buttons:ChildCount() - 1 do
                                if UIComponent(buttons:Find(j)):VisibleFromRoot() then
                                    UIComponent(buttons:Find(j)):SetState("active");
                                end;
                            end;
                            UIComponent(buttons:Find("idrinth_settlement_panel_button")):SetState("selected");
                            local settlement = find_uicomponent(UIComponent(parent:Find(i)), "settlement_view");
                            UIComponent(settlement:Find("default_view")):SetVisible(false);
                            UIComponent(settlement:Find("hostile_views")):SetVisible(false);
                            UIComponent(settlement:Find("discovered_views")):SetVisible(false);
                            UIComponent(settlement:Find("allied_view")):SetVisible(false);
                            UIComponent(settlement:Find("idrinth_settlement_hostile_slots")):SetVisible(true);
                        end;
                    end;
                elseif Idrinth._lastClicked == "button_default_view" or Idrinth._lastClicked == "button_ally_view" or Idrinth._lastClicked == "button_player_foreign_view" or Idrinth._lastClicked == "button_player_foreign_trap_view" or Idrinth._lastClicked == "button_discovered_view" then
                    local parent = find_uicomponent(core:get_ui_root(), "settlement_panel", "settlement_list");
                    if not parent then
                        return;
                    end;            
                    for i = 0, parent:ChildCount() - 1 do
                        local buttons = find_uicomponent(UIComponent(parent:Find(i)), "settlement_view", "toggle_button_holder", "button_list");
                        if UIComponent(buttons:Find(Idrinth._lastClicked)):CurrentState() == "selected" and UIComponent(buttons:Find("idrinth_settlement_panel_button")):CurrentState() == "selected" and UIComponent(buttons:Find("idrinth_settlement_panel_button")):VisibleFromRoot() then
                            UIComponent(buttons:Find("idrinth_settlement_panel_button")):SetState("active");
                            local settlement = find_uicomponent(UIComponent(parent:Find(i)), "settlement_view");
                            UIComponent(settlement:Find("idrinth_settlement_hostile_slots")):SetVisible(false);
                            if context.string == "button_default_view" then
                                UIComponent(settlement:Find("default_view")):SetVisible(true);
                            elseif context.string == "button_ally_view" then
                                UIComponent(settlement:Find("allied_view")):SetVisible(true);
                            elseif context.string == "button_player_foreign_view" then
                                UIComponent(settlement:Find("hostile_views")):SetVisible(true);
                            elseif context.string == "button_player_foreign_trap_view" then
                                UIComponent(settlement:Find("hostile_views")):SetVisible(true);
                            elseif context.string == "button_discovered_view" then
                                UIComponent(settlement:Find("discovered_views")):SetVisible(true);
                            end;
                        end;
                    end;
                end;
            end,
            1
        );
    end,
    true
);
core:add_listener(
    "idrinth_SettlementPanelOpened",
    "PanelOpenedCampaign",
    function(context)
        local idrinth = Idrinth.get();
        if not idrinth then
            return false;
        end;
        return context.string == "settlement_panel";
    end,
    function(context)
        out("IDRINTH DEBUG: ===== CREATING SETTLEMENT DETAIL UI =====");
        local parent = find_uicomponent(core:get_ui_root(), "settlement_panel", "settlement_list");
        if not parent then
            return;
        end;
        for i = 1, parent:ChildCount() - 1 do
            local settlementSlots = find_uicomponent(UIComponent(parent:Find(i)), "settlement_view", "hostile_views", "settlement_hostile_slots");
            local settlement = find_uicomponent(UIComponent(parent:Find(i)), "settlement_view");
            local element;
            if i == 1 then
                element = core:get_or_create_component(
                    "idrinth_settlement_hostile_slots",
                    "ui/idrinth/idrinth_settlement_hostile_slots_capital.twui.xml",
                    settlement
                );
            else
                element = core:get_or_create_component(
                    "idrinth_settlement_hostile_slots",
                    "ui/idrinth/idrinth_settlement_hostile_slots.twui.xml",
                    settlement
                );
            end;
            element:SetContextObject(settlementSlots:GetContextObject("CcoCampaignSettlement"));
            element:SetVisible(false);
            local buttons = find_uicomponent(UIComponent(parent:Find(i)), "settlement_view", "toggle_button_holder", "button_list");
            local button = core:get_or_create_component(
                "idrinth_settlement_panel_button",
                "ui/idrinth/idrinth_settlement_panel_button.twui.xml",
                buttons
            );
            button:SetContextObject(settlementSlots:GetContextObject("CcoCampaignSettlement"));
        end;
    end,
    true
);
core:add_listener(
    "idrinth_BuildingBrowserPanelOpened",
    "PanelOpenedCampaign",
    function(context)
        local idrinth = Idrinth.get();
        if not idrinth then
            return false;
        end;
        return context.string == "building_browser";
    end,
    function(context)
        out("IDRINTH DEBUG: ===== CREATING SETTLEMENT DETAIL UI =====");
        local parent = find_uicomponent(core:get_ui_root(), "building_browser", "main", "footer", "settlement_list");
        if not parent then
            return;
        end;
        for i = 1, parent:ChildCount() - 1 do
            local settlement = find_uicomponent(UIComponent(parent:Find(i)), "settlement_view", "hostile_views", "settlement_hostile_slots");
            local element = core:get_or_create_component(
                "idrinth_settlement_hostile_slots",
                "ui/idrinth/idrinth_settlement_hostile_slots.twui.xml",
                settlement
            );
            element:SetContextObject(settlement:GetContextObject("CcoCampaignSettlement"));
        end;
    end,
    true
);
core:add_listener(
    "idrinth_SettlementSelected",
    "CampaignSettlementSelectedAny",
    function(context)
        local idrinth = Idrinth.get();
        if not idrinth then
            return false;
        end;
        return true;
    end,
    function(context)
        out("IDRINTH DEBUG: ===== UPDATING SETTLEMENT DETAIL UI =====");
        local parent = find_uicomponent(core:get_ui_root(), "settlement_panel", "settlement_list");
        if not parent then
            return;
        end;
        for i = 1, parent:ChildCount() - 1 do
            core:get_or_create_component(
                "idrinth_settlement_hostile_slots",
                "ui/idrinth/idrinth_settlement_hostile_slots.twui.xml",
                find_uicomponent(UIComponent(parent:Find(i)), "settlement_view", "hostile_views", "settlement_hostile_slots")
            );
        end;
    end,
    true
);
core:add_listener(
    "idrinth_BattleCompleted",
    "BattleCompleted",
    function(context)
        local idrinth = Idrinth.get();
        if not idrinth then
            return false;
        end;
        return cm:model():pending_battle():has_been_fought();
    end,
    function(context)
        out("IDRINTH DEBUG FUNCTION: BattleCompleted");
        local addResource = function(name, faction, amount, battleResult)
            local results = {
                asuryan = {
                    heroic_victory = 125,
                    decisive_victory = 150,
                    close_victory = 100,
                    pyrrhic_victory = 50,
                    valiant_defeat = 75,
                    close_defeat = 75,
                    decisive_defeat = 25,
                    crushing_defeat = 0
                },
                kurnous = {
                    heroic_victory = 125,
                    decisive_victory = 100,
                    close_victory = 100,
                    pyrrhic_victory = 100,
                    valiant_defeat = 25,
                    close_defeat = 25,
                    decisive_defeat = 25,
                    crushing_defeat = 25
                },
                khaine = {
                    heroic_victory = 150,
                    decisive_victory = 125,
                    close_victory = 100,
                    pyrrhic_victory = 75,
                    valiant_defeat = 75,
                    close_defeat = 50,
                    decisive_defeat = 25,
                    crushing_defeat = 0
                }
            };
            local amt = amount * results[name][battleResult]/100 * (0.94 + cm:random_number(11)/100);
            cm:pooled_resource_factor_transaction(faction:pooled_resource_manager(), "idrinth_" .. name .. "_battles", am);
        end;
        local idrinth, idrinthFaction = Idrinth.get();
        if not idrinth then
            return;
        end;
        local attackerWon = false;
        if cm:pending_battle_cache_attacker_victory() then
            attackerWon = true;
        end;
        local defenderWon = false;
        if cm:pending_battle_cache_defender_victory() then
            defenderWon = true;
        end;
        local idrinthIsAttacker = false;
        local idrinthFactionName = nil;
        local attackerCharacters = 0;
        for i = 1, cm:pending_battle_cache_num_attackers() do
            local char_cqi, mf_cqi, faction_name = cm:pending_battle_cache_get_attacker(i);
            local characters = cm:pending_battle_cache_get_attacker_embedded_character_subtypes(i);
            local general = cm:get_character_by_cqi(char_cqi);
            if general then
                attackerCharacters = attackerCharacters + 1;
                if general:character_subtype("idrinth_hev_high_elf_vampires_idrinthgeneral") then
                    idrinthIsAttacker = true;
                    idrinthFactionName = faction_name;
                end;
            end;
            for j=1, #characters do
                attackerCharacters = attackerCharacters + 1;
                if characters[j] == "idrinth_hev_high_elf_vampires_idrinthchampion" then
                    idrinthIsAttacker = true;
                    idrinthFactionName = faction_name;
                end;
                if characters[j] == "idrinth_hev_high_elf_vampires_idrinthgeneral" then
                    idrinthIsAttacker = true;
                    idrinthFactionName = faction_name;
                end;
            end;
        end;
        local idrinthIsDefender = false;
        local defenderCharacters = 0;
        for i = 1, cm:pending_battle_cache_num_defenders() do
            local char_cqi, mf_cqi, faction_name = cm:pending_battle_cache_get_defender(i);
            local characters = cm:pending_battle_cache_get_defender_embedded_character_subtypes(i);
            local general = cm:get_character_by_cqi(char_cqi);
            if general then
                defenderCharacters = defenderCharacters + 1;
                if general:character_subtype("idrinth_hev_high_elf_vampires_idrinthgeneral") then
                    idrinthIsDefender = true;
                    idrinthFactionName = faction_name;
                end;
            end;
            for j=1, #characters do
                defenderCharacters = defenderCharacters + 1;
                if characters[j] == "idrinth_hev_high_elf_vampires_idrinthchampion" then
                    idrinthIsDefender = true;
                    idrinthFactionName = faction_name;
                end;
                if characters[j] == "idrinth_hev_high_elf_vampires_idrinthgeneral" then
                    idrinthIsDefender = true;
                    idrinthFactionName = faction_name;
                end;
            end;
        end;
        if idrinthIsAttacker then
            Idrinth.battlesFought = Idrinth.battlesFought + 1;
            local base = 1;
            if attackerWon then
                base = 5;
            else
                for i = 1, cm:pending_battle_cache_num_defenders() do
                    local char_cqi, mf_cqi, faction_name = cm:pending_battle_cache_get_defender(i);
                    local general = cm:get_character_by_cqi(char_cqi);
                    if general then
                        cm:force_add_trait(
                            cm:char_lookup_str(general),
                            "idrinth_killer",
                            true,
                            1
                        );
                    end;
                end;
            end;
            addResource(
                "asuryan",
                idrinthFaction,
                base + (1 - cm:model():pending_battle():percentage_of_attacker_killed()) * cm:pending_battle_cache_defender_value()/cm:pending_battle_cache_attacker_value(),
                cm:model():pending_battle():attacker_battle_result()
            );
            addResource(
                "kurnous",
                idrinthFaction,
                base + (1 + defenderCharacters)/(1 + attackerCharacters) * 5,
                cm:model():pending_battle():attacker_battle_result()
            );
            addResource(
                "khaine",
                idrinthFaction,
                base + cm:model():pending_battle():attacker_kills() * 0.0175,
                cm:model():pending_battle():attacker_battle_result()
            );
            if cm:pending_battle_cache_culture_is_defender("wh2_main_hef_high_elves") then
                cm:force_add_trait(
                    cm:char_lookup_str(idrinth),
                    "idrinth_slayer_elves_asuryan",
                    true,
                    3
                );
                cm:force_add_trait(
                    cm:char_lookup_str(idrinth),
                    "idrinth_slayer_elves_kurnous",
                    true,
                    2
                );
                cm:force_add_trait(
                    cm:char_lookup_str(idrinth),
                    "idrinth_slayer_elves_khaine",
                    true,
                    1
                );
            end;
            if cm:pending_battle_cache_culture_is_defender("wh_dlc05_wef_wood_elves") then
                cm:force_add_trait(
                    cm:char_lookup_str(idrinth),
                    "idrinth_slayer_elves_asuryan",
                    true,
                    2
                );
                cm:force_add_trait(
                    cm:char_lookup_str(idrinth),
                    "idrinth_slayer_elves_kurnous",
                    true,
                    3
                );
                cm:force_add_trait(
                    cm:char_lookup_str(idrinth),
                    "idrinth_slayer_elves_khaine",
                    true,
                    1
                );
            end;
            if cm:pending_battle_cache_culture_is_defender("wh2_main_def_dark_elves") then
                cm:force_add_trait(
                    cm:char_lookup_str(idrinth),
                    "idrinth_slayer_elves_asuryan",
                    true,
                    2
                );
                cm:force_add_trait(
                    cm:char_lookup_str(idrinth),
                    "idrinth_slayer_elves_kurnous",
                    true,
                    1
                );
                cm:force_add_trait(
                    cm:char_lookup_str(idrinth),
                    "idrinth_slayer_elves_khaine",
                    true,
                    3
                );
            end;
        elseif idrinthIsDefender then
            Idrinth.battlesFought = Idrinth.battlesFought + 1;
            local base = 1;
            if defenderWon then
                base = 5;
            else
                for i = 1, cm:pending_battle_cache_num_attackers() do
                    local char_cqi, mf_cqi, faction_name = cm:pending_battle_cache_get_attacker(i);
                    local general = cm:get_character_by_cqi(char_cqi);
                    if general then
                        cm:force_add_trait(
                            cm:char_lookup_str(general),
                            "idrinth_killer",
                            true,
                            1
                        );
                    end;
                end;
            end;
            addResource(
                "asuryan",
                idrinthFaction,
                base + (1 - cm:model():pending_battle():percentage_of_defender_killed()) * cm:pending_battle_cache_attacker_value()/cm:pending_battle_cache_defender_value(),
                cm:model():pending_battle():defender_battle_result()
            );
            addResource(
                "kurnous",
                idrinthFaction,
                base + (1 + attackerCharacters)/(1 + defenderCharacters) * 5,
                cm:model():pending_battle():defender_battle_result()
            );
            addResource(
                "khaine",
                idrinthFaction,
                base + cm:model():pending_battle():defender_kills() * 0.0075,
                cm:model():pending_battle():defender_battle_result()
            );

            if cm:pending_battle_cache_culture_is_attacker("wh2_main_hef_high_elves") then
                cm:force_add_trait(
                    cm:char_lookup_str(idrinth),
                    "idrinth_slayer_elves_asuryan",
                    true,
                    3
                );
                cm:force_add_trait(
                    cm:char_lookup_str(idrinth),
                    "idrinth_slayer_elves_kurnous",
                    true,
                    2
                );
                cm:force_add_trait(
                    cm:char_lookup_str(idrinth),
                    "idrinth_slayer_elves_khaine",
                    true,
                    1
                );
            end;
            if cm:pending_battle_cache_culture_is_attacker("wh_dlc05_wef_wood_elves") then
                cm:force_add_trait(
                    cm:char_lookup_str(idrinth),
                    "idrinth_slayer_elves_asuryan",
                    true,
                    2
                );
                cm:force_add_trait(
                    cm:char_lookup_str(idrinth),
                    "idrinth_slayer_elves_kurnous",
                    true,
                    3
                );
                cm:force_add_trait(
                    cm:char_lookup_str(idrinth),
                    "idrinth_slayer_elves_khaine",
                    true,
                    1
                );
            end;
            if cm:pending_battle_cache_culture_is_attacker("wh2_main_def_dark_elves") then
                cm:force_add_trait(
                    cm:char_lookup_str(idrinth),
                    "idrinth_slayer_elves_asuryan",
                    true,
                    2
                );
                cm:force_add_trait(
                    cm:char_lookup_str(idrinth),
                    "idrinth_slayer_elves_kurnous",
                    false,
                    1
                );
                cm:force_add_trait(
                    cm:char_lookup_str(idrinth),
                    "idrinth_slayer_elves_khaine",
                    true,
                    3
                );
            end;
        end;
    end,
    true
);

core:add_listener(
    "idrinth_MctInitialized_Handling",
    "MctInitialized",
    true,
    function(context)
        out("IDRINTH DEBUG FUNCTION: MctInitialized");

        Idrinth._hasModConfig = true;

        local my_mod = context:mct():get_mod_by_key("idrinth")

        Idrinth._expandedCulturesActive = my_mod:get_option_by_key("expanded_spawn"):get_finalized_setting()

        Idrinth._unlockLevelAdjustment = Idrinth._levelAdjustment[my_mod:get_option_by_key("level_adjustment"):get_finalized_setting()]

        Idrinth._dilemmaCooldownMode = my_mod:get_option_by_key("dilemma_cooldown"):get_finalized_setting()

        Idrinth._enableChapels = my_mod:get_option_by_key("chapels"):get_finalized_setting()

        Idrinth._enableStoryEvents = my_mod:get_option_by_key("story_events"):get_finalized_setting()

        Idrinth._godBlessedItemRequirements = my_mod:get_option_by_key("god_item_difficulty"):get_finalized_setting()
    end,
    true
)
core:add_listener(
    "idrinth_MctFinalized_Handling",
    "MctFinalized",
    true,
    function(context)
        out("IDRINTH DEBUG FUNCTION: MctFinalized");

        Idrinth._hasModConfig = true;

        local my_mod = context:mct():get_mod_by_key("idrinth")

        Idrinth._expandedCulturesActive = my_mod:get_option_by_key("expanded_spawn"):get_finalized_setting()

        Idrinth._unlockLevelAdjustment = Idrinth._levelAdjustment[my_mod:get_option_by_key("level_adjustment"):get_finalized_setting()]

        Idrinth._dilemmaCooldownMode = my_mod:get_option_by_key("dilemma_cooldown"):get_finalized_setting()

        Idrinth._enableChapels = my_mod:get_option_by_key("chapels"):get_finalized_setting()

        Idrinth._enableStoryEvents = my_mod:get_option_by_key("story_events"):get_finalized_setting()

        Idrinth._godBlessedItemRequirements = my_mod:get_option_by_key("god_item_difficulty"):get_finalized_setting()
    end,
    true
);
core:add_listener(
    "idrinth_unitCreatedRename",
    "UnitCreated",
    function(context)
        local idrinth = Idrinth.get();
        if not idrinth then
            return false;
        end;
        return context:unit():unit_key() == "idrinth_hev_high_elf_vampires_chapel_asuryan_leader" or context:unit():unit_key() == "idrinth_hev_high_elf_vampires_chapel_kurnous_leader" or context:unit():unit_key() == "idrinth_hev_high_elf_vampires_chapel_khaine_leader" or context:unit():unit_key() == "idrinth_hev_high_elf_vampires_chapel_great_eagle" or context:unit():unit_key() == "idrinth_hev_high_elf_vampires_chapel_asuryan" or context:unit():unit_key() == "idrinth_hev_high_elf_vampires_chapel_kurnous" or context:unit():unit_key() == "idrinth_hev_high_elf_vampires_chapel_khaine" or context:unit():unit_key() == "idrinth_hev_high_elf_vampires_chapel_mixed" or context:unit():unit_key() == "idrinth_hev_high_elf_vampires_chapel_cave_bats" or context:unit():unit_key() == "idrinth_hev_high_elf_vampires_chapel_hawks" or context:unit():unit_key() == "idrinth_hev_high_elf_vampires_chapel_wolves";
    end,
    function(context)
        local length = #Idrinth._names;
        if length == 0 then
            out("No names in list");
            return;
        end;
        local name = Idrinth._names[cm:random_number(length)];
        out("Name: " .. name);
        if context:unit():unit_key() == "idrinth_hev_high_elf_vampires_chapel_asuryan_leader" or context:unit():unit_key() == "idrinth_hev_high_elf_vampires_chapel_kurnous_leader" or context:unit():unit_key() == "idrinth_hev_high_elf_vampires_chapel_khaine_leader" or context:unit():unit_key() == "idrinth_hev_high_elf_vampires_chapel_great_eagle" then
            cm:change_custom_unit_name(context:unit(), name)
        else
            cm:change_custom_unit_name(context:unit(), name .. "'s " .. common.get_localised_string("land_units_onscreen_name_" .. context:unit():unit_key()));
        end;
    end,
    true
)

cm:add_saving_game_callback(
	function(context)
        out("IDRINTH DEBUG FUNCTION: SavingGameCallback");
		cm:save_named_value("idrinth.activeRounds", Idrinth.activeRounds, context);
		cm:save_named_value("idrinth.battlesFought", Idrinth.battlesFought, context);
		cm:save_named_value("idrinth.charactersAssassinated", Idrinth.charactersAssassinated, context);
		cm:save_named_value("idrinth.unlockLevelAdjustment", Idrinth._unlockLevelAdjustment, context);
		for name, element in pairs(Idrinth.dilemmas) do
            if element.triggered then
                cm:save_named_value("idrinth.dilemmas." .. name, 1, context);
            end;
		end;
		for name, element in pairs(Idrinth._unlockMissionStarted) do
            if element then
                cm:save_named_value("idrinth.unlocks." .. name, 1, context);
            end;
		end;
		cm:save_named_value("idrinth.dilemmaCooldown", Idrinth._dilemmaCooldown, context);
		if Idrinth._expandedCulturesActive then
            cm:save_named_value("idrinth.expandedCultures", 1, context)
        end;
        for name, element in pairs(Idrinth._godFavourDilemmas) do
            cm:save_named_value("idrinth.godFavour." .. name, element.cooldown, context);
        end;
        for name, element in pairs(Idrinth._item_dilemmas) do
            if element.triggered then
                cm:save_named_value("idrinth.item_dilemmas." .. name, 1, context);
            end;
        end;
        if Idrinth._enableChapels then
            cm:save_named_value("idrinth.enableChapels", 1, context);
        elseif Idrinth._enableChapels == false then
            cm:save_named_value("idrinth.enableChapels", 0, context);
        end;
        cm:save_named_value("idrinth.version.main", Idrinth.currentVersion.main, context);
        cm:save_named_value("idrinth.version.feature", Idrinth.currentVersion.feature, context);
        cm:save_named_value("idrinth.version.bug", Idrinth.currentVersion.bug, context);
        for region, data in pairs(Idrinth.place_of_interest) do
            if data.triggered then
                cm:save_named_value("idrinth.poi."..region, 1, context)
            end;            
        end;
	end
);
cm:add_loading_game_callback(
	function(context)
        out("IDRINTH DEBUG FUNCTION: LoadingGameCallback");
		if cm:is_new_game() == false then
            Idrinth.activeRounds = cm:load_named_value("idrinth.activeRounds", Idrinth.activeRounds, context);
            Idrinth.battlesFought = cm:load_named_value("idrinth.battlesFought", Idrinth.battlesFought, context);
            Idrinth.charactersAssassinated = cm:load_named_value("idrinth.charactersAssassinated", Idrinth.charactersAssassinated, context);
            Idrinth._dilemmaCooldown = cm:load_named_value("idrinth.dilemmaCooldown", Idrinth._dilemmaCooldown, context);
            Idrinth._expandedCulturesActive = (cm:load_named_value("idrinth.expandedCultures", 0, context) == 1);
            Idrinth._unlockLevelAdjustment = cm:load_named_value("idrinth.unlockLevelAdjustment", 0, context);
            Idrinth._enableChapels = (cm:load_named_value("idrinth.enableChapels", 0, context) == 1);
            for name, element in pairs(Idrinth.dilemmas) do
                element.triggered = (cm:load_named_value("idrinth.dilemmas." .. name, 0, context) == 1);
            end;
            for name, element in pairs(Idrinth._godFavourDilemmas) do
                element.cooldown = cm:load_named_value("idrinth.godFavour." .. name, 0, context);
            end;
            for name, element in pairs(Idrinth._item_dilemmas) do
                element.triggered = (cm:load_named_value("idrinth.item_dilemmas." .. name, 0, context) == 1);
            end;
            for name, element in pairs(Idrinth.place_of_interest) do
                element.triggered = (cm:load_named_value("idrinth.poi." .. name, 0, context) == 1);
            end;
            version = {
                main =  cm:load_named_value("idrinth.version.main", 0, context),
                feature =  cm:load_named_value("idrinth.version.feature", 0, context),
                bug =  cm:load_named_value("idrinth.version.bug", 0, context),
            };
            if Idrinth.isCurrentVersionNewerThan(version.main, version.feature, version.bug) then
                -- for the next upgrade
            end;
            local possible_factions = {
                "wh2_dlc09_tmb_dune_kingdoms",
                "wh2_dlc09_tmb_exiles_of_nehek",
                "wh2_dlc09_tmb_followers_of_nagash",
                "wh2_dlc09_tmb_khemri",
                "wh2_dlc09_tmb_lybaras",
                "wh2_dlc09_tmb_numas",
                "wh2_dlc09_tmb_rakaph_dynasty",
                "wh2_dlc09_tmb_the_sentinels",
                "wh2_dlc09_tmb_tomb_kings",
                "wh2_dlc09_tmb_tomb_kings_rebels",
                "wh2_dlc09_tmb_tombking_qb1",
                "wh2_dlc09_tmb_tombking_qb2",
                "wh2_dlc09_tmb_tombking_qb3",
                "wh2_dlc09_tmb_tombking_qb4",
                "wh2_dlc09_tmb_tombking_qb_exiles_of_nehek",
                "wh2_dlc09_tmb_tombking_qb_followers_of_nagash",
                "wh2_dlc09_tmb_tombking_qb_khemri",
                "wh2_dlc09_tmb_tombking_qb_lybaras",
                "wh2_dlc10_def_blood_voyage",
                "wh2_dlc11_cst_noctilus",
                "wh2_dlc11_cst_noctilus_separatists",
                "wh2_dlc11_cst_pirates_of_sartosa",
                "wh2_dlc11_cst_pirates_of_sartosa_separatists",
                "wh2_dlc11_cst_the_drowned",
                "wh2_dlc11_cst_the_drowned_separatists",
                "wh2_dlc11_cst_vampire_coast",
                "wh2_dlc11_cst_vampire_coast_encounters",
                "wh2_dlc11_cst_vampire_coast_qb1",
                "wh2_dlc11_cst_vampire_coast_qb2",
                "wh2_dlc11_cst_vampire_coast_qb3",
                "wh2_dlc11_cst_vampire_coast_qb4",
                "wh2_dlc11_cst_vampire_coast_rebellion_rebels",
                "wh2_dlc11_cst_vampire_coast_rebels",
                "wh2_dlc11_cst_vampire_coast_separatists",
                "wh2_dlc11_def_the_blessed_dread",
                "wh2_dlc11_def_the_blessed_dread_separatists",
                "wh2_dlc11_emp_empire_qb5",
                "wh2_dlc11_vmp_the_barrow_legion",
                "wh2_dlc13_emp_golden_order",
                "wh2_dlc13_emp_the_huntmarshals_expedition",
                "wh2_dlc13_wef_laurelorn_forest",
                "wh2_dlc14_brt_chevaliers_de_lyonesse",
                "wh2_dlc15_hef_dragon_encounters",
                "wh2_dlc15_hef_imrik",
                "wh2_dlc16_emp_colonist_invasion",
                "wh2_dlc16_emp_empire_invasion",
                "wh2_dlc16_emp_empire_qb8",
                "wh2_dlc16_vmp_lahmian_sisterhood",
                "wh2_dlc16_wef_drycha",
                "wh2_dlc16_wef_sisters_of_twilight",
                "wh2_dlc16_wef_waystone_faction_1",
                "wh2_dlc16_wef_waystone_faction_2",
                "wh2_dlc16_wef_waystone_faction_3",
                "wh2_dlc16_wef_wood_elves_qb4",
                "wh2_dlc16_wef_wood_elves_qb5",
                "wh2_dlc16_wef_wood_elves_qb6",
                "wh2_dlc16_wef_wood_elves_qb7",
                "wh2_main_brt_knights_of_origo",
                "wh2_main_brt_knights_of_the_flame",
                "wh2_main_brt_thegans_crusaders",
                "wh2_main_def_bleak_holds",
                "wh2_main_def_blood_hall_coven",
                "wh2_main_def_clar_karond",
                "wh2_main_def_cult_of_excess",
                "wh2_main_def_cult_of_pleasure",
                "wh2_main_def_cult_of_pleasure_separatists",
                "wh2_main_def_dark_elves",
                "wh2_main_def_dark_elves_qb1",
                "wh2_main_def_dark_elves_qb2",
                "wh2_main_def_dark_elves_qb3",
                "wh2_main_def_dark_elves_qb4",
                "wh2_main_def_dark_elves_rebels",
                "wh2_main_def_deadwood_sentinels",
                "wh2_main_def_drackla_coven",
                "wh2_main_def_ghrond",
                "wh2_main_def_hag_graef",
                "wh2_main_def_hag_graef_separatists",
                "wh2_main_def_har_ganeth",
                "wh2_main_def_har_ganeth_separatists",
                "wh2_main_def_karond_kar",
                "wh2_main_def_naggarond",
                "wh2_main_def_naggarond_separatists",
                "wh2_main_def_scourge_of_khaine",
                "wh2_main_def_ssildra_tor",
                "wh2_main_def_the_forgebound",
                "wh2_main_emp_new_world_colonies",
                "wh2_main_emp_new_world_colonies_mp",
                "wh2_main_emp_pirates_of_sartosa",
                "wh2_main_emp_pirates_of_sartosa_mp",
                "wh2_main_emp_sudenburg",
                "wh2_main_hef_avelorn",
                "wh2_main_hef_caledor",
                "wh2_main_hef_chrace",
                "wh2_main_hef_citadel_of_dusk",
                "wh2_main_hef_cothique",
                "wh2_main_hef_eataine",
                "wh2_main_hef_eataine_mp",
                "wh2_main_hef_ellyrion",
                "wh2_main_hef_fortress_of_dawn",
                "wh2_main_hef_high_elves",
                "wh2_main_hef_high_elves_qb1",
                "wh2_main_hef_high_elves_qb2",
                "wh2_main_hef_high_elves_qb3",
                "wh2_main_hef_high_elves_qb4",
                "wh2_main_hef_high_elves_qb5",
                "wh2_main_hef_high_elves_qb6",
                "wh2_main_hef_high_elves_qb7",
                "wh2_main_hef_high_elves_qb8",
                "wh2_main_hef_high_elves_rebels",
                "wh2_main_hef_nagarythe",
                "wh2_main_hef_order_of_loremasters",
                "wh2_main_hef_saphery",
                "wh2_main_hef_tiranoc",
                "wh2_main_hef_tor_elasor",
                "wh2_main_hef_yvresse",
                "wh2_main_vmp_necrarch_brotherhood",
                "wh2_main_vmp_strygos_empire",
                "wh2_main_vmp_the_silver_host",
                "wh2_main_wef_bowmen_of_oreon",
                "wh2_twa03_def_rakarth",
                "wh2_twa03_def_rakarth_separatists",
                "wh3_dlc20_brt_march_of_couronne",
                "wh3_dlc21_cst_dead_flag_fleet",
                "wh3_dlc21_vmp_jiangshi_rebels",
                "wh3_dlc21_wef_spirits_of_shanlin",
                "wh3_dlc24_cst_vampire_coast_bloated_rebels",
                "wh3_dlc24_cth_the_celestial_court",
                "wh3_dlc25_vmp_the_court_of_night",
                "wh3_dlc25_vmp_vampire_counts_invasion",
                "wh3_dlc25_wef_wood_elves_invasion",
                "wh3_dlc26_cst_vampire_coast_qb1",
                "wh3_dlc26_cst_vampire_coast_qb2",
                "wh3_dlc26_def_dark_elves_invasion",
                "wh3_dlc26_hef_high_elves_invasion",
                "wh3_dlc26_vmp_templehof_qb",
                "wh3_dlc27_brt_bretonnia_dm",
                "wh3_dlc27_cth_cathay_dm",
                "wh3_dlc27_def_dark_elves_dm",
                "wh3_dlc27_emp_empire_dm",
                "wh3_dlc27_hef_aislinn",
                "wh3_dlc27_hef_aislinn_confederation_owner",
                "wh3_dlc27_hef_high_elves_dm",
                "wh3_dlc27_teb_tilea_dm",
                "wh3_dlc27_wef_wood_elves_dm",
                "wh3_main_brt_aquitaine",
                "wh3_main_cst_dread_rock_privateers",
                "wh3_main_cth_burning_wind_nomads",
                "wh3_main_cth_cathay_mp",
                "wh3_main_cth_cathay_qb1",
                "wh3_main_cth_cathay_qb2",
                "wh3_main_cth_cathay_qb3",
                "wh3_main_cth_cathay_rebels",
                "wh3_main_cth_celestial_loyalists",
                "wh3_main_cth_dissenter_lords_of_jinshen",
                "wh3_main_cth_eastern_river_lords",
                "wh3_main_cth_imperial_wardens",
                "wh3_main_cth_rebel_lords_of_nan_yang",
                "wh3_main_cth_the_jade_custodians",
                "wh3_main_cth_the_northern_provinces",
                "wh3_main_cth_the_western_provinces",
                "wh3_main_emp_cult_of_sigmar",
                "wh3_main_ie_vmp_sires_of_mourkain",
                "wh3_main_tmb_deserters_of_khatep",
                "wh3_main_vmp_caravan_of_blue_roses",
                "wh3_main_vmp_lahmian_sisterhood",
                "wh3_main_vmp_nagashizzar",
                "wh3_main_wef_laurelorn",
                "wh3_prologue_dervingard_garrison",
                "wh3_prologue_kislev_expedition",
                "wh_dlc05_brt_brionne",
                "wh_dlc05_brt_gisoroux",
                "wh_dlc05_brt_montfort",
                "wh_dlc05_brt_quenelles",
                "wh_dlc05_wef_anmyr",
                "wh_dlc05_wef_argwylon",
                "wh_dlc05_wef_arranoc",
                "wh_dlc05_wef_atylwyth",
                "wh_dlc05_wef_cavaroc",
                "wh_dlc05_wef_cythral",
                "wh_dlc05_wef_fyr_darric",
                "wh_dlc05_wef_modryn",
                "wh_dlc05_wef_tirsyth",
                "wh_dlc05_wef_torgovann",
                "wh_dlc05_wef_wood_elves",
                "wh_dlc05_wef_wood_elves_qb1",
                "wh_dlc05_wef_wood_elves_qb2",
                "wh_dlc05_wef_wood_elves_qb3",
                "wh_dlc05_wef_wood_elves_rebels",
                "wh_dlc05_wef_wydrioth",
                "wh_main_brt_artois",
                "wh_main_brt_bastonne",
                "wh_main_brt_bordeleaux",
                "wh_main_brt_bretonnia",
                "wh_main_brt_bretonnia_qb1",
                "wh_main_brt_bretonnia_qb2",
                "wh_main_brt_bretonnia_qb3",
                "wh_main_brt_bretonnia_qb4",
                "wh_main_brt_bretonnia_rebels",
                "wh_main_brt_carcassonne",
                "wh_main_brt_lyonesse",
                "wh_main_brt_parravon",
                "wh_main_emp_averland",
                "wh_main_emp_empire",
                "wh_main_emp_empire_qb1",
                "wh_main_emp_empire_qb2",
                "wh_main_emp_empire_qb3",
                "wh_main_emp_empire_qb4",
                "wh_main_emp_empire_qb5",
                "wh_main_emp_empire_qb_intro",
                "wh_main_emp_empire_rebels",
                "wh_main_emp_empire_rebels_qb1",
                "wh_main_emp_empire_separatists",
                "wh_main_emp_hochland",
                "wh_main_emp_marienburg",
                "wh_main_emp_marienburg_rebels",
                "wh_main_emp_middenland",
                "wh_main_emp_nordland",
                "wh_main_emp_ostermark",
                "wh_main_emp_ostland",
                "wh_main_emp_stirland",
                "wh_main_emp_talabecland",
                "wh_main_emp_wissenland",
                "wh_main_teb_border_princes",
                "wh_main_teb_border_princes_mp",
                "wh_main_teb_border_princes_rebels",
                "wh_main_teb_estalia",
                "wh_main_teb_estalia_mp",
                "wh_main_teb_estalia_rebels",
                "wh_main_teb_tilea",
                "wh_main_teb_tilea_mp",
                "wh_main_teb_tilea_rebels",
                "wh_main_vmp_mousillon",
                "wh_main_vmp_rival_sylvanian_vamps",
                "wh_main_vmp_schwartzhafen",
                "wh_main_vmp_vampire_counts",
                "wh_main_vmp_vampire_counts_qb1",
                "wh_main_vmp_vampire_counts_qb2",
                "wh_main_vmp_vampire_counts_qb3",
                "wh_main_vmp_vampire_counts_qb4",
                "wh_main_vmp_vampire_rebels",
                "wh_main_vmp_waldenhof",
            };
            for name in possible_factions do
                local stored = cm:load_named_value("idrinth.unlocks." .. name, 0, context);
                if stored == 1 then
                    Idrinth._unlockMissionStarted[name] = true;
                elseif stored == "1" then
                    Idrinth._unlockMissionStarted[name] = true;
                end;
            end;
		end;
	end
);
cm:add_first_tick_callback(                                                                       
    function()
        out("IDRINTH DEBUG FUNCTION: PostFirstTickCallback");
        local idrinth, faction = Idrinth.get();
        if faction == cm:get_local_faction() then
            local parent = find_uicomponent(core:get_ui_root(), "hud_campaign", "resources_bar_holder", "resources_bar");
            out("IDRINTH DEBUG: ===== CREATING UI =====");
            local asuryan = core:get_or_create_component(
                "idrinth_pooled_resource_asuryan",
                "ui/idrinth/idrinth_pooled_resource_asuryan.twui.xml",
                parent
            );
            local kurnous = core:get_or_create_component(
                "idrinth_pooled_resource_kurnous",
                "ui/idrinth/idrinth_pooled_resource_kurnous.twui.xml",
                parent
            );
            local khaine = core:get_or_create_component(
                "idrinth_pooled_resource_khaine",
                "ui/idrinth/idrinth_pooled_resource_khaine.twui.xml",
                parent
            );
            campaign_manager:add_pooled_resource_changed_listener_by_faction(
                "idrinth_PooledResourceListener",
                faction:name(),
                function(context)
                    if context:amount() == 0 then
                        return;
                    end;
                    local parent = find_uicomponent(core:get_ui_root(), "hud_campaign", "resources_bar_holder", "resources_bar");
                    if context:resource():key() == "idrinth_asuryan" then
                        local asuryan = core:get_or_create_component(
                            "idrinth_pooled_resource_asuryan",
                            "ui/idrinth/idrinth_pooled_resource_asuryan.twui.xml",
                            parent
                        );
                        UIComponent(asuryan:Find(0)):SetText(context:resource():value());
                    end;
                    if context:resource():key() == "idrinth_kurnous" then
                        local kurnous = core:get_or_create_component(
                            "idrinth_pooled_resource_kurnous",
                            "ui/idrinth/idrinth_pooled_resource_kurnous.twui.xml",
                            parent
                        );        
                        UIComponent(kurnous:Find(0)):SetText(context:resource():value());            
                    end;
                    if context:resource():key() == "idrinth_khaine" then
                        local khaine = core:get_or_create_component(
                            "idrinth_pooled_resource_khaine",
                            "ui/idrinth/idrinth_pooled_resource_khaine.twui.xml",
                            parent
                        );
                        UIComponent(khaine:Find(0)):SetText(context:resource():value());
                    end;
                end,
                true
            )
        end;
    end
);