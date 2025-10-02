#set page(paper: "us-letter")
#set text(size: 16pt)

#show heading.where(level: 1): it => {
	set align(center);
	set text(20pt);
	v(0.6em);
	it;
	v(0.4em);
}
#show link: it => {
	underline(text(fill: blue, it));
}
#set par(linebreaks: "optimized")
#show quote: it => {
	block(
		fill: color.hsl(0deg, 0, 245),
		inset: (x: 0.3in, y: 0.2in),
	)[
		#set text(style: "italic")
		“
		#it.body
		”
	];
}


// Title

#{
	set align(center);
	text(weight: "bold", size: 24pt)[Submission for GSND 6250 Project 3];
	parbreak();
	text(style: "italic")[Team 03];
	parbreak();
}


= Team Members

#block(width: 100%)[
	#set align(center);
	#table(
		columns: 2,
		stroke: none,
		gutter: 0.5em,
		[Yichi Zhang],
		[Sadaf Nezameddini],
		[Zhuowen Song],
		[Nianyi Wang],
	);
];


= Links

#block(width: 100%)[#{
	set align(center);
	let gutter = 1em;
	link("https://trello.com/invite/b/68d963856709bd5d32cea46b/ATTI0b933e8f8f6dc2135421fe3c77baf4a0ACBF0814/gsnd-6250-project-3")[Trello board];
	h(gutter);
	link("https://github.com/Nianyi-GSND-Projects/GSND-6250-GP3-Boss-Encounter")[GitHub repository]
	h(gutter);
	link("https://aiwass-z.itch.io/project3-boss-encounter")[itch.io page];
	h(gutter);
	link("https://docs.google.com/document/d/11HpOXuXg-u75F06DtLXdyfmVDafwoutt2QrkMhvgYGc/edit?usp=sharing")[Design Doc];
	footnote[No external credits this time.]
}];


= Project Description

In this level, the player plays the role of a righteous thief who sneaks into an evil base to steal the Energy Diamond. With the help of a hacker, the player successfully reached the deepest part of the base. When the player attempts to grab the diamond, it will alert the boss. The player does have a way to defeat the boss in this level, but it is quite difficult. The branching paths of the level and the ceiling vent hint to the player that they can temporarily bypass the boss and come back later.

#pagebreak()


= Design Problem and Target Experience

#quote[How to make the player aware of the potential boss and hint that they can avoid it?]

The player will play as a thief trespassing in a underground bank vault who need to escape without getting caught.
Straight from the spawning area, they could see a diamond protected in a glass case on the other end of the hallway, in the central dome of the vault. It is obvious that it would be sweet to steal a free diamond before leaving. But as they reach the central area, a security (the boss) at the exit door will see the player and starts chasing them. If the player is curious enough in the first place, they may explore the side branches of the hallway and realize that there has always been a path to the exit without alerting the security.


= Selected Patterns

== #link("https://patternlanguageforgamedesign.com/PatternLibraryApp/PatternLibrary/3712")[Bosses Can Be Bypassed]

#quote[In some games, especially those with large, non-linear worlds, players can face powerful bosses early on in the game. These bosses might be difficult to defeat when first encountered, but players are given the option to avoid the fight by either exploring alternative paths, coming back later, or using different strategies. This design pattern encourages exploration and adaptability. It also teaches players that not every boss fight needs to be tackled head-on; sometimes it’s better to build strength and return when ready, or bypass the fight entirely. It’s a way to make the world feel alive, offering both combat and exploration as valid playstyles.]

At the beginning of the level, the player is spawned in the Enter section (see @fig-early-sketch). All the level areas are in darkness except path A and the center. The player will naturally go towards the center. When they reach the center, the exit door will close and the boss will appear near the exit in path K, and the boss encounter starts. The boss will approach the player, and the player needs to run away.
If the player keeps struggling with this level, in the next respawn, they can avoid going to the center and they can take the paths from B to K to reach the exit. These paths are in the darkness, but the player can do it since they have learned this route from previous attempts.

== #link("https://patternlanguageforgamedesign.com/PatternLibraryApp/PatternLibrary/3720")[Hidden in Plain Sight]

#quote[A boss that appears from nowhere is no fun. You have to give hints to the player that a boss can be around the corner but not in the usual dungeon way. You can use architectural forms to convey a passage that will close when you are close, or arriving to a deadend and a boss appears when you are backtracking (if the path has hints about the boss, the better! eg. claw marks, destroyed boxes, etc.). Other way is to introduce a neutral character that at the end is a villain and mastermind of that arc.]

We hid the boss at the end of a hallway that is not visible from the beginning. It will only be alerted when the player touches the Diamond.



= Sketches

#figure(
	image("images/early-sketch.png", height: 3.5in),
	caption: [An early sketch of the level design, abstract and unscaled.],
)<fig-early-sketch>

#figure(
	image("images/alternative-early-sketch.png", height: 3.5in),
	caption: [An alternative version of sketch, deprecated as it doesn't implement the chosen patterns.],
)

#figure(
	image("images/diamond-glass-case-sketch.png", height: 3in),
	caption: [A sketch of the glass case protecting the diamond.],
)

#figure(
	image("images/scaled-sketch.png", height: 4.5in),
	caption: [The refined, scaled sketch of the final scene.],
)


= Gray Box

#figure(
	image("images/graybox-01.png", height: 3.5in),
	caption: [Manually modelled hexagon-based architectures.],
)

#figure(
	image("images/graybox-02.png", height: 3.5in),
	caption: [The central dome, with the basic modular models and the floor material applied.],
)


= Final Screenshots

#figure(
	image("images/final-01.png", height: 3.5in),
	caption: [The view from a corner in the dome.],
)

#figure(
	image("images/final-02.png", height: 3.5in),
	caption: [A hallway with lasors on.],
)


= Time Table

#block(width: 100%)[
	#set align(center)
	#table(
		columns: 3,
		stroke: none,
		table.hline(),
		table.header([*Subject*], [*Estimated Time*], [*Actual Time*]),
		table.hline(stroke: 0.5pt),
		[Team], [17h05m], [20h35m],
		[Average], [4h16m], [5h8m],
		table.hline(stroke: 0.5pt),
		[Yichi], [6h25m], [6h40m],
		[Zhuowen], [3h30m], [4h45m],
		[Sadaf], [4h], [5h],
		[Nianyi], [3h10m], [4h10m],
		table.hline(),
	)
]