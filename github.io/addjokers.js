let combatAceJokers = [
  {
    name: "Combat Ace - Soldier",
    text: [
      "Played {C:attention}Aces{} each",
      "give {C:chips}+35{} Chips",
      "when scored."
    ],
    image_url: "assets/1x/ca_soldier.png",
    rarity: "Common"
  },
  {
    name: "Combat Ace - Supplies",
    text: [
      "For every {C:red}3 discarded{} ",
      "{C:attention}Aces{} get {C:money}$3{}.",
      "+{C:money}$1{} every time it activates",
      "{C:inactive}(Next supply drop in: 3)"
    ],
    image_url: "assets/1x/ca_supplies.png",
    rarity: "Common"
  },
  {
    name: "Combat Ace - Mercenary",
    text: [
      "Played {C:attention}Aces{} each give",
      "{X:mult,C:white}X1.2{} Mult. At the",
      "end of Round pay {C:money}$2{}",
      "If unable to pay, destroy this Joker."
    ],
    image_url: "assets/1x/ca_mercenary.png",
    rarity: "Common"
  },
  {
    name: "Combat Ace - Promotion",
    text: [
      "Played {C:attention}Aces{} have a",
      "{C:green}1 in 6{} chance to",
      "become a random edition"
    ],
    image_url: "assets/1x/ca_promotion.png",
    rarity: "Uncommon"
  },
  {
    name: "Combat Ace - Recruiter",
    text: [
      "{C:red}Discarded cards{} have a",
      "{C:green}1 in 8{} chance to",
      "become an {C:attention}Ace{}"
    ],
    image_url: "assets/1x/ca_recruiter.png",
    rarity: "Uncommon"
  },
  {
    name: "Combat Ace - General",
    text: [
      "{X:mult,C:white}X0.2{} Mult for each",
      "remaining {C:attention}Ace{} in Deck",
      "{C:inactive}(Currently {X:mult,C:white}X1{} Mult)"
    ],
    image_url: "assets/1x/ca_general.png",
    rarity: "Rare"
  },
  {
    name: "Combat Ace - Veteran",
    text: [
      "Each {C:attention}Ace{}",
      "held in hand",
      "gives {X:mult,C:white}X1.5{} Mult"
    ],
    image_url: "assets/1x/ca_veteran.png",
    rarity: "Rare"
  }
];

let jurassicJokers = [
  {
    name: "Jurassic - Quetzalcoatlus",
    text: [
      "Retrigger each played",
      "{C:attention}Ace{} and {C:attention}Stone Card{}.",
      "{C:green}1 in 4{} chance to go extinct",
      "at the end of round."
    ],
    image_url: "assets/1x/ju_quetzalcoatlus.png",
    rarity: "Rare"
  },
  {
    name: "Jurassic - T-Rex",
    text: [
      "Every played {C:attention}King{}",
      "and {C:attention}Stone Card{} permanently",
      "gains {C:chips}+10 Chips{} and {C:mult}+2 Mult{}",
      "when scored.",
      "{C:green}1 in 4{} chance to go extinct",
      "at the end of round."
    ],
    image_url: "assets/1x/ju_trex.png",
    rarity: "Rare"
  },
  {
    name: "Jurassic - Mosasaurus",
    text: [
      "This Joker gains {C:chips}+15{} Chips",
      "for every scored {C:attention}Queen{}",
      "and {C:attention}Stone Card{}.",
      "{C:green}1 in 4{} chance to go extinct",
      "at the end of round.",
      "{C:inactive}(Currently {C:chips}+45{} Chips)"
    ],
    image_url: "assets/1x/ju_mosasaurus.png",
    rarity: "Rare"
  },
  {
    name: "Jurassic - Brachiosaurus",
    text: [
      "Gives {C:mult}2{} Mult for each {C:attention}Jack{} and",
      "{C:attention}Stone Card{} in your full deck.",
      "{C:green}1 in 4{} chance to go extinct",
      "at the end of round.",
      "{C:inactive}(Currently {C:mult}6{} Mult)"
    ],
    image_url: "assets/1x/ju_brachiosaurus.png",
    rarity: "Rare"
  },
  {
    name: "Jurassic - Fossil",
    text: [
      "Played {C:attention}Aces{} and {C:attention}Stone Cards{}",
      "each give {X:mult,C:white}X1.5{} Mult when scored"
    ],
    image_url: "assets/1x/ju_fossil_quetz.png",
    rarity: "Uncommon"
  },
  {
    name: "Jurassic - Fossil",
    text: [
      "Played {C:attention}Kings{} and {C:attention}Stone Cards{}",
      "each give {X:mult,C:white}X1.5{} Mult when scored"
    ],
    image_url: "assets/1x/ju_fossil_rex.png",
    rarity: "Uncommon"
  },
  {
    name: "Jurassic - Fossil",
    text: [
      "Played {C:attention}Queens{} and {C:attention}Stone Cards{}",
      "each give {X:mult,C:white}X1.5{} Mult when scored"
    ],
    image_url: "assets/1x/ju_fossil_mosa.png",
    rarity: "Uncommon"
  },
  {
    name: "Jurassic - Fossil",
    text: [
      "Played {C:attention}Jacks{} and {C:attention}Stone Cards{}",
      "each give {X:mult,C:white}X1.5{} Mult when scored"
    ],
    image_url: "assets/1x/ju_fossil_brachio.png",
    rarity: "Uncommon"
  },
  {
    name: "Jurassic - Paleontologist",
    text: [
      "{C:attention}Stone Card{} held",
      "in Hand gives {X:mult,C:white}X1.2{} Mult"
    ],
    image_url: "assets/1x/ju_paleontologist.png",
    rarity: "Common"
  },
  {
    name: "Jurassic - Excavation",
    text: [
      "If first hand of round has",
      "no {C:attention}Stone Cards{}, all played cards",
      "become {C:attention}Stone Cards{}."
    ],
    image_url: "assets/1x/ju_excavation.png",
    rarity: "Uncommon"
  },
  {
    name: "Jurassic - Museum",
    text: [
      "Earn {C:money}$2{} for each {C:attention}Stone Card{}",
      "in your full deck at the end of round",
      "{C:inactive}(Currently {C:money}$6){}"
    ],
    image_url: "assets/1x/ju_museum.png",
    rarity: "Common"
  },
  {
    name: "Jurassic - Dinosaur Egg",
    text: [
      "After {C:attention}3{} rounds,",
      "hatches into a random {C:attention}Dinosaur{}",
      "or a {C:attention}Fossilized Egg{}.",
      "{C:inactive}(1/3){}"
    ],
    image_url: "assets/1x/ju_dinosauregg.png",
    rarity: "Uncommon"
  },
  {
    name: "Jurassic - Fossilized Egg",
    text: [
      "Played {C:attention}Stone Cards{}",
      "each give {C:money}$1{} when scored."
    ],
    image_url: "assets/1x/ju_fossil_egg.png",
    rarity: "Common"
  }
];

let infectedJokers = [
  {
    name: "Infected - Mutation",
    text: [
      "{C:green}Infected Cards{}",
      "give {X:mult,C:white}X1.2{} Mult",
      "when scored"
    ],
    image_url: "assets/1x/in_mutation.png",
    rarity: "Common"
  },
  {
    name: "Infected - Potency",
    text: [
      "Upgrades level of played",
      "{C:green}Infected Poker Hand{}"
    ],
    image_url: "assets/1x/in_potency.png",
    rarity: "Uncommon"
  },
  {
    name: "Infected - Joker",
    text: [
      "Spreads {C:green}Infection{}",
      "to a random card in deck",
      "when {C:attention}Blind{} is selected."
    ],
    image_url: "assets/1x/in_joker.png",
    rarity: "Common"
  },
  {
    name: "Infected - Contagion",
    text: [
      "{C:green}Infection{} also spreads",
      "{C:attention}Seals{} and {C:attention}Editions"
    ],
    image_url: "assets/1x/in_contagion.png",
    rarity: "Rare"
  },
  {
    name: "Infected - Swarm",
    text: [
      "Retrigger all",
      "{C:green}Infected Cards{}"
    ],
    image_url: "assets/1x/in_swarm.png",
    rarity: "Rare"
  },
  {
    name: "Infected - Plague Doctor",
    text: [
      "Gives {X:mult,C:white}X0.2{} Mult.",
      "for each {C:green}Infected Card{}",
      "in your full deck",
      "{C:inactive}(Currently {X:mult,C:white}X1{} Mult)"
    ],
    image_url: "assets/1x/in_plaguedoctor.png",
    rarity: "Rare"
  },
  {
    name: "Infected - Corrupted Joker",
    text: [
      "Played {C:green}Infected Cards{}",
      "give {C:mult}+3{} Mult",
      "when scored"
    ],
    image_url: "assets/1x/in_corruptedjoker.png",
    rarity: "Common"
  },
  {
    name: "Infected - Super Spreader",
    text: [
      "Played {C:green}Infected Cards{}",
      "have a {C:green}1 in 4{} chance to",
      "{C:green}Spread{} when scored"
    ],
    image_url: "assets/1x/in_superspreadder.png",
    rarity: "Uncommon"
  },
  {
    name: "Infected - Pulcinella",
    text: [
      "When you play an {C:green}Infected Poker Hand{},",
      "retrigger it once for each",
      "{C:green}Infected Card{} held in hand"
    ],
    image_url: "assets/1x/in_pulcinella.png",
    rarity: "Legendary"
  }
];

// Enhancement arrays
let infectedEnhancements = [
  {
    name: "Infected Card",
    text: [
      "Spreads {C:green}Infection{}.",
      "{X:chips,C:white}X15{} Chips while this card stays in hand",
      "when {C:green}Infected Poker Hand{} is played.",
      "{X:chips,C:white}X5{} Chips when this card stays in hand",
      "when any other Poker Hand is played."
    ],
    image_url: "assets/1x/infected.png",
    rarity: "Enhanced"
  }
];

// Combined array for backward compatibility
let jokers = [...combatAceJokers, ...jurassicJokers, ...infectedJokers];

let blinds = [
  {
    name: "Combat Ace - Desertation",
    text: [
      "All {C:attention}Aces{} are",
      "debuffed."
    ],
    image_url: "assets/1x/ca_desertation.png",
    rarity: "Blind"
  }
];

let cols = {
  RED: "#fe5f55",
  GREEN: "#4BC292",
  BLUE: "#009dff",
  YELLOW: "#f0c300",
  PURPLE: "#b26cbb",
  ORANGE: "#fe8c00",
  PINK: "#ff69b4",
  CYAN: "#00ced1",
  LIME: "#32cd32",
  GOLD: "#ffd700",
  SILVER: "#c0c0c0",
  BROWN: "#8b4513",
  GRAY: "#808080",
  BLACK: "#000000",
  WHITE: "#ffffff",
  MONEY: "#f0c300",
  CHIPS: "#4BC292",
  ATTENTION: "#ff9a00",
  INACTIVE: "#6b7280",
  MULT: "#fe5f55",
  JOKER_GREY: "#bfc7d5",
  VOUCHER: "#cb724c",
  BOOSTER: "#646eb7",
  EDITION: "#ffffff",
  DARK_EDITION: "#000000",
  ETERNAL: "#c75985",
  DYN_UI: {
    MAIN: "#374244",
    DARK: "#374244",
    BOSS_MAIN: "#374244",
    BOSS_DARK: "#374244",
    BOSS_PALE: "#374244"
  },
  SO_1: {
    Hearts: "#f03464",
    Diamonds: "#f06b3f",
    Spades: "#403995",
    Clubs: "#235955",
  },
  SO_2: {
    Hearts: "#f83b2f",
    Diamonds: "#e29000",
    Spades: "#4f31b9",
    Clubs: "#008ee6",
  },
  SUITS: {
      Hearts: "#FE5F55",
      Diamonds: "#FE5F55",
      Spades: "#374649",
      Clubs: "#424e54",
  },
  
  SET: {
    Default: "#cdd9dc",
    Enhanced: "#cdd9dc",
    Joker: "#424e54",
    Tarot: "#424e54",
    Planet: "#424e54",
    Spectral: "#424e54",
    Voucher: "#424e54",
  }, 
  SECONDARY_SET: {
    Default: "#9bb6bdFF",
    Enhanced: "#8389DDFF",
    Joker: "#708b91",
    Tarot: "#a782d1",
    Planet: "#13afce",
    Spectral: "#4584fa",
    Voucher: "#fd682b",
    Edition: "#4ca893",
  },
}

let rarities = {
  "Common": "#009dff", 
  "Uncommon": "#4BC292",
  "Rare": "#fe5f55",
  "Legendary": "#b26cbb",
  "Tarot": "#424e54",
  "Blind": "#8b4513",
  "Enhanced": "#8389DD"
}

regex = /{([^}]+)}/g;

function processText(text, card) {
  text = text.map((line) => { return line + "{}"});
  text = text.join("<br/>");
  text = text.replaceAll("{}", "</span>");
  text = text.replace(regex, function replacer(match, p1, offset, string, groups) {
    let classes = p1.split(",");
    let css_styling = "";

    for (let i = 0; i < classes.length; i++) {
      let parts = classes[i].split(":");
      if (parts[0] === "C") {
        css_styling += `color: ${cols[parts[1].toUpperCase()]};`;
      } else if (parts[0] === "X") {
        css_styling += `background-color: ${cols[parts[1].toUpperCase()]}; border-radius: 5px; padding: 0 5px;`;
      }
    }

    return `</span><span style='${css_styling}'>`;
  });
  
  return text;
}

function createCardElement(card, type) {
  let card_div = document.createElement("div");
  card_div.classList.add(type === "blind" ? "blind" : "joker");
  
  let processedText = processText(card.text, card);
  
  card_div.innerHTML = `
    <h3>${card.name}</h3>
    <img src="${card.image_url}" alt="${card.name}" />
    <h4 class="rarity" style="background-color: ${rarities[card.rarity]}">${card.rarity}</h4>
    <div class="text">${processedText}</div>
  `;

  return card_div;
}

// Add Combat Ace jokers
let combat_aces_jokers_div = document.querySelector("#combat-aces .jokers");
for (let joker of combatAceJokers) {
  console.log("adding combat ace joker", joker.name);
  let joker_div = createCardElement(joker, "joker");
  combat_aces_jokers_div.appendChild(joker_div);
}

// Add Jurassic jokers
let jurassic_jokers_div = document.querySelector("#jurassic .jokers");
if (jurassic_jokers_div) {
  for (let joker of jurassicJokers) {
    console.log("adding jurassic joker", joker.name);
    let joker_div = createCardElement(joker, "joker");
    jurassic_jokers_div.appendChild(joker_div);
  }
}

// Add Infected jokers
let infected_jokers_div = document.querySelector("#infected .jokers");
if (infected_jokers_div) {
  for (let joker of infectedJokers) {
    console.log("adding infected joker", joker.name);
    let joker_div = createCardElement(joker, "joker");
    infected_jokers_div.appendChild(joker_div);
  }
}

// Add Infected enhancements
let infected_enhancements_div = document.querySelector("#infected .enhancements");
if (infected_enhancements_div) {
  for (let enhancement of infectedEnhancements) {
    console.log("adding infected enhancement", enhancement.name);
    let enhancement_div = createCardElement(enhancement, "enhancement");
    infected_enhancements_div.appendChild(enhancement_div);
  }
}



// Add blinds
let blinds_div = document.querySelector(".blinds");
for (let blind of blinds) {
  console.log("adding blind", blind.name);
  let blind_div = createCardElement(blind, "blind");
  blinds_div.appendChild(blind_div);
}

// Tab functionality
function setupTabs() {
  const tabButtons = document.querySelectorAll('.tab-button');
  const themeContents = document.querySelectorAll('.theme-content');

  tabButtons.forEach(button => {
    button.addEventListener('click', () => {
      const theme = button.getAttribute('data-theme');
      
      // Remove active class from all buttons and contents
      tabButtons.forEach(btn => btn.classList.remove('active'));
      themeContents.forEach(content => content.classList.remove('active'));
      
      // Add active class to clicked button and corresponding content
      button.classList.add('active');
      document.getElementById(theme).classList.add('active');
    });
  });
}

// Card type navigation functionality
function setupCardTypeTabs() {
  const cardTypeButtons = document.querySelectorAll('.card-type-button');
  const cardTypeContents = document.querySelectorAll('.card-type-content');

  cardTypeButtons.forEach(button => {
    button.addEventListener('click', () => {
      const cardType = button.getAttribute('data-type');
      const themeContent = button.closest('.theme-content');
      
      // Remove active class from all buttons and contents in this theme
      themeContent.querySelectorAll('.card-type-button').forEach(btn => btn.classList.remove('active'));
      themeContent.querySelectorAll('.card-type-content').forEach(content => content.classList.remove('active'));
      
      // Add active class to clicked button and corresponding content
      button.classList.add('active');
      themeContent.querySelector(`#${cardType}`).classList.add('active');
    });
  });
}

// Initialize tabs
setupTabs();
setupCardTypeTabs();